FallingState = State:extend()

function FallingState:new(player)
  FallingState.super.new(self, player)
  self.name = 'falling'

  self.player.velocityY = player.speed/2

  self.player.colliders.playerCollider:setLinearVelocity(self.player.velocityX, self.player.velocityY)


  self.player.animations.idle = {}
  self.player.animations.idle.right = anim8.newAnimation( player.grid('1-8', 1), player.animationDuration )
  self.player.animations.idle.left = self.player.animations.idle.right:clone():flipH()

  player.direction = 'down'


  self.player.anim = player.animations.idle.left

  return self
end

function FallingState:input(command)

  local player = self.player

  local canJump = true
  if player.hasJumped > 1 then canJump = false end

  if command == 'jump' and canJump then return JumpState(player) end
  if command == 'right' then player.direction = 'right'  end
  if command == 'left' then player.direction = 'left' end

end

function FallingState:update(dt)

  local player = self.player

  if (player.direction == 'left') then player.velocityX = -player.speed end
  if (player.direction == 'right') then player.velocityX = player.speed end

  if player.isOnGround then 
    if player.direction == 'down' then player.direction = 'left' end
    player.state = IdleState(player) 
  end
  
  
  local vx, vy = player.colliders.playerCollider:getLinearVelocity()
  
  if vy == 0 then vy = 300 end


  player.colliders.playerCollider:setLinearVelocity(player.velocityX, vy)


end