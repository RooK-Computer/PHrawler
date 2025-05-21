State = Object:extend()

function State:new(player)
  self.player = player
end


function State:enter()
end

function State:input(command)
  local player = self.player

  if player.direction == 'left' or player.direction == 'right' then
    player.animationDirection = player.direction
  end
end

function State:update(dt)
end

function State:exit()
end

function State:inputEnd(command)
end


require('src/player/States/IdleState')
require('src/player/States/RunningState')
require('src/player/States/JumpState')
require('src/player/States/FallingState')
