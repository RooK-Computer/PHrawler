DamageState = State:extend()

function DamageState:new(player)
  DamageState.super.new(self, player)

  self.name = Constants.DAMAGE_STATE
  self.player.startTimer = love.timer.getTime()
  self.player.anim = player.animations[Constants.DAMAGE_STATE][player.animationDirection]
  self.player:setDamage(1)
  self.player.isMovementBlocked = true


  return self
end


function DamageState:update(dt)

  local player = self.player

  player.anim = player.animations[Constants.DAMAGE_STATE][player.animationDirection]

  local passedTime = love.timer.getTime() - player.startTimer

  if passedTime > 1 then  
      self.player.isMovementBlocked = false
    return ActionIdleState(player)
  end

end