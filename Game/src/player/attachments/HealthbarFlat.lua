HealthbarFlat = Attachments:extend()

function HealthbarFlat:new(player)
  HealthbarFlat.super.new(self, player)
  return self
end

function HealthbarFlat:create()
  self.scale = 0.1
  local player = self.player

  local scale = self.scale
  self.containerDrawable =  love.graphics.newImage('assets/players/healthbar/HealthbarFlat_container.png')
  local containerMiddle = self.containerDrawable:getWidth() * scale
  self.containerdrawConfig = {
    scaleX = scale,
    scaleY = scale,
    offsetX = containerMiddle/2
  }


  self.fillingDrawable = love.graphics.newImage('assets/players/healthbar/HealthbarFlat_filling.png')
  self.fillingDrawConfig = {
    scaleX = scale,
    scaleY = scale,
    offsetX = containerMiddle/2
  } 

end


function HealthbarFlat:setHealthbar(newHealth)

  local player = self.player

  local scale = self.scale
  self.containerdrawConfig.scaleX = scale
  self.containerdrawConfig.scaleY = scale
  


  local filling = scale * (newHealth/player.maxHealth)
  self.fillingDrawConfig.scaleX = filling
  self.fillingDrawConfig.scaleY = scale
  
end


function HealthbarFlat:draw()


  love.graphics.draw(
    self.containerDrawable, 
    self.player.x + self.player.width/2 - self.containerdrawConfig.offsetX, 
    self.player.y, 
    0, 
    self.containerdrawConfig.scaleX, 
    self.containerdrawConfig.scaleY
    )


    love.graphics.draw(
    self.fillingDrawable, 
    self.player.x + self.player.width/2 - self.fillingDrawConfig.offsetX, 
    self.player.y, 
    0, 
    self.fillingDrawConfig.scaleX, 
    self.fillingDrawConfig.scaleY
    )


end






