Attachments = Object:extend()

function Attachments:new(player)
  self.player = player
  self:create()
  return self
end

function Attachments:create()
end


function Attachments:draw()
end

require('src/player/attachments/Healthbar')



