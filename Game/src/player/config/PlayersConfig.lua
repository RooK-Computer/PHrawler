require('src/player/config/gamepadConfig')
require('src/player/config/animationConfigDefault')

PlayersConfig = {}
PlayersConfig.get = function(playerNumber) 

  local playerConfig = {}

  for i=1,playerNumber do

    local defaultConfig = {
      name = 'Player ' .. i,
      id = 'player_' .. i,
      priority = 1,
      x = 0,
      y = 0,
      registeredGamepad = nil,
      controls = {
        inputs = {
          gamepad = gamepadConfig,
        },
        defaultInput = 'gamepad',
      },
      animations = animationConfigDefault
    }

    if   i <= 4 then defaultConfig.controls.inputs.keyboard = keyboardConfig[i] end

    table.insert(playerConfig, defaultConfig)


  end

  return playerConfig


end