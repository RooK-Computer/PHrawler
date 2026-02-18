DropState = State:extend()

function DropState:new(player)
  DropState.super.new(self, player)
  self.name = Constants.DROP_STATE
  
  return self
  
end


function DropState:enterState()
  
  local player = self.player
  if player.canNotDrop then return Constants.IDLE_STATE end
  
  player.collisionClass = 'PlayerDrop'
  player.physics.body:setLinearVelocity(0, -1) --initialzes new collision contact which we need to drop
  
  player.anim = player.animations[Constants.FALL_STATE][player.animationDirection]
  player.direction = Constants.PLAYER_DIRECTION_DOWN
  
  return self.name

end

function DropState:input(command)
  DropState.super.input(self, command)

  return Constants.IDLE_STATE


end

function DropState:update(dt)
  
  local player = self.player
  
  local velocityX, velocityY = player.physics.body:getLinearVelocity()
    
  if player.collisionClass == 'Player' 
  or velocityY == 0 then -- handles weird drop bug if player stands on another player
      return Constants.IDLE_STATE
  end
  
end