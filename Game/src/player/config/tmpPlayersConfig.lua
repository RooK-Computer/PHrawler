require('src/player/config/gamepadConfig')

tmpPlayersConfig = {
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
          left = 'left',
          right = 'right',
          fight = 'space'
        },      
        gamepad = gamepadConfig,
      },
      defaultInput = 'gamepad',
    },
    animations = {
      idle = {
        grid = '1-8',
        column = 1
      },
      running = {
        grid = '1-8',
        column = 3
      },
      jump = {
        grid = '1-2',
        column = 4
      },
      falling = {
        grid = '3-4',
        column = 4,
      },
    }
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
          left = 'a',
          right = 'd',
          fight = 'lshift'
        },
        gamepad = gamepadConfig,
      },
      defaultInput = 'gamepad',
    },
    animations = {
      idle = {
        grid = '1-8',
        column = 1
      },
      running = {
        grid = '1-8',
        column = 3
      },
      jump = {
        grid = '1-2',
        column = 4
      },
      falling = {
        grid = '3-4',
        column = 4,
      },
    }
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
          left = 'j',
          right = 'l',
          fight = 'h'
        },
        gamepad = gamepadConfig,
      },
      defaultInput = 'keyboard',
    },
    animations = {
      idle = {
        grid = '1-8',
        column = 1
      },
      running = {
        grid = '1-8',
        column = 3
      },
      jump = {
        grid = '1-2',
        column = 4
      },
      falling = {
        grid = '3-4',
        column = 4,
      },
    }
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
          left = 'v',
          right = 'n',
          fight = 'c'
        },
        gamepad = gamepadConfig,
      },
      defaultInput = 'keyboard',
    },
    animations = {
      idle = {
        grid = '1-8',
        column = 1
      },
      running = {
        grid = '1-8',
        column = 3
      },
      jump = {
        grid = '1-2',
        column = 4
      },
      falling = {
        grid = '3-4',
        column = 4,
      },
    }
  }
}