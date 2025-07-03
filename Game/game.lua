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
    supportedPlayerNumbers = {2,3,4},
    --supportedPlayerNumbers = {2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}, 
    showFPS = false,
    version = 0.4,
  }

end

game = game.defaultConfig()

game.gravity = 9.81 * game.PIXELS_PER_METER

game.start = function()
  game.players = {}
  game.screen = nil
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

