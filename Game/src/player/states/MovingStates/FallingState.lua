FallingState = State:extend()

function FallingState:new(player)
  FallingState.super.new(self, player)
  self.name = Constants.FALL_STATE

  return self
end

function FallingState:enterState()
  
  local player = self.player

  player.velocityY = player.speed/2

  player.physics.body:setLinearVelocity(player.velocityX, player.velocityY)

  player.anim = player.animations[Constants.FALL_STATE][player.animationDirection]
  player.direction = Constants.PLAYER_DIRECTION_DOWN

  return self.name

end

function FallingState:input(command)
  FallingState.super.input(self, command)

  local player = self.player

  local canJump = true
  if player.hasJumped > 1 then canJump = false end

  if command == Constants.JUMP_STATE and canJump then return Constants.JUMP_STATE end
  if command == Constants.PLAYER_DIRECTION_RIGHT then player.direction = Constants.PLAYER_DIRECTION_RIGHT  end
  if command == Constants.PLAYER_DIRECTION_LEFT then player.direction = Constants.PLAYER_DIRECTION_LEFT end

end

function FallingState:update(dt)

  local player = self.player

  if (player.direction == Constants.PLAYER_DIRECTION_LEFT) then player.velocityX = -player.speed end
  if (player.direction == Constants.PLAYER_DIRECTION_RIGHT) then player.velocityX = player.speed end
  

  local vx, vy = player.physics.body:getLinearVelocity()
  
    if vy >= -1 and vy <= 1 then 
    player.isOnGround = true 
    return Constants.IDLE_STATE 
  end
  
  player.physics.body:setLinearVelocity(player.velocityX, vy)


end