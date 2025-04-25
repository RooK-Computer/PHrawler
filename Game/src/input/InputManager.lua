require('src/input/KeyboardInput')
require('src/input/JoystickInput')



InputManager = Object:extend()

function InputManager:new()

  self.inputTypes = {}
  self.inputTypes.keyboard = KeyboardInput()
  self.inputTypes.joystick = JoystickInput()

end


function InputManager:registerPlayer(player, type)

  self.inputTypes[type]:registerPlayer(player)
  return self.inputTypes[type]

end 
  
