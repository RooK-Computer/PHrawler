FistHitTargetState = State:extend()

function FistHitTargetState:new(player)
  FistHitTargetState.super.new(self, player)

  self.name = Constants.FIST_HIT_TARGET_STATE
  self.audio = {}
  self.audio.hit = {
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'PipeClank_Strike_Hit_Impact_8Bit_ChipSound.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Punch_Strike_Hit_Impact_8Bit_ChipSound.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Short_Burst_Strike_Hit_Impact_8Bit_ChipSound.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Short_Zap_Strike_Hit_Impact_8Bit_ChipSound.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Simple_Sizzle_Strike_Hit_Impact_8Bit_ChipSound.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Soft2_Strike_Hit_Impact_8Bit_ChipSound.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laser_Soft_Impact_Retro_8_Bit_Chiptune.wav' , 'static'),
  }    
  
  self.audio.laugh = {
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_01.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_02.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_03.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_04.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_05.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_06.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_07.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_08.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_09.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Laugh_10.wav' , 'static'),
  }  

  return self
end

function FistHitTargetState:enterState()
  
  local player = self.player
  self.startTimer = love.timer.getTime()
  player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]
  self.audio.hit[math.random(7)]:play()

  player.isMovementBlocked = true
  player.isStateChangeBlocked = true

  local playerImpulseX, playerImpulseY = player.physics.body:getLinearVelocity()
  if playerImpulseX > 100 then playerImpulseX = 100 end
  if playerImpulseX <= 0 then playerImpulseX = -125 
    if player.animationDirection == Constants.PLAYER_DIRECTION_LEFT then playerImpulseX = -playerImpulseX end
  end

    
  if playerImpulseY < -150 then playerImpulseY = -150 end
  if playerImpulseY > -100 then playerImpulseY = -100 end
  
  player.physics.body:applyLinearImpulse( playerImpulseX, playerImpulseY )
  
  return self.name
end


function FistHitTargetState:update(dt)

  local player = self.player

  player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]

  local passedTime = love.timer.getTime() - self.startTimer

  if passedTime > 0.5 then 
    
    local index = math.random(20) -- don't always play a laugh
    if (index <= 10) then self.audio.laugh[index]:play() end 
    player.isMovementBlocked = false
    player.isStateChangeBlocked = false
    return Constants.IDLE_STATE 
  end

end