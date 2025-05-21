JumpState = State:extend()

function JumpState:new(player)
  JumpState.super.new(self, player)
  self.name = 'jump'

  self.player.direction = 'up'
  self.player.anim = player.animations.jump[player.animationDirection]  
  self.player.hasJumped = player.hasJumped + 1
  self.player.velocityY =  -2 * game.PIXELS_PER_METER

  local vx, vy = player.physics.body:getLinearVelocity()

  local player = self.player
  if player.hasJumped < 3 then 
    player.physics.body:setLinearVelocity(vx, -360) 
  end


  return self
end

function JumpState:input(command)
  JumpState.super.input(self, command)


  local player = self.player
  if player.hasJumped > 2 then return end


  if command == 'jump'  then return JumpState(player) end
  if command == 'right' then player.direction = 'right' return end
  if command == 'left' then player.direction = 'left' return end

end

function JumpState:update(dt) 

  local player = self.player

  local velocityX, velocityY = player.physics.body:getLinearVelocity()

  if (player.direction == 'left') then velocityX = -player.speed end
  if (player.direction == 'right') then velocityX = player.speed end

  player.anim = player.animations.jump[player.animationDirection]

  player.physics.body:setLinearVelocity(velocityX, velocityY) 

  if velocityY > 0 then 
    player.state = FallingState(player) 
  end


end