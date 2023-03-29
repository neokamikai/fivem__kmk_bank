ATM = {
  canInteract = false,
  id = -1
}
local ATMHashes = {
  prop_atm_01 = { sint = -870868698, usint = 3424098598 },
  prop_atm_02 = { sint = -1126237515, usint = 3168729781 },
  prop_atm_03 = { sint = -1364697528, usint = 2930269768 },
  prop_fleeca_atm = { sint = 506770882, usint = 506770882 }
}
 

local function isAtmModel(hash)
  return hash == ATMHashes.prop_atm_01.sint or hash == ATMHashes.prop_atm_01.sint or
      hash == ATMHashes.prop_atm_02.sint or hash == ATMHashes.prop_atm_02.sint or
      hash == ATMHashes.prop_atm_03.sint or hash == ATMHashes.prop_atm_03.sint or
      hash == ATMHashes.prop_fleeca_atm.sint or hash == ATMHashes.prop_fleeca_atm.sint
end
local function DisplayInteractionText(msg, coords)
  AddTextEntry('kmkBankFloatingHelpNotification', msg)
  SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z - 0.6)
  SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
  BeginTextCommandDisplayHelp('kmkBankFloatingHelpNotification')
  EndTextCommandDisplayHelp(2, false, false, -1)
  
end



Citizen.CreateThread(function()
  for _, info in pairs(Config.blips) do
    if (not info.hidden) then
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
      local normalizedPlayerHeading = playerHeading
      local playerCoords = GetEntityCoords(xPlayer.ped, false)
      local debugInfo = {
        blipIndex = -1,
        blipInfo = {},
        distance = 0,
        headingDelta = 0,
        isFacingATM = false,
        isCloseForInteraction = false,
        canInteract = false,
        shapeTestResult = {
          hit = false,
          endCoords = { x = 0, y = 0, z = 0 },
          surfaceNormal = { x = 0, y = 0, z = 0 },
          entityHit = 0,
          model = nil
        }
      }
      for atmId, info in pairs(Config.blips) do
        local marker = info.marker
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, info.x, info.y, info.z,
          true)
        normalizedPlayerHeading = playerHeading
        if (info.interactVec.heading + info.interactVec.headingDelta >= 360 and playerHeading <= info.interactVec.headingDelta) then
          normalizedPlayerHeading = playerHeading + 360
        end
        local headingDelta = math.abs(info.interactVec.heading - normalizedPlayerHeading)
        local isFacingATM = headingDelta < info.interactVec.headingDelta
        local isCloseForInteraction = distance < info.interactVec.distance
        DrawMarker(
          29,
          marker.x, marker.y, marker.z,
          0.0, 0.0, 0.0,
          0.0, 0.0, 0.0,
          marker.scale, marker.scale, marker.scale,
          marker.color.r, marker.color.g, marker.color.b, marker.color.a,
          marker.bopUpAndDown, true, 2, false, nil, nil, false
        )
        if (info.interactVec.view) then
          DrawMarker(
            26,
            info.x, info.y, info.z,
            0.0, 1.0, 0.0,
            0.0, 0.0, 0.0,
            marker.scale, marker.scale, marker.scale,
            marker.color.r, marker.color.g, marker.color.b, marker.color.a,
            false, false, 2, false, nil, nil, false
          )
        end
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
          playerHeading = normalizedPlayerHeading,
        }))
      elseif (debugUIWasVisible) then
        SendNUIMessage(json.encode({ type = 'atmDebugInfo', uiVisible = false }))
      end
      debugUIWasVisible = Config.debug.uiVisible
    end
  end)
end)