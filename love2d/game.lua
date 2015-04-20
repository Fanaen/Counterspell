
require "attack"
require "enemy"

Game = {
  
}


function Game:load()

  -- Physic --
  
  love.physics.setMeter(LINES_HEIGHT) -- the height of a meter our worlds will be LINES_HEIGHT px
  self.world = love.physics.newWorld(0, 0, true)
  self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  -- Fanaen Code --

  self.textBlinkLength  = 0.5   -- Cursor's blink 
  self.textBlinkTime    = 0     -- Cursor's current time (used for state)
  self.textBlinkState   = true  -- Cursor's current state
  self.textCursorLine   = 1     -- Cursor's line
  self.textLineMax      = 10    -- Nb line max
  self.textCursorText   = "Test"    -- Current text
  self.textFont         = love.graphics.newFont("fonts/UbuntuMono-R.ttf", 20)
  
  -- Background --
  self.background       = love.graphics.newImage("images/background.png")
  
  -- Text attacks list --
  self.attacks          = {}

  -- Psyko Code --
  
end

function Game:update(dt)

  -- Fanaen Code --
  
  -- Blink state --
  self.textBlinkTime = self.textBlinkTime + dt
  if self.textBlinkTime > self.textBlinkLength then 
    self.textBlinkState = not self.textBlinkState
    self.textBlinkTime = self.textBlinkTime - self.textBlinkLength
  end
  
  -- Attacks --
  self:updateArray(self.attacks, dt)

-- Psyko Code --
	
end

function Game:draw()

  -- Fanaen Code --
  
  -- Background --
  love.graphics.draw(self.background, 0, 0)
  
  -- Line --
  local lineY = MARGIN_TOP + self.textCursorLine * LINES_HEIGHT
  
  -- Text --
  if self.textCursorText ~= "" then
    local x = 10
    local y = lineY
  
    love.graphics.setFont(self.textFont)
    love.graphics.print(self.textCursorText, x, y)
  end
  
  -- Cursor --
  if self.textBlinkState then
    local x = 10 + string.len(self.textCursorText) * 10
    local y = lineY
    love.graphics.rectangle("fill", x, y, 4, 20)
  end
  
  -- Draw attacks --
  
  self:drawArray(self.attacks)
  
  -- Psyko Code --	

end

function Game:onkeypressed(k)

  -- Fanaen Code --
  if k == "backspace" then
    self:backspace()
  elseif k == "return" then
    self:enter()
  elseif string.len(k) == 1 then
    self.textCursorText = self.textCursorText .. k
  end
  
  -- Psyko Code --
	
end

-- Management methods --

function Game:enter()
  
  -- Send the text --
  if string.len(self.textCursorText) > 0 then
    
    local attack = Attack:new(nil, self.textCursorText, self.textCursorLine)
    attack:config()
    attack:loadPhysic(self.world)
    table.insert(self.attacks, attack)
    
    self.textCursorText = ""
  end

  -- Go to the next line --
  if self.textCursorLine < self.textLineMax then
    self.textCursorLine = self.textCursorLine + 1
  end
  
end

function Game:backspace()

  if string.len(self.textCursorText) > 0 then -- Remove a letter --
    self.textCursorText = string.sub(self.textCursorText, 1, string.len(self.textCursorText) - 1)
  elseif self.textCursorLine > 1 then -- Remove the line --
    self.textCursorLine = self.textCursorLine - 1
  end
end

function Game:drawArray(array)
  for key, item in ipairs(array) do
    item:draw()
  end
end

function Game:updateArray(array, dt)
  for key, item in ipairs(array) do
    item:update(dt)
  end
end

-- Physic --

function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    local aObject, bObject = a:getUserData(),  b:getUserData()
    
        
    print(aObject.className.." colliding with ".. bObject.className)
end

function endContact(a, b, coll) end
function preSolve(a, b, coll) end
function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2) end

