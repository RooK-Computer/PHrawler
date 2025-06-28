RunningState = State:extend()

function RunningState:new(player)
  RunningState.super.new(self, player)
  self.name = 'running'
  self.player.anim = player.animations.running[player.animationDirection]

  return self
end

function RunningState:input(command)

  local player = self.player


  if command == 'left' then player.direction = command end
  if command == 'right' then player.direction = command end
  if command == 'idle' then return MovingIdleState(player) end
  if command == 'jump' then return JumpState(player) end
    if command == Constants.PLAYER_DROP_COMMAND then 
    return DropState(player) 
  end

end

function RunningState:inputEnd(command)
  RunningState.super.input(self, command)


  local player = self.player
  return MovingIdleState(player)

end

function RunningState:update(dt) 

  local player = self.player
  if not player.isOnGround then 
    return FallingState(player) 
  end


  player.anim = player.animations.running[player.direction]


  if (player.direction == 'left') then player.velocityX = -player.speed end
  if (player.direction == 'right') then player.velocityX = player.speed end

  player.physics.body:setLinearVelocity(player.velocityX, player.velocityY)

end