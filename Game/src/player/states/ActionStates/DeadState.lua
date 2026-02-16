DeadState = State:extend()

function DeadState:new(player)
  DeadState.super.new(self, player)

  self.name = Constants.DEAD_STATE
  
  return self
end

function DeadState:enterState()
  
  local player = self.player
  
  player.startTimer = love.timer.getTime()
  player.anim = player.animations[Constants.DEAD_STATE][player.animationDirection]
  player.collisionClass = Constants.DEAD_STATE
  
  player.physics.shape = love.physics.newRectangleShape(0, 14, 1, 1, math.rad(90))
  player.physics.fixture:destroy()
  player.physics.fixture = love.physics.newFixture(self.player.physics.body, self.player.physics.shape)


  player.isDead = true
  player.isMovementBlocked = true

  if player.gamepad~= nil and player.gamepad:isVibrationSupported() then 
    player.gamepad:setVibration( 1, 1, 1 ) 
  end
  
  return self.name
end 

function DeadState:update(dt)
  DeadState.super.input(self, command)
  local player = self.player

  player.anim = player.animations[Constants.DEAD_STATE][player.animationDirection]

  if player.anim.status == 'paused' then
    local passedTime = love.timer.getTime() - player.startTimer

    if passedTime > 2 then 
      if not self.player.physics.fixture:isDestroyed() then self.player.physics.fixture:destroy() end

      for i, gamePlayer in ipairs(game.players) do 

        if gamePlayer.id == player.id then 
          table.remove(game.players, i)
        end

      end
    end

  end
end