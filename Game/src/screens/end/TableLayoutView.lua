
TableLayoutView = View:extend()

function TableLayoutView:new()
    TableLayoutView.super.new(self)
    self.table = {
        nCols = 0,
        nRows = 0,
        content = {}
    }
    return self
end

function TableLayoutView:setPosition(view,col,row)
    if self.table.content[col] == nil then
        self.table.content[col] = {}
    end
    self.table.content[col][row]=view
    if col > self.table.nCols then
        self.table.nCols = col
    end
    if row > self.table.nRows then
        self.table.nRows = row
    end

end

function TableLayoutView:draw()
    local separator = 10
    local reservedWidth = separator * (self.table.nCols - 1)
    local reservedHeight = separator * (self.table.nRows - 1)
    local elemWidth = math.floor((self.view.width - reservedWidth) / self.table.nCols)
    local elemHeight = math.floor((self.view.height - reservedHeight) / self.table.nRows)
    for col,rows in pairs(self.table.content) do
        for row,view in pairs(rows) do
            local x = (col - 1) * (elemWidth+separator)
            local y = (row - 1) * (elemHeight+separator)
            view:setX(x)
            view:setY(y)
            view:setWidth(elemWidth)
            view:setHeight(elemHeight)
        end
    end
end