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
  
  local playerImpulseX, playerImpulseY = -100, -300
  if player.direction == Constants.PLAYER_DIRECTION_LEFT then
    playerImpulseX = -playerImpulseX
  end
  player.physics.body:applyLinearImpulse( playerImpulseX, playerImpulseY )

  if player.gamepad ~= nil and player.gamepad:isVibrationSupported() then 
    player.gamepad:setVibration( 1, 1, 1 ) 
  end
  
  return self.name
end


function FistHitTargetState:update(dt)

  local player = self.player

  player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]

  local passedTime = love.timer.getTime() - self.startTimer

  if passedTime > 0.5 then 
    self.player.isMovementBlocked = false
    player.isStateChangeBlocked = false
    return Constants.IDLE_STATE 
  end

end