
require "entity"

Attack = Entity:new()

-- Constructors --

function Attack:new(o, text, line)
  o = o or Entity:new()
  setmetatable(o, self)
  self.__index = self
  self.className = "Attack"
  self.text = text
  self.line = line
  return o
end

-- Methods --

function Attack:config()
  self.x = 10
  self.y = MARGIN_TOP + self.line * LINES_HEIGHT
  self.h = 20
  self.w = string.len(self.line) * 10
  
  
end

function Attack:loadPhysic(world)
  self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  self.body:setFixedRotation(true)
  self.shape = love.physics.newRectangleShape(0, 0, self.w, self.h)
  self.fixture = love.physics.newFixture(self.body, self.shape, 20)
  self.fixture:setUserData(self)
end

function Attack:update(dt)
  self.x = self.x + 10 * dt
end

function Attack:draw()
  love.graphics.print(self.text, self.x, self.y)
end