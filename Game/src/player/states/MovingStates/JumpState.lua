JumpState = State:extend()

function JumpState:new(player)
  JumpState.super.new(self, player)
  self.name = Constants.JUMP_STATE

  return self
end

function JumpState:enterState()
  
  local player = self.player
  
  player.direction = Constants.PLAYER_DIRECTION_UP  
  player.anim = player.animations[Constants.JUMP_STATE][player.animationDirection]
  player.hasJumped = player.hasJumped + 1
  player.velocityY =  -game.gravity

  local vx, vy = player.physics.body:getLinearVelocity()

  if player.hasJumped <= 2 then 
    player.physics.body:setLinearVelocity(vx, -360) 
  end
  
  return self.name

end

function JumpState:input(command)
  JumpState.super.input(self, command)


  local player = self.player
  if player.hasJumped >=3 then return end


  if command == Constants.JUMP_STATE  then 
    return Constants.JUMP_STATE 
    end
  if command == Constants.PLAYER_DIRECTION_RIGHT then player.direction = Constants.PLAYER_DIRECTION_RIGHT return end
  if command == Constants.PLAYER_DIRECTION_LEFT then player.direction = Constants.PLAYER_DIRECTION_LEFT return end

end

function JumpState:update(dt) 

  local player = self.player
  local velocityX, velocityY = player.physics.body:getLinearVelocity()
  player.anim = player.animations.jump[player.animationDirection]

  if not player.isMovementBlocked then

    if (player.direction == Constants.PLAYER_DIRECTION_LEFT ) then velocityX = -player.speed end
    if (player.direction == Constants.PLAYER_DIRECTION_RIGHT ) then velocityX = player.speed end

    player.physics.body:setLinearVelocity(velocityX, velocityY) 
    
  end 

  if velocityY >= 0 then
    return Constants.FALL_STATE 
  end


end