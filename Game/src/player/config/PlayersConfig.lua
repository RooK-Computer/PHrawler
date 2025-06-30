require('src/player/config/gamepadConfig')
require('src/player/config/animationConfigDefault')
require('src/player/config/animationConfigMale')

PlayersConfig = {}
PlayersConfig.beta = {
  {
    name = 'Player One',
    id = 'player_1',
    priority = 1,
    x = 100,
    y = 50,
    controls = {
      inputs = {
        keyboard = {
          jump = 'up',
          drop = 'down',
          left = 'left',
          right = 'right',
          fight = 'space'
        },      
        gamepad = gamepadConfig,
      },
      defaultInput = 'gamepad',
    },
    animations = animationConfigDefault
  },
  {
    name = 'Player Two',
    id = 'player_2',
    priority = 2,
    x = 150,
    y = 300,
    controls = {
      inputs = {
        keyboard = {
          jump = 'w',
          drop = 's',
          left = 'a',
          right = 'd',
          fight = 'lshift'
        },
        gamepad = gamepadConfig,
      },
      defaultInput = 'gamepad',
    },
    animations = animationConfigMale
  },
  {
    name = 'Player Three',
    id = 'player_3',
    priority = 3,
    x = 300,
    y = 200,
    controls = {
      inputs = {
        keyboard = {
          jump = 'i',
          drop = 'k',
          left = 'j',
          right = 'l',
          fight = 'h'
        },
        gamepad = gamepadConfig,
      },
      defaultInput = 'gamepad',
    },
    animations = animationConfigDefault
  },
  {
    name = 'Player Four',
    id = 'player_4',
    priority = 4,
    x = 450,
    y = 250,
    controls = {
      inputs = {
        keyboard = {      
          jump = 'g',
          drop = 'b',
          left = 'v',
          right = 'n',
          fight = 'c'
        },
        gamepad = gamepadConfig,
      },
      defaultInput = 'gamepad',
    },
    animations = animationConfigMale
  }
}


PlayersConfig.get = function(playerNumber) 

  local playerConfig = {}

  for i=1,playerNumber do

    local defaultConfig = {
      name = 'Player ' .. i,
      id = 'player_' .. i,
      priority = 1,
      x = 0,
      y = 0,
      controls = {
        inputs = {
          gamepad = gamepadConfig,
        },
        defaultInput = 'gamepad',
      },
      animations = animationConfigDefault
    }

    if   i <= 4 then defaultConfig.controls.inputs.keyboard = keyboardConfig[i] end
    if i%2 == 0 then defaultConfig.animations = animationConfigMale end

    table.insert(playerConfig, defaultConfig)


  end

  return playerConfig


end