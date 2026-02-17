RookScreen = Screen:extend()

function RookScreen:new()
  self.name = 'RookScreen'
  self.logoScale = 0.01
  self.startTimer = love.timer.getTime()
  love.graphics.setDefaultFilter('linear', 'linear') -- best for pixel art

  self.logo = love.graphics.newImage('assets/images/rook_logo.png')
  self.vibrationForce = 0
  
  self.audio = {}
  love.audio.setVolume( 0.5 )


  return self
end


function RookScreen:load()

  self.font = love.graphics.newFont( '/assets/fonts/NewGameFont.ttf' )
  self.font:setFilter("nearest")
  love.graphics.setFont( self.font)
  self.audio.rookCall = love.audio.newSource( '/assets/audio/rook.mp3', 'stream' )
  self.audio.background = love.audio.newSource( '/assets/audio/Grp48_Melodic_5_Retro_8_Bit_Chiptune.wav', 'stream' )

end

function RookScreen:enter()
  love.audio.play(self.audio.rookCall)
end


function RookScreen:update(dt)

  self.logoScale = self.logoScale + 0.0015

end

function RookScreen:draw()
  love.graphics.clear( 255/255, 220/255, 0, 1)

  local scale = self.logoScale
  
  local passedTime = love.timer.getTime() - self.startTimer


  if scale > 0.15 then 
    scale = 0.15


    if passedTime > 5 then 
      love.audio.stop()
      game.switchScreen(StartScreen())
    end
  end

  love.graphics.draw( self.logo, game.windowWidth/2 - self.logo:getWidth()/2 * scale, game.windowHeight/2 - self.logo:getHeight()/2 * scale, 0, scale, scale )
  

end

function RookScreen:exit()
end