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
}
game.gravity = 9.81 * game.PIXELS_PER_METER


function love.load(arg)
  io.stdout:setvbuf("no") -- needed for print() to work in ZeroBrane Studios Editor
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- needed for debugging in ZeroBrane Studios Editor

  push:setupScreen(game.windowWidth, game.windowHeight, game.windowWidth, game.windowHeight, {
      fullscreen = false,
      vsync = true,
      resizable = true,
      highdpi = true
    })

  game.screen = StartScreen()

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
  push:finish()
end
