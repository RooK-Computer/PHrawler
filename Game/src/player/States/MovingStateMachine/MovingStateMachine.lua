require('src/player/States/MovingStateMachine/MovingIdleState')
require('src/player/States/MovingStateMachine/RunningState')
require('src/player/States/MovingStateMachine/JumpState')
require('src/player/States/MovingStateMachine/FallingState')

MovingStateMachine = StateMachine:extend()

function MovingStateMachine:new(player)
  self.player = player
  self.name = 'MovingStateMachine'
  self.state = MovingIdleState(player)
  return self
end


function MovingStateMachine:update(dt)
  local newState = self.state:update(command)
  if newState then 
    self.state = newState
  end
end


function MovingStateMachine:input(command)

  local newState = self.state:input(command)

  if newState then 
    self.state = newState
  end


end


function MovingStateMachine:inputEnd(command)
  local newState = self.state:inputEnd(command)

  if newState then 
    self.state = newState
  end

end