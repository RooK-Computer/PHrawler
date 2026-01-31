
PauseScreenInputHandler = InputHandler:extend()

function PauseScreenInputHandler:new()
  return self
end

function PauseScreenInputHandler:OnPress(joystick, button)
end

function PauseScreenInputHandler:OnRelease(joystick, button)
  local screen = game.screens:peek(0)

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


  if button == 'start' then 
    game.screen():resume()
  end  
end