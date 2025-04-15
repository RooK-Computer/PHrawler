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
        player.speed = 150
        player.spritesheet = love.graphics.newImage('assets/players/' .. player.id .. '.png')
        player.grid = anim8.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight() )
        player.collider = world:newBSGRectangleCollider(player.x, player.y, 15, 30 , 10)
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
    end

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
    activateDebug = false

    for i = 1, #players do


        local vx = 0
        local vy = 100
        local isRunning = false
        local player = players[i]

        if love.keyboard.isDown(player.controls.right) then
            vx = player.speed
            player.direction = 'right'
            isRunning = true
            player.anim = player.animations.run.right
        end

        if love.keyboard.isDown(player.controls.left) then
            vx = player.speed * -1
            player.direction = 'left'
            isRunning = true
            player.anim = player.animations.run.left
        end

        if love.keyboard.isDown(player.controls.up) then
            vy = 100 * -1
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

    if love.keyboard.isDown(".") then activateDebug = true end
    world:update(dt)
end

function love.draw()
    betaStage:draw()
    for i = 1, #players do
        players[i].anim:draw(players[i].spritesheet, players[i].x, players[i].y, nil, scale)
    end
    if activateDebug then world:draw() end
end


