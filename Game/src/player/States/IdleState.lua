IdleState = State:extend()

function IdleState:new(player)
  IdleState.super.new(self, player)
  self.name = 'idle'


  self.player.colliders.playerCollider:getLinearVelocity()

  self.player.velocityX = 0
  self.player.velocityY = 100
  self.player.x = player.colliders.playerCollider:getX() - player.width/2
  self.player.y = player.colliders.playerCollider:getY() - player.height/2
  
  
  self.player.animations.idle = {}
  self.player.animations.idle.right = anim8.newAnimation( player.grid('1-8', 1), player.animationDuration )
  self.player.animations.idle.left = self.player.animations.idle.right:clone():flipH()
  
  self.player.anim = player.animations.idle[player.direction]
  
  return self
end

function IdleState:input(command)


  if command == 'left' then return WalkState(self.player) end
  if command == 'right' then return WalkState(self.player) end
  --if command == 'up' then return JumpState(command) end
  --if command == 'fight' then return FightState(command) end

end