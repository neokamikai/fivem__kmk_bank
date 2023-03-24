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
    title = "Caixa Eletrônico",
    colour = 25,
    id = 207, -- 33.0, -1348.0, 29.5
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
  } }

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
    while true do
      Citizen.Wait(0)
      local canInteract = false
      local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] =
          GetLocalTime()
      local xPlayer = ESX.GetPlayerData()
      local playerCoords = xPlayer.coords
      local playerHeading = GetEntityHeading(xPlayer.ped)
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
        local headingDelta = info.interactVec.heading - playerHeading
        if (distance < info.interactVec.distance and math.abs(headingDelta) < info.interactVec.headingDelta) then
          DisplayInteractionText(_U('interactKeyMapMsg', Config.InteractKeyMap.keyboard.text), info.marker)
          canInteract = true
        end
        ATM.canInteract = canInteract
        if(ATM.canInteract)then
          ATM.id = atmId
        else
          ATM.id = -1          
        end
      end
    end
  end)
end)