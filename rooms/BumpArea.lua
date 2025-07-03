BumpArea = Object:extend()

function BumpArea:new(room)
    self.room = room
    self.game_objects = {}
end

function BumpArea:update(dt)
end

function BumpArea:draw()
end

function BumpArea:addWorld()
    self.world = Bump.newWorld(50)
end