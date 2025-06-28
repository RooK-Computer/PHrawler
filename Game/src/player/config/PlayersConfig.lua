require('src/player/config/gamepadConfig')
require('src/player/config/animationConfigDefault')
require('src/player/config/animationConfigMale')

PlayersConfig = {
  {
    name = 'Player One',
    id = 'player_one',
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
    id = 'player_two',
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
    animations = animationConfigDefault
  },
  {
    name = 'Player Three',
    id = 'player_three',
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
    animations = animationConfigMale
  },
  {
    name = 'Player Four',
    id = 'player_four',
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