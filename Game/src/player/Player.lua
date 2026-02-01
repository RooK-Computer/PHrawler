require('src/input/InputManager')
require('src/player/states/StateManager')
require('src/player/attachments/Attachments')


Player = Object:extend()

function Player:new(config, game)

  self.name = config.name
  self.id = config.id
  self.priority = config.priority
  self.x = config.x
  self.y = config.y
  self.world = game.world
  self.controls = config.controls
  self.activeInput = config.controls.defaultInput
  self.ongoingCommand = {}

  self.config = config
end

function Player:setup()
  local player = self
  player.width = 64 * game.scale
  player.height = 64 * game.scale
  player.speed = 2 * game.PIXELS_PER_METER
  player.velocityX = 0
  player.velocityY = 0
  player.hasJumped = 0
  player.upThreshold = 0
  player.health = 5
  player.maxHealth = player.health
  player.debug = {}
  player.isOnGround = false
  player.isDead = false
  player.isMovementBlocked = false


  player.attachments = {
    healthbar = Healthbar(self)
  }

  player.spritesheet = love.graphics.newImage('assets/players/' .. player.id .. '.png')
  player.grid = anim8.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight() )

  player.physics = {}
  player.physics.body = love.physics.newBody(game.world, player.x, player.y, 'dynamic')
  player.physics.body:setFixedRotation(true)
  player.physics.shape = love.physics.newRectangleShape(player.width/4, player.height/2)
  player.physics.fixture = love.physics.newFixture(player.physics.body, player.physics.shape)
  player.collisionClass = 'Player'


  player.physics.fixture:setUserData(player)  

  player.direction = 'right'
  player.animationDirection = 'right'
  player.animationDuration = 0.05
  player.animations = {}


  for stateName, animationConfig in pairs(player.config.animations) do

    local frames = {}

    for i, animationFrames in pairs(animationConfig.frames) do

      local internalFrames = player.grid(animationFrames.grid, animationFrames.column)

      for i, internalFrame in pairs(internalFrames) do
        table.insert(frames, internalFrame)
      end
    end

    player.animations[stateName] = {}
    player.animations[stateName].right = anim8.newAnimation( frames, player.animationDuration, animationConfig.onLoop or function() end )
    player.animations[stateName].left = player.animations[stateName].right:clone():flipH()

  end


  player.stateManager = StateManager(player)

end

function Player:setStartingPoint(point) 
  self.x = point.x
  self.y = point.y
end


function Player:setDamage(damagePoints)

  local player = self

  player.health = player.health - damagePoints

  player.attachments.healthbar:setHealthbar(player.health)

end


function Player:update(dt)

  local player = self
  player.dt = dt

  for command,active in pairs(self.ongoingCommand) do
    if active == true then
      player.stateManager:inputStart(command)
    end
  end

  player.stateManager:update(dt)

  player.x = player.physics.body:getX() - player.width/2
  player.y = player.physics.body:getY() - player.height/2
  player.anim:update(dt)

end

function Player:inputStart(command)
  self.stateManager:inputStart(command)
  if command == Constants.PLAYER_DIRECTION_LEFT or command == Constants.PLAYER_DIRECTION_RIGHT or command == Constants.PLAYER_FIGHT_COMMAND then
    self.ongoingCommand[command] = true
  end
end

function Player:inputEnd(command)  
  self.stateManager:inputEnd(command)
  if self.ongoingCommand[command] == true then
    self.ongoingCommand[command] = false
  end
end

function Player:draw()
  self.anim:draw(self.spritesheet, self.x, self.y, nil, game.scale)

  for i,attachment in pairs(self.attachments) do attachment:draw() end

end

function Player:getActiveStates()  
  return player.stateManager:getActiveStates()
end


