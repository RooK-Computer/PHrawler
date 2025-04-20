BetaStage = {}
BetaStage.__index = BetaStage


function BetaStage.new(world)
  local betaStage = {}
  setmetatable(betaStage, BetaStage)

  betaStage.sti = sti('maps/beta-stage.lua')
  betaStage:init(world)
  
  return betaStage

end


function BetaStage:init(world)
  
  world:addCollisionClass('Platform')
  world:addCollisionClass('Player')
  plattforms = {}

  local level = self.sti

  if level.layers['Plattforms'] then

    for i, obj in pairs(level.layers['Plattforms'].objects) do 
      local plattform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
      plattform:setType('static')
      plattform:setCollisionClass('Platform')
      plattform:setObject(plattform)

      --plattform:setUserData({name = 'plattform_'..i})
      table.insert(plattforms, plattform)
    end
  end

  worldLimits = {}

  if level.layers['WorldLimits'] then

    for i, obj in pairs(level.layers['WorldLimits'].objects) do 
      local limits = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
      limits:setType('static')
      table.insert(worldLimits, limits)
    end
  end
end


function BetaStage:draw()
  self.sti:draw()
end