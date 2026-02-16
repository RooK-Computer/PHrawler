--EntryState
MovingIdleState = State:extend()

function MovingIdleState:new(player)
  MovingIdleState.super.new(self, player)
  self.name = Constants.IDLE_STATE
  return self
end

function MovingIdleState:enterState()
  
  local player = self.player
  player.velocityX = 0
  player.velocityY = player.speed/2
  player.hasJumped = 0
  player.physics.body:setLinearVelocity(player.velocityX, player.velocityY)
  player.anim = player.animations[Constants.IDLE_STATE][player.animationDirection]
  return self.name

end

function MovingIdleState:input(command)
  local player = self.player
  if player.isMovementBlocked then return end
  MovingIdleState.super.input(self, command)


  if command == Constants.PLAYER_DIRECTION_LEFT then 
    player.direction = Constants.PLAYER_DIRECTION_LEFT
    return Constants.RUN_STATE
  end

  if command == Constants.PLAYER_DIRECTION_RIGHT then 
    player.direction = Constants.PLAYER_DIRECTION_RIGHT
    return Constants.RUN_STATE 
  end

  if command == Constants.JUMP_STATE then 
     return Constants.JUMP_STATE 
  end  
  
  if command == Constants.PLAYER_DROP_COMMAND then 
    return Constants.DROP_STATE
  end

end

function MovingIdleState:update(dt) 
  
  local player = self.player

  local vx, vy =   player.physics.body:getLinearVelocity()

  if vy >= 1 then  
    return Constants.FALL_STATE
  end
  
end