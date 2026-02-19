DeadState = State:extend()

function DeadState:new(player)
  DeadState.super.new(self, player)

  self.name = Constants.DEAD_STATE
  self.audio = {}
  self.audio.dead = {
    love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Complain_01.wav' , 'static'),
    love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Complain_02.wav' , 'static'),
    love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Just_Wake_Up.wav' , 'static'),
    love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Afraid.wav' , 'static'),
    love.audio.newSource(Constants.AUDIO.SFX_PATH .. 'Shout.wav' , 'static'),
    }
  
  return self
end

function DeadState:enterState()
  
  local player = self.player
  
  love.event.push(Constants.EVENT_PLAYER_DIED, player.name)
  
  self.audio.dead[math.random(5)]:play()
  
  
  player.startTimer = love.timer.getTime()
  player.anim = player.animations[Constants.DEAD_STATE][player.animationDirection]
  player.collisionClass = Constants.DEAD_STATE
  
  player.physics.shape = love.physics.newRectangleShape(0, 14, 1, 1, math.rad(90))
  player.physics.fixture:destroy()
  player.physics.fixture = love.physics.newFixture(self.player.physics.body, self.player.physics.shape)


  player.isDead = true
  player.isMovementBlocked = true
  
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