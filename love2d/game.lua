
Game = {
  
}


function Game:load()

  -- Fanaen Code --

  self.textBlinkLength  = 0.5   -- Cursor's blink 
  self.textBlinkTime    = 0     -- Cursor's current time (used for state)
  self.textBlinkState   = true  -- Cursor's current state
  self.textCursorLine   = 1     -- Cursor's line
  self.textCursorMax    = 10    -- Nb line max
  self.textCursorText   = ""    -- Current text
  
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
  
  -- Cursor --
  if self.textBlinkState then
    local x = 10
    local y = MARGIN_TOP + self.textCursorLine * LINES_HEIGHT
    love.graphics.rectangle("fill", x, y, 4, 20)
  end
  
  -- Psyko Code --	

end

function Game:onkeypressed(k)

  -- Fanaen Code --
  

  -- Psyko Code --
	
end