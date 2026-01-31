
PlayerInput = InputHandler:extend()

function PlayerInput:new(screen,player,inputs,config)
    self.screen = screen
    self.player = player
    self.inputs = inputs
    self.buttons = {}

    for command, buttons in pairs(config) do 
        for i, button in ipairs(buttons) do
            self.buttons[button] = command
        end
    end
    return self
end

function PlayerInput:AllowedInputDevices()
    return self.inputs
end

function PlayerInput:OnPress(joystick, button)
    local command = self.buttons[button]
    if command then
        self.player:inputStart(command)
    end
end

function PlayerInput:OnRelease(joystick, button)
    local command = self.buttons[button]
    if command then
        self.player:inputEnd(command)
    end
    if button == "start" then
        self.screen:pauseScreen()
    end
end