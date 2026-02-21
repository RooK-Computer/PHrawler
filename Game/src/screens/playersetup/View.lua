View = Object:extend()

function View:new()
    self.view = {}
    self.view.x = 0
    self.view.y = 0
    self.view.width = 0
    self.view.height = 0
    self.view.dirty = false
    self.view.subviews = {}
    return self
end

function View:getX()
    return self.view.x
end

function View:getY()
    return self.view.y
end

function View:getWidth()
    return self.view.width
end

function View:getHeight()
    return self.view.height
end

function View:setX(x)
    self.view.x = x
end

function View:setY(y)
    self.view.y = y
end

function View:setWidth(width)
    self.view.width=width
    self:setNeedsDisplay()
end

function View:setHeight(height)
    self.view.height=height
    self:setNeedsDisplay()
end

function View:addSubview(view)
    table.insert(self.view.subviews,view)
    self:setNeedsDisplay()
end

function View:removeSubview(view)
    self:setNeedsDisplay()
    for k,v in ipairs(self.view.subviews) do
        if v == view then
            table.remove(self.view.subviews,k)
            return
        end
    end
end

function View:setNeedsDisplay()
    self.view.dirty=true
    for k,v in ipairs(self.view.subviews) do
        v:setNeedsDisplay()
    end
end

function View:update(dt)
    for k,v in ipairs(self.view.subviews) do
        v:update(dt)
    end
end

function View:draw()
end

function View:viewdraw()
    love.graphics.push()
    love.graphics.translate(self.view.x,self.view.y)
-- unfortunately, the tiledmaps library fucks up stencil buffers as its not saving them correctly.    
--    local width = self.view.width
--    local height = self.view.height
--    love.graphics.stencil(function()
--        love.graphics.rectangle("fill",0,0,width,height)
--    end,"replace",1)
--    love.graphics.setStencilTest("greater",0)
    self:draw()
--    love.graphics.setStencilTest("always",0)

    for k,v in ipairs(self.view.subviews) do
        v:viewdraw()
    end
    love.graphics.pop()
end