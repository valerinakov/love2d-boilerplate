function UUID()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return  ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

function random(n1, n2)
    if n1 and n2 then 
        if n1 > n2 then
            return love.math.random()*(n1-n2) + n2
        elseif n2 > n1 then
            return love.math.random()*(n2-n1) + n1
        end
    elseif n1 and not n2 then
        return love.math.random()*n1
    end
end

-- Given any number of args, store in table and print individually
function printAll(...)
    local arg = {...}
    for _,v in pairs(arg) do
        print(v)
    end
end

-- Given any number of args, store in table and print as one string
function printText(...)
    local arg = {...}
    local string = ''
    for _,v in pairs(arg) do
        string = string .. v
    end
    print(string)
    return string
end

-- Given pivot points x,y and rotation degree r, rotate r around x,y
function pushRotate(x,y,r)
    love.graphics.push()
    love.graphics.translate(x,y)
    love.graphics.rotate(r or 0)
    love.graphics.translate(-x,-y)
end

-- Given pivot points x,y rotation degree r and scalar values sx,sy, rotate r around x,y and scale
function pushRotateScale(x,y,r,sx,sy)
    love.graphics.push()
    love.graphics.translate(x,y)
    love.graphics.rotate(r or 0)
    love.graphics.scale(sx or 1, sy or sx or 1)
    love.graphics.translate(-x,-y)
end

function table.random(t)
    return t[love.math.random(1,#t)]
end

function table.merge(t1,t2)
    local new_table = {}
    for k,v in pairs(t2) do new_table[k] = v end
    for k,v in pairs(t1) do new_table[k] = v end
    return new_table
end

-- Given a table t, recursively iterate and print key names
function printKeys(t, indent)
    local indent = indent or ""

    for key, value in pairs(t) do
        print(indent .. tostring(key))

        if type(value) == "table" then
            printKeys(value, indent .. "  ")
        end
    end
end

function createIrregularPolygon(size, point_amount)
    local point_amount = point_amount or 8
    local points = {}

    for i = 1, point_amount do 
        local angle_interval = 2*math.pi/point_amount
        local distance = size + random(-size/4, size/4)
        local angle = (i-1)*angle_interval + random(-angle_interval/4, angle_interval/4)
        table.insert(points, distance*math.cos(angle))
        table.insert(points, distance*math.sin(angle))
    end
    return points
end

-- Given tables containing {value, weight} pairs, produce random value (given weight probability) by calling :next()
-- example: 
--   chance_definitions = {
--     {"slime", 5},
--     {"goblin", 3},
--     {"dragon", 1}
--   }
function chanceList(...)
    return {
        chance_list = {},
        chance_definitions = {...},
        next = function(self)
            if #self.chance_list == 0 then
                for _, chance_definition in ipairs(self.chance_definitions) do
                    for i = 1, chance_definition[2] do
                        table.insert(self.chance_list, chance_definition[1])
                    end
                end
            end
            return table.remove(self.chance_list, love.math.random(1,#self.chance_list))
        end
    }
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1-x2) * (x1-x2) + (y1 - y2)*(y1 - y2))
end