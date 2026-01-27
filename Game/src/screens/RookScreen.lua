RookScreen = Screen:extend()

function RookScreen:new()
  self.name = 'RookScreen'
  self.logoScale = 0.01
  self.startTimer = love.timer.getTime()
  love.graphics.setDefaultFilter('linear', 'linear') -- best for pixel art

  self.logo = love.graphics.newImage('assets/images/rook_logo.png')
  self.vibrationForce = 0

  return self
end


function RookScreen:load()

  self.font = love.graphics.newFont( '/assets/fonts/NewGameFont.ttf' )
  self.font:setFilter("nearest")
  love.graphics.setFont( self.font)

end


function RookScreen:update(dt)

  self.logoScale = self.logoScale + 0.0015

end

function RookScreen:draw()
  love.graphics.clear( 255/255, 220/255, 0, 1)

  local scale = self.logoScale

  if scale > 0.15 then 
    scale = 0.15

    self.vibrationForce =   self.vibrationForce + 0.01
    local gamepads = love.joystick.getJoysticks()
    for i, gamepad in pairs(gamepads) do
      if gamepad:isVibrationSupported() then gamepad:setVibration( self.vibrationForce, self.vibrationForce, 0.5 ) end
    end

    local passedTime = love.timer.getTime() - self.startTimer

    if passedTime > 5 then 

      local gamepads = love.joystick.getJoysticks()
      for i, gamepad in pairs(gamepads) do
        if gamepad:isVibrationSupported() then gamepad:setVibration(0,0,0) end
      end
      game.switchScreen(StartScreen())
    end
  end
  
  love.graphics.draw( self.logo, game.windowWidth/2 - self.logo:getWidth()/2 * scale, game.windowHeight/2 - self.logo:getHeight()/2 * scale, 0, scale, scale )

end

function RookScreen:exit()
end