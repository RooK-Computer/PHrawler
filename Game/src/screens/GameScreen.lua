require 'src/player/config/PlayersConfig' 

GameScreen = Screen:extend()

function GameScreen:new()
  self.name = 'GameScreen'

  return self
end

function GameScreen:load()
  game.world = love.physics.newWorld(0, game.gravity)
  game.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  game.level = Level(game.world, game.levelConfig.selectedLevel)
  game.level:setupLevel()

  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art


  game.inputManager:registerInput(KeyboardInput(), 'keyboard')
  game.inputManager:registerInput(GamepadInput(), 'gamepad')

  local playerNumber = game.levelConfig.selectedPlayerNumber
  local playersConfig = PlayersConfig.get(game.levelConfig.selectedPlayerNumber)
  --local playersConfig = PlayersConfig.beta


  for i,playerConfig in ipairs(playersConfig) do
    local player =  Player(playerConfig, game)
    player:setStartingPoint(game.level:getStartingPoint(i))
    player:setup()

    table.insert(game.players, player)
  end

end

function GameScreen:enter()
  local allPlayers = game.players

  for i, player in ipairs(allPlayers) do
    player:setInput()
  end

end

function GameScreen:update(dt)

  local allPlayers = game.players

  for i, player in ipairs(allPlayers) do
    player:update(dt)
  end

  game.world:update(dt)

end

function GameScreen:draw()

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
        love.graphics.print(player.name .. " active Input: ".. player.activeInput, statsPositionX, statsPositionY)
        --love.graphics.print(player.name .. " AnimDirection: ".. player.animationDirection .. ' / isFighting: ' .. tostring(player.isFighting), statsPositionX, statsPositionY)
        --statsPositionY = statsPositionY + 10            


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

end

function GameScreen:restart()

  game.players = {}
  game.screen = nil
  game.screen = GameScreen()
  game.screen:load()

end

function GameScreen:exit()
end