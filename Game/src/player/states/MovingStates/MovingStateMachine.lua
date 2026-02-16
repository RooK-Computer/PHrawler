require('src/player/states/MovingStates/MovingIdleState')
require('src/player/states/MovingStates/RunningState')
require('src/player/states/MovingStates/JumpState')
require('src/player/states/MovingStates/FallingState')
require('src/player/states/MovingStates/DropState')


MovingStateMachine = StateMachine:extend()

function MovingStateMachine:new(player)
  
    self.states = {}
    self.states[Constants.IDLE_STATE] = MovingIdleState(player)
    self.states[Constants.RUN_STATE] = RunningState(player)
    self.states[Constants.JUMP_STATE] = JumpState(player)
    self.states[Constants.FALL_STATE] = FallingState(player)
    self.states[Constants.DROP_STATE] = DropState(player)

  
    MovingStateMachine.super.new(self, player, 'MovingStateMachine', self.states, 'idle')
  
  return self
end