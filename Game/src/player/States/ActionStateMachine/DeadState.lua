DeadState = State:extend()

function DeadState:new(player)
  self.player = player
  self.name = Constants.DEAD_STATE
end

function DeadState:input(command)
end