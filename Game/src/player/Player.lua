require('src/input/InputManager')
require('src/player/States/States')


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
  self.inputs = {}


  for inputType, controls in pairs(self.controls.inputs) do
    self.inputs[inputType] = game.inputManager:registerPlayer(self, inputType, controls)
  end 

  self.inputManager = self.inputs[self.activeInput]


  self.config = config

  self:setup()

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
  player.debug = {}
  player.isOnGround = false

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
  player.formerDirection = 'right'
  player.animationDuration = 0.05
  player.animations = {}       


  for stateName, animationConfig in pairs(player.config.animations) do

    player.animations[stateName] = {}
    player.animations[stateName].right = anim8.newAnimation( player.grid(animationConfig.grid, animationConfig.column), player.animationDuration )
    player.animations[stateName].left = player.animations[stateName].right:clone():flipH()

    player.animations[stateName].up = player.animations[stateName].right:clone() 
    player.animations[stateName].down = player.animations[stateName].right:clone() 

  end

  player.state = FallingState(self)

end


function Player:update(dt)

  local player = self
  player.dt = dt

  player.inputs[player.activeInput]:checkForInput()
  player.state:update(dt)

  player.x = player.physics.body:getX() - player.width/2
  player.y = player.physics.body:getY() - player.height/2
  player.anim:update(dt)

end

function Player:inputStart(command)

  local player = self
  if command == 'none' then command = 'idle' end
  local newState = player.state:input(command)

  if newState then 
    player.state = newState
  end


end

function Player:inputEnd(command)

  local player = self
  if command == 'none' then command = 'idle' end
  local newState = player.state:inputEnd(command)

  if newState then 
    player.state = newState
  end

end


function Player:draw()
  self.anim:draw(self.spritesheet, self.x, self.y, nil, game.scale)
end


