require 'init'


game = {
  windowWidth = 640,
  windowHeight = 480,
  scale = 1,
  activateDebug = false,
  PIXELS_PER_METER = 100,
  level = {},
  world = {},
  players = {},
  showFPS = false,
}
game.gravity = 9.81 * game.PIXELS_PER_METER

game.start = function()
  game.players = {}
  game.screen = nil
  game.screen = StartScreen()
  game.screen:load()
end


game.restart = function()
  game.start()
end


game.endGame = function()
  
end


function love.load(arg)
  io.stdout:setvbuf("no") -- needed for print() to work in ZeroBrane Studios Editor
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- needed for debugging in ZeroBrane Studios Editor

  push:setupScreen(game.windowWidth, game.windowHeight, game.windowWidth, game.windowHeight, {
      fullscreen = false,
      vsync = true,
      resizable = true,
      highdpi = true
    })

  game.start()

  --game.screen = GameScreen()
  --game.screen:load()

end

function love.update(dt)
  game.screen:update(dt)
end

function love.resize(w, h)
  push:resize(w, h)
end


function love.draw()
  push:start()
  game.screen:draw()
  if game.showFPS then love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10) end
  push:finish()
end
