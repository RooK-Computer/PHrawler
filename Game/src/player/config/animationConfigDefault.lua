animationConfigDefault = {
  [Constants.IDLE_STATE] = {
    frames = {
      {
        grid = '1-8',
        column = 1
      }
    }
  },
  [Constants.RUN_STATE] = {
    frames = {
      {
        grid = '1-8',
        column = 3
      }
    }
  },
  [Constants.JUMP_STATE] = {
    frames =  {
      {
        grid = '1-2',
        column = 4
      }
    }
  },
  [Constants.FALL_STATE] = {
    frames = {
      {
        grid = '3-4',
        column = 4,
      }
    }
  },
  [Constants.FIGHT_STATE] = {
    frames = {
      {
        grid = '3-8',
        column = 9,
      },
      {
        grid = '1-2',
        column = 10,
      }
    }
  },
  [Constants.DEAD_STATE] = {
    frames = {
      {
        grid = '1-7',
        column = 5,
      }
    },
    onLoop = 'pauseAtEnd'
  },
  [Constants.HIT_STATE] = {
    frames = {
      {
        grid = '7-8',
        column = 4
      }
    }
  }
}