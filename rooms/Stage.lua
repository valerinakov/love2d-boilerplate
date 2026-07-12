Stage = Object:extend()

function Stage:new()
    self.area = Area(self)
    self.timer = Timer()
    self.area:addPhysicsWorld()
    self.main_canvas = love.graphics.newCanvas(gw,gh)

    self.player = self.area:addGameObject('Player', gw/2, gh/2)

    self.wall = self.area:addGameObject('Wall', 300,150)

    self.area:addCollision(self.wall)

    self.area:addCollision(self.player)
end

local playerFilter = function(item, other)
    if other.class == 'Wall' then
        return 'slide'
    end
  -- else return nil
end

function Stage:update(dt)
    self.area:update(dt)
    self.timer:update(dt)

    camera.smoother = Camera.smooth.damped(5)
    camera:lockPosition(dt, (gw/2), gh/2)
    
    if self.player then
        self.area:move(self.player, playerFilter)
        -- camera:lookAt(self.player.x,self.player.y)
    end

    -- Use this if you need to manage movement of multiple objects
    --
    -- if self.area then
    --     local items, len = self.area.world:getItems()

    --     for i, item in ipairs(items) do
    --         if item.name == "Player" then
    --             self.area:move(self.player,playerFilter)
    --         end
    --     end
    -- end

end

function Stage:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    camera:attach(0,0,gw,gh)
        if self.area then self.area:draw() end
    camera:detach()
    love.graphics.setCanvas()

        love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end

function Stage:destroy()
    self.area:destroy()
    self.player = nil
    self.area = nil
    self.timer:destroy()
end