Object = require "lib/classic" -- OOP library
--lick = require 'lib/lick' 
--lick.reset = true -- adds live-reloading for development; should be removed on prod
sti = require 'lib/sti' -- simple tiled loader / used for import of tiled maps
anim8 = require 'lib/anim8' -- animation library
--windfield = require 'lib/windfield' -- physics library wrapper
inspect = require('lib/inspect') -- gives us something like var_dump in php
push = require('lib/push') -- gives us resizable screens


--CORE
require('src/core/Stack')

--GLOBALS
require('src/misc/Constants')
require('src/misc/Helper')
require('game')


--classes
require 'src/player/config/PlayersConfig' 
require('src/collisions/Collisions')
require('src/level/Level')
require('src/player/Player')
require 'src/screens/Screens' 

