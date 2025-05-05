require 'init'


game = {
  windowWidth = 640,
  windowHeight = 480,
  scale = 1,
  activateDebug = false,
  PIXELS_PER_METER = 100,
  savedAnimationDuration = 0,
  stateActive = false,
  level = {},
  world = {},
  players = {},
}


function love.load(arg)
  io.stdout:setvbuf("no") -- needed for print() to work in ZeroBrane Studios Editor
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- needed for debugging in ZeroBrane Studios Editor

  game.world = windfield.newWorld(0, 9.81 * game.PIXELS_PER_METER)
  game.level = Level(game.world, {level = 'betastage'})
  game.inputManager = InputManager()


  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
  push:setupScreen(game.windowWidth, game.windowHeight, game.windowWidth, game.windowHeight, {
      fullscreen = false,
      vsync = true,
      resizable = true,
      highdpi = true
    })

  require 'src/player/tmpPlayersConfig' 

  for i = 1, #tmpPlayersConfig do

    local player = Player(tmpPlayersConfig[i], game)
    table.insert(game.players, player)

  end

end

function love.update(dt)


  for i = 1, #game.players do
    game.players[i]:update(dt)
  end

  game.world:update(dt)
end

function love.resize(w, h)
  push:resize(w, h)
end


function love.draw()

  push:start()
  game.level:draw()    
  for i = 1, #game.players do
    game.players[i]:draw()
  end

  if game.activateDebug then 

    local statsPositionX = 10
    local statsPositionY = 10
    game.world:draw() 
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), statsPositionY, statsPositionX)


    for i = 1, #game.players do
      statsPositionX = statsPositionX + 10
      local player = game.players[i]
      love.graphics.print(player.name .. " State: ".. player.state.name, statsPositionY, statsPositionX)
    end


  end
  push:finish()
end


