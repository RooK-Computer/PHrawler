Healthbar = Attachments:extend()

function Healthbar:new(player)
  Healthbar.super.new(self, player)
  return self
end

function Healthbar:create()

  local player = self.player

  local scale = 0.35
  self.containerDrawable =  love.graphics.newImage('assets/players/healthbar/healthbar_flat_container.png')
  self.containerdrawConfig = {
    x = player.x,
    y = player.y,
    radians = 0,
    scaleX = scale,
    scaleY = scale,
    offsetX = -player.width/2,
    offsetY = -player.height/2 * scale,
  }


  self.fillingDrawable = love.graphics.newImage('assets/players/healthbar/healthbar_flat_filling.png')
  self.fillingDrawConfig = {
    x = player.x,
    y = player.y,
    radians = 0,
    scaleX = scale,
    scaleY = scale,
    offsetX = -player.width/2,
    offsetY = -player.height/2 * scale,
  } 

end


function Healthbar:setHealthbar(newHealth)

  local player = self.player

  local scale = 0.35
  self.containerdrawConfig = {
    x = player.x,
    y = player.y,
    radians = 0,
    scaleX = scale,
    scaleY = scale,
    offsetX = -player.width/2,
    offsetY = -player.height/2 * scale,
  }


  local filling = scale * (newHealth/player.maxHealth)
  self.fillingDrawConfig = {
    x = player.x,
    y = player.y,
    radians = 0,
    scaleX = filling,
    scaleY = scale,
    offsetX = (-player.width/5) / filling,
    offsetY = -player.height/2 * scale,
  } 
end


function Healthbar:draw()


  love.graphics.draw(
    self.containerDrawable, 
    self.player.x, 
    self.player.y, 
    self.containerdrawConfig.radians, 
    self.containerdrawConfig.scaleX, 
    self.containerdrawConfig.scaleY, 
    self.containerdrawConfig.offsetX, 
    self.containerdrawConfig.offsetY
    )


    love.graphics.draw(
    self.fillingDrawable, 
    self.player.x, 
    self.player.y, 
    self.fillingDrawConfig.radians, 
    self.fillingDrawConfig.scaleX, 
    self.fillingDrawConfig.scaleY, 
    self.fillingDrawConfig.offsetX, 
    self.fillingDrawConfig.offsetY
    )


end






