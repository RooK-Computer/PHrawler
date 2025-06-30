require('src/level/TiledMaps/TiledMaps')

Palasthotel_Stage1 = TiledMaps:extend()

function Palasthotel_Stage1:new(world)
  self.world = world
  self.startingPoints = {}
  self.name = 'Palasthotel...Stage 1'
  return self

end


function Palasthotel_Stage1:setup()
  local world = self.world
  self.sti = sti('maps/palasthotel-stage.lua') -- draw method comes from TiledMaps abstract class

  local level = self.sti

  if level.layers['Plattforms'] then

    for i, obj in pairs(level.layers['Plattforms'].objects) do 
      local plattform = {
        collisionClass = 'Plattform',
        object = obj
      }

      plattform.body = love.physics.newBody(world, obj.x, obj.y, 'static')

      if (obj.shape == 'rectangle') then plattform.shape = love.physics.newRectangleShape( obj.width/2, obj.height/2, obj.width, obj.height ) end
      if (obj.shape == 'polygon') then 

        local vertices = {}
        for _, vertice in ipairs(obj.polygon) do
          table.insert(vertices, vertice.x)
          table.insert(vertices, vertice.y)
        end
        
        plattform.shape = love.physics.newPolygonShape(vertices) 

      end
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


