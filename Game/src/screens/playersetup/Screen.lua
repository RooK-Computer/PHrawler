require 'src/screens/playersetup/View'
require 'src/screens/playersetup/GridLayoutView'
require 'src/screens/playersetup/PlayerSlotView'
require 'src/screens/playersetup/PlayerSetupInputHandler'
require 'src/screens/playersetup/PlayerSetupPlayerInputHandler'

PlayerSetupScreen = Screen:extend()

function PlayerSetupScreen:new()
    self.availablePlayerSlots={}
    self.activePlayerSlots={}
    self.view = GridLayoutView()
    self.inputHandler = PlayerSetupInputHandler(self)
end

function PlayerSetupScreen:load()
    --TODO: fill the available Player slots
end

function PlayerSetupScreen:enter()
    --TODO: push input handler
end

function PlayerSetupScreen:exit()
    --TODO: pop input handler. all of them
end

function PlayerSetupScreen:registerNewPlayer(gamepad)
    --TODO: set up a free player if available.
end

function PlayerSetupScreen:goBack()
    --TODO: leave for the start screen.
end

function PlayerSetupScreen:readyCheck()
    --TODO: check if all players are reay and launch game
end

function PlayerSetupScreen:draw()
    self.view:viewdraw()
end