game = {}
game.defaultConfig = function() -- needed for restart purposes
  return {
    windowWidth = 640,
    windowHeight = 480,
    scale = 1,
    activateDebug = false,
    PIXELS_PER_METER = 100,
    levels = {Constants.LEVEL_1},
    world = {},
    players = {},
    defaultFont = love.graphics.getFont(),
    levelConfig = {
      selectedPlayerNumber = 2,
      selectedLevel = Constants.LEVEL_1
    },
    minSupportedPlayerNumber = 2,
    maxSupportedPlayerNumber = 8,
    connectedGamepads = {},
    showFPS = false,
    version = "0.5...nbg",
  }

end

game = game.defaultConfig()

game.gravity = 9.81 * game.PIXELS_PER_METER

game.start = function()
  game.players = {}
  game.screen = nil
  game.inputManager = InputManager()
  game.screen = RookScreen()
  game.screen:load()
end

game.restart = function()
  game.players = {}
  game.screen = nil
  game.screen = StartScreen()
  game.screen:load()
end


game.endGame = function()

end

