
require "entity"

Enemy = Entity:new()

-- Constructors --

function Enemy:new(color, line, o)
  o = o or Entity:new()
  setmetatable(o, self)
  self.__index = self
  self.line = line
  self.className = "Enemy"
  self.drawable = {}
  self.walkStateNb = 3
  self.walkState = 1
  self.walkTime = 0
  self.walkIntertime = 0.25
  
  return o
end

-- Methods --

function Enemy:config()  
  self.x = 800 - 16 - 10
  self.y = MARGIN_TOP + self.line * LINES_HEIGHT + 10
  self.w, self.h = 16, 15
  
  local walkMapping = {}
  walkMapping[1] = 1
  walkMapping[2] = 2
  self.walkStateNb = 2
  
  self:loadSprite("images/enemies/rat-"..self.color..".png", walkMapping) -- 4 directions --
end


function Enemy:loadSprite(location, walkMapping)
  -- Init sprite batch --
  local atlas = love.graphics.newImage(location)
  atlas:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
  local spriteBatch = love.graphics.newSpriteBatch(atlas)
  
  -- Init sprites
  self.quads = {}
  for key, walk in ipairs(walkMapping) do
    self.quads[key] = love.graphics.newQuad(
      (walk-1) * self.w,                  -- x
      0,                              -- y
      self.w,                         -- Sprite width
      self.h,                         -- Sprite height
      atlas:getWidth(),               -- Atlas width
      atlas:getHeight())              -- Atlas height 
  end

  
  -- Init other values --
  self.drawable = spriteBatch
  self.drawable:add(self.quads[self.walkState])
end

function Enemy:loadPhysic(world)
  self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  self.body:setFixedRotation(true)
  self.shape = love.physics.newRectangleShape(0, 0, self.w, self.h)
  self.fixture = love.physics.newFixture(self.body, self.shape, 1)
  self.fixture:setUserData(self)
end

function Enemy:update(dt)

  if self.body:getX() < 100 then
    gameState = GAME_STATE_GAME_OVER
  end

  self.body:setLinearVelocity(-20, 0)
  -- Update state --
  self.walkTime = self.walkTime + dt
  if self.walkTime > self.walkIntertime then 
    self:nextWalkState()
    self.drawable:clear()
    self.drawable:add(self.quads[self.walkState])
    
    self.walkTime = self.walkTime - self.walkIntertime
  end
end

function Enemy:nextWalkState()
  if(self.walkState < self.walkStateNb) then
    self.walkState = self.walkState + 1
  else
    self.walkState = 1
  end
end

function Enemy:draw()
  
  --love.graphics.setColor(100, 100, 100, 255)
  --love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(self.drawable, self.body:getX(), self.body:getY(), 0, 1, 1, self.w/2, self.h/2)
end