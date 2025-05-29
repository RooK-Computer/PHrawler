State = Object:extend()

function State:new(player)
  self.player = player
  self.name = 'state'
end

function State:input(command)
  local player = self.player

  if player.direction == 'left' or player.direction == 'right' then
    player.animationDirection = player.direction
  end
end

function State:update(dt)
end

function State:inputEnd(command)
end




