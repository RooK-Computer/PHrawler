require 'init'


game = {
  windowWidth = 640,
  windowHeight = 480,
  scale = 1,
  activateDebug = false,
  PIXELS_PER_METER = 100,
  savedAnimationDuration = 0,
  level = {},
  world = {},
  players = {},
}
game.gravity = 9.81 * game.PIXELS_PER_METER


function love.load(arg)
  io.stdout:setvbuf("no") -- needed for print() to work in ZeroBrane Studios Editor
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- needed for debugging in ZeroBrane Studios Editor

  game.world = windfield.newWorld(0, game.gravity)
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
  
  local playersConfig = tmpPlayersConfig
  --playersConfig = {}
  --table.insert(playersConfig, table.remove(tmpPlayersConfig, 1))

  for i,playerConfig in pairs(playersConfig) do
    local player =  Player(playerConfig, game)
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
      statsPositionX = statsPositionX + 20
      local player = game.players[i]
      --local vx, vy = player.colliders.playerCollider:getLinearVelocity()
      love.graphics.print(player.name .. " State: ".. player.state.name, statsPositionY, statsPositionX)
      statsPositionX = statsPositionX + 10
      love.graphics.print(player.name .. " isOnGround: " .. tostring(player.isOnGround), statsPositionY, statsPositionX)      
      
      statsPositionX = statsPositionX + 10
      love.graphics.print(player.name .. " hasJumped: " .. tostring(player.hasJumped), statsPositionY, statsPositionX)
      
    end


  end
  push:finish()
end


