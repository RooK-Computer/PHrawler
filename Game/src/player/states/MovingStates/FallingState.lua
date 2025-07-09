FallingState = State:extend()

function FallingState:new(player)
  FallingState.super.new(self, player)
  self.name = Constants.FALL_STATE

  self.player.velocityY = player.speed/2

  self.player.physics.body:setLinearVelocity(self.player.velocityX, self.player.velocityY)

  self.player.anim = player.animations[Constants.FALL_STATE][player.animationDirection]
  player.direction = Constants.PLAYER_DIRECTION_DOWN

  return self
end

function FallingState:input(command)
  FallingState.super.input(self, command)

  local player = self.player

  local canJump = true
  if player.hasJumped > 1 then canJump = false end

  if command == Constants.JUMP_STATE and canJump then return JumpState(player) end
  if command == Constants.PLAYER_DIRECTION_RIGHT then player.direction = Constants.PLAYER_DIRECTION_RIGHT  end
  if command == Constants.PLAYER_DIRECTION_LEFT then player.direction = Constants.PLAYER_DIRECTION_LEFT end

end

function FallingState:update(dt)

  local player = self.player

  if (player.direction == Constants.PLAYER_DIRECTION_LEFT) then player.velocityX = -player.speed end
  if (player.direction == Constants.PLAYER_DIRECTION_RIGHT) then player.velocityX = player.speed end
  

  if player.isOnGround then 
    return MovingIdleState(player) 
  end

  local vx, vy = player.physics.body:getLinearVelocity()
  player.physics.body:setLinearVelocity(player.velocityX, vy)


end