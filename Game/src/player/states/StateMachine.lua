StateMachine = Object:extend()

function StateMachine:new(player, name, states, entryState)
  self.player = player
  self.name = name
  self.states = states
  self.state = {}
  self:enterState(entryState)
  return self
end

function StateMachine:enterState(proposedNewState) 
  local actualNewState = self.states[proposedNewState]:enterState()
  self.state = self.states[actualNewState]
end


function StateMachine:update(dt)
  local newState = self.state:update(dt)
  if newState then self:enterState(newState) end
end


function StateMachine:input(command)

  local newState = self.state:input(command)

  if newState and not self.player.isStateChangeBlocked then self:enterState(newState) end

end


function StateMachine:inputEnd(command)
  local newState = self.state:inputEnd(command)

  if newState and not self.player.isStateChangeBlocked then self:enterState(newState) end

end