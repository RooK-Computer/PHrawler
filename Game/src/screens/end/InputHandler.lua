
EndScreenInputHandler = InputHandler:extend()

function EndScreenInputHandler:new()
end

function EndScreenInputHandler:OnRelease(joystick,button)
  local screen = game.screens:peek(0)
  
  if screen.firstClickGuardActive then 
    screen.firstClickGuardActive = false 
    screen.menuItems[1].isActive = true 
    return
  end 

  if button == 'dpdown' then
    if (screen.activeItemIndex < #screen.menuItems) then 
      screen.menuItems[screen.activeItemIndex].isActive = false
      screen.activeItemIndex = screen.activeItemIndex + 1
      screen.menuItems[screen.activeItemIndex].isActive = true
    end
  end

  if button == 'dpup' then
    if (screen.activeItemIndex > 1) then 
      screen.menuItems[screen.activeItemIndex].isActive = false
      screen.activeItemIndex = screen.activeItemIndex - 1
      screen.menuItems[screen.activeItemIndex].isActive = true
    end
  end

  if button == 'a' then 
    screen.menuItems[screen.activeItemIndex].selectOption()
  end  

  if button == 'b' then 
    screen.menuItems[screen.activeItemIndex].selectOption()
  end  


  if button == 'start' then 
    game.screen():resume()
  end  
end