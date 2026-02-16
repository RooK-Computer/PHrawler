require('src/player/states/ActionStates/ActionIdleState')
require('src/player/states/ActionStates/DeadState')
require('src/player/states/ActionStates/FightState')
require('src/player/states/ActionStates/DamageState')
require('src/player/states/ActionStates/FistHitTargetState')


ActionStateMachine = StateMachine:extend()

function ActionStateMachine:new(player)
  
    self.states = {}
    self.states[Constants.IDLE_STATE] = ActionIdleState(player)
    self.states[Constants.FIGHT_STATE] = FightState(player)
    self.states[Constants.DAMAGE_STATE] = DamageState(player)
    self.states[Constants.FIST_HIT_TARGET_STATE] = FistHitTargetState(player)
    self.states[Constants.DEAD_STATE] = DeadState(player)
  
    ActionStateMachine.super.new(self, player, 'ActionStateMachine', self.states, 'idle')
  
  return self
end