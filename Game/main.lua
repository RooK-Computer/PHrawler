local lick = require 'lib/lick' 
lick.reset = true -- adds live-reloading for development; should be removed on prod
local sti = require 'lib/sti'
local anim8 = require 'lib/anim8'
local windfield = require 'lib/windfield'
local windowWidth = 640
local windowHeight = 480
local scale = 1
local activateDebug = false

function love.load()
    betaStage = sti('maps/beta-stage.lua')
    love.window.setMode(windowWidth, windowHeight)

    world = windfield.newWorld(0, 0)

 

    player = {}
    player.width = 64 * scale
    player.height = 64 * scale
    player.x = windowWidth/2  - player.width/2
    player.y = windowHeight/2 - player.height/2
    player.speed = 150
    player.spriteSheet = love.graphics.newImage('assets/players/female_character_v1.png')
    player.grid = anim8.newGrid( 64, 64, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )
    player.collider = world:newBSGRectangleCollider(player.x, player.y, 20, 30 , 10)
    player.collider:setFixedRotation(true)

    player.direction = 'right'

    player.animations = {
        idle = {},
        run = {},
    }
    player.animations.idle.right = anim8.newAnimation( player.grid('1-8', 1), 0.15 )
    player.animations.idle.left = anim8.newAnimation( player.grid('1-8', 1), 0.15 ):flipH()

    player.animations.run.right = anim8.newAnimation( player.grid('1-8', 3), 0.15 )
    player.animations.run.left = anim8.newAnimation( player.grid('1-8', 3), 0.15 ):flipH()
    player.anim = player.animations.idle.right

    walls = {}

    if betaStage.layers['PlattformColliders'] then

        for i, obj in pairs(betaStage.layers['PlattformColliders'].objects) do 
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end






end

function love.update(dt)


    local vx = 0
    local vy = 100
    local isRunning = false
    activateDebug = false


    if love.keyboard.isDown("right") then
        vx = player.speed
        player.direction = 'right'
        isRunning = true
        player.anim = player.animations.run.right
    end

    if love.keyboard.isDown("left") then
        vx = player.speed * -1
        player.direction = 'left'
        isRunning = true
        player.anim = player.animations.run.left
    end

    if love.keyboard.isDown("up") then
        vy = 100 * -1
    end    


    if love.keyboard.isDown("d") then
        print('D')
        activateDebug = true
    end




    if not isRunning then 
        if player.direction == 'right' then player.anim = player.animations.idle.right
        else player.anim = player.animations.idle.left
        end

    end

    player.collider:setLinearVelocity(vx, vy)
    world:update(dt)

    player.x = player.collider:getX() - player.width/2
    player.y = player.collider:getY() - player.height/2
    player.anim:update(dt)

end

function love.draw()
    betaStage:draw()
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, scale)
    if activateDebug then world:draw() end
end


