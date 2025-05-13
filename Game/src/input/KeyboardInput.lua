KeyboardInput = Object:extend()

function KeyboardInput:new()

  self.players = {}
  self.keys = {}
  self.registeredKeys = {}
  self.continuousInputKeys = {}
  return self

end

function KeyboardInput:registerPlayer(player)

  local keyboardInputs = player.controls

  for command, key in pairs(keyboardInputs) do 

    self.keys[key] = {}
    self.keys[key].id = player.id
    self.keys[key].command = command

    if command == 'left' or command == 'right' then
      self.continuousInputKeys[key] = {}
      self.continuousInputKeys[key].id = player.id
      self.continuousInputKeys[key].command = command
    else 

      self.registeredKeys[key] = {}
      self.registeredKeys[key].id = player.id
      self.registeredKeys[key].command = command

    end
  end

  self.players[player.id] = player
end

function KeyboardInput:checkForInput()

  local continuousInputKeys = self.continuousInputKeys

  for key, playerInfo in pairs(continuousInputKeys) do

    if love.keyboard.isDown(key) then 
      local player = self.players[playerInfo.id]
      player:inputStart(playerInfo.command)
    end

  end
end

function love.keypressed(key, scancode, isrepeat)
  game.inputManager.inputTypes.keyboard:keypressed(key, scancode, isrepeat)
end

function KeyboardInput:keypressed(key, scancode, isrepeat)

  local players = self.players
  local keys = self.registeredKeys

  if key == "." then game.activateDebug = not game.activateDebug end


  if key == "," then         
    print('######')

    for i, player in pairs(players) do
      print(player.name .. ' health: ' .. player.health)
    end
    print('######')
  end

  if isrepeat then 
    local stop = 1
  end

  for registeredKey, playerInfo in pairs(keys) do

    if key == registeredKey then 
      local player = players[playerInfo.id]
      player:inputStart(playerInfo.command)
      player.debug.keyPressed = key
    end

  end

end 



function love.keyreleased( key, scancode )
  game.inputManager.inputTypes.keyboard:keyreleased(key, scancode)
end 

function KeyboardInput:keyreleased(key, scancode, isrepeat)

  local players = self.players
  local keys = self.keys

  for registeredKey, playerInfo in pairs(keys) do

    if key == registeredKey then 
      local player = players[playerInfo.id]
      player:inputEnd(playerInfo.command)
      player.debug.keyReleased = key
    end

  end
end

