require 'src/player/config/PlayersConfig' 
require 'src/screens/game/PlayerInput'

GameScreen = Screen:extend()

function GameScreen:new(playersConfig)
  self.name = 'GameScreen'
  self.isPaused = false
  self.isEnded = false
  self.playersConfig = playersConfig
  return self
end

function GameScreen:load()
  game.world = love.physics.newWorld(0, game.gravity)
  game.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  game.level = Level(game.world, game.levelConfig.selectedLevel)
  game.level:setupLevel()

  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
  love.graphics.setFont(game.defaultFont)


  local playerNumber = game.levelConfig.selectedPlayerNumber
  local playersConfig = self.playersConfig

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
    game.inputManager.HandlerStack:push(PlayerInput(self,player,{player.config.registeredGamepad},player.controls.inputs.gamepad))
  end
  game.level:enterLevel()

end

function GameScreen:update(dt)
  if self.isPaused or self.isEnded then return end

  local allPlayers = game.players
  
  if #allPlayers == 1 then self:endScreen() end

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
        
        local color = {0, 0, 0} -- black
        
        love.graphics.print({ color, player.name .. " active Input: ".. player.activeInput}, statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10            


        love.graphics.print({ color, player.name .. " health: ".. player.health }, statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10   

        local velocityX, velocityY = player.physics.body:getLinearVelocity()

        love.graphics.print({ color, player.name .. " velocityY: " .. velocityY}, statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10    
        
        love.graphics.print({ color, player.name .. " | velocityX: ".. velocityX }, statsPositionX, statsPositionY)
        
        statsPositionY = statsPositionY + 10      

        love.graphics.print({ color,player.name .. " isOnGround: " .. tostring(player.isOnGround)}, statsPositionX, statsPositionY) 
        
        statsPositionY = statsPositionY + 10            
        local activeStates = player:getActiveStates()
        local statesString = ''
        
          
        for i, state in ipairs(activeStates) do
          statesString = statesString .. ' ' .. state
        end
  
        
        love.graphics.print({ color, player.name .. " active States: ".. statesString}, statsPositionX, statsPositionY)

      end
    end


  end

end

function GameScreen:restartGame()

  game.players = {}
  game.switchScreen(GameScreen(self.playersConfig))
end


function GameScreen:endScreen()

  if self.isEnded then return end
  self.isEnded = true

  game.pushScreen(EndScreen())
end


function GameScreen:pauseScreen()

  if self.isEnded then return end
  self.isPaused = true
  game.pushScreen(PauseScreen())

end

function GameScreen:resume()

  self.isPaused = false
  game.popScreen()
end

function GameScreen:exit()
  for i, player in ipairs(game.players) do
    game.inputManager.HandlerStack:pop()
  end
  game.level:exitLevel()
end