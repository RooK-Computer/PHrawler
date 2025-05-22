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
  player.isFighting = false
  player.isDead = false

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

  player.state = FallingState(self)

end

function Player:checkIsOnGround() 
  local vx, vy =   self.physics.body:getLinearVelocity()
  if vy == 0 then self.isOnGround = true end  
end


function Player:fightStart()

  local player = self
  player.isFighting = true 

  local offsetX = player.width/5
  if player.animationDirection == 'left' then offsetX = -player.width/5 end

  local shape = love.physics.newRectangleShape(offsetX, 0, 15, player.height/3)
  local fixture = love.physics.newFixture(player.physics.body, shape)
  fixture:setUserData({player = player, collisionClass = 'FightOtherPlayer'})  
  fixture:setSensor(true)

  player.physics.fightFixture = fixture

end

function Player:dying()
  local player = self

  if player.isDead then 

    if player.anim.status == 'paused' then

      local passedTime = love.timer.getTime() - player.startTimer

      if passedTime > 2 then 


        for i, gamePlayer in ipairs(game.players) do 

          if gamePlayer.id == player.id then 
            table.remove(game.players, i)
          end

        end
      end

    end
  else 
    player.isDead = true
    player.startTimer = love.timer.getTime()
    --player.physics.fixture:setSensor(true)
    player.anim = player.animations['dying'][player.animationDirection]
  end

end

function Player:update(dt)

  local player = self
  player.dt = dt

  player:checkIsOnGround()
  player.inputs[player.activeInput]:checkForInput()
  player.state:update(dt)

  -- needs a new state machine!
  if player.isFighting then player.anim = player.animations['fighting'][player.animationDirection] end
  if player.health == 0 then player:dying() end

  player.x = player.physics.body:getX() - player.width/2
  player.y = player.physics.body:getY() - player.height/2
  player.anim:update(dt)

end

function Player:inputStart(command)

  local player = self
  if command == 'none' then command = 'idle' end
  if command == 'fight' then player:fightStart() end

  local newState = player.state:input(command)

  if newState then 
    player.state = newState
  end


end

function Player:inputEnd(command)

  local player = self
  if command == 'none' then command = 'idle' end
  if command == 'fight' then 
    player.isFighting = false 
    player.anim = player.animations[player.state.name][player.animationDirection]
    player.physics.fightFixture:destroy()
  end

  local newState = player.state:inputEnd(command)

  if newState then 
    player.state = newState
  end

end


function Player:draw()
  self.anim:draw(self.spritesheet, self.x, self.y, nil, game.scale)
end


