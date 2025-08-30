
Stack = Object:extend()

function Stack:new()
    self.store={}
end

function Stack:push(thing)
    table.insert(self.store,thing)
end

function Stack:pop()
    if #self.store == 0 then
        error("Trying to pop from an empty stack.",1)
    end
    table.remove(self.store,#self.store)
end

function Stack:peek(offset)
    return self.store[#self.store-offset]
end

function Stack:popUpTo(thing, includingThing)
    while self:peek(0) ~= thing do
        self:pop()
    end
    if includingThing then
        self:pop()
    end
end

function Stack:clear()
    self.store = {}
end
