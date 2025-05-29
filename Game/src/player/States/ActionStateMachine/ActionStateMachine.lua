require('src/player/States/ActionStateMachine/ActionIdleState')
require('src/player/States/ActionStateMachine/DeadState')
require('src/player/States/ActionStateMachine/FightingState')

ActionStateMachine = StateMachine:extend()

function ActionStateMachine:new(player)
  self.player = player
  self.name = 'ActionStateMachine'
  self.state = ActionIdleState(player)
  return self
end


function ActionStateMachine:update(dt)

  local newState = self.state:update(command)
  if newState then 
    self.state = newState
  end
end


function ActionStateMachine:input(command)

  local newState = self.state:input(command)

  if newState then 
    self.state = newState
  end


end


function ActionStateMachine:inputEnd(command)
  local newState = self.state:inputEnd(command)

  if newState then 
    self.state = newState
  end

end


