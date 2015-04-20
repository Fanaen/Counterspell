
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

-- local to main.lua
local isKeyRightDown = false
local isKeyLeftDown = false
local isKeyUpDown = false
local isKeyDownDown = false

require "game"

function love.load()
    Game:load()
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end