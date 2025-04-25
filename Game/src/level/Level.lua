Level = Object:extend()

function Level:new(world, config)
  self.level = {}
  if config.level == 'betastage' then 
      require('src/level/TiledMaps/BetaStage')
      self.level = BetaStage(world)      
    end

end


function Level:draw()
  self.level:draw()
end