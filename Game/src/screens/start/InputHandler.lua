StartScreenInputHandler = InputHandler:extend()

function StartScreenInputHandler:new(screen)
    self.screen = screen
    self.name = 'startscreen_inputhandler'
    return self
end

function StartScreenInputHandler:OnPress(joystick, button)

end

function StartScreenInputHandler:OnRelease(joystick, button) 

  local screen = self.screen
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

  if button == 'dpleft' then
    screen.menuItems[screen.activeItemIndex].changeOption(screen.menuItems[screen.activeItemIndex],'left')
  end


  if button == 'dpright' then
    screen.menuItems[screen.activeItemIndex].changeOption(screen.menuItems[screen.activeItemIndex],'right')
  end

  if button == 'a' and screen.activeItemIndex == 1 then 
    screen.menuItems[screen.activeItemIndex].selectOption()
  end  


  if button == 'start' and screen.activeItemIndex == 1 then 
    screen.menuItems[screen.activeItemIndex].selectOption()
  end  

end