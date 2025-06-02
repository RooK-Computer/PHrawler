require('src/level/TiledMaps/TiledMaps')

BetaStage = TiledMaps:extend()

function BetaStage:new(world)
  self.sti = sti('maps/beta-stage.lua') -- draw method comes from TiledMaps abstract class
  self.world = world
  self.startingPoints = {}
  self:setup()
  return self

end


function BetaStage:setup()
  local world = self.world

  local level = self.sti

  if level.layers['Plattforms'] then

    for i, obj in pairs(level.layers['Plattforms'].objects) do 
      local plattform = {
        collisionClass = 'Plattform',
        object = obj
      }

      plattform.body = love.physics.newBody(world, obj.x, obj.y, 'static')
      plattform.shape = love.physics.newRectangleShape( obj.width/2, obj.height/2, obj.width, obj.height)
      plattform.fixture = love.physics.newFixture( plattform.body, plattform.shape)
      plattform.fixture:setUserData(plattform)  

    end
  end

  if level.layers['WorldLimits'] then

    for i, obj in pairs(level.layers['WorldLimits'].objects) do 

      local worldLimits = { 
        collisionClass = 'WorldLimit',
        object = obj
      }
      worldLimits.body = love.physics.newBody(world, obj.x, obj.y, 'static')
      worldLimits.shape = love.physics.newRectangleShape( obj.width/2, obj.height/2, obj.width, obj.height )
      worldLimits.fixture = love.physics.newFixture( worldLimits.body, worldLimits.shape )
      worldLimits.fixture:setUserData(worldLimits)  

    end
  end


  if level.layers['StartPoints'] then
    for i, obj in pairs(level.layers['StartPoints'].objects) do
      self.startingPoints[i] = {x = obj.x, y = obj.y}

      local startingPointsDebug = {}

      startingPointsDebug.body = love.physics.newBody(world, obj.x, obj.y, 'static')
      startingPointsDebug.shape = love.physics.newCircleShape( obj.x, obj.y, 1 )
      startingPointsDebug.fixture = love.physics.newFixture( startingPointsDebug.body, startingPointsDebug.shape )
      startingPointsDebug.fixture:setSensor(true)  

  end
  
  self.startingPoints = Helper.shuffleArray(self.startingPoints)

  end


end


