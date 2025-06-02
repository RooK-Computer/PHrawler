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

  game.world = love.physics.newWorld(0, game.gravity)
  game.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  game.level = Level(game.world, {level = 'betastage'})
  game.inputManager = InputManager()


  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
  push:setupScreen(game.windowWidth, game.windowHeight, game.windowWidth, game.windowHeight, {
      fullscreen = false,
      vsync = true,
      resizable = true,
      highdpi = true
    })

  require 'src/player/config/PlayersConfig' 

  local playersConfig = PlayersConfig

  --playersConfig = {}
  --table.insert(playersConfig, table.remove(PlayersConfig, 1)) --only insert player 1
  --table.insert(playersConfig, table.remove(PlayersConfig, 1)) --only insert player 2
  --table.insert(playersConfig, table.remove(PlayersConfig, 1)) --only insert player 3
  --table.insert(playersConfig, table.remove(PlayersConfig, 1)) --only insert player 4

  for i,playerConfig in ipairs(playersConfig) do
    local player =  Player(playerConfig, game)
    player:setStartingPoint(game.level:getStartingPoint(i))
    player:setup()

    table.insert(game.players, player)
  end


end

function love.update(dt)

  local allPlayers = game.players

  for i, player in ipairs(allPlayers) do
    player:update(dt)
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
    Helper.drawDebug(game.world)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), statsPositionY, statsPositionX)


    for i = 1, #game.players do
      if i > 32 then
      else 
        statsPositionY = statsPositionY + 20
        local player = game.players[i]
        --love.graphics.print(player.name .. " active Input: ".. player.activeInput, statsPositionX, statsPositionY)
        love.graphics.print(player.name .. " AnimDirection: ".. player.animationDirection .. ' / isFighting: ' .. tostring(player.isFighting), statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10            


        love.graphics.print(player.name .. " health: ".. player.health, statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10   

        --local velocityX, velocityY = player.physics.body:getLinearVelocity()

        --love.graphics.print(player.name .. " velocityX: ".. velocityX .. " | velocityY: " .. velocityY , statsPositionX, statsPositionY)
        --statsPositionY = statsPositionY + 10      

        --love.graphics.print(player.name .. " State: ".. player.state.name, statsPositionX, statsPositionY)
        --statsPositionY = statsPositionY + 10
        --love.graphics.print(player.name .. " isOnGround: " .. tostring(player.isOnGround), statsPositionX, statsPositionY)      

        --statsPositionY = statsPositionY + 10
        --love.graphics.print(player.name .. " hasJumped: " .. tostring(player.hasJumped), statsPositionX, statsPositionY)
      end
    end


  end
  push:finish()
end
