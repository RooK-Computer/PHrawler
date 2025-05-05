IdleState = State:extend()

function IdleState:new(player)
  IdleState.super.new(self, player)
  self.name = 'idle'


  self.player.colliders.playerCollider:getLinearVelocity()

  self.player.velocityX = 0
  self.player.velocityY = 100

  self.player.colliders.playerCollider:setLinearVelocity(player.velocityX, player.velocityY)


  self.player.animations.idle = {}
  self.player.animations.idle.right = anim8.newAnimation( player.grid('1-8', 1), player.animationDuration )
  self.player.animations.idle.left = self.player.animations.idle.right:clone():flipH()

  self.player.anim = player.animations.idle[player.direction]

  return self
end

function IdleState:input(command)

  local player = self.player


  if command == 'left' then 
    player.direction = 'left'
    return WalkState(player) 
  end
  if command == 'right' then 
    player.direction = 'right'
    return WalkState(player) 
  end
  if command == 'jump' then 
    return JumpState(player) 
  end
  --if command == 'fight' then return FightState(self.player) end

end