
Game = {
  
}


function Game:load()

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

function Game:enter()
  
  -- Send the text --
  if string.len(self.textCursorText) > 0 then
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