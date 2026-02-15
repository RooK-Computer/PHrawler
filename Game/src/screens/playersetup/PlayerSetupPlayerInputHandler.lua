
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
    if button == "dpright" then
        self.view.wantsNextModel = true
    end
    if button == "dpleft" then
        self.view.wantsPreviousModel = true
    end
    if button == "b" then
        self.view.ready=true
        self.view:setNeedsDisplay()
        self.screen:readyCheck()
    end
end