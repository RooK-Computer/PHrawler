require('src/input/KeyboardInput')
require('src/input/JoystickInput')
require('src/input/GamepadState')
require('src/input/InputHandler')

InputManager = Object:extend()

function InputManager:new()

  self.inputTypes = {}
  self.inputTypes.none = nil
  self.gamepadStates = {}
  self.HandlerStack = Stack()
--  self.HandlerStack:push(AssertiveInputHandler())
  self.HandlerStack:push(InputHandler())
end

function InputManager:registerInput(input, type)

  self.inputTypes[type] = input
end


function InputManager:getInput(type)
  return self.inputTypes[type]
end


function InputManager:registerPlayer(player, type, controls)

  self.inputTypes[type]:registerPlayer(player, controls)
  return self.inputTypes[type]

end

function InputManager:addGamepad(joystick)

  self.gamepadStates[joystick:getID()] = GamepadState()
  game.connectedGamepads[joystick:getID()] = joystick --we need to store it here so it outlives a new InputManager instance...
  if self.inputTypes.gamepad ~=  nil then self.inputTypes.gamepad:addGamepad(joystick) end

end 

function InputManager:removeGamepad(joystick)

  self.gamepadStates[joystick:getID()] = nil
  for i, gamepad in ipairs(game.connectedGamepads) do 

    if gamepad:getID() == joystick:getID() then 
      table.remove(game.connectedGamepads, i)
    end
  end

end 

function InputManager:getGamepads()
  return game.connectedGamepads 
end 

function InputManager:OnPress(joystick, button)
  local offset = 0
  local handled = false
  while handled == false do
    local handler = self.HandlerStack:peek(offset)
    local inputs = handler:AllowedInputDevices()
    local allowed = false
    for k,v in pairs(inputs) do
      if v == joystick:getID() then
        allowed = true
      end
    end
    if allowed then
      handler:OnPress(joystick, button)
      handled = true
    else 
      offset = offset + 1
    end
  end
end

function InputManager:OnRelease(joystick, button)
  local offset = 0
  local handled = false
  while handled == false do
    local handler = self.HandlerStack:peek(offset)
    local inputs = handler:AllowedInputDevices()
    local allowed = false
    for k,v in pairs(inputs) do
      if v == joystick:getID() then
        allowed = true
      end
    end
    if allowed then
      handler:OnRelease(joystick, button)
      handled = true
    else 
      offset = offset + 1
    end
  end
end

--keyboard Input

function love.keyreleased( key, scancode )
  if game.inputManager ~=  nil then
    if game.inputManager.inputTypes.keyboard ~= nil then game.inputManager.inputTypes.keyboard:keyreleased(key, scancode) end
  end
end 

function love.keypressed(key, scancode, isrepeat)
  if game.inputManager ~=  nil then
    if game.inputManager.inputTypes.keyboard ~= nil then game.inputManager.inputTypes.keyboard:keypressed(key, scancode, isrepeat) end
  end
end

--gamepad Input
function love.joystickadded( joystick )

  if game.inputManager ==  nil then return end

  local isGamepad = joystick:isGamepad()
  if isGamepad then 

    game.inputManager:addGamepad(joystick)    

  end
end 

function love.joystickremoved(joystick)
  if game.inputManager ==  nil then return end
  local isGamepad = joystick:isGamepad()
  if isGamepad then 

    game.inputManager:removeGamepad(joystick)    

  end

end

function love.gamepadpressed( joystick, button )

  local isGamepad = joystick:isGamepad()
  if isGamepad then 
    if not game.inputManager.gamepadStates[joystick:getID()] then
      game.inputManager.gamepadStates[joystick:getID()] = GamepadState()
    end
    if game.inputManager.gamepadStates[joystick:getID()]:isReleased(button) then
      game.inputManager.gamepadStates[joystick:getID()]:press(button)
      if game.inputManager.inputTypes.gamepad ~= nil then
        game.inputManager.inputTypes.gamepad:gamepadpressed(joystick, button)
      end
      game.inputManager:OnPress(joystick, button)
    end
  end

end

function love.gamepadreleased( joystick, button )

  local isGamepad = joystick:isGamepad()
  if isGamepad then
    if not game.inputManager.gamepadStates[joystick:getID()] then
      game.inputManager.gamepadStates[joystick:getID()] = GamepadState()
    end
    if game.inputManager.gamepadStates[joystick:getID()]:isPressed(button) then
      game.inputManager.gamepadStates[joystick:getID()]:release(button)
      if game.inputManager.inputTypes.gamepad ~= nil then
        game.inputManager.inputTypes.gamepad:gamepadreleased(joystick, button)
      end
      game.inputManager:OnRelease(joystick, button)
    end
  end
end
