local lick = require 'lib/lick' 
lick.reset = true -- adds live-reloading for development; should be removed on prod
local sti = require 'lib/sti'
local anim8 = require 'lib/anim8'
local windfield = require 'lib/windfield'
local inspect = require('lib/inspect') -- gives us something like var_dump in php
local windowWidth = 640
local windowHeight = 480
scale = 1
local activateDebug = false
PIXELS_PER_METER = 100

local savedAnimationDuration = 0
local stateActive = false

function love.load(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    betaStage = sti('maps/beta-stage.lua')
    love.window.setMode(windowWidth, windowHeight)

    world = windfield.newWorld(0, 9.81 * PIXELS_PER_METER)
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
                fight = 'space'
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
                fight = 'lshift'
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
                fight = 'h'
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
                fight = 'c'
            }
        }
    }


    for i = 1, #players do
        local player = players[i]
        player.width = 64 * scale
        player.height = 64 * scale
        player.speed = 2 * PIXELS_PER_METER
        player.canJump = 0
        player.state = 'idle'
        player.upThreshold = 0
        player.health = 5
        player.spritesheet = love.graphics.newImage('assets/players/' .. player.id .. '.png')
        player.grid = anim8.newGrid( 64, 64, player.spritesheet:getWidth(), player.spritesheet:getHeight() )
        player.colliders = {
            playerCollider = world:newBSGRectangleCollider(player.x, player.y, 15, 30 , 10)
        }
        player.colliders.playerCollider:setFixedRotation(true)
        player.colliders.playerCollider:setCollisionClass('Player')
        player.colliders.playerCollider:setObject(player)

        player.colliderID = 'fight'.. player.id


        player.direction = 'left'

        player.animations = {
            idle = {},
            run = {},
            fight = {}
        }

        local animationDuration = 0.15

        player.animations.idle.right = anim8.newAnimation( player.grid('1-8', 1), animationDuration )
        player.animations.idle.left = anim8.newAnimation( player.grid('1-8', 1), animationDuration ):flipH()

        player.animations.run.right = anim8.newAnimation( player.grid('1-8', 3), animationDuration )
        player.animations.run.left = anim8.newAnimation( player.grid('1-8', 3), animationDuration ):flipH()          


        player.animations.fight.right = anim8.newAnimation( player.grid('5-8', 9), animationDuration )
        player.animations.fight.left = anim8.newAnimation( player.grid('5-8', 9), animationDuration ):flipH()
 
        player.anim = player.animations.idle.right --default


        player.updateAnimation = function(dt)
                if player.state == 'idle' then
                    if player.direction == 'right' then player.anim = player.animations.idle.right
                    else player.anim = player.animations.idle.left
                    end
                end

                if player.state == 'running' then
                    if player.direction == 'right' then player.anim = player.animations.run.right
                    else player.anim = player.animations.run.left
                    end
                end

                if player.state == 'fight' then

                    local fixturesID = player.colliderID

                    if not stateActive then 
                        stateActive = true

                        if player.direction == 'left' then 
                            player.anim = player.animations.fight.left 
                                                        
                            if player.colliders.playerCollider.fixtures[fixturesID] == nil then
                                player.colliders.playerCollider:addShape(fixturesID, 'RectangleShape', -10, 0, 100, player.height/2)
                                player.colliders.playerCollider.fixtures[fixturesID]:setSensor(true)
                                player.colliders.playerCollider.fixtures[fixturesID]:setUserData('fightFixtureLeft')
                            end

                        end
                        if player.direction == 'right' then 
                            player.anim = player.animations.fight.right
 
                            if player.colliders.playerCollider.fixtures[fixturesID] == nil then
                                player.colliders.playerCollider:addShape(fixturesID, 'RectangleShape', 10, 0, 100, player.height/2)
                                player.colliders.playerCollider.fixtures[fixturesID]:setSensor(true)
                                player.colliders.playerCollider.fixtures[fixturesID]:setUserData('fightFixtureRight')
                            end
                        end
                    end
                    savedAnimationDuration = savedAnimationDuration + dt
                    if savedAnimationDuration > animationDuration * 3 then 
                        savedAnimationDuration = 0 
                        player.state = 'idle' 
                        player.colliders.playerCollider:removeShape(fixturesID)
                        stateActive = false
                    end


                end

                player.anim:update(dt)

            end



        player.colliders.playerCollider:setPreSolve(function(collider_1, collider_2, contact)        
        if collider_1.collision_class == 'Player' and collider_2.collision_class == 'Platform' then
            local px, py = collider_1:getPosition()
            --print('plattformY: ' .. collider_1)
            --print(inspect(collider_1:getObject()  ))
            --print('.--------.')
            local tx, ty = collider_2:getPosition() 
            --print('plattformY: ' .. collider_2)
            if py + 10 > ty then contact:setEnabled(false) return end
        end

         if collider_1.collision_class == 'Player' and collider_2.collision_class == 'Player' then
            local player1 = collider_1:getObject() 
            local player2 = collider_2:getObject() 
            if player1.colliders.playerCollider.fixtures[player1.colliderID] then
                --local player1 = collider_1:getObject()
                --local fixturesID = player1.colliderID
                print('######')
                print(inspect(player1.name .. ' fights ' .. player2.name  ))
                print('END')
                player1.colliders.playerCollider:removeShape(player1.colliderID)


                player2.health = player2.health -1 

            end
        end
      end)

        player.colliders.playerCollider:setPostSolve(
            function(collider_1, collider_2, contact) 
            end
        )

    end

    plattforms = {}

    if betaStage.layers['Plattforms'] then

        for i, obj in pairs(betaStage.layers['Plattforms'].objects) do 
            local plattform = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            plattform:setType('static')
            plattform:setCollisionClass('Platform')
            plattform:setObject(plattform)

            --plattform:setUserData({name = 'plattform_'..i})
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
        local vx, vy = player.colliders.playerCollider:getLinearVelocity()
        vx = 0

        if vy == 0 then player.canJump = 0 end
        if vy == 0 and vx == 0 and player.state ~= 'fight' then player.state = 'idle' end

        if love.keyboard.isDown(player.controls.right) and player.state ~= 'fight' then
            vx = player.speed
            player.direction = 'right'
            player.state = 'running'
        end

        if love.keyboard.isDown(player.controls.left) and player.state ~= 'fight' then
            vx = -player.speed
            player.direction = 'left'
            player.state = 'running'
        end 

    
        player.colliders.playerCollider:setLinearVelocity(vx, vy)

        

        player.x = player.colliders.playerCollider:getX() - player.width/2
        player.y = player.colliders.playerCollider:getY() - player.height/2
        player.updateAnimation(dt)

    end

    world:update(dt)
end

function love.keypressed(key)
    if key == "." then activateDebug = not activateDebug end
    if key == "," then         
        for i = 1, #players do
            print(players[i].name .. ' health: ' .. players[i].health)
        end
    end

    for i = 1, #players do
        local player = players[i]
        local vx, vy = player.colliders.playerCollider:getLinearVelocity()

        if key == player.controls.up and player.canJump < 2 then
            player.colliders.playerCollider:setLinearVelocity(vx, -340)
            player.canJump = player.canJump+1
            player.state = 'jump'
        end

        if love.keyboard.isDown(player.controls.fight) then
            player.state = 'fight'
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