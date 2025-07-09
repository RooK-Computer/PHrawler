GamepadInput = Object:extend()

function GamepadInput:new()
  self.name = 'gamepad'
  self.players = {}
  self.connectedGamepads = game.inputManager:getGamepads()
  self.buttons = {}
  self.registeredButtons = {}
  self.continuousInputButtons = {}
  self.playerGamepads = {}

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



  self:connectGamepadWithPlayer(player)


end


function GamepadInput:checkForInput()

  local continuousInputButtons = self.continuousInputButtons


  for playerID, buttons in pairs(continuousInputButtons) do

    local playerGamepad = self.playerGamepads[playerID]
    if playerGamepad then 

      self:checkForDebug(playerGamepad)

      for button, command in pairs(buttons) do
        local player = self.players[playerID]

        if not player.isDead and playerGamepad:isGamepadDown( button ) then
          player:inputStart(command)
          player.activeInput = self.name

        end

      end

    end
  end


end

function GamepadInput:addGamepad( joystick )

end



function GamepadInput:connectGamepadWithPlayer( player )


  for joystickID, joystick in pairs(self.connectedGamepads) do
    
    if self.playerGamepads[joystickID] == nil then 
      self.playerGamepads[joystickID] = player
      self.playerGamepads[player.id] = joystick
      player.activeInput = self.name
    end

  end

end


function GamepadInput:gamepadpressed(joystick, pressedButton)

  local player = self.playerGamepads[joystick:getID()]
  local registeredButtons = self.registeredButtons[player.id]

  for button, command in pairs(registeredButtons) do
    if pressedButton == button and not player.isDead then 
      player:inputStart(command)
    end
  end
  player.activeInput = self.name

end

function GamepadInput:gamepadreleased(joystick, releasedButton)

  local player = self.playerGamepads[joystick:getID()]
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

function GamepadInput:checkForDebug(playerGamepad)

  if playerGamepad:isGamepadDown('leftshoulder') and
  playerGamepad:isGamepadDown('rightshoulder') and
  playerGamepad:isGamepadDown('x') then
    game.activateDebug = true
  end  
  
  if playerGamepad:isGamepadDown('leftshoulder') and
  playerGamepad:isGamepadDown('rightshoulder') and
  playerGamepad:isGamepadDown('y') then
    game.activateDebug = false
  end

end

