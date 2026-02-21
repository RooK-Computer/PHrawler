
PlayerView = View:extend()

function PlayerView:new(player)
    PlayerView.super.new(self)
    self.player = player
    self.anim = anim8.newAnimation( self.player.grid('1-8',1), 0.05)
    return self
end

function PlayerView:update(dt)
    self.anim:update(dt)
end

function PlayerView:draw()
    self.anim:draw(self.player.spritesheet,self:getWidth()/2,self:getHeight()/2,nil,1,1,32,32)
end