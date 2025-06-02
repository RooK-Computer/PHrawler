JumpState = State:extend()

function JumpState:new(player)
  JumpState.super.new(self, player)
  self.name = Constants.JUMP_STATE

  self.player.direction = Constants.PLAYER_DIRECTION_UP
  self.player.anim = player.animations.jump[player.animationDirection]  
  self.player.hasJumped = player.hasJumped + 1
  self.player.velocityY =  -2 * game.PIXELS_PER_METER

  local vx, vy = player.physics.body:getLinearVelocity()

  if player.hasJumped < 3 then 
    player.physics.body:setLinearVelocity(vx, -360) 
  end


  return self
end

function JumpState:input(command)
  JumpState.super.input(self, command)


  local player = self.player
  if player.hasJumped > 2 then return end


  if command == Constants.JUMP_STATE  then return JumpState(player) end
  if command == Constants.PLAYER_DIRECTION_RIGHT then player.direction = Constants.PLAYER_DIRECTION_RIGHT return end
  if command == Constants.PLAYER_DIRECTION_LEFT then player.direction = Constants.PLAYER_DIRECTION_LEFT return end

end

function JumpState:update(dt) 

  local player = self.player

  local velocityX, velocityY = player.physics.body:getLinearVelocity()

  if (player.direction == Constants.PLAYER_DIRECTION_LEFT ) then velocityX = -player.speed end
  if (player.direction == Constants.PLAYER_DIRECTION_RIGHT ) then velocityX = player.speed end

  player.anim = player.animations.jump[player.animationDirection]

  player.physics.body:setLinearVelocity(velocityX, velocityY) 

  if velocityY > 0 then 
    return FallingState(player) 
  end


end