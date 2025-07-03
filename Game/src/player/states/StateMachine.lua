StateMachine = Object:extend()

function StateMachine:new(player, name, entryState)
  self.player = player
  self.name = name
  self.state = entryState(player)
  return self
end


function StateMachine:update(dt)
  local newState = self.state:update(dt)
  if newState then 
    self.state = newState
  end
end


function StateMachine:input(command)

  local newState = self.state:input(command)

  if newState then 
    self.state = newState
  end


end


function StateMachine:inputEnd(command)
  local newState = self.state:inputEnd(command)

  if newState then 
    self.state = newState
  end

end