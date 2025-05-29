DeadState = State:extend()

function DeadState:new(player)
  self.player = player
  self.name = Constants.DEAD_STATE
  self.player.startTimer = love.timer.getTime()
  self.player.anim = player.animations[Constants.DEAD_STATE][player.animationDirection]
  self.player.physics.body:setType('static')
  self.player.physics.body:setActive(true)
  
  return self

end

function DeadState:update(command)

  local player = self.player
  player.anim = player.animations[Constants.DEAD_STATE][player.animationDirection]

  if player.anim.status == 'paused' then

    local passedTime = love.timer.getTime() - player.startTimer

    if passedTime > 2 then 
      player.physics.fixture:destroy()

      for i, gamePlayer in ipairs(game.players) do 

        if gamePlayer.id == player.id then 
          table.remove(game.players, i)
        end

      end
    end

  end
end