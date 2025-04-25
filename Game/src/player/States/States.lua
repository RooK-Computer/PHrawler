State = Object:extend()

function State:new(player)
  self.player = player
end


function State:enter()
end

function State:input(command)
end

function State:update(dt)
end

function State:exit()
end


require('src/player/States/IdleState')
require('src/player/States/WalkState')
