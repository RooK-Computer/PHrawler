require 'src/player/config/PlayersConfig' 
require 'src/screens/level/PlayerInput'

LevelScreen = Screen:extend()

function LevelScreen:new(session)
  self.name = 'LevelScreen'
  self.isPaused = false
  self.isEnded = false
  self.session = session
  return self
end

function LevelScreen:load()
  self.session.instance.world = love.physics.newWorld(0, game.gravity)
  self.session.instance.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  self.session.instance.level = Level(self.session.instance.world, self.session.setup.selectedLevel)
  self.session.instance.level:setupLevel()

  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
  love.graphics.setFont(game.defaultFont)


  local playerNumber = self.session.setup.numberOfPlayers
  local playersConfig = self.session.setup.players

  for i,playerConfig in ipairs(playersConfig) do
    local player =  Player(playerConfig, self.session)
    player:setStartingPoint(self.session.instance.level:getStartingPoint(i))
    player:setup()

    table.insert(self.session.instance.players, player)
  end

end

function LevelScreen:enter()
  local allPlayers = self.session.instance.players
  for i, player in ipairs(allPlayers) do
    game.inputManager.HandlerStack:push(PlayerInput(self,player,{player.config.registeredGamepad},player.controls.inputs.gamepad))
  end
  self.session.instance.level:enterLevel()

end

function LevelScreen:update(dt)
  if self.isPaused or self.isEnded then return end

  local allPlayers = self.session.instance.players
  
  if #allPlayers == 1 then self:endScreen() end

  for i, player in ipairs(allPlayers) do
    player:update(dt)
  end

  self.session.instance.world:update(dt)

end

function LevelScreen:draw()

  self.session.instance.level:draw()    
  for i = 1, #self.session.instance.players do
    self.session.instance.players[i]:draw()
  end

  if game.activateDebug then 

    local statsPositionX = 10
    local statsPositionY = 10
    Helper.drawDebug(game.world)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), statsPositionY, statsPositionX)


    for i = 1, #self.session.instance.players do
      if i > 32 then
      else 
        statsPositionY = statsPositionY + 20
        local player = self.session.instance.players[i]
        
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

function LevelScreen:restartGame()

  self.session.instance.players = {}
  game.switchScreen(LevelScreen(self.session))
end


function LevelScreen:endScreen()

  if self.isEnded then return end
  self.isEnded = true

  game.pushScreen(EndScreen())
end


function LevelScreen:pauseScreen()

  if self.isEnded then return end
  self.isPaused = true
  game.pushScreen(PauseScreen())

end

function LevelScreen:resume()

  self.isPaused = false
  game.popScreen()
end

function LevelScreen:exit()
  for i, player in ipairs(game.players) do
    game.inputManager.HandlerStack:pop()
  end
  game.level:exitLevel()
end