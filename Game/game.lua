game = {}
game.defaultConfig = function() -- needed for restart purposes
  return {
    -- START CONSTANST 
    -- can potentially be overwritten by settings or save files 
    -- TODO: ALL CAPS REWRITE!
    version = "0.6.0...road.to.bielefeld",
    windowWidth = 640,
    windowHeight = 480,
    scale = 1,
    activateDebug = false,
    showFPS = false,
    PIXELS_PER_METER = Constants.PIXELS_PER_METER,
    gravity = 9.81 * Constants.PIXELS_PER_METER,
    -- END CONSTANTS
    levels = {Constants.LEVEL_1, Constants.LEVEL_0},
    defaultFont = love.graphics.getFont(), -- used if no font is found
    font = love.graphics.getFont(), -- can be overwritten by level or screen config
    minSupportedPlayerNumber = 2,
    maxSupportedPlayerNumber = 8,
    connectedGamepads = {},
  }

end

game.getConfig = function() return game end
game.config = {} -- I want to potentially rename and reorganize the config - in order to not break code right now, I'll use this config
game.config = game.defaultConfig()


game = game.defaultConfig()


game.start = function()
  game.players = {}
  game.screens = Stack()
  game.inputManager = InputManager()
  game.switchScreen(RookScreen())
end

game.restart = function()
  game.players = {}
  game.screens = Stack()
  love.audio.stop()
  game.inputManager:restart()
  game.switchScreen(StartScreen(GameSession()))
end

game.switchScreen = function(screen)
  while(not game.screens:isEmpty()) do
    local oldScreen = game.screens:pop()
    oldScreen:exit()
  end
  game.screens:push(screen)
  screen:load()
  screen:enter()
end

game.pushScreen = function(screen)
  game.screens:push(screen)
  screen:load()
  screen:enter()
end

game.popScreen = function()
  local screen = game.screens:pop()
  screen:exit()
end

game.screen = function()
  return game.screens:peek(game.screens:size() - 1)
end

game.endGame = function()

end

