tmpPlayersConfig = {
  {
    name = 'Player One',
    id = 'player_one',
    x = 100,
    y = 50,
    controls = {
      keyboard = {
        jump = 'up',
        left = 'left',
        right = 'right',
        fight = 'space'
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
    name = 'Player Two',
    id = 'player_two',
    x = 150,
    y = 300,
    controls = {
      keyboard = {
        jump = 'w',
        left = 'a',
        right = 'd',
        fight = 'lshift'
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
    name = 'Player Three',
    id = 'player_three',
    x = 300,
    y = 200,
    controls = {
      keyboard = {
        jump = 'i',
        left = 'j',
        right = 'l',
        fight = 'h'
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
    x = 450,
    y = 250,
    controls = {
      keyboard = {      
        jump = 'g',
        left = 'v',
        right = 'n',
        fight = 'c'
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