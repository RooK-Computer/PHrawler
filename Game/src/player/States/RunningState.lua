RunningState = State:extend()

function RunningState:new(player)
  RunningState.super.new(self, player)
  self.name = 'running'
  self.player.anim = player.animations.running[player.direction]

  return self
end

function RunningState:input(command)

  local player = self.player


  if command == 'left' then player.direction = command end
  if command == 'right' then player.direction = command end
  if command == 'idle' then return IdleState(player) end
  if command == 'jump' then return JumpState(player) end

end

function RunningState:inputEnd(command)

  local player = self.player
  return IdleState(player)

end

function RunningState:update(dt) 

  local player = self.player
  if not player.isOnGround then 
    player.state = FallingState(player) 
    return
  end


  player.anim = player.animations.running[player.direction]


  if (player.direction == 'left') then player.velocityX = -player.speed end
  if (player.direction == 'right') then player.velocityX = player.speed end

  player.colliders.playerCollider:setLinearVelocity(player.velocityX, player.velocityY)
  
  

end