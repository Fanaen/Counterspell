
require "menus"
require "highScores"
require "game"

-- global constants
CS_VERSION = "0.5"
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

LINES_HEIGHT = 40
MARGIN_TOP = 85

MSG_DURATION = 3 -- seconds
LINE_MAX_NUMBER = 10

-- state in menu system
GAME_MENU_MAIN = 1
GAME_MENU_HOW_TO_PLAY = 2
GAME_MENU_SETTINGS = 3
GAME_MENU_HIGH_SCORES = 4
GAME_MENU_ABOUT = 5

-- state of the main menu selection
MAIN_MENU_START = 1
MAIN_MENU_HOW_TO_PLAY = 2
MAIN_MENU_SETTINGS = 3
MAIN_MENU_HIGH_SCORES = 4
MAIN_MENU_ABOUT = 5
MAIN_MENU_EXIT = 6

-- state of the game at the highest level
GAME_STATE_MENU = 1
GAME_STATE_PLAYING = 2
GAME_STATE_ESC = 3
GAME_STATE_LEVEL_COMPLETE = 4
GAME_STATE_GAME_OVER = 5

-- key mappings
keyMoveUp = "up"
keyMoveDown = "down"
keyMoveLeft = "left"
keyMoveRight = "right"

-- global variables
gameMenu = GAME_MENU_MAIN
mainMenuSelection = MAIN_MENU_START
titleFont = love.graphics.newFont(24)
menuFont = love.graphics.newFont(18)
mainFont = love.graphics.newFont(16)
smallFont = love.graphics.newFont(12)
gameState = GAME_STATE_MENU
logoImage = {}
scores = {}
currentScore = 0

-- GOD MOD --
local TEST_COMMANDS_ACTIVATED = false

-- local to main.lua
local ESC_HEIGHT = 200  -- screen 800 x 600
local ESC_WIDTH = 600

local isKeyRightDown = false
local isKeyLeftDown = false
local isKeyUpDown = false
local isKeyDownDown = false


function love.load()

  love.graphics.setFont(mainFont)
  math.randomseed( os.date("%S%M%H") ) -- seed our random number generator
  
  -- load Images --
  
  -- load Sounds --
  
  -- create high score system --
  love.filesystem.setIdentity("counterSpell_data")
  scores = highScores:new()
  scores:load("scores.txt",20)

  Game:load()
    
end

function love.quit()
	scores:save()
end


function love.keypressed(k)     -- **** LOVE CALLBACK ****
  if gameState == GAME_STATE_PLAYING then
    keyPressedPlaying(k)
  elseif gameState == GAME_STATE_MENU then
    menus.keyPressedMenu(k)
  elseif gameState == GAME_STATE_ESC then
    keyPressedEsc(k)
  elseif gameState == GAME_STATE_LEVEL_COMPLETE then
    keyPressedLevelComplete(k)
  elseif gameState == GAME_STATE_GAME_OVER then
    keyPressedGameOver(k)
  end
end

function keyPressedEsc(k)
  if k == "return" then
    gameState = GAME_STATE_MENU
  elseif k == "escape" then
    gameState = GAME_STATE_PLAYING
  end
end

function startGame()
--  stats.newGame()
--  destroyLevel()
--  populateLevel()
  gameState = GAME_STATE_PLAYING
end

function startLevel()
--  stats.newLevel()
--  destroyLevel()
--  populateLevel()
  gameState = GAME_STATE_PLAYING
end

function keyPressedPlaying(k)
  if k == "escape" then
    gameState = GAME_STATE_ESC

  elseif TEST_COMMANDS_ACTIVATED and (k=='f1') then
    -- stats.levelComplete()
  elseif TEST_COMMANDS_ACTIVATED and (k=='f2') then
    gameState = GAME_STATE_GAME_OVER
  else
    Game:onkeypressed(k)
  end
end

function keyPressedLevelComplete(k)
  if k == " " or k == "return" then
    startLevel()
  end
end

function keyPressedGameOver(k)
  if k == " " or k == "return" then
--    if highScoreName:len() > 0 and scores:isHighScore(stats.score) then
--      scores:addScore(highScoreName,stats.score)
--    end
    gameState = GAME_STATE_MENU
--  elseif k:len() == 1 and 
--    ((k >= "a" and k <= "z") or (k >= "0" and k <= "9")) then
--    if (highScoreName:len() < 10) then
--      highScoreName = highScoreName..k
--    end
--  elseif k == "backspace" or k == "delete" then
--    local len = highScoreName:len()
--    if (len > 0) then
--      highScoreName = highScoreName:sub(1,len-1)
--    end
  end
end



function love.update(dt)
if gameState == GAME_STATE_PLAYING then
    -- stats.update(dt)
    Game:update(dt)
  elseif (gameState == GAME_STATE_MENU) then
  elseif (gameState == GAME_STATE_ESC) then
  elseif (gameState == GAME_STATE_LEVEL_COMPLETE) then
  elseif (gameState == GAME_STATE_GAME_OVER) then
  end
    
end

function love.draw()
  if gameState == GAME_STATE_PLAYING then
    Game:draw()
  elseif gameState == GAME_STATE_MENU then
    menus.draw()
  elseif gameState == GAME_STATE_ESC then
    Game:draw()
    drawEsc()
  elseif gameState == GAME_STATE_LEVEL_COMPLETE then
    Game:draw()
    drawLevelComplete()
  elseif gameState == GAME_STATE_GAME_OVER then
    Game:draw()
    drawGameOver()
  end
    
end

function drawEsc()
  drawPopup()
  love.graphics.setFont(menuFont)
  love.graphics.printf("Game Paused", 0,250,SCREEN_WIDTH,"center")
  love.graphics.setFont(mainFont)
  love.graphics.printf("press [Enter] to quit and return to the main menu", 0,300,SCREEN_WIDTH,"center")
  love.graphics.printf("press [esc] to continue playing", 0,320,SCREEN_WIDTH,"center")
end

function drawLevelComplete()
  drawPopup()
  love.graphics.setFont(menuFont)
  love.graphics.printf("Level "..stats.level.." Complete", 0,250,SCREEN_WIDTH,"center")
  love.graphics.setFont(mainFont)
  love.graphics.printf("Time bonus = "..util.round(stats.time,0), 0,275,SCREEN_WIDTH,"center")
  love.graphics.printf("press [space] to start next level", 0,320,SCREEN_WIDTH,"center")
end

function drawGameOver()
  drawPopup()
  love.graphics.setFont(menuFont)
  love.graphics.printf("GAME OVER", 0,230,SCREEN_WIDTH,"center")

  love.graphics.setFont(mainFont)
  --love.graphics.printf("Score: "..stats.score,0,250,SCREEN_WIDTH,"center")
  --if scores:isHighScore(stats.score) then
  --  love.graphics.printf("Enter name to record score.",0,290,SCREEN_WIDTH,"center")
  --  love.graphics.printf("Name: ["..highScoreName.."]",0,310,SCREEN_WIDTH,"center")
  --end
  love.graphics.printf("press [space] to return to main menu", 0,350,SCREEN_WIDTH,"center")
end

function drawPopup()
  local windowX = (SCREEN_WIDTH / 2) - (ESC_WIDTH / 2)
  local windowY = (SCREEN_HEIGHT / 2) - (ESC_HEIGHT / 2)
  love.graphics.setColor(80, 80, 80, 230)
  love.graphics.rectangle("fill",windowX,windowY,ESC_WIDTH,ESC_HEIGHT) -- mode, x, y, width, height
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(windowX, windowY,windowX + ESC_WIDTH,windowY) -- x1, y1, x2, y2, ...
  love.graphics.line(windowX, windowY + ESC_HEIGHT,windowX + ESC_WIDTH,windowY + ESC_HEIGHT) -- x1, y1, x2, y2, ...
end