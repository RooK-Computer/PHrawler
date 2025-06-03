StartScreen = Screen:extend()

function StartScreen:new()
  self.name = 'StartScreen'
  self.logoScale = 0.01
  self.startTimer = love.timer.getTime()
  love.graphics.setDefaultFilter('linear', 'linear') -- best for pixel art

  self.logo = love.graphics.newImage('assets/images/rook_logo.png')

  return self
end


function StartScreen:load()


end


function StartScreen:update(dt)

  self.logoScale = self.logoScale + 0.0025

end

function StartScreen:draw()
  love.graphics.clear( 255, 220, 0, 1)

  local scale = self.logoScale

  if scale > 0.25 then 
    scale = 0.25 

    if self.nextScreen == nil then 
      self.nextScreen = GameScreen()
      self.nextScreen:load()
    end


    local passedTime = love.timer.getTime() - self.startTimer

    if passedTime > 5 then 
      self.nextScreen:enter()
      game.screen = self.nextScreen 
      end
  end
  love.graphics.draw( self.logo, game.windowWidth/2, game.windowHeight/2, 0, scale, scale, game.windowWidth, game.windowHeight )

end

function StartScreen:exit()
end