Screen = Object:extend()

function Screen:new()
end

function Screen:enter()
end

function Screen:load()
end

function Screen:update(dt)
end

function Screen:draw()
end

function Screen:exit()
end


require 'src/screens/RookScreen' 
require 'src/screens/start/Screen' 
require 'src/screens/GameScreen' 
require 'src/screens/PauseScreen' 
require 'src/screens/EndScreen' 
