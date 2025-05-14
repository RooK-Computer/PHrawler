require('src/level/TiledMaps/TiledMaps')

BetaStage = TiledMaps:extend()

function BetaStage:new(world)
  self.sti = sti('maps/beta-stage.lua') -- draw method comes from TiledMaps abstract class
  self.world = world
  self:setup()
  return self

end


function BetaStage:setup()
  local world = self.world
  world:addCollisionClass('Platform')
  world:addCollisionClass('Player')
  world:addCollisionClass('WorldLimits')

  local level = self.sti

  if level.layers['Plattforms'] then

    for i, obj in pairs(level.layers['Plattforms'].objects) do 
      local plattform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
      plattform:setType('static')
      plattform:setCollisionClass('Platform')
      plattform:setObject(plattform)
    end
  end

  if level.layers['WorldLimits'] then

    for i, obj in pairs(level.layers['WorldLimits'].objects) do 
      local limits = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
      limits:setCollisionClass('WorldLimits')
      limits:setType('static')
    end
  end
end

