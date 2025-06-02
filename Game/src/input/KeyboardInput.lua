KeyboardInput = Object:extend()

function KeyboardInput:new()
  self.name = 'keyboard'
  self.keys = {}
  self.registeredKeys = {}
  self.continuousInputKeys = {}
  return self

end

function KeyboardInput:registerPlayer(player, controls)

  local keyboardInputs = controls

  for command, key in pairs(keyboardInputs) do 

    self.keys[key] = {}
    self.keys[key].id = player.id
    self.keys[key].command = command

    if command == 'left' or command == 'right' or command == 'fight' then
      self.continuousInputKeys[key] = {}
      self.continuousInputKeys[key].id = player.id
      self.continuousInputKeys[key].command = command
    else 

      self.registeredKeys[key] = {}
      self.registeredKeys[key].id = player.id
      self.registeredKeys[key].command = command

    end
  end
end

function KeyboardInput:checkForInput()

  local continuousInputKeys = self.continuousInputKeys

  for key, playerInfo in pairs(continuousInputKeys) do

    if love.keyboard.isDown(key) then 
      local player = Helper.getPlayerById(playerInfo.id)
      if player ~= nil then
        player:inputStart(playerInfo.command)
        player.activeInput = self.name
      end
    end
  end

  return self
end

function love.keypressed(key, scancode, isrepeat)
  game.inputManager.inputTypes.keyboard:keypressed(key, scancode, isrepeat)
end

function KeyboardInput:keypressed(pressedKey, scancode, isrepeat)

  local players = game.players
  local keys = self.registeredKeys

  if pressedKey == "." then game.activateDebug = not game.activateDebug end


  if pressedKey == "," then         
    print('######')

    for i, player in pairs(players) do
      print(player.name .. ' health: ' .. player.health)
    end
    print('######')
  end

  for registeredKey, playerInfo in pairs(keys) do
    local player = Helper.getPlayerById(playerInfo.id)

    if player ~= nil and pressedKey == registeredKey then 
      player:inputStart(playerInfo.command)      
      player.debug.keyPressed = pressedKey
      player.activeInput = self.name

    end

  end


end



function love.keyreleased( key, scancode )
  game.inputManager.inputTypes.keyboard:keyreleased(key, scancode)
end 

function KeyboardInput:keyreleased(releasedKey, scancode, isrepeat)

  local keys = self.keys

  for registeredKey, playerInfo in pairs(keys) do

    if releasedKey == registeredKey then 
      local player = Helper.getPlayerById(playerInfo.id)

      if player ~= nil then 
        player:inputEnd(playerInfo.command)      
        player.debug.keyReleased = releasedKey
      end
    end

  end
end

