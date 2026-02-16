require('src/player/states/States')
require('src/player/states/StateMachine')
require('src/player/states/ActionStates/ActionStateMachine')
require('src/player/states/MovingStates/MovingStateMachine')

StateManager = Object:extend()

function StateManager:new(player)
  self.player = player
  self.name = player.name
  self.stateMachines = {
    MovingStateMachine(player),
    ActionStateMachine(player)
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

function StateManager:getActiveStates() 
  
  local activeStates = {}
  
  for i, stateMachine in ipairs(self.stateMachines) do
    
    local name = stateMachine.name .. ': ' .. stateMachine.state.name
    table.insert(activeStates, name)
  end
  
  return activeStates
  
  
  end