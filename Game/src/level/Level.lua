Level = Object:extend()

function Level:new(world, config)
  self.stage = {}
  if config.level == 'betastage' then 
      require('src/level/TiledMaps/BetaStage')
      self.stage = BetaStage(world)      
    end

end


function Level:draw()
  self.stage:draw()
end

function Level:getStartingPoints()
    return self.stage.startingPoints
end

function Level:getStartingPoint(i)
    return self.stage.startingPoints[i]
end
