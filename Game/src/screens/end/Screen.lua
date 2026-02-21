require 'src/screens/end/InputHandler'

EndScreen = Screen:extend()
function EndScreen:new(session)
  self.session = session
  self.name = 'Endscreen'

  self.font = love.graphics.newFont( Constants.GRAPHIC.FONTS.MENUFONT )
  self.font:setFilter("nearest")
  love.graphics.setFont(self.font)

  self.activeIndicator = love.graphics.newImage(Constants.GRAPHIC.INDICATOR.RIGHT)
  self.activeIndicator:setFilter("nearest")
  self.activeItemIndex = 1
  self.menuItems = {
    { 
      name = 'restart', 
      label = 'Restart Game', 
      isActive = true,
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


function EndScreen:draw()
  love.graphics.setColor( Colors.getYellowRGBA(0.5) )
  love.graphics.rectangle( 'fill', 0, 0, game.windowWidth, game.windowHeight )

  love.graphics.setColor(1,1,1,1)

  local totalHeight = 0
  for i,menuItem in ipairs(self.menuItems) do
    local height = self.font:getHeight(menuItem.label) + 50
    totalHeight = totalHeight + height
  end  
  
  local winner = self.session.instance.players[1]
  local winnerText = winner.name .. ' has won!'

  
  love.graphics.print({Colors.getPurpleRGBA(), winnerText}, 
      game.windowWidth/2 - self.font:getWidth(winnerText)*3/2, 
      75,
      0,
      3
    )
  


  local y = game.windowHeight/2 - totalHeight/2 + 50

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

function EndScreen:enter()
  game.inputManager.HandlerStack:push(EndScreenInputHandler())
end

function EndScreen:exit()
  game.inputManager.HandlerStack:pop()
end
