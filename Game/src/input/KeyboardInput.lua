KeyboardInput = Object:extend()

function KeyboardInput:new()

  self.players = {}
  self.registeredKeys = {}
  self.keysHaveRepeatInput = {}
  return self

end

function KeyboardInput:registerPlayer(player)

  local keys = player.controls

  for command, key in pairs(keys) do 
    self.registeredKeys[key] = {}
    self.registeredKeys[key].id = player.id
    self.registeredKeys[key].command = command

    if command == 'left' or command == 'right' then 
      self.keysHaveRepeatInput[key] = {}
      self.keysHaveRepeatInput[key].id = player.id
      self.keysHaveRepeatInput[key].command = 'idle'
    end
  end

  self.players[player.id] = player
end

function KeyboardInput:checkForInput()

  local registeredKeys = self.registeredKeys

  for key, playerInfo in pairs(registeredKeys) do

    if love.keyboard.isDown(key) then 
      local player = self.players[playerInfo.id]
      player:input(playerInfo.command)
    end

  end
end



function KeyboardInput:keypressed(key, scancode, isrepeat)

  local players = self.players
  local keys = self.registeredKeys

  if key == "." then game.activateDebug = not game.activateDebug end


  if key == "," then         
    print('######')

    for i, player in pairs(players) do
      local test = player

      print(player.name .. ' health: ' .. player.health)
    end
    print('######')
  end

end 


function love.keypressed(key, scancode, isrepeat)
  game.inputManager.inputTypes.keyboard:keypressed(key, scancode, isrepeat)
end


function KeyboardInput:keyreleased(key, scancode, isrepeat)

  local keysHaveRepeatInput = self.keysHaveRepeatInput

  for repeatKey, playerInfo in pairs(keysHaveRepeatInput) do

    if key == repeatKey then 
      local player = self.players[playerInfo.id]
      player:input(playerInfo.command)
    end

  end

end

function love.keyreleased( key, scancode )
  game.inputManager.inputTypes.keyboard:keyreleased(key, scancode)
end 