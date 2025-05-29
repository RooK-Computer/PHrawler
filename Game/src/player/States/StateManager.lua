require('src/player/States/States')
require('src/player/States/StateMachine')
require('src/player/States/ActionStates/ActionIdleState')
require('src/player/States/MovingStates/MovingIdleState')

StateManager = Object:extend()

function StateManager:new(player)
  self.player = player
  self.name = player.name
  self.stateMachines = {
    StateMachine(player, 'MovingStateMachine', MovingIdleState),
    StateMachine(player, 'ActionStateMachine', ActionIdleState)
  }

  return self
end


function StateManager:update(dt)
  for i,state in ipairs(self.stateMachines) do 
    state:update(dt)
  end 
end


function StateManager:inputStart(command)

  if command == 'none' then command = 'idle' end

  for i, state in ipairs(self.stateMachines) do
    state:input(command)
  end
end

function StateManager:inputEnd(command)

  if command == 'none' then command = 'idle' end

  for i, state in ipairs(self.stateMachines) do
    state:inputEnd(command)
  end
end