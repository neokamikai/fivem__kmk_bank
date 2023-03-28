Commands = {}

function Commands.showatms()
  local objectPool = GetGamePool('CObject')
  for _, entity in pairs(objectPool) do
    local model = GetEntityModel(entity)
    if (model == GetHashKey('prop_atm_01') or model == GetHashKey('prop_atm_02') or
        model == GetHashKey('prop_atm_03') or model == GetHashKey('prop_fleeca_atm')) then
      local coords = GetEntityCoords(entity, false)
      local heading = GetEntityHeading(entity)
      print(json.encode({ coords = coords, heading = heading }))
    end
  end
end
RegisterCommand('dinheiro', function(args)
  print(json.encode(args))
end, true)

RegisterCommand('showatms', function()
  Commands.showatms()
end, true)
