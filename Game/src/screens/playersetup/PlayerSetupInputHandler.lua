
PlayerSetupInputHandler = InputHandler:extend()

function PlayerSetupInputHandler:new(screen)
    self.screen = screen
end

function PlayerSetupInputHandler:OnRelease(joystick, button)
    if button == "a" then
        self.screen:goBack()
    end
    if button == "b" then
        self.screen:registerNewPlayer(joystick:getID())
    end
end