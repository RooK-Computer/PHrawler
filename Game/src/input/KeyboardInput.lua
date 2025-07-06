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

    if command == Constants.PLAYER_DIRECTION_LEFT or command == Constants.PLAYER_DIRECTION_RIGHT or command == Constants.PLAYER_FIGHT_COMMAND then
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

function KeyboardInput:keypressed(pressedKey, scancode, isrepeat)

  local players = game.players
  local registeredKeys = self.registeredKeys
  local allKeys = self.keys

  if pressedKey == "escape" then game.screen:pauseScreen() end


  if pressedKey == "." then game.activateDebug = not game.activateDebug end


  if pressedKey == "," then         
    print('######')

    for i, player in pairs(players) do
      print(player.name .. ' health: ' .. player.health)
    end
    print('######')
  end

  for key, playerInfo in pairs(allKeys) do 
    local player = Helper.getPlayerById(playerInfo.id)

    -- first check if keyboard was pressed by player so we can hotswap the active input to keyboard
    if player ~= nil and pressedKey == key then 

      player.activeInput = self.name

      -- after that we check if this key should send a command
      for registeredKey, playerInfo in pairs(registeredKeys) do

        if pressedKey == registeredKey then
          player:inputStart(playerInfo.command)      
        end
      end

    end

  end 



end


function KeyboardInput:keyreleased(releasedKey, scancode, isrepeat)

  local keys = self.keys

  for registeredKey, playerInfo in pairs(keys) do

    if releasedKey == registeredKey then 
      local player = Helper.getPlayerById(playerInfo.id)

      if player ~= nil then 
        player:inputEnd(playerInfo.command)      
      end
    end

  end
end

