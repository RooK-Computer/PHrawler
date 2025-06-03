require('src/player/states/States')
require('src/player/states/StateMachine')
require('src/player/states/ActionStates/ActionIdleState')
require('src/player/states/MovingStates/MovingIdleState')

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