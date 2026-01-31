require 'src/player/config/PlayersConfig' 
require 'src/screens/game/PlayerInput'

GameScreen = Screen:extend()

function GameScreen:new()
  self.name = 'GameScreen'
  self.isPaused = false
  self.isEnded = false
  return self
end

function GameScreen:load()
  game.world = love.physics.newWorld(0, game.gravity)
  game.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  game.level = Level(game.world, game.levelConfig.selectedLevel)
  game.level:setupLevel()

  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
  love.graphics.setFont(game.defaultFont)


  game.inputManager:registerInput(KeyboardInput(), 'keyboard')

  local playerNumber = game.levelConfig.selectedPlayerNumber
  local playersConfig = PlayersConfig.get(game.levelConfig.selectedPlayerNumber)

  for i,playerConfig in ipairs(playersConfig) do
    local player =  Player(playerConfig, game)
    player:setStartingPoint(game.level:getStartingPoint(i))
    player:setup()

    table.insert(game.players, player)
  end

end

function GameScreen:enter()
  local allPlayers = game.players
  local gamepads = game.inputManager.gamepadStates
  local gamePad = 1
  for i, player in ipairs(allPlayers) do
    local inputs = {gamePad}
    if gamepads[gamePad] == nil then
      inputs = {}
    end
    gamePad = gamePad + 1

    game.inputManager.HandlerStack:push(PlayerInput(self,player,inputs,player.controls.inputs.gamepad))
  end

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
        love.graphics.print(player.name .. " active Input: ".. player.activeInput, statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10            


        love.graphics.print(player.name .. " health: ".. player.health, statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10   

        local velocityX, velocityY = player.physics.body:getLinearVelocity()

        love.graphics.print(player.name .. " velocityX: ".. velocityX .. " | velocityY: " .. velocityY , statsPositionX, statsPositionY)
        statsPositionY = statsPositionY + 10      

        love.graphics.print(player.name .. " isOnGround: " .. tostring(player.isOnGround), statsPositionX, statsPositionY)      

      end
    end


  end

  if self.isPaused then

    self.pausescreen:draw()
  end

  if self.isEnded then
    self.endscreen:draw()
  end

end

function GameScreen:restartGame()

  game.players = {}
  game.switchScreen(GameScreen())
end


function GameScreen:endScreen()

  if self.isEnded then return end
  self.isEnded = true

  game.inputManager:registerInput(EndScreenKeyboardInput(), 'keyboard')
  game.inputManager:registerInput(EndScreenGamepadInput(), 'gamepad')

  self.endscreen = EndScreen()

end


function GameScreen:pauseScreen()

  if self.isEnded then return end
  self.isPaused = true

  game.inputManager:registerInput(PauseScreenKeyboardInput(), 'keyboard')
  game.inputManager:registerInput(PauseScreenGamepadInput(), 'gamepad')

  self.pausescreen = PauseScreen()

end

function GameScreen:resume()

  self.isPaused = false

  game.inputManager:registerInput(KeyboardInput(), 'keyboard')
  game.inputManager:registerInput(GamepadInput(), 'gamepad')

  for i, player in ipairs(game.players) do
    player:setupInput()
  end

  self:enter()

end

function GameScreen:exit()
  for i, player in ipairs(game.players) do
    game.inputManager.HandlerStack:pop()
  end
  game.restart()
end