DropState = State:extend()

function DropState:new(player)
  DropState.super.new(self, player)
  
  if player.canNotDrop then return MovingIdleState(self.player) end

  self.name = Constants.DROP_STATE
  self.player.collisionClass = 'PlayerDrop'
  self.player.physics.body:setLinearVelocity(0, -1) --initialzes new collision contact which we need to drop
  
  self.player.anim = player.animations[Constants.FALL_STATE][player.animationDirection]
  self.player.direction = Constants.PLAYER_DIRECTION_DOWN
  
end

function DropState:input(command)
  DropState.super.input(self, command)

  return MovingIdleState(self.player)


end

function DropState:update(dt)
    
  if self.player.collisionClass == 'Player' then
      return MovingIdleState(self.player)
  end
  
end