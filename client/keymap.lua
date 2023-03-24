local OPEN_ATM_COMMAND = '_kmk_bank:OpenAtTM'
-- local OPEN_ATM_COMMAND_GAMEPAD = '_kmk_bank:OpenAtTM:Gamepad'

local function openATM()
  local xPlayer = ESX.GetPlayerData()
  if(not ATM.canInteract)then
    print('not close to any ATM')
    return
  end
  Manage.getBalance(nil, function(balance)
    SendNuiMessage(json.encode({
      type = 'openATM',
      accountInfo = {
        owner = {
          name = string.format('%s %s', xPlayer.firstName, xPlayer.lastName),
          firstName = xPlayer.firstName,
          lastName = xPlayer.lastName,
        },
        balance = balance
      }
    }))
    SetNuiFocus(true, true)
  end)
end
RegisterCommand(OPEN_ATM_COMMAND, openATM, false)
RegisterKeyMapping(OPEN_ATM_COMMAND, _U('interactKeyMapLabel'), 'keyboard', Config.InteractKeyMap.keyboard.id)
-- RegisterKeyMapping(OPEN_ATM_COMMAND_GAMEPAD, _U('interactKeyMapGamepadLabel'), 'gamepad', Config.InteractKeyMap.gamepad.id)
