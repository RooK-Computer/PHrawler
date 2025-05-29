ActionIdleState = State:extend()

function ActionIdleState:new(player)
  ActionIdleState.super.new(self, player)
  self.name = Constants.IDLE_STATE

  return self
end

function ActionIdleState:input(command)
  ActionIdleState.super.input(self, command)

  local player = self.player

  if command == Constants.PLAYER_FIGHT_COMMAND then return FightingState(player) end
  
end