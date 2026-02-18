Level = Object:extend()


function Level:new(world, levelID)
  self.stage = nil

  if levelID == Constants.LEVEL_1 then 
    require('src/level/TiledMaps/Palasthotel_Stage1')
    self.stage = Palasthotel_Stage1(world)
  end


end

function Level:setupLevel()
  if self.stage ~= nil then self.stage:setup() end
end


function Level:getName()
  if self.stage ~= nil then return self.stage.name end
  
  return ''
end


function Level:enterLevel()
    self.stage:enterLevel()
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
