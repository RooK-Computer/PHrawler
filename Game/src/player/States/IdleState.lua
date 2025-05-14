IdleState = State:extend()

function IdleState:new(player)
  IdleState.super.new(self, player)
  self.name = 'idle'

  self.player.velocityX = 0
  self.player.velocityY = player.speed/2
  self.player.hasJumped = 0
  self.player.colliders.playerCollider:setLinearVelocity(player.velocityX, player.velocityY)

  self.player.anim = player.animations.idle[player.direction]

  return self
end

function IdleState:input(command)

  local player = self.player

  if command == 'left' then 
    player.direction = 'left'
    return RunningState(player) 
  end
  if command == 'right' then 
    player.direction = 'right'
    return RunningState(player) 
  end
  if command == 'jump' then 
    return JumpState(player) 
  end
  
end