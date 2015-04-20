
require "menus"
require "highScores"
require "game"

-- global constants
SNIPES_VERSION = "0.5"
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

LINES_HEIGHT = 50
MARGIN_TOP = 100

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
local isKeyRightDown = false
local isKeyLeftDown = false
local isKeyUpDown = false
local isKeyDownDown = false

local colors = {}


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
  end
end

function keyPressedLevelComplete(k)
  if k == " " or k == "return" then
    startLevel()
  end
end

function keyPressedGameOver(k)
  if k == " " or k == "return" then
    if highScoreName:len() > 0 and scores:isHighScore(stats.score) then
      scores:addScore(highScoreName,stats.score)
    end
    gameState = GAME_STATE_MENU
  elseif k:len() == 1 and 
    ((k >= "a" and k <= "z") or (k >= "0" and k <= "9")) then
    if (highScoreName:len() < 10) then
      highScoreName = highScoreName..k
    end
  elseif k == "backspace" or k == "delete" then
    local len = highScoreName:len()
    if (len > 0) then
      highScoreName = highScoreName:sub(1,len-1)
    end
  end
end



function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.keypressed(key)
    Game:onkeypressed(key)
end