HitState = State:extend()

function HitState:new(player)
  HitState.super.new(self, player)
  
  self.name = Constants.HIT_STATE
  self.player.startTimer = love.timer.getTime()
  self.player.anim = player.animations[Constants.HIT_STATE][player.animationDirection]
  self.player:setDamage(1)

  return self
end


function HitState:update(dt)

  local player = self.player
  
  player.anim = player.animations[Constants.HIT_STATE][player.animationDirection]
  player.physics.body:setType('static')

  local passedTime = love.timer.getTime() - player.startTimer

  if passedTime > 1 then  
    player.physics.body:setType('dynamic')
    return ActionIdleState(player)
  end

end