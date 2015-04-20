
require "attack"
require "enemy"

local colors = {"black", "blue", "brown", "gray", "green", "orange", "pink", "purple", "rainbow", "red", "white", "yellow", "zebra"}


Game = {
  
}

function Game:load()

  -- Physic --
  
  love.physics.setMeter(LINES_HEIGHT) -- the height of a meter our worlds will be LINES_HEIGHT px
  self.world = love.physics.newWorld(0, 0, true)
  self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  -- Fanaen Code --

  self.textBlinkLength      = 0.5   -- Cursor's blink 
  self.textBlinkTime        = 0     -- Cursor's current time (used for state)
  self.textBlinkState       = true  -- Cursor's current state
  self.textCursorLine       = 1     -- Cursor's line
  self.textLineMax          = 10    -- Nb line max
  self.textCursorText       = ""    -- Current text
  self.textCursorColor      = {r = 255, g = 255, b = 255, a = 255} 
  self.textCursorColorName  = "white"
  self.textFont             = love.graphics.newFont("fonts/UbuntuMono-R.ttf", 20)
  
  -- Background --
  self.background       = love.graphics.newImage("images/background.png")
  
  -- Text attacks list --
  self.attacks          = {}

  -- Psyko Code --
  
  self.pathCount = 10
  self.level = 1
  self.enemyNumber = 0
  self.partyTime = 0
  self.interspaceTime = math.random(2,10)
  self.remainingEnemies = math.random(10,20)
  self.enemies = {}
  
  
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
	
	local selectedLine = math.random(1,LINE_MAX_NUMBER)
	
	  -- Spawn state --
  self.partyTime = self.partyTime + dt
  if self.partyTime > self.interspaceTime then 
    self.partyTime = self.partyTime - self.interspaceTime
    self.interspaceTime = math.random(2,10)
    
    local selectedEnemy = colors[math.random(1,#colors)]
    
    table.insert(self.enemies,selectedEnemy)
  end
	
	
end

function Game:draw()

  -- Fanaen Code --
  
  -- Background --
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(self.background, 0, 0)
  
  -- Line --
  local lineY = MARGIN_TOP + self.textCursorLine * LINES_HEIGHT
  
  -- Text --
  if self.textCursorText ~= "" then
    local x = 10
    local y = lineY
  
    love.graphics.setColor(self.textCursorColor.r, self.textCursorColor.g, self.textCursorColor.b, self.textCursorColor.a)
    love.graphics.setFont(self.textFont)
    love.graphics.print(self.textCursorText, x, y)
  end
  
  -- Cursor --
  if self.textBlinkState then
    local x = 10 + string.len(self.textCursorText) * 10
    local y = lineY
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", x, y, 4, 20)
  end
  
  -- Draw attacks --
  
  self:drawArray(self.attacks)
  
  -- Psyko Code --	

  self:GuiDraw()
end

function Game:onkeypressed(k)

  -- Fanaen Code --
  if k == "backspace" then
    self:backspace()
  elseif k == "return" then
    self:enter()
  elseif string.len(k) == 1 then
    self.textCursorText = self.textCursorText .. k
    
    for key, color in ipairs(self:getColors()) do
      print(self.textCursorText, color)
      if string.find(self.textCursorText, color) then
        self.textCursorColor = self:getColor(color)
      end
    end
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
    
    attack.color = self.textCursorColor
    
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

local DASH_HEIGHT = 50
function Game:GuiDraw()

  -- love.graphics.setFont(mainFont)
  -- love.graphics.setColor(80, 80, 80, 230)
  -- love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,DASH_HEIGHT) -- mode, x, y, width, height
  
  local vertices = {0,SCREEN_HEIGHT-30, 100,SCREEN_HEIGHT-30, 130,SCREEN_HEIGHT, 0,SCREEN_HEIGHT}
  love.graphics.polygon("fill",vertices) -- mode, vertices
  
--  love.graphics.setColor(255, 255, 255)
--  love.graphics.print("Hives Destroyed:", 5,6) -- subtract 12
--  love.graphics.print("Snipes Killed:", 5,26)
--  love.graphics.print(stats.hivesDestroyed.."/"..stats.hivesLeft, 150,6)
--  love.graphics.print(stats.snipesKilled.."/"..stats.snipesLeft, 150,26)
--  love.graphics.print("Lives:", 350,6)
--  love.graphics.print("Level:", 350,26)
--  love.graphics.print(stats.lives, 410,6)
--  love.graphics.print(stats.level, 410,26)
--  love.graphics.print("Score:", 600,6)
--  love.graphics.print("Bonus Time:", 600,26)
--  love.graphics.print(stats.score, 710,6)
--  love.graphics.print(util.round(stats.time,0), 710,26)

  local vertices = {1,DASH_HEIGHT, 
    SCREEN_WIDTH-1,DASH_HEIGHT,
    SCREEN_WIDTH-1,SCREEN_HEIGHT-75-1,
    SCREEN_WIDTH-100-1,SCREEN_HEIGHT-75-1,
    SCREEN_WIDTH-100-1,SCREEN_HEIGHT-1,
    130,SCREEN_HEIGHT-1,
    100,SCREEN_HEIGHT-31,
    1,SCREEN_HEIGHT-31}

  love.graphics.setLineWidth(2)
  love.graphics.polygon("line",vertices) -- mode, vertices
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

-- Color --

function Game:getColor(str)
  local color = {r = 255, g = 255, b = 255, a = 255} 
  
  if str == "black" then
    color.r = 0
    color.g = 0
    color.b = 0
  elseif str == "blue" then
    color.r = 0
    color.g = 127
    color.b = 255
  elseif str == "brown" then
    color.r = 127
    color.g = 63
    color.b = 0
  elseif str == "gray" then
    color.r = 127
    color.g = 127
    color.b = 127
  elseif str == "green" then
    color.r = 0
    color.g = 255
    color.b = 0
  elseif str == "orange" then
    color.r = 255
    color.g = 127
    color.b = 0
  elseif str == "pink" then
    color.r = 255
    color.g = 127
    color.b = 127
  elseif str == "purple" then
    color.r = 127
    color.g = 0
    color.b = 255
  elseif str == "rainbow" then
  elseif str == "red" then
    color.r = 255
    color.g = 0
    color.b = 0
  elseif str == "white" then
    color.r = 0
    color.g = 0
    color.b = 0
  elseif str == "yellow" then
    color.r = 255
    color.g = 255
    color.b = 0
  elseif str == "zebra" then
  end
  
  return color
end

function Game:getColors()
  local colors = {
    "black",
    "blue",
    "brown",
    "gray",
    "green",
    "orange", 
    "pink",
    "purple",
    --"rainbow",
    "red",
    "white",
    "yellow", 
    --"zebra" 
  }
  
  return colors
end

