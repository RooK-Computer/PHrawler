require('src/player/states/MovingStates/RunningState')
require('src/player/states/MovingStates/JumpState')
require('src/player/states/MovingStates/FallingState')
require('src/player/states/MovingStates/DropState')

--EntryState
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
  local player = self.player
  if player.isMovementBlocked then return end
  MovingIdleState.super.input(self, command)


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
  
  if command == Constants.PLAYER_DROP_COMMAND then 
    return DropState(player) 
  end

end