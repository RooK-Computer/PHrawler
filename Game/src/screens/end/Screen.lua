require 'src/screens/end/InputHandler'
require 'src/screens/end/TableLayoutView'
require 'src/screens/end/PlacementLabelView'
require 'src/screens/end/PlayerView'

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
  self.firstClickGuardActive = true
  self.menuItems = {      
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

  self.scoreBoard = TableLayoutView()
  self.scoreBoard:setX(0)
  self.scoreBoard:setWidth(game.windowWidth)
  self.scoreBoard:setHeight(100)
  return self
end

function EndScreen:load()
  local view = PlacementLabelView(self.font,'1.')
  self.scoreBoard:addSubview(view)
  self.scoreBoard:setPosition(view,1,1)
  local playerView = PlayerView(self.session.instance.players[1])
  self.scoreBoard:addSubview(playerView)
  self.scoreBoard:setPosition(playerView,1,2)

  for i,player in ipairs(self.session.instance.deadPlayers) do
    local view = PlacementLabelView(self.font,tostring(i+1)..'.')
    self.scoreBoard:addSubview(view)
    self.scoreBoard:setPosition(view,i+1,1)

    local playerView = PlayerView(player)
    self.scoreBoard:addSubview(playerView)
    self.scoreBoard:setPosition(playerView,#self.session.instance.deadPlayers - i+2, 2)
  end
end


function EndScreen:draw()
  love.graphics.setColor( Colors.getYellowRGBA(0.5) )
  love.graphics.rectangle( 'fill', 0, 0, game.windowWidth, game.windowHeight )

  love.graphics.setColor(1,1,1,1)
  
  local winner = self.session.instance.players[1]
  local winnerText = winner.name .. ' has won!'
  
  local scale = 2.5
  
  love.graphics.print({Colors.getPurpleRGBA(), winnerText}, 
      game.windowWidth/2 - self.font:getWidth(winnerText) * scale/2, 
      35,
      0,
      scale
    )
  
  
  self.scoreBoard:setY(self.font:getHeight(winnerText) + 100)
  self.scoreBoard:viewdraw()



  local paddingBottom = 60
  local y = game.windowHeight - paddingBottom
  scale = 1.25

  
 -- we iterate from the end through this array, because these items get put on the screen from the bottom upwards
  for i = #self.menuItems, 1, -1 do
	local menuItem = self.menuItems[i]
    local x = game.windowWidth/2 - self.font:getWidth(menuItem.label) * scale/2
    

    if (menuItem.isActive) then
      love.graphics.draw(self.activeIndicator, x - 50, y, 0, scale, scale)
      self.activeItemIndex = i
    end

    love.graphics.print({Colors.getPurpleRGBA(), menuItem.label}, 
      x, 
      y,
      0,
      scale
    )

    y = y - paddingBottom
  end





end

function EndScreen:update(dt)
  self.scoreBoard:update(dt)
end

function EndScreen:enter()
  game.inputManager.HandlerStack:push(EndScreenInputHandler())
end

function EndScreen:exit()
  game.inputManager.HandlerStack:pop()
end
