EndScreen = Object:extend()
function EndScreen:new()
  self.name = 'Endscreen'


  local fontPartyPack = love.graphics.newFont( '/assets/fonts/Party_Pack_Normal.ttf' )
  local newGameFont = love.graphics.newFont( '/assets/fonts/NewGameFont.ttf' )

  self.font = newGameFont
  self.font:setFilter("nearest")
  love.graphics.setFont(self.font)

  self.activeIndicator = love.graphics.newImage('assets/images/triangle_points_right.png')
  self.activeItemIndex = 1
  self.menuItems = {
    { 
      name = 'restart', 
      label = 'Restart Game', 
      isActive = true,
      selectOption = function() 
        game.screen:restartGame()
      end
    },    
    { 
      name = 'exit', 
      label = 'Exit Game', 
      isActive = false,
      selectOption = function() 
        game.screen:exit()
      end
    },
  }

  return self
end


function EndScreen:draw()
  love.graphics.setColor( 255/255, 220/255, 0, 0.5 )
  love.graphics.rectangle( 'fill', 0, 0, game.windowWidth, game.windowHeight )

  love.graphics.setColor(1,1,1,1)

  local totalHeight = 0
  for i,menuItem in ipairs(self.menuItems) do
    local height = self.font:getHeight(menuItem.label) + 50
    totalHeight = totalHeight + height
  end  
  
  local winner = game.players[1]
  local winnerText = winner.name .. ' has won!'

  
  love.graphics.print({{144/255, 0, 255/255}, winnerText}, 
      game.windowWidth/2 - self.font:getWidth(winnerText)*4/2, 
      75,
      0,
      4
    )
  


  local y = game.windowHeight/2 - totalHeight/2 + 50

  for i,menuItem in ipairs(self.menuItems) do

    local x = game.windowWidth/2 - self.font:getWidth(menuItem.label)

    if (menuItem.isActive) then
      love.graphics.draw(self.activeIndicator, x - 50, y)
      self.activeItemIndex = i
    end

    love.graphics.print({{144/255, 0, 255/255}, menuItem.label}, 
      x, 
      y,
      0,
      2
    )

    y = y + 100

  end







end


EndScreenKeyboardInput = Object:extend()

function EndScreenKeyboardInput:new()
  self.name = 'keyboard_endscreen'
  return self
end


function EndScreenKeyboardInput:keyreleased( key, scancode )

end 

function EndScreenKeyboardInput:keypressed(key, scancode, isrepeat)

  local screen = game.screen.endscreen

  if key == 'down' then
    if (screen.activeItemIndex < #screen.menuItems) then 
      screen.menuItems[screen.activeItemIndex].isActive = false
      screen.activeItemIndex = screen.activeItemIndex + 1
      screen.menuItems[screen.activeItemIndex].isActive = true
    end
  end

  if key == 'up' then
    if (screen.activeItemIndex > 1) then 
      screen.menuItems[screen.activeItemIndex].isActive = false
      screen.activeItemIndex = screen.activeItemIndex - 1
      screen.menuItems[screen.activeItemIndex].isActive = true
    end
  end

  if key == 'return' then 
    screen.menuItems[screen.activeItemIndex].selectOption()
  end  


  if key == 'escape' then 
    game.screen:resume()
  end  
end


EndScreenGamepadInput = Object:extend()

function EndScreenGamepadInput:new()
  self.name = 'gamepad_endscreen'
  self.connectedGamepads = game.inputManager:getGamepads()
  return self
end


function EndScreenGamepadInput:gamepadreleased(joystick, pressedButton)

  local screen = game.screen.endscreen

  if pressedButton == 'dpdown' then
    if (screen.activeItemIndex < #screen.menuItems) then 
      screen.menuItems[screen.activeItemIndex].isActive = false
      screen.activeItemIndex = screen.activeItemIndex + 1
      screen.menuItems[screen.activeItemIndex].isActive = true
    end
  end

  if pressedButton == 'dpup' then
    if (screen.activeItemIndex > 1) then 
      screen.menuItems[screen.activeItemIndex].isActive = false
      screen.activeItemIndex = screen.activeItemIndex - 1
      screen.menuItems[screen.activeItemIndex].isActive = true
    end
  end

  if pressedButton == 'a' then 
    screen.menuItems[screen.activeItemIndex].selectOption()
  end  


  if pressedButton == 'start' then 
    game.screen:resume()
  end  
end

function EndScreenGamepadInput:gamepadpressed(joystick, releasedButton)

end
