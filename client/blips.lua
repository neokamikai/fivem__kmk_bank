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
local blips = { -- Example {title="", colour=, id=, x=, y=, z=},
  {
    title = "Caixa Eletrônico", -- Loja
    colour = 25,
    id = 207, 
    x = 33.249,
    y = -1348.0,
    z = 29.500,
    -- setcoords 33.249 -1348.0 29.7
    interactVec = { distance = 0.85, heading = 185, headingDelta = 7.8, view = false },
    modelHash = -870868698,
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
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 267, headingDelta = 15, view = false },
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
    -- setcoords -717.347 -915.647 21.0
    interactVec = { distance = 1.6, heading = 95, headingDelta = 12, view = false },
    marker = {
      x = -718.247,
      y = -915.647,
      z = 20.216,
      scale = 0.75,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -821.8935546875,
    y = -1081.5545654296876,
    z = 10.1366,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 30, headingDelta = 15, view = false },
    marker = {
      x = -821.8935546875,
      y = -1081.5545654296876,
      z = 10.1366 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -526.779113,
    y = -1223.3736572,
    z = 17.4527206,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 155, headingDelta = 15, view = false },
    marker = {
      x = -821.8935546875,
      y = -1081.5545654296876,
      z = 17.4527206 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -537.805175,
    y = -854.9356689,
    z = 28.275428,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 180, headingDelta = 15, view = false },
    marker = {
      x = -537.805175,
      y = -854.9356689,
      z = 28.275428 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  --
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -712.9356689,
    y = -818.48272705,
    z = 22.740657806,
    hidden = true,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 359, headingDelta = 15, view = false },
    marker = {
      x = -712.9356689,
      y = -818.48272705,
      z = 22.740657806 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -710.0827636,
    y = -818.475585,
    z = 22.736335,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 359, headingDelta = 15, view = false },
    marker = {
      x = -710.0827636,
      y = -818.475585,
      z = 22.736335 + 2,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -660.676330,
    y = -854.488159,
    z = 23.456634,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 180, headingDelta = 15, view = false },
    marker = {
      x = -660.676330,
      y = -854.488159,
      z = 23.456634 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  --
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -1289.74194335,
    y = -227.1649780,
    z = 41.430309,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 125, headingDelta = 15, view = false },
    marker = {
      x = -1289.74194335,
      y = -227.1649780,
      z = 41.430309 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -1285.1364746,
    y = -223.9421539,
    z = 41.430309,
    hidden = true,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 305, headingDelta = 15, view = false },
    marker = {
      x = -660.676330,
      y = -854.488159,
      z = 41.430309 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
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
  for _, info in pairs(blips) do
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
      for atmId, info in pairs(blips) do
        local marker = info.marker
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, info.x, info.y, info.z,
          true)
        local headingDelta = math.abs(info.interactVec.heading - playerHeading)
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