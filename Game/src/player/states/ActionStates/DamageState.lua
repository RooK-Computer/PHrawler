DamageState = State:extend()

function DamageState:new(player)
  DamageState.super.new(self, player)

  self.name = Constants.DAMAGE_STATE

  return self
end

function DamageState:enterState()
  
  local player = self.player
  
  player.startTimer = love.timer.getTime()
  player.anim = player.animations[Constants.DAMAGE_STATE][player.animationDirection]
  player:setDamage(1)
  player.isMovementBlocked = true
  player.isStateChangeBlocked = true

  if player.gamepad~= nil and player.gamepad:isVibrationSupported() then 
    player.gamepad:setVibration( 1, 1, 1 ) 
  end
  
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