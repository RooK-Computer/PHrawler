GamepadInput = Object:extend()

function GamepadInput:new()
  self.name = 'gamepad'
  self.players = {}
  self.connectedGamepads = {}
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

    if command == 'left' or command == 'right' or command == 'fight' then
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

end


function GamepadInput:checkForInput()

  local continuousInputButtons = self.continuousInputButtons

  for playerID, buttons in pairs(continuousInputButtons) do


    if playerID == 'player_one' then
      local stop = 1
    end

    local playerGamepad = self.playerGamepads[playerID]
    if playerGamepad then 

      for button, command in pairs(buttons) do
        local player = self.players[playerID]

        if playerGamepad:isGamepadDown( button ) then
          player:inputStart(command)
          player.activeInput = self.name
          return
        end

        local analogStickleft = playerGamepad:getGamepadAxis("leftx")

        if analogStickleft == 0 then
          player:inputStart('idle')
        end

        if analogStickleft > 0 then
          player:inputStart('right')
          player.activeInput = self.name
        end
        if analogStickleft < 0 then
          player:inputStart('left')
          player.activeInput = self.name
        end

      end

    end
  end


end


function GamepadInput:addGamepad( joystick )

  local connectedGamepads = self.connectedGamepads

  if connectedGamepads[joystick:getGUID()] then return end

  local highestPriorityPlayer = { priority = 100 }

  for playerID, player in pairs(self.players) do 
    if highestPriorityPlayer.priority > player.priority and not player.hasGamepad then 
      highestPriorityPlayer = player
    end
  end

  highestPriorityPlayer.hasGamepad = true
  self.connectedGamepads[joystick:getGUID()] = highestPriorityPlayer
  self.playerGamepads[highestPriorityPlayer.id] = joystick
  highestPriorityPlayer.activeInput = self.name

end


function love.joystickadded( joystick )

  local isGamepad = joystick:isGamepad()
  if isGamepad then game.inputManager.inputTypes.gamepad:addGamepad(joystick) end
end 


function GamepadInput:gamepadpressed(joystick, pressedButton)

  local player = self.connectedGamepads[joystick:getGUID()]
  local registeredButtons = self.registeredButtons[player.id]

  for button, command in pairs(registeredButtons) do
    if pressedButton == button then 
      player:inputStart(command)
    end
  end
  player.activeInput = self.name

end

function GamepadInput:gamepadreleased(joystick, releasedButton)

  local player = self.connectedGamepads[joystick:getGUID()]
  local registeredButtons = self.buttons[player.id]


  for button, command in pairs(registeredButtons) do
    if releasedButton == button then 
      player:inputEnd(command)
    end
  end
  player.activeInput = self.name

end

function love.gamepadpressed( joystick, button )

  local isGamepad = joystick:isGamepad()
  if isGamepad then game.inputManager.inputTypes.gamepad:gamepadpressed(joystick, button) end

end


function love.gamepadreleased( joystick, button )
  local isGamepad = joystick:isGamepad()
  if isGamepad then game.inputManager.inputTypes.gamepad:gamepadreleased(joystick, button) end
end