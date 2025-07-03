Player = GameObject:extend()

function Player:new(area,x,y,opts)
    Player.super.new(self,area,x,y,opts)
    self.name = 'Player'
    self.x,self.y = x, y
    self.w,self.h = 12,12
end

function Player:update(dt)
    Player.super.update(self,dt)


    if input:down('left') then
        self.x = self.x - 1    
    end

    if input:down('right') then
        self.x = self.x + 1
    end

    if input:down('up') then
        self.y = self.y - 1
    end

    if input:down('down') then
        self.y = self.y + 1    
    end
end

function Player:draw()
    love.graphics.setColor(love.math.colorFromBytes(128, 234, 255))
    love.graphics.rectangle("fill", self.x,self.y, self.w,self.h)
end