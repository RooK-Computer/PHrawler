
PlacementLabelView = View:extend()

function PlacementLabelView:new(font,text)
    PlacementLabelView.super.new(self)
    self.font = font
    self.text = text
end

function PlacementLabelView:draw()
    local height = self.font:getHeight()*2
    local width = self.font:getWidth(self.text)*2
    love.graphics.print({Colors.getPurpleRGBA(),self.text},self.font,self:getWidth()/2-width/2,self:getHeight()/2-height/2,0,2)
end
