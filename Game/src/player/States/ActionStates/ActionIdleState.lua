require('src/player/States/ActionStates/DeadState')
require('src/player/States/ActionStates/FightingState')
require('src/player/States/ActionStates/HitState')

--EntryState
ActionIdleState = State:extend()

function ActionIdleState:new(player)
  ActionIdleState.super.new(self, player)
  self.name = Constants.IDLE_STATE
  self.player.anim = player.animations[Constants.IDLE_STATE][player.animationDirection]

  return self
end

function ActionIdleState:input(command)
  ActionIdleState.super.input(self, command)

  local player = self.player
  if command == Constants.PLAYER_HIT_COMMAND then return HitState(player) end
  if command == Constants.PLAYER_FIGHT_COMMAND then return FightingState(player) end  

end

function ActionIdleState:update(dt)

  local player = self.player
  if self.player.health < 1 then return DeadState(player) end
end