lick = require 'lib/lick' 
lick.reset = true -- adds live-reloading for development; should be removed on prod
sti = require 'lib/sti'
anim8 = require 'lib/anim8'
windfield = require 'lib/windfield'
inspect = require('lib/inspect') -- gives us something like var_dump in php
push = require('lib/push')

--classes
require('src/level/init')