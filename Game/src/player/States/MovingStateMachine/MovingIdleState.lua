MovingIdleState = State:extend()

function MovingIdleState:new(player)
  MovingIdleState.super.new(self, player)
  self.name = Constants.IDLE_STATE
  
  self.player.velocityX = 0
  self.player.velocityY = player.speed/2
  self.player.hasJumped = 0
  self.player.physics.body:setLinearVelocity(player.velocityX, player.velocityY)

  self.player.anim = player.animations.idle[player.animationDirection]

  return self
end

function MovingIdleState:input(command)
  MovingIdleState.super.input(self, command)

  local player = self.player

  if command == Constants.PLAYER_DIRECTION_LEFT then 
    player.direction = Constants.PLAYER_DIRECTION_LEFT
    return RunningState(player) 
  end
  
  if command == Constants.PLAYER_DIRECTION_RIGHT then 
    player.direction = Constants.PLAYER_DIRECTION_RIGHT
    return RunningState(player) 
  end
  
  if command == Constants.JUMP_STATE then 
    return JumpState(player) 
  end
  
end