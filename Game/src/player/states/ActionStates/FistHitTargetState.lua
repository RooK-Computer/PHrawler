FistHitTargetState = State:extend()

function FistHitTargetState:new(player)
  FistHitTargetState.super.new(self, player)

  self.name = Constants.FIST_HIT_TARGET_STATE

  return self
end

function FistHitTargetState:enterState()
  
  local player = self.player
  self.startTimer = love.timer.getTime()
  player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]
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
    player.isMovementBlocked = false
    player.isStateChangeBlocked = false
    return Constants.IDLE_STATE 
  end

end