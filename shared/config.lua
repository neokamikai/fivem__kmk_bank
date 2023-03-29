Config = {}
Config.Locale = GetConvar('esx:locale', 'en')
Config.debug = {
  uiVisible = true
}
Config.InteractKeyMap = {
  keyboard = {
    text = 'E',
    id = 'E'
  },
  gamepad = {
    id = ''
  }
}
Config.blips = {                -- Example {title="", colour=, id=, x=, y=, z=},
  {
    title = "Caixa Eletrônico", -- Loja
    colour = 25,
    id = 207,
    x = 33.249,
    y = -1348.0,
    z = 29.500,
    -- setcoords 33.249 -1348.0 29.7
    interactVec = { distance = 0.85, heading = 185, headingDelta = 7.8, view = true },
    modelHash = -870868698,
    marker = {
      x = 33.2,
      y = -1348.85,
      z = 30.400,
      scale = 1.0,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
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
    interactVec = { distance = 1.2, heading = 267, headingDelta = 15, view = true },
    marker = {
      x = -720.768,
      y = -415.567,
      z = 36.35,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
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
    interactVec = { distance = 1.6, heading = 95, headingDelta = 12, view = true },
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
    interactVec = { distance = 1.2, heading = 30, headingDelta = 15, view = true },
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
    interactVec = { distance = 1.2, heading = 155, headingDelta = 15, view = true },
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
    -- setcoords -537.805175 -854.9356689 28.275428,
    interactVec = { distance = 1.2, heading = 180, headingDelta = 15, view = true },
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
    y = -819.13272705,
    z = 22.740657806,
    hidden = true,
    -- setcoords -721.168 -415.567 34.2
    interactVec = { distance = 1.2, heading = 359, headingDelta = 15, view = false },
    marker = {
      x = -712.9356689,
      y = -818.68272705,
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
    x = -710.019,
    y = -819.13272705,
    z = 22.740657806,
    -- setcoords -710.08 -818.475 22.8
    interactVec = { distance = 1.2, heading = 359, headingDelta = 15, view = false },
    marker = {
      x = -710.019,
      y = -818.68272705,
      z = 22.740657806 + 2,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
  {
    title = "Caixa Eletrônico", -- Rua
    colour = 25,
    id = 207,
    x = -660.661,
    y = -853.741,
    z = 24.482,
    -- setcoords -660.661 -853.741 24.482
    interactVec = { distance = 0.8, heading = 180, headingDelta = 15, view = false },
    marker = {
      x = -660.761,
      y = -854.241,
      z = 24.482 + 1,
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
    x = -1289.065,
    y = -226.599,
    z = 42.446,
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
    x = -1285.872,
    y = -224.504,
    z = 42.446,
    hidden = true,
    -- setcoords -1285.1364746 -223.9421539 41.43
    interactVec = { distance = 0.8, heading = 305, headingDelta = 15, view = false },
    marker = {
      x = -1285.1364746,
      y = -223.9421539,
      z = 41.430309 + 2,
      scale = 0.5,
      bopUpAndDown = true,
      color = { r = 0, g = 170, b = 0, a = 192 }
    },
  },
}
