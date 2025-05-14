require('src/input/InputManager')
require('src/player/States/States')


Player = Object:extend()

function Player:new(config, game)

  self.name = config.name
  self.id = config.id
  self.x = config.x
  self.y = config.y
  self.world = game.world
  self.controls = config.controls.keyboard
  self.defaultInput = config.controls.defaultInput
  self.inputManager = game.inputManager:registerPlayer(self, config.controls.defaultInput)
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
  player.colliders = {
    playerCollider = player.world:newBSGRectangleCollider(player.x, player.y, 15, 30 , 10)
  }
  player.colliders.playerCollider:setFixedRotation(true)
  player.colliders.playerCollider:setCollisionClass('Player')
  player.colliders.playerCollider:setObject(player)

  player.colliderID = 'fight'.. player.id

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

  player.colliders.playerCollider:setPreSolve(function(collider_1, collider_2, contact)        
      if collider_1.collision_class == 'Player' and collider_2.collision_class == 'Platform' then
        local playerX, playerY = collider_1:getPosition()
        local platformX, platformY = collider_2:getPosition() 
        if playerY + 10 > platformY then 
          contact:setEnabled(false)
          player.isOnGround = false
          return
        end
      end
    end)


  player.state = FallingState(self)

end


function Player:update(dt)

  local player = self
  player.dt = dt
  player:setIsOnGround()

  player.inputManager:checkForInput()
  player.state:update(dt)

  player.x = player.colliders.playerCollider:getX() - player.width/2
  player.y = player.colliders.playerCollider:getY() - player.height/2
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


function Player:setIsOnGround()

  local player = self
  player.isOnGround = false 

  local colliderClasses = {'Platform'}

  for i, colliderClass in pairs(colliderClasses) do

    player.colliders.playerCollider:enter(colliderClass)
    if player.colliders.playerCollider:stay(colliderClass) then 
      player.isOnGround = true 
    end
    player.colliders.playerCollider:exit(colliderClass)

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


