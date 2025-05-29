StateMachine = Object:extend()

function StateMachine:new(player)
  self.player = player
  self.name = player.name
  self.stateMachines = {
    MovingStateMachine(player),
    ActionStateMachine(player)
  }

  return self
end


function StateMachine:update(dt)
  for i,state in ipairs(self.stateMachines) do 
    state:update(dt)
  end 
end


function StateMachine:inputStart(command)

  if command == 'none' then command = 'idle' end

  for i, state in ipairs(self.stateMachines) do
    state:input(command)
  end
end

function StateMachine:inputEnd(command)

  if command == 'none' then command = 'idle' end

  for i, state in ipairs(self.stateMachines) do
    state:inputEnd(command)
  end
end

require('src/player/States/States')
require('src/player/States/MovingStateMachine/MovingStateMachine')
require('src/player/States/ActionStateMachine/ActionStateMachine')