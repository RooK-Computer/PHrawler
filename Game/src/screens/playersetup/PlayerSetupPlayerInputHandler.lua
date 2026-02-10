
PlayerSetupPlayerInputHandler = InputHandler:extend()

function PlayerSetupPlayerInputHandler:new(gamepadID,playerView,screen)
    self.gamePad = gamepadID
    self.view = playerView
    self.screen = screen
end

function PlayerSetupPlayerInputHandler:AllowedInputDevices() 
    return {self.gamePad}
end

function PlayerSetupPlayerInputHandler:OnRelease(joystick, button)
    if self.view.ready then
        return
    end
    if button == "dbright" then
        --TODO: choose next model
    end
    if button == "dpleft" then
        --TODO: choose previous model
    end
    if button == "a" then
        self.view.ready=true
        self.view:setNeedsDisplay()
        self.screen:readyCheck()
    end
end