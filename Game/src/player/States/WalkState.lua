WalkState = State:extend()

function WalkState:new(player)
  WalkState.super.new(self, player)
  self.name = 'walk'

  self.player.animations.run = {}
  self.player.animations.run.right = anim8.newAnimation( player.grid('1-8', 3), player.animationDuration )
  self.player.animations.run.left = player.animations.run.right:clone():flipH()   
  self.player.anim = player.animations.run[player.direction]

  return self
end

function WalkState:input(command)

  local player = self.player


  if command == 'left' then player.direction = command end
  if command == 'right' then player.direction = command end
  if command == 'idle' then return IdleState(player) end
  if command == 'jump' then return JumpState(player) end

end

function WalkState:inputEnd(command)

  local player = self.player
  return IdleState(player)

end

function WalkState:update(dt) 

  local player = self.player
  if not player.isOnGround then 
    player.state = FallingState(player) 
    return
  end


  player.anim = player.animations.run[player.direction]


  if (player.direction == 'left') then player.velocityX = -player.speed end
  if (player.direction == 'right') then player.velocityX = player.speed end

  player.colliders.playerCollider:setLinearVelocity(player.velocityX, player.velocityY)
  
  

end