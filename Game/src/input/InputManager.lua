require('src/input/KeyboardInput')
require('src/input/JoystickInput')
require('src/input/GamepadInput')



InputManager = Object:extend()

function InputManager:new()

  self.inputTypes = {}
  self.inputTypes.none = nil
  self.connectedGamepads  = {}

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

  self.connectedGamepads[joystick:getGUID()] = joystick
  if self.inputTypes.gamepad ~=  nil then self.inputTypes.gamepad:addGamepad(joystick) end

end 

function InputManager:getGamepads()
  return self.connectedGamepads
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

function love.gamepadpressed( joystick, button )
  if game.inputManager ==  nil or game.inputManager.inputTypes.gamepad == nil then return end

  local isGamepad = joystick:isGamepad()
  if isGamepad then game.inputManager.inputTypes.gamepad:gamepadpressed(joystick, button) end

end

function love.gamepadreleased( joystick, button )
  if game.inputManager ==  nil or game.inputManager.inputTypes.gamepad == nil then return end

  local isGamepad = joystick:isGamepad()
  if isGamepad then game.inputManager.inputTypes.gamepad:gamepadreleased(joystick, button) end
end