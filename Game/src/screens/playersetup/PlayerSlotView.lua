
PlayerSlotView = View:extend()

function PlayerSlotView:new()
    self.player = nil
    self.gamepad = nil
    self.model = nil
    self.ready = false
    return self
end

function PlayerSlotView:draw()
    if self.gamepad == nil then
        --TODO: we are not yet active
        love.graphics.clear(255,0,0)
    else
        if self.ready == false then
            love.graphics.clear(0,255,0)
            --TODO: render the selection UI
        else
            love.graphics.clar(0,0,255)
            --TODO: render the finished UI
        end
    end
end