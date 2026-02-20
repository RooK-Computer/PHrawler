require 'src/screens/pause/InputHandler' 

PauseScreen = Screen:extend()
function PauseScreen:new()
  self.name = 'Pausescreen'


  local fontPartyPack = love.graphics.newFont( '/assets/fonts/Party_Pack_Normal.ttf' )
  local newGameFont = love.graphics.newFont( '/assets/fonts/NewGameFont.ttf' )

  self.font = newGameFont
  self.font:setFilter("nearest")
  love.graphics.setFont(self.font)

  self.activeIndicator = love.graphics.newImage('assets/images/triangle_points_right.png')
  self.activeItemIndex = 1
  self.menuItems = {
    { 
      name = 'resume', 
      label = 'Resume Game', 
      isActive = true,
      selectOption = function() 
        game.screen():resume()
      end
    },    
    { 
      name = 'restart', 
      label = 'Restart Game', 
      isActive = false,
      selectOption = function() 
        game.screen():restartGame()
      end
    },    
    { 
      name = 'exit', 
      label = 'Exit Game', 
      isActive = false,
      selectOption = function() 
        game.restart()
      end
    },
  }

  return self
end


function PauseScreen:draw()
  love.graphics.setColor( Colors.getYellowRGBA(0.5) )
  love.graphics.rectangle( 'fill', 0, 0, game.windowWidth, game.windowHeight )

  love.graphics.setColor(1,1,1,1)

  local totalHeight = 0
  for i,menuItem in ipairs(self.menuItems) do
    local height = self.font:getHeight(menuItem.label) + 50
    totalHeight = totalHeight + height
  end  


  local y = game.windowHeight/2 - totalHeight/2

  for i,menuItem in ipairs(self.menuItems) do

    local x = game.windowWidth/2 - self.font:getWidth(menuItem.label)

    if (menuItem.isActive) then
      love.graphics.draw(self.activeIndicator, x - 50, y)
      self.activeItemIndex = i
    end

    love.graphics.print({Colors.getPurpleRGBA(), menuItem.label}, 
      x, 
      y,
      0,
      2
    )

    y = y + 100

  end

end

function PauseScreen:enter()
  game.inputManager.HandlerStack:push(PauseScreenInputHandler())
end

function PauseScreen:exit()
  game.inputManager.HandlerStack:pop()
end