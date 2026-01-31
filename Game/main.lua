require 'init'

function love.load(arg)
  io.stdout:setvbuf("no") -- needed for print() to work in ZeroBrane Studios Editor
  local fullscreen = arg[1] ~= "-windowed" or false
  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
    fullscreen = false 
  end -- needed for debugging in ZeroBrane Studios Editor

  push:setupScreen(game.windowWidth, game.windowHeight, game.windowWidth, game.windowHeight, {
      fullscreen = fullscreen,
      vsync = true,
      resizable = true,
      highdpi = true
    })

  game.start()

end

function love.update(dt)
  local offset = game.screens:size() - 1
  while offset >= 0 do
    local screen = game.screens:peek(offset)
    screen:update(dt)
    offset = offset - 1
  end
end

function love.resize(w, h)
  push:resize(w, h)
end


function love.draw()
  push:start()
  local offset = game.screens:size() - 1
  while offset >= 0 do
    local screen = game.screens:peek(offset)
    screen:draw()
    offset = offset - 1
  end
  if game.showFPS then love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10) end
  push:finish()
end
