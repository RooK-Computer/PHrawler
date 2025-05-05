JumpState = State:extend()

function JumpState:new(player)
  JumpState.super.new(self, player)
  self.name = 'jump'

  if player.direction == 'left' then
    --self.player.velocityX =  -1  * game.PIXELS_PER_METER
  else 
    --self.player.velocityX =  1 * game.PIXELS_PER_METER
  end


  self.player.direction = 'up'
  self.player.animations.jump = {}
  self.player.animations.jump.right = anim8.newAnimation( player.grid('1-8', 1), player.animationDuration )
  self.player.animations.jump.left = self.player.animations.jump.right:clone():flipH()
  self.player.hasJumped = player.hasJumped + 1
  self.player.velocityY =  -2.5 * game.PIXELS_PER_METER


  --self.player.anim = player.animations.idle[player.direction]
  self.player.anim = player.animations.idle.left

  player.colliders.playerCollider:applyLinearImpulse( self.player.velocityX / 5, self.player.velocityY)


  return self
end

function JumpState:input(command)

  local player = self.player
  if player.hasJumped > 1 then return end




  if command == 'jump'  then return JumpState(player) end
  if command == 'right' then player.direction = 'right' end
  if command == 'left' then player.direction = 'left' end
  --if command == 'up' then return JumpState(command) end
  --if command == 'fight' then return FightState(command) end

end

function JumpState:update(dt) 

  local player = self.player
  --player.anim = player.animations.jump[player.direction]

  local gx, gy = player.world:getGravity()



  if player.direction == 'left' then player.velocityX = -player.speed end
  if player.direction == 'right' then player.velocityX = player.speed end

  --player.colliders.playerCollider:setLinearVelocity(player.velocityX, player.velocityY)

  local velocityX, velocityY = player.colliders.playerCollider:getLinearVelocity()
  if velocityY > 0 then 
    player.state = FallingState(player) 

  end


end