require('src/input/KeyboardInput')
require('src/input/JoystickInput')
require('src/input/GamepadInput')



InputManager = Object:extend()

function InputManager:new()

  self.inputTypes = {}
  self.inputTypes.keyboard = KeyboardInput()
  self.inputTypes.joystick = JoystickInput()
  self.inputTypes.gamepad = GamepadInput()
  self.inputTypes.none = nil

end


function InputManager:registerPlayer(player, type, controls)

  self.inputTypes[type]:registerPlayer(player, controls)
  return self.inputTypes[type]

end 
  
