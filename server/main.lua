if (ESX) then
  print('ESX is available at server!')
end
BankAccount = {}
BankAccount.Player = {}
BankAccount.Society = {}
local transferTargets = {

}

function BankAccount.Player.canAfford(source, amount)
  local xPlayer = ESX.GetPlayerFromId(source)
  local account = xPlayer.getAccount('bank')
  return account.money >= amount
end

function BankAccount.Player.withdraw(source, amount)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.removeAccountMoney('bank', amount)
  xPlayer.addMoney(amount)
  return xPlayer.getAccount('bank').money
end

function BankAccount.Player.getBalance(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  return xPlayer.getAccount('bank').money
end

function BankAccount.Player.addAmount(source, amount)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addMoney(amount)
  return xPlayer.getAccount('bank').money
end

function BankAccount.Player.transferToPlayer(source, target, amount)
  local xPlayer = ESX.GetPlayerFromId(source)
  local xPlayerTarget = ESX.GetPlayerFromId(target)
  xPlayer.removeAccountMoney('bank', amount)
  xPlayerTarget.addAccountMoney('bank', amount)
  return xPlayer.getAccount('bank').money
end
-- Gets player job society money
-- ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
--
-- end, ESX.PlayerData.job.name)


-- local xPlayer = ESX.GetPlayerFromId(source)
-- xPlayer.getMoney()
ESX.RegisterServerCallback('kmk_bank:withdrawMoney', function(source, cb, data)
  local updatedBalance = BankAccount.Player.withdraw(source, data.amount)
  -- print(string.format("%s is trying to withdraw %s from bank", xPlayer.getName(), data.amount))
  cb({ error = nil, message = 'withdrawMoneySuccessful', balance = updatedBalance })
end)
ESX.RegisterServerCallback('kmk_bank:getTransferTargets', function(source, cb)
  if (transferTargets[source]) then
    cb(transferTargets[source])
    return
  end

  MySQL.query('SELECT * FROM bank_transfer_targets WHERE identifier = @playerId ORDER BY job_grade DESC', {
    ['@playerId'] = source
  }, function(results)
    local transferTargets = {}
    for i = 1, #results, 1 do
      local entry = results[i]
      local name = entry.target_name
      local target = { id = entry.target_id, name = '' }
      if (entry.target_type == 'society') then
        local society = GetSociety(entry.target_id)
        if (society ~= nil) then
          target.name = society.name
        end
      end
      if (entry.target_type == 'citizen') then
        local xTargetPlayer = ESX.GetPlayerFromIdentifier(target.id)
        if (xTargetPlayer ~= nil) then
          target.name = xTargetPlayer.name
        end
      end

      table.insert(transferTargets, {
        id = entry.id,
        name = name,
        type = entry.target_type,
        [entry.target_type] = target
      })
    end
    transferTargets[source] = {
      transferTargets = results
    }
    cb(transferTargets[source])
  end)
end)

local function registerTransferTarget(cb, source, data)
  MySQL.query(
    'INSERT INTO bank_transfer_targets (`identifier`, target_type, target_id, target_name) values (@source, @type, @targetId, @targetName); SELECT LAST_INSERT_ID() as id;',
    {
      ['@source'] = source,
      ['@type'] = data.newTarget.type,
      ['@targetId'] = data.newTarget[string.format('%sId', data.newTarget.type)],
      ['@targetName'] = data.targetName
    }, function(result)
      cb({
        success = true,
        result = result
      })
    end)
end
RegisterNetEvent('kmk_bank:registerTransferTarget', registerTransferTarget)
-- ESX.RegisterServerCallback('kmk_bank:registerTransferTarget', registerTransferTarget)

local function transferMoneyToTarget(cb, source, targetId, data)
  print(string.format('transferMoneyToTarget called with %s, %s, %s', source, targetId, json.encode(data)))
  cb({ error = true, message = 'não implementado' })
end
local function getPlayerBalance(identifier, cb)
  local xPlayer = ESX.GetPlayerFromId(identifier)
  cb(xPlayer.getAccount('bank').money)
end
RegisterNetEvent('kmk_bank:transferMoneyToTarget', transferMoneyToTarget)
--RegisterNetEvent('kmk_bank:transferMoneyToTarget', getPlayerBalance)
ESX.RegisterServerCallback('kmk_bank:getPlayerBalance', getPlayerBalance)
-- ESX.RegisterServerCallback('kmk_bank:transferMoneyToTarget', transferMoneyToTarget)

