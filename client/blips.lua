ATM = {
  canInteract = false,
  id = -1
}
if(Config)then
  print ('Config available')
  if (Config.InteractKeyMap) then
    print('Config.InteractKeyMap available')
  else
    print('Config.InteractKeyMap not available')
  end
else
  print ('Config not available')
end
local blips = { -- Example {title="", colour=, id=, x=, y=, z=},
  {
    title = "Caixa Eletrônico", -- Loja
    colour = 25,
    id = 207, 
    x = 33.435,
    y = -1347.314,
    z = 29.500,
    interactVec = { distance = 0.8, heading = 185, headingDelta = 7.8 },
    marker = {
      x = 33.2,
      y = -1348.85,
      z = 30.400,
      scale = 1.0,
      bopUpAndDown = true,
      color = {r=0,g=170,b=0,a=192}
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -721.168,
    y = -415.567,
    z = 34.0,
    interactVec = { distance = 0.8, heading = 267, headingDelta = 15 },
    marker = {
      x = -720.768,
      y = -415.567,
      z = 36.35,
      scale = 0.5,
      bopUpAndDown = true,
      color = {r=0,g=170,b=0,a=192}
    },
  },
  {
    title = "Caixa Eletrônico", -- Loja
    colour = 25,
    id = 207,
    x = -717.347,
    y = -915.647,
    z = 19.216,
    interactVec = { distance = 1.6, heading = 92, headingDelta = 7.8 },
    marker = {
      x = -718.247,
      y = -915.647,
      z = 20.216,
      scale = 0.75,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
}
 

local function DisplayInteractionText(msg, coords)
  AddTextEntry('kmkBankFloatingHelpNotification', msg)
  SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z - 0.6)
  SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
  BeginTextCommandDisplayHelp('kmkBankFloatingHelpNotification')
  EndTextCommandDisplayHelp(2, false, false, -1)
  
end



Citizen.CreateThread(function()
  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 1.0)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringKeyboardDisplay(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
  Citizen.CreateThread(function()
    while not ESX.IsPlayerLoaded() do
      Citizen.Wait(1000)
    end
    local debugUIWasVisible = Config.debug.uiVisible
    while true do
      Citizen.Wait(0)
      ESX.GetPlayerData()
      local xPlayer = ESX.GetPlayerData()
      local canInteract = false
      local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] =
          GetLocalTime()
      local playerHeading = GetEntityHeading(xPlayer.ped)
      local playerCoords = GetEntityCoords(xPlayer.ped, false)
      local debugInfo = {
        blipIndex = -1,
        blipInfo = {},
        distance = 0,
        headingDelta = 0,
        isFacingATM = false,
        isCloseForInteraction = false,
        canInteract = false,
      }
      for atmId, info in pairs(blips) do
        local marker = info.marker
        DrawMarker(
          29,
          marker.x, marker.y, marker.z,
          0.0, 0.0, 0.0,
          0.0, 0.0, 0.0,
          marker.scale, marker.scale, marker.scale,
          marker.color.r, marker.color.g, marker.color.b, marker.color.a,
          marker.bopUpAndDown, true, 2, false, nil, nil, false
        )
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, info.x, info.y, info.z,
          true)
        local headingDelta = math.abs(info.interactVec.heading - playerHeading)
        local isFacingATM = headingDelta < info.interactVec.headingDelta
        local isCloseForInteraction = distance < info.interactVec.distance
        if (isCloseForInteraction and isFacingATM) then
          DisplayInteractionText(_U('interactKeyMapMsg', Config.InteractKeyMap.keyboard.text), info.marker)
          canInteract = true
        end
        ATM.canInteract = canInteract
        if (ATM.canInteract) then
          ATM.id = atmId
        else
          ATM.id = -1
        end
        if (Config.debug.uiVisible) then
          if (debugInfo.blipIndex == -1 or distance <= debugInfo.distance) then
            debugInfo.blipIndex = atmId
            debugInfo.distance = distance
            debugInfo.blipInfo = info
            debugInfo.headingDelta = headingDelta
            debugInfo.isFacingATM = isFacingATM
            debugInfo.isCloseForInteraction = isCloseForInteraction
            debugInfo.canInteract = canInteract
          end
        end
        debugUIWasVisible = Config.debug.uiVisible
      end
      if (Config.debug.uiVisible) then
        SendNUIMessage(json.encode({
          type = 'atmDebugInfo',
          uiVisible = true,
          distance = debugInfo.distance,
          headingDelta = debugInfo.headingDelta,
          isFacingATM = debugInfo.isFacingATM,
          isCloseForInteraction = debugInfo.canInteract,
          closestATM = debugInfo.blipIndex,
          blipInfo = debugInfo.blipInfo,
          playerHeading = playerHeading,
        }))
      elseif (debugUIWasVisible) then
        SendNUIMessage(json.encode({ type = 'atmDebugInfo', uiVisible = false }))
      end
    end
  end)
end)