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

  self.logoScale = self.logoScale + 0.0025

end

function RookScreen:draw()
  love.graphics.clear( 255/255, 220/255, 0, 1)

  local scale = self.logoScale

  if scale > 0.25 then 
    scale = 0.25 
    
    local nameScale = 3

    love.graphics.print({{144/255, 0, 255/255},'Rook Komputer'}, 
      game.windowWidth/2 - self.font:getWidth('Rook Komputer')/2*nameScale, 
      game.windowHeight - 100 - self.font:getHeight('Rook Komputer'),
      0,
      nameScale
    )


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
      self.nextScreen = StartScreen()
      self.nextScreen:load()
      game.screen = self.nextScreen 
    end
  end
  love.graphics.draw( self.logo, game.windowWidth/2, game.windowHeight/2, 0, scale, scale, game.windowWidth, game.windowHeight )

end

function RookScreen:exit()
end