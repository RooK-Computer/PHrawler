animationConfig = {
  idle = {
    frames = {
      {
        grid = '1-8',
        column = 1
      }
    }
  },
  running = {
    frames = {
      {
        grid = '1-8',
        column = 3
      }
    }
  },
  jump = {
    frames =  {
      {
        grid = '1-2',
        column = 4
      }
    }
  },
  falling = {
    frames = {
      {
        grid = '3-4',
        column = 4,
      }
    }
  },
  fighting = {
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
  dying = {
    frames = {
      {
        grid = '1-7',
        column = 5,
      }
    },
    onLoop = 'pauseAtEnd'
  }
}