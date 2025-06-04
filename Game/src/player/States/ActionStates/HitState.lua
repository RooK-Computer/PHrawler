HitState = State:extend()

function HitState:new(player)
  HitState.super.new(self, player)

  self.name = Constants.HIT_STATE
  self.startTimer = love.timer.getTime()
  self.player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]
  self.player.isMovementBlocked = true


  local playerImpulseX, playerImpulseY = -150, -150
  if player.animationDirection == 'left' then playerImpulseX = -playerImpulseX end
  player.physics.body:applyLinearImpulse( playerImpulseX, playerImpulseY )


  return self
end


function HitState:update(dt)

  local player = self.player

  player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]

  local passedTime = love.timer.getTime() - self.startTimer

  if passedTime > 1 then 
    return ActionIdleState(player) 
  end

end