DamageState = State:extend()

function DamageState:new(player)
  DamageState.super.new(self, player)

  self.name = Constants.DAMAGE_STATE
  self.audio = {}
    
    self.audio.damage = {
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_01.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_02.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_03.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_04.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_05.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_06.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_07.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_08.wav' , 'static'),
      love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Hurt_09.wav' , 'static'),
    }
  
  return self
end

function DamageState:enterState()
  
  local player = self.player
  
  player.startTimer = love.timer.getTime()
  player.anim = player.animations[Constants.DAMAGE_STATE][player.animationDirection]
  player:setDamage(1)
  
  self.audio.damage[math.random(9)]:play()
  player.isMovementBlocked = true
  player.isStateChangeBlocked = true
  
  return self.name
end


function DamageState:update(dt)

  local player = self.player

  player.anim = player.animations[Constants.DAMAGE_STATE][player.animationDirection]

  local passedTime = love.timer.getTime() - player.startTimer

  if passedTime > 1 then  
    self.player.isMovementBlocked = false
    self.player.isStateChangeBlocked = false
    return Constants.IDLE_STATE
  end

end