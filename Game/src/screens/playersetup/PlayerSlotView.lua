
PlayerSlotView = View:extend()

function PlayerSlotView:new()
    PlayerSlotView.super.new(self)
    self.spritesheet = nil
    self.animGrid = nil
    self.anim = nil
    self.loadedImage = nil
    self.name = nil
    self.player = nil
    self.gamepad = nil
    self.ready = false
    self.wantsNextModel = false
    self.wantsPreviousModel = false

    self.changeLeftIndicator = love.graphics.newImage('assets/images/triangle_points_left.png')
    self.changeRightIndicator = love.graphics.newImage('assets/images/triangle_points_right.png')
    self.font = love.graphics.newFont( '/assets/fonts/NewGameFont.ttf',32 )

    return self
end

function PlayerSlotView:update(dt) 
    if self.anim ~= nil then
        self.anim:update(dt)
    end
end

function PlayerSlotView:draw()
    if self.loadedImage ~= self.player then
        self.spritesheet = love.graphics.newImage('assets/players/'..self.player..'.png')
        self.animGrid = anim8.newGrid( 64, 64, self.spritesheet:getWidth(), self.spritesheet:getHeight() )
        self.anim = anim8.newAnimation( self.animGrid('1-8',1), 0.05)

        self.loadedImage = self.player
    end
    if self.gamepad == nil then
        
        local width = self.font:getWidth("Press FIGHT")
        love.graphics.print({{144/255, 0, 255/255},"Press FIGHT"},self.font,self:getWidth()/2-width/2,self:getHeight()/2 - self.font:getHeight()/2)
    else
        if self.ready == false then
            local x = self:getWidth()/2
            local y = self:getHeight()/2
            self.anim:draw(self.spritesheet,x,y,nil,1,1,32,32)

            local leftWidth= self:getWidth()/2 - 16
            x = leftWidth/2 - self.changeLeftIndicator:getWidth()/2
            y = self:getHeight()/2 - self.changeLeftIndicator:getHeight()/2
            love.graphics.draw(self.changeLeftIndicator,x,y)

            x = self:getWidth()/2 + 16 + leftWidth/2 - self.changeRightIndicator:getWidth()/2
            y = self:getHeight()/2 - self.changeRightIndicator:getHeight()/2
            love.graphics.draw(self.changeRightIndicator,x,y)

            local fontWidth = self.font:getWidth(self.name)
            love.graphics.print({{144/255, 0, 255/255},self.name},self.font,self:getWidth()/2 - fontWidth/2,self:getHeight()/2 - 16 - self.font:getHeight())

        else
            local x = self:getWidth()/2
            local y = self:getHeight()/2
            self.anim:draw(self.spritesheet,x,y,nil,1,1,32,32)
            local fontWidth = self.font:getWidth(self.name)
            love.graphics.print({{144/255, 0, 255/255},self.name},self.font,self:getWidth()/2 - fontWidth/2,self:getHeight()/2 - 16 - self.font:getHeight())
        end
    end
end