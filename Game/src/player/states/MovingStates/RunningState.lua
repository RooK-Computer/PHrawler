RunningState = State:extend()

function RunningState:new(player)
  RunningState.super.new(self, player)
  self.player = player
  self.name = Constants.RUN_STATE
  return self
end


function RunningState:enterState()
  
  local player = self.player
  player.anim = player.animations[Constants.RUN_STATE][player.animationDirection]
  return self.name

end

function RunningState:input(command)

  local player = self.player


  if command == 'left' then player.direction = command end
  if command == 'right' then player.direction = command end
  if command == 'idle' then return Constants.IDLE_STATE end
  if command == 'jump' then return Constants.JUMP_STATE end
  if command == Constants.PLAYER_DROP_COMMAND then 
    return Constants.DROP_STATE 
  end

end

function RunningState:inputEnd(command)
  RunningState.super.input(self, command)


  local player = self.player
  return Constants.IDLE_STATE

end

function RunningState:update(dt) 

  local player = self.player
  
  local vx, vy =   self.player.physics.body:getLinearVelocity()
  if vy > 10 then  
    return Constants.FALL_STATE 
  end


  player.anim = player.animations.running[player.direction]


  if (player.direction == 'left') then player.velocityX = -player.speed end
  if (player.direction == 'right') then player.velocityX = player.speed end

  player.physics.body:setLinearVelocity(player.velocityX, player.velocityY)

end