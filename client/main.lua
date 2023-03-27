Manage = {}
exports('getSharedObject', function()
  return Manage
end)
local Endpoint = {}
-- web events:
-- atmHasClosed: notifies client backend that user has closed the ATM interface
-- getAssociations: requests list of societies
-- getAssociationDetail: request details for a specific society
-- withdrawMoney: withdraw money from bank and add 'money' item to inventory
-- makeDeposit: deposits 'money' from inventory to 'target' account (at the moment should only support player bank)
-- getTransferTargets: requests a list of possible transfer targets
-- makeTransfer: transfers money from an account to another

-- read bank balance: ESX.PlayerData.accounts.bank
-- xPlayer.addAccountMoney('bank', salary, "Paycheck")
-- TriggerClientEvent('esx:showAdvancedNotification', player, TranslateCap('bank'), TranslateCap('received_paycheck'),
--     TranslateCap('received_salary', salary), 'CHAR_BANK_MAZE', 9)


function Endpoint.atmHasClosed(data, cb)
  SetNuiFocus(false, false)
  cb('')
end
function Endpoint.getAssociations(data, cb)
  local response = {
    error = nil,
    message = ''
  }
  cb(json.encode(response))
end
function Endpoint.getAssociationDetail(data, cb)
  local response = {
    error = nil,
    message = ''
  }
  cb(json.encode(response))
end
function Endpoint.withdrawMoney(data, cb)
  ESX.TriggerServerCallback('kmk_bank:withdrawMoney', function(response)
    cb(json.encode({ error = response.error, message = _U(response.message), balance = response.balance,
      response = response }))
  end, data)
  -- local amount = data.amount
  -- local xPlayer = ESX.PlayerData
  -- local bankAccount = xPlayer.getAccount('bank')
  -- if (amount > bankAccount.money) then
  --   cb(json.encode({ error = true, message = 'Saldo insuficiente!' }))
  -- else
  --   xPlayer.removeAccountMoney('bank', amount)
  --   xPlayer.addAccountMoney('money', amount)
  --   local response = {
  --     error = nil,
  --     message = string.format('Retirada efetuada com sucesso!')
  --   }

  --   cb(json.encode(response))
  -- end
end
function Endpoint.makeDeposit(data, cb)
  local amount = data.amount
  local xPlayer = ESX.PlayerData
  local moneyAccount = xPlayer.getAccount('money')
  if (amount > moneyAccount.money) then
    cb(json.encode({ error = true, message = 'Você não possui todo esse dinheiro!' }))
  else
    xPlayer.removeAccountMoney('money', amount)
    xPlayer.addAccountMoney('bank', amount)
    local response = {
      error = nil,
      message = ''
    }
    cb(json.encode(response))
  end
end
function Endpoint.getTransferTargets(data, cb)
  local xPlayer = ESX.GetPlayerData()
  ESX.TriggerServerCallback('callbackName', function(response)
    cb(json.encode(response))
  end, xPlayer.identifier, data)
end
RegisterNUICallback('atmHasClosed', Endpoint.atmHasClosed)
RegisterNUICallback('getAssociations', Endpoint.getAssociations)
RegisterNUICallback('getAssociationDetail', Endpoint.getAssociationDetail)
RegisterNUICallback('withdrawMoney', Endpoint.withdrawMoney)
RegisterNUICallback('makeDeposit', Endpoint.makeDeposit)
RegisterNUICallback('getTransferTargets', Endpoint.getTransferTargets)
function Manage.getBalance(args, cb)
  if (args == nil and cb == nil) then
    print(
      '^3missing callback^7\n\nUsage:\ngetBalance(* function)\nor\ngetBalance({target = \'self\'})\nor\ngetBalance({target = \'society\', society = \'name\'})')
    return nil
  end
  if (cb == nil and type(args) == "function") then
    cb = args
  end
  if (not args or not args.target or args.target == 'self') then
    local xPlayer = ESX.GetPlayerData()
    ESX.TriggerServerCallback('kmk_bank:getPlayerBalance', function(amount)
      if(type(cb) == 'function')then
        cb(amount)
      end
    end, xPlayer.identifier)
    
  end
  if (args and args.type == 'society') then
    local p = promise.new()
    local societyMoney = 0
    TriggerServerEvent('esx_society:getSociety', args.society, function(society)
      TriggerServerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        societyMoney = account.money
        p.resolve(p, account.money)
        cb(account.money)
      end)
    end)
    Citizen.Await(p)
    return societyMoney
  end
  return 0
end

function Manage.transferMoneyToTarget(amount, targetId, cb)
  local xPlayer = ESX.GetPlayerData()
  TriggerServerEvent('kmk_bank:transferMoneyToTarget', function (result)
    print(result);
    cb(json.encode(result))
  end, xPlayer.source, targetId, amount)
end

RegisterNUICallback('registerTransferTarget', function(data, cb)
  local xPlayer = ESX.GetPlayerData()
  TriggerServerEvent('kmk_bank:registerTransferTarget', function(result)
    cb(json.encode(result))
  end, xPlayer.source, data.target, false, 0)
end)
RegisterNUICallback('makeTransfer', function(data, cb)
  local amount = data.amount
  local xPlayer = ESX.GetPlayerData()
  local bankAccount = xPlayer.getAccount('bank')
  local target = data.target
  if (amount > bankAccount.money) then
    cb(json.encode({ error = true, message = 'Saldo insuficiente!' }))
    return
  end
  if (target.id == 'new') then
    TriggerServerEvent('kmk_bank:registerTransferTarget', function(result)
      print(result)
      -- if (target.type == 'society') then
      --   Manage.transferMoneyToTarget(amount, targetId, function(result)
      --     cb(json.encode({
      --       error = not result.success,
      --       message = result.message
      --     }))
      --   end)
      -- end
    end, target, true, amount)
  else
    Manage.transferMoneyToTarget(amount, target.id, function(result)
      cb(json.encode({
        error = not result.success,
        message = result.message
      }))
    end)
  end
end)

AddEventHandler('CEventPlayerDeath', function()
  SendNuiMessage(json.encode({ type = 'playerDied' }))
end)
