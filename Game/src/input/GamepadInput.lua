GamepadInput = Object:extend()

function GamepadInput:new()
  self.name = 'gamepad'
  self.players = {}
  self.connectedGamepads = game.inputManager:getGamepads()
  self.buttons = {}
  self.registeredButtons = {}
  self.continuousInputButtons = {}
  self.playerGamepads = {}
  self.analogeStickUsed = false

  return self

end

function GamepadInput:registerPlayer(player, controls)

  local gamepadInputs = controls

  local playerID = player.id
  self.buttons[playerID] = {}      
  self.continuousInputButtons[playerID] = {}      
  self.registeredButtons[playerID] = {}


  for command, buttons in pairs(gamepadInputs) do 

    for i, button in ipairs(buttons) do

      self.buttons[playerID][button] = {}
      self.buttons[playerID][button] = command

      if command == Constants.PLAYER_DIRECTION_LEFT or command == Constants.PLAYER_DIRECTION_RIGHT or command == Constants.PLAYER_FIGHT_COMMAND then
        self.continuousInputButtons[playerID][button] = {}
        self.continuousInputButtons[playerID][button] = command
      else 
        self.registeredButtons[playerID][button] = {}
        self.registeredButtons[playerID][button] = command
      end
    end

  end

  self.players[player.id] = player

  local sortedPlayersByPriority = {}

  for key, registeredPlayer in pairs(self.players) do
    sortedPlayersByPriority[registeredPlayer.priority] = registeredPlayer
  end


  for key, sortedPlayers in pairs(sortedPlayersByPriority) do
    self.players[sortedPlayers.id] = sortedPlayers
  end

  local joysticks = love.joystick.getJoysticks()
  for i, joystick in pairs(joysticks) do
    self:addGamepad( joystick )
  end

end


function GamepadInput:checkForInput()

  local continuousInputButtons = self.continuousInputButtons


  for playerID, buttons in pairs(continuousInputButtons) do

    local playerGamepad = self.playerGamepads[playerID]
    if playerGamepad then 

      self:checkForRestart(playerGamepad)

      for button, command in pairs(buttons) do
        local player = self.players[playerID]

        if not player.isDead and playerGamepad:isGamepadDown( button ) then
          player:inputStart(command)
          player.activeInput = self.name
          self.analogeStickUsed = false
          break
        end

        if not player.isDead then 
          local analogStickleft = playerGamepad:getGamepadAxis("leftx")

          if self.analogeStickUsed and analogStickleft == 0 then
            player:inputStart('idle')
          end

          if analogStickleft > 0 then
            player:inputStart('right')
            self.analogeStickUsed  = true
            player.activeInput = self.name
          end
          if analogStickleft < 0 then
            player:inputStart('left')
            self.analogeStickUsed = true
            player.activeInput = self.name
          end
        end

      end

    end
  end


end


function GamepadInput:addGamepad( joystick )

  local connectedGamepads = self.connectedGamepads

  if connectedGamepads[joystick:getGUID()] then return end

  local highestPriorityPlayer = { priority = 100, notPlayer = true }

  for playerID, player in pairs(self.players) do 
    if highestPriorityPlayer.priority > player.priority and not player.hasGamepad then 
      highestPriorityPlayer = player
    end
  end
  
  if highestPriorityPlayer.notPlayer then return end
  
  
  local vendorID, productID, productVersion = joystick:getDeviceInfo()
  local deviceName = joystick:getName()

  highestPriorityPlayer.hasGamepad = true
  self.connectedGamepads[joystick:getGUID()] = highestPriorityPlayer
  self.playerGamepads[highestPriorityPlayer.id] = joystick
  highestPriorityPlayer.activeInput = self.name

end


function GamepadInput:gamepadpressed(joystick, pressedButton)

  local player = self.connectedGamepads[joystick:getGUID()]
  local registeredButtons = self.registeredButtons[player.id]

  for button, command in pairs(registeredButtons) do
    if pressedButton == button and not player.isDead then 
      player:inputStart(command)
    end
  end
  player.activeInput = self.name

end

function GamepadInput:gamepadreleased(joystick, releasedButton)

  local player = self.connectedGamepads[joystick:getGUID()]
  local registeredButtons = self.buttons[player.id]


  for button, command in pairs(registeredButtons) do
    if releasedButton == button and not player.isDead then 
      player:inputEnd(command)
    end
  end
  player.activeInput = self.name


  if releasedButton == 'back' then game.showFPS = not game.showFPS end
  if releasedButton == 'start' then game.screen:pauseScreen() end

end

function GamepadInput:checkForRestart(playerGamepad)

  if playerGamepad:isGamepadDown('a') and
  playerGamepad:isGamepadDown('b') and
  playerGamepad:isGamepadDown('x') and
  playerGamepad:isGamepadDown('y') and
  playerGamepad:isGamepadDown('start') then
    game.screen.restartGame()
  end

end

