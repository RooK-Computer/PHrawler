FallingState = State:extend()

function FallingState:new(player)
  FallingState.super.new(self, player)
  self.name = 'falling'


  self.player.colliders.playerCollider:getLinearVelocity()

  self.player.velocityX = 0
  self.player.velocityY = 100

  self.player.colliders.playerCollider:setLinearVelocity(player.velocityX, player.velocityY)


  self.player.animations.idle = {}
  self.player.animations.idle.right = anim8.newAnimation( player.grid('1-8', 1), player.animationDuration )
  self.player.animations.idle.left = self.player.animations.idle.right:clone():flipH()

  --player.direction = 'down'


  self.player.anim = player.animations.idle.left

  return self
end

function FallingState:input(command)

  local player = self.player

  local canJump = true
  if player.hasJumped > 1 then canJump = false end


  if command == 'jump' and canJump then return JumpState(player) end
  if command == 'right' then 
    player.direction = 'right'
    return WalkState(player)

  end
  if command == 'left' then 
    player.direction = 'left' 
    return WalkState(player)
  end

end

function FallingState:update(dt)

  local player = self.player

  local velocityX, velocityY = player.colliders.playerCollider:getLinearVelocity()

  if velocityY == 0 then 
    player.direction = 'left'
    player.hasJumped = 0
    player.state = IdleState(player) 

  end

end