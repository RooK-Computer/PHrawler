GridLayoutView = View:extend()

function GridLayoutView:draw()
    local subviews = self.view.subviews
    local count = #subviews
    local cols = math.ceil(math.sqrt(count))
    local rows = math.ceil(count / cols)
    local separator = 10;
    local reservedWidth = separator * (cols - 1)
    local reservedHeight = separator * (rows - 1)
    local elemWidth = math.floor((self.view.width - reservedWidth) / cols)
    local elemHeight = math.floor((self.view.height - reservedHeight) / rows)

    local x = 0
    local y = 0
    local col = 0
    local row = 0
    for k,v in ipairs(self.view.subviews) do
        v:setX(x)
        v:setY(y)
        v:setWidth(elemWidth)
        v:setHeight(elemHeight)
        x = x + elemWidth + separator
        col = col + 1
        if col == cols then
            col = 0
            x = 0
            y = y + elemHeight + separator
            row = row + 1
        end
    end
end