local lick = require 'lib/lick' 
lick.reset = true -- adds live-reloading for development; should be removed on prod
local sti = require 'lib/sti'
local anim8 = require 'lib/anim8'
local windfield = require 'lib/windfield'
local windowWidth = 640
local windowHeight = 480
local scale = 1
local activateDebug = false
local PIXELS_PER_METER = 100

function love.load()
    betaStage = sti('maps/beta-stage.lua')
    love.window.setMode(windowWidth, windowHeight)

    world = windfield.newWorld(0, 9.81 * PIXELS_PER_METER)
    --world:setGravity(0, 512)
    world:addCollisionClass('Platform')
    world:addCollisionClass('Player')

    players = {
        {
            name = 'Player One',
            id = 'player_one',
            x = 100,
            y = 50,
            controls = {
                up = 'up',
                left = 'left',
                right = 'right',
            }
        },
        {
            name = 'Player Two',
            id = 'player_two',
            x = 150,
            y = 300,
            controls = {
                up = 'w',
                left = 'a',
                right = 'd',
            }
        },
        {
            name = 'Player Three',
            id = 'player_three',
            x = 300,
            y = 200,
            controls = {
                up = 'i',
                left = 'j',
                right = 'l',
            }
        },
        {
            name = 'Player Four',
            id = 'player_four',
            x = 450,
            y = 250,
            controls = {
                up = 'g',
                left = 'v',
                right = 'n',
            }
        }
    }


    for i = 1, #players do
        local player = players[i]
        player.width = 64 * scale
        player.height = 64 * scale
        player.speed = 2 * PIXELS_PER_METER
        player.canJump = 0
        player.upThreshold = 0
        player.spritesheet = love.graphics.newImage('assets/players/' .. player.id .. '.png')
        player.grid = anim8.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight() )
        player.collider = world:newBSGRectangleCollider(player.x, player.y, 15, 30 , 10)
        player.collider:setFixedRotation(true)
        player.collider:setCollisionClass('Player')

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


        player.collider:setPreSolve(function(collider_1, collider_2, contact)        
        if collider_1.collision_class == 'Player' and collider_2.collision_class == 'Platform' then
          local px, py = collider_1:getPosition()
          --print('playery: ' .. py)
          local tx, ty = collider_2:getPosition() 
          --print('plattformY: ' .. ty)
            if py + 10 > ty then contact:setEnabled(false) end
        end   
      end)

    end

    plattforms = {}

    if betaStage.layers['Plattforms'] then

        for i, obj in pairs(betaStage.layers['Plattforms'].objects) do 
            local plattform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            plattform:setType('static')
            plattform:setCollisionClass('Platform')
            table.insert(plattforms, plattform)
        end
    end

    worldLimits = {}

    if betaStage.layers['WorldLimits'] then

        for i, obj in pairs(betaStage.layers['WorldLimits'].objects) do 
            local limits = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            limits:setType('static')
            table.insert(worldLimits, limits)
        end
    end

end

function love.update(dt)

    for i = 1, #players do

        local player = players[i]
        local vx, vy = player.collider:getLinearVelocity()
        vx = 0
        local isRunning = false

        if vy == 0 then player.canJump = 0 end

        if love.keyboard.isDown(player.controls.right) then
            vx = player.speed
            player.direction = 'right'
            isRunning = true
            player.anim = player.animations.run.right
        end

        if love.keyboard.isDown(player.controls.left) then
            vx = -player.speed
            player.direction = 'left'
            isRunning = true
            player.anim = player.animations.run.left
        end

        if love.keyboard.isDown(player.controls.up) then
            --vy = -player.speed
        end    


        if not isRunning then 
            if player.direction == 'right' then player.anim = player.animations.idle.right
            else player.anim = player.animations.idle.left
            end

        end
        player.collider:setLinearVelocity(vx, vy)

        

        player.x = player.collider:getX() - player.width/2
        player.y = player.collider:getY() - player.height/2
        player.anim:update(dt)

    end

    world:update(dt)
end

function love.keypressed(key)
   if key == "." then activateDebug = not activateDebug end

    for i = 1, #players do
        local player = players[i]
        local vx, vy = player.collider:getLinearVelocity()

        if key == player.controls.up and player.canJump < 2 then
            print(player.canJump)
          player.collider:setLinearVelocity(vx, -340)
          player.canJump = player.canJump+1
        end

    end

end

function love.draw()
    betaStage:draw()
    for i = 1, #players do
        players[i].anim:draw(players[i].spritesheet, players[i].x, players[i].y, nil, scale)
    end
    if activateDebug then 
        world:draw() 
        love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    end
end


