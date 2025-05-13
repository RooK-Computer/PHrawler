require('src/input/KeyboardInput')
require('src/input/JoystickInput')
require('src/input/GamepadInput')



InputManager = Object:extend()

function InputManager:new()

  self.inputTypes = {}
  self.inputTypes.keyboard = KeyboardInput()
  self.inputTypes.joystick = JoystickInput()
  self.inputTypes.gamepad = GamepadInput()

end


function InputManager:registerPlayer(player, type)

  self.inputTypes[type]:registerPlayer(player)
  return self.inputTypes[type]

end 
  
