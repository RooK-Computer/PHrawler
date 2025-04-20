require 'init'


game = {
  windowWidth = 640,
  windowHeight = 480,
  scale = 1,
  activateDebug = false,
  PIXELS_PER_METER = 100,
  savedAnimationDuration = 0,
  stateActive = false,
  level = {},
  world = {},
}


local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself


function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end

  game.world = windfield.newWorld(0, 9.81 * game.PIXELS_PER_METER)
  game.level = BetaStage.new(game.world)


  love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
  push:setupScreen(game.windowWidth, game.windowHeight, game.windowWidth, game.windowHeight, {
      fullscreen = false,
      vsync = true,
      resizable = true,
      highdpi = true
      })

end

function love.update(dt)


  --for i = 1, #players do

  --player:update(dt)
  --end

  game.world:update(dt)
end

function love.resize(w, h)
  push:resize(w, h)
end


function love.keypressed(key)
  if key == "." then activateDebug = not activateDebug end
--  if key == "," then         
--    for i = 1, #players do
--      print(players[i].name .. ' health: ' .. players[i].health)
--    end
--  end

--  for i = 1, #players do
--    local player = players[i]
--    local vx, vy = player.colliders.playerCollider:getLinearVelocity()

--    if key == player.controls.up and player.canJump < 2 then
--      player.colliders.playerCollider:setLinearVelocity(vx, -340)
--      player.canJump = player.canJump+1
--      player.state = 'jump'
--    end

--    if love.keyboard.isDown(player.controls.fight) then
--      player.state = 'fight'
--    end

--  end

end

function love.draw()

  push:start()
  game.level:draw()
  --  for i = 1, #players do
  --      -- players:draw()
  --    players[i].anim:draw(players[i].spritesheet, players[i].x, players[i].y, nil, scale)
  --  end
  if activateDebug then 
    game.world:draw() 
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
  end
  push:finish()
end


