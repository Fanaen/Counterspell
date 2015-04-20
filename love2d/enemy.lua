
require "entity"

Enemy = Entity:new()

-- Constructors --

function Enemy:new(o)
  o = o or Entity:new()
  setmetatable(o, self)
  self.__index = self
  self.className = "Enemy"
  return o
end

-- Methods --

function Enemy:config()  
end

function Enemy:loadPhysic(world)
  self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  self.body:setFixedRotation(true)
  self.shape = love.physics.newRectangleShape(0, 0, self.w, self.h)
  self.fixture = love.physics.newFixture(self.body, self.shape, 20)
  self.fixture:setUserData(self)
end

function Enemy:update(dt)
  
end

function Enemy:draw()
  
end