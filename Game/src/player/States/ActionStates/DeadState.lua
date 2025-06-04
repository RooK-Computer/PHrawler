DeadState = State:extend()

function DeadState:new(player)
  DeadState.super.new(self, player)

  self.name = Constants.DEAD_STATE
  self.player.startTimer = love.timer.getTime()
  self.player.anim = player.animations[Constants.DEAD_STATE][player.animationDirection]
  self.player.collisionClass = Constants.DEAD_STATE

  self.player.physics.shape = love.physics.newRectangleShape(0, 14, 1, 1, math.rad(90))
  self.player.physics.fixture:destroy()
  self.player.physics.fixture = love.physics.newFixture(self.player.physics.body, self.player.physics.shape)


  self.player.isDead = true
  self.player.isMovementBlocked = true

  return self
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