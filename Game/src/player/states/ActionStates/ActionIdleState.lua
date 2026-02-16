--EntryState
ActionIdleState = State:extend()

function ActionIdleState:new(player)
  ActionIdleState.super.new(self, player)
  
  self.name = Constants.IDLE_STATE

  return self
end

function ActionIdleState:enterState()
  
  local player = self.player
  
  player.anim = player.animations[Constants.IDLE_STATE][player.animationDirection]
  player.isMovementBlocked = false
  
  return self.name
end

function ActionIdleState:input(command)
  ActionIdleState.super.input(self, command)
  local player = self.player
  
  if command == Constants.PLAYER_FIST_HIT_TARGET_COMMAND then 
    local test = 1
    return Constants.FIST_HIT_TARGET_STATE 
    end
  if command == Constants.PLAYER_DAMAGE_COMMAND then return Constants.DAMAGE_STATE end
  if command == Constants.PLAYER_FIGHT_COMMAND then return Constants.FIGHT_STATE end  

end

function ActionIdleState:update(dt)

  local player = self.player
  if self.player.health < 1 then return Constants.DEAD_STATE end
end