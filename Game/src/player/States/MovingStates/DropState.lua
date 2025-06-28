DropState = State:extend()

function DropState:new(player)
  DropState.super.new(self, player)
  self.name = Constants.DROP_STATE
  self.player.collisionClass = 'PlayerDrop'
  self.timer = 1

end

function DropState:input(command)
  DropState.super.input(self, command)

  return MovingIdleState(self.player)


end

function DropState:update(dt)
  
  self.timer = self.timer + 1
  
  if self.player.collisionClass == 'Player' then
      return MovingIdleState(self.player)
  end
  
end