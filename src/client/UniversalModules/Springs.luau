--// Mememoxzine, 2024
--// Inspired from Blackshibe's spring module

local _iterations: number = 8

local Spring = {}
Spring.__index = Spring

function Spring.new(mass: number, force: number, damping: number, speed: number): any
local self = {
Target= Vector3.new();
Position= Vector3.new();
Velocity= Vector3.new();

Mass= mass or 5;
Force= force or 50;
Damping= damping or 4;
Speed= speed  or 4;
}

return setmetatable(self, Spring)
end

function Spring:Shove(force: Vector3): any
local x, y, z = force.X, force.Y, force.Z

if (x ~= x or x == math.huge or x == -math.huge) then -- check if x is a real number
x = 0
end

if (y ~= y or y == math.huge or y == -math.huge) then -- check if y is a real number
y = 0
end

if (z ~= z or z == math.huge or z == -math.huge) then -- check if z is a real number
z = 0
end

self.Velocity = self.Velocity + Vector3.new(x, y, z)
end

function Spring:Update(deltaTime: number)
local scaledDeltaTime = math.min(deltaTime, 1) * self.Speed/_iterations

for i: number = 1, _iterations do
local iterationForce = self.Target - self.Position
local acceleration = (iterationForce * self.Force)/self.Mass

acceleration = acceleration - self.Velocity * self.Damping

self.Velocity = self.Velocity + acceleration * scaledDeltaTime
self.Position = self.Position + self.Velocity * scaledDeltaTime
end

return self.Position
end

-- export default

return Spring
