FallingState = State:extend()

function FallingState:new(player)
  FallingState.super.new(self, player)
  self.name = 'falling'

  self.player.velocityY = player.speed/2

  self.player.physics.body:setLinearVelocity(self.player.velocityX, self.player.velocityY)

  self.player.anim = player.animations.falling[player.animationDirection]

  player.direction = 'down'

  return self
end

function FallingState:input(command)
  FallingState.super.input(self, command)

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
    player.state = IdleState(player) 
  end

  local vx, vy = player.physics.body:getLinearVelocity()
  player.physics.body:setLinearVelocity(player.velocityX, vy)


end