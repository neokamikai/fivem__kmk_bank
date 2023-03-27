const app = angular.module('app', []);

const knownGamepadLayouts = {
  DS4: {
    vendor: '054c',
    product: ['09cc', '05c4'],
    axes: {
      leftStickLR: [0],
      leftStickUD: [1],
      rightStickLR: [2],
      rightStickUD: [3],
    },
    buttons: {
      cross: 0,
      circle: 1,
      square: 2,
      triangle: 3,
      L1: 4,
      R1: 5,
      L2: 6,
      R2: 7,
      share: 8,
      options: 9,
      leftStick: 10,
      rightStick: 11,
      dpadUp: 12,
      dpadDown: 13,
      dpadLeft: 14,
      dpadRight: 15,
      ps: 16,
      touchpad: 17,
    },
    getButtonNameByIndex(index) {
      return Object.keys(this.buttons)[index];
    }
  },
  byHash(hash) {
    const map = (gamepadLayout) => {
      return gamepadLayout.product.reduce((prev, product) =>({
        ...prev,
        [`${gamepadLayout.vendor}:${product}`]: gamepadLayout,
      }))
    };
    const knownLayouts = {
      ...map(this.DS4),
    };
    return knownLayouts[hash];
  }
}
function rumbleGamepad(gamepad, {startDelay = 0, duration = 1000, weakMagnitude = 1.0, strongMagnitude = 1.0 } = {}) {
  if(!gamepad){
    console.warn('gamepad unavailable');
    return;
  }
  gamepad.vibrationActuator.playEffect(gamepad.vibrationActuator.type, {
    startDelay,
    duration,
    weakMagnitude,
    strongMagnitude,
  });
}
window.addEventListener("gamepaddisconnected", (e) => {
  console.log(
    "Gamepad disconnected from index %d: %s",
    e.gamepad.index,
    e.gamepad.id
  );
});
app.filter('simplenumber', function () {
  return (function (input) {
    if (typeof input != 'number') return input;
    let output = parseInt(`${input}`).toFixed(0);
    while (output.indexOf('000') > 0 || output.indexOf('kkk') > 0)
      output = output.replace(/000(k|kk)?$/, 'k$1');
    return output.replace(/(\d)kk$/, '$1m').replace(/(\d)kk$/, '$1b');
  });
});

app.controller('MainController', ['$scope', function MainController(scope) {
  const ctrl = this;
  ctrl.post = (event, data) => fetch(`https://${GetParentResourceName()}/${event}`, {
    method: 'POST', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(data),
  }).then(resp => resp.json()).then(resp => {
    let output = resp;
    try {
      if (typeof resp == 'string') output = JSON.parse(resp)
    } catch (error) {
      console.error(error)
    }
    if (resp.response) output = output.response
    return output;
  });
  const eventHandlers = {
    'accountBalanceUpdate': (data) => {
      if (ctrl.atm.accountInfo.accountId != data.accountId) return;
      ctrl.atm.accountInfo.balance = data.balance;
    },
    'openATM': (data) => {
      ctrl.atm.accountInfo.owner = data.accountInfo.owner;
      ctrl.atm.accountInfo.balance = data.accountInfo.balance;
      ctrl.atm.show();
    },
    'atmDebugInfo': (data) => {
      ctrl.atm.debug = data
    },
    'playerDied': () => {
      Swal.close();
      ctrl.atm.close();
    }
  };
  window.addEventListener('message', (event) => {
    let data = event.data;
    if (typeof data === 'string') {
      data = JSON.parse(data);
    }
    const handler = eventHandlers[data.type];
    if (typeof handler == 'function') {
      handler(data);
      scope.$apply();
    }
    else {
      console.warn('no handler defined for [',data.type,']', event.data)
    }
  });

  const makeWindowStack = () => ({
    _windowStack: [],
    goBack() {
      const previous = this.window;
      this._windowStack.pop();
    },
    getCurrentWindow() {
      return this._windowStack[this._windowStack.length - 1];
    },
    isCurrentWindow(checkWindow) {
      return this.getCurrentWindow() == checkWindow;
    },
    goLoading() {
      this.goTo('loading');
    },
    goError() {
      if (this.window == 'loading') this._window.pop();
      this.goTo('error');
    },
    goTo(value) {
      if (this.window == 'loading' && value != 'loading') this._windowStack.pop();
      if (this._windowStack.includes(value)) {
        this._windowStack.splice(this._windowStack.indexOf(value) + 1);
        return;
      }
      this._windowStack.push(value);

    },
    get window() { return this._windowStack[this._windowStack.length - 1]; },
    set window(value) {
      this.goTo(value);
    },
  });
  const availableAddAmounts = [1, 10, 50, 100, 500, 1000, 10000, 100000, 1000000];
  console.log(location, ctrl)
  ctrl.atm = {
    closed: true,
    ...makeWindowStack(),
    show(data = {}) {
      this.goTo('');
      this.closed = false;
      ctrl.atm.accessTimer = setTimeout(() => {

      }, data.timeout || 60000);
    },
    close() {
      clearTimeout(ctrl.atm.accessTimer);
      delete ctrl.atm.accessTimer;
      this.closed = true;
      ctrl.post('atmHasClosed', {});
      scope.$apply();
    },
    goWithdraw() {
      this.withdraw.goSelect();
      this.goTo('withdraw');
    },
    goDeposit() {
      this.deposit.goFill();
      this.goTo('deposit');
    },
    goTransfer() {
      if(this.transfer.knownTargets){
        this.goTo('transfer');
        this.transfer.refreshTargets().then(() => {
          this.transfer.goFill();
        });
        return;
      }
      this.transfer.goFill();
      this.goTo('transfer');
    },
    goAssociations() {
      this.goTo('associations');
      this.associations.goList(true);
    },
    associations: {
      ...makeWindowStack(),
      list: [],
      detail: {},
      goList(refresh) {
        if (refresh) {
          this.goLoading();
          ctrl.post('getAssociations', { target: 'atm' }).then((resp) => {
            if (resp.error) {
              this.error = resp.error;
              this.message = resp.message;
              this.goError();
            }
            else {
              ctrl.atm.associations.list = resp.list;
              ctrl.atm.associations.goList();
            }
            scope.$apply();
          });
        }
        else {
          this.goTo('list');
        }
      },
      goDetail(id) {
        this.goLoading();
        ctrl.post('getAssociationDetail', { target: 'atm', id }).then((resp) => {
          if (resp.error) {
            ctrl.atm.associations.error = resp.error;
            ctrl.atm.associations.message = resp.message;
            ctrl.atm.associations.goError();
          }
          else {
            ctrl.atm.associations.detail = resp.association;
            ctrl.atm.associations.window = 'detail';
          }
          scope.$apply();
        });
      }
    },
    withdraw: {
      debug: true,
      ...makeWindowStack(),
      availableAmounts: [10, 50, 100, 200, 500, 1000, 5000, 10000, 25000, 50000, 100000, 250000, 250000 * 2, 250000 * 3, 250000 * 4],
      availableAddAmounts,
      amount: null,
      inputAmount: null,
      goSelect() {
        this.goTo('select');
      },
      addToInput(amount) {
        const newAmount = (this.inputAmount || 0) + amount;
        this.inputAmount = newAmount <= 0 ? 0 : newAmount;
      },
      requestConfirm(amount) {
        if (isNaN(parseFloat(`${amount}`.replace(/[^\d.]/g, ''))) || parseFloat(`${amount}`) <= 0) {
          Swal.fire({
            icon: 'error',
            text: 'Favor informar um valor válido!'
          });
          return;
        }
        this.amount = amount;
        this.goTo('confirm');
      },
      confirm() {
        ctrl.post('withdrawMoney', { amount: this.amount }).then((resp) => {
          Swal.fire({
            icon: resp.error && 'error' || 'success',
            text: resp.message
          });
          if (typeof resp.balance == 'number') {
            ctrl.atm.accountInfo.balance = resp.balance;
          }
          ctrl.atm.goBack();
          scope.$apply();
        })
      }
    },
    deposit: {
      ...makeWindowStack(),
      availableAddAmounts,
      inputAmount: null,
      amount: 0,
      target: {},
      addToInput(amount) {
        const newAmount = (this.inputAmount || 0) + amount;
        this.inputAmount = newAmount <= 0 ? 0 : newAmount;
      },
      requestConfirm() {
        if (isNaN(parseFloat(`${this.inputAmount}`.replace(/[^\d.]/g, ''))) || parseFloat(`${this.inputAmount}`) <= 0) {
          Swal.fire({
            icon: 'error',
            text: 'Favor informar um valor válido para depósito!'
          });
          return;
        }
        this.amount = this.inputAmount;
        this.goTo('confirm');
      },
      confirm() {
        ctrl.post('makeDeposit', {
          target: this.target,
          amount: this.amount
        }).then(resp => {
          Swal.fire({
            icon: resp.error && 'error' || 'success',
            text: resp.message
          });
          ctrl.atm.goBack();
          scope.$apply();
        });
      },
      goFill() {
        this.inputAmount = null;
        this.goTo('fill');
      },
    },
    transfer: {
      ...makeWindowStack(),
      availableAddAmounts,
      refreshTargets() {
        this.goTo('loading');
        const self = this;
        return ctrl.post('getTransferTargets', {}).then(resp => {
          self.knownTargets = resp.transferTargets;
          scope.$apply();
        });
      },
      goFill() {
        this.goTo('fill');
      },
    },
    accountInfo: {
      owner: {
        name: 'Fulano'
      },
      balance: 0,
    }
  };
}]);