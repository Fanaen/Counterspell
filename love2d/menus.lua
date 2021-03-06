menus = {} -- package name

local SETTINGS_MENU_SOUND = 1
local SETTINGS_MENU_SWAP = 2
local background = love.graphics.newImage("images/background.png")

--**********************************************************
--*  key input logic
--**********************************************************
function menus.keyPressedMenu(k)
  if gameMenu == GAME_MENU_MAIN then
    -- main menu input
    if k == "escape" then
      love.event.push("quit") -- quit the game
    elseif k == "up" then
      if mainMenuSelection == MAIN_MENU_START then
        mainMenuSelection = MAIN_MENU_EXIT
      else
        mainMenuSelection = mainMenuSelection - 1
      end
    elseif k == "down" then
      if mainMenuSelection == MAIN_MENU_EXIT then
        mainMenuSelection = MAIN_MENU_START
      else
        mainMenuSelection = mainMenuSelection + 1
      end
    elseif k == " " or k == "return" then
      if (mainMenuSelection == MAIN_MENU_START) then
        startGame()
      elseif (mainMenuSelection == MAIN_MENU_HOW_TO_PLAY) then
        gameMenu = GAME_MENU_HOW_TO_PLAY
      elseif (mainMenuSelection == MAIN_MENU_SETTINGS) then
        menus.settingsMenuSelection = SETTINGS_MENU_SOUND
        gameMenu = GAME_MENU_SETTINGS
      elseif (mainMenuSelection == MAIN_MENU_HIGH_SCORES) then
        gameMenu = GAME_MENU_HIGH_SCORES
      elseif (mainMenuSelection == MAIN_MENU_ABOUT) then
        gameMenu = GAME_MENU_ABOUT
      elseif (mainMenuSelection == MAIN_MENU_EXIT) then
        love.event.push("quit") -- quit the game
      end
    end
  elseif gameMenu == GAME_MENU_SETTINGS then
    if k == "up" then
      if menus.settingsMenuSelection == SETTINGS_MENU_SOUND then
        menus.settingsMenuSelection = SETTINGS_MENU_SWAP
      else
        menus.settingsMenuSelection = menus.settingsMenuSelection - 1
      end
    elseif k == "down" then
      if menus.settingsMenuSelection == SETTINGS_MENU_SWAP then
        menus.settingsMenuSelection = SETTINGS_MENU_SOUND
      else
        menus.settingsMenuSelection = menus.settingsMenuSelection + 1
      end
    elseif k == "right" then
      if menus.settingsMenuSelection == SETTINGS_MENU_SOUND then
        love.audio.setVolume(1.0)
      elseif menus.settingsMenuSelection == SETTINGS_MENU_SWAP then
        -- util.setKeys(KEY_MODE_LEFT_HANDED)
      end
    elseif k == "left" then
      if menus.settingsMenuSelection == SETTINGS_MENU_SOUND then
        love.audio.setVolume(0.0)
      elseif menus.settingsMenuSelection == SETTINGS_MENU_SWAP then
        -- util.setKeys(KEY_MODE_RIGHT_HANDED)
      end
    elseif k == "escape" or k == " " or k == "return" then
      -- return to main menu
      gameMenu = GAME_MENU_MAIN
    end
  elseif gameMenu == GAME_MENU_HIGH_SCORES then
    -- clear scores
    if k == "delete" then
      scores:clearScores()      
    end
    -- return to main menu
    if k == "escape" or k == " " or k == "return" then
      gameMenu = GAME_MENU_MAIN
    end
  elseif gameMenu == GAME_MENU_HOW_TO_PLAY or gameMenu == GAME_MENU_ABOUT then
    -- return to main menu
    if k == "escape" or k == " " or k == "return" then
      gameMenu = GAME_MENU_MAIN
    end
  end
end

--**********************************************************
--*  draw
--**********************************************************
function menus.draw()
  if gameMenu == GAME_MENU_MAIN then
    menus._drawMenuMain()
  elseif gameMenu == GAME_MENU_HOW_TO_PLAY then
    menus._drawMenuHowToPlay()
  elseif gameMenu == GAME_MENU_SETTINGS then
    menus._drawSettings()
  elseif gameMenu == GAME_MENU_HIGH_SCORES then
    menus._drawMenuHighScores()
  elseif gameMenu == GAME_MENU_ABOUT then
    menus._drawMenuAbout()
  end
end

function menus._drawMenuHowToPlay()

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(background, 0, 0)
  love.graphics.setFont(menuFont)
  
  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.printf("How To Play", 0,20,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.setFont(mainFont)
  local txt = "CounterSpell is a fun new game for the Lundum Dare Jam #32 "
  txt = txt.."created by The Fried Chikens. The object of the game is to kill your "
  txt = txt.."enemies by spelling words to destroy the rats that are running on you "
  txt = txt.."Your Speller can move using the Up/Down Arrows and spell by typing"
  txt = txt.."on your keyboard and by validate your spells using the "
  txt = txt.."Enter and BackSpace keys. If you type special words, you'll see something incredible !"
  love.graphics.printf(txt, 100,100,SCREEN_WIDTH - 100,"left") -- text,x,y,wrap limit,align

  love.graphics.setColor(80, 80, 80, 180)
  love.graphics.rectangle("fill",100,220,650,160) -- mode, x, y, width, height
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.line(100, 220,750,220) -- x1, y1, x2, y2, ...
  love.graphics.line(100, 380,750,380) -- x1, y1, x2, y2, ...

  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.setFont(menuFont)
  love.graphics.print("Controls:", 100,200)
  love.graphics.setFont(mainFont)
  love.graphics.print("Up/Down Arrows", 100,240)
  love.graphics.print("- move your Speller", 250,240)
--  love.graphics.print("A", 50,220)
--  love.graphics.print("- shoot left", 200,220)
--  love.graphics.print("D", 50,240)
--  love.graphics.print("- shoot right", 200,240)
--  love.graphics.print("W", 50,260)
--  love.graphics.print("- shoot up", 200,260)
--  love.graphics.print("S", 50,280)
--  love.graphics.print("- shoot down", 200,280)
--  love.graphics.print("(combine to shoot diagonally)", 200,300)
  love.graphics.print("[Esc]", 100,340)
  love.graphics.print("- pause / quit game", 250,340)

--  love.graphics.setFont(menuFont)
--  love.graphics.print("Game Objects:", 50,370)
--  love.graphics.setFont(mainFont)
--
--  love.graphics.setColor(80, 80, 80, 230)
--  love.graphics.rectangle("fill",40,395,720,95) -- mode, x, y, width, height
--  love.graphics.setColor(255, 255, 255)
--  love.graphics.line(40, 395,760,395) -- x1, y1, x2, y2, ...
--  love.graphics.line(40, 490,760,490) -- x1, y1, x2, y2, ...
--
--  love.graphics.draw(snipeImage,50,400)
--  love.graphics.print("- snipe", 80,402)
--  love.graphics.draw(snipeArmoredImage,50,430)
--  love.graphics.print("- armored snipe", 80,432)
--  love.graphics.rectangle("line",50,460,SNIPE_SIZE,SNIPE_SIZE, 0) -- mode, x, y, width, height
--  love.graphics.print("- snipe hive", 80,462)
--
--  love.graphics.draw(powerupPowerBallImage, 400,400)
--  love.graphics.print("- power ball (destroys walls)", 430,402)
--  love.graphics.draw(powerupExtraLifeImage, 400,430)
--  love.graphics.print("- extra life", 430,432)

  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.setFont(smallFont)
  love.graphics.printf("press [Esc] to return to main menu", 0,SCREEN_HEIGHT-50,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
end

function menus._drawSettings()

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(background, 0, 0)
  love.graphics.setFont(menuFont)
  
  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.printf("Settings", 0,20,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.setFont(mainFont)
  
  if menus.settingsMenuSelection == SETTINGS_MENU_SOUND then
    menus._drawSettingsSelectionBox(90)
  end
  love.graphics.print("sound effects",55,100)
--  if love.audio.getVolume() > 0 then
--    love.graphics.draw(toggleOnImage, 300,95)
--  else
--    love.graphics.draw(toggleOffImage, 300,95)
--  end

  if menus.settingsMenuSelection == SETTINGS_MENU_SWAP then
    menus._drawSettingsSelectionBox(130)
  end
  love.graphics.print("swap movement/shoot keys",55,140)
--  if keyMoveUp == "up" then
--    love.graphics.draw(toggleOffImage, 300,135)
--  else
--    love.graphics.draw(toggleOnImage, 300,135)
--  end

  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(smallFont)
  love.graphics.printf("Use the [up] and [down] keys to navigate settings", 0,SCREEN_HEIGHT-90,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.printf("Use the [right] and [left] keys to toggle settings", 0,SCREEN_HEIGHT-70,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.printf("press [Esc] to return to main menu", 0,SCREEN_HEIGHT-50,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
end

function menus._drawSettingsSelectionBox(y)
  local selX = 50
  local selY = y
  local w = 350
  local h = 40
  love.graphics.setColor(80, 80, 80, 180)
  love.graphics.rectangle("fill",selX,selY,w,h) -- mode, x, y, width, height
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.line(selX, selY,selX,selY + h) -- x1, y1, x2, y2, ...
  love.graphics.line(selX + w,selY,selX + w,selY + h) -- x1, y1, x2, y2, ...
  
  love.graphics.setColor(0, 0, 0)
end

function menus._drawMenuHighScores()

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(background, 0, 0)
  love.graphics.setFont(menuFont)
  
  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.printf("High Scores", 0,20,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.setFont(mainFont)
  
  love.graphics.print("Name", 255,60) 
  love.graphics.print("Score", 400,60)

  love.graphics.setColor(80, 80, 80, 180)
  love.graphics.rectangle("fill",200, 85, 350, 410) -- mode, x, y, width, height
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.line(200, 85, 600, 85) -- x1, y1, x2, y2, ...
  love.graphics.line(200, 495, 600, 495) -- x1, y1, x2, y2, ...

  love.graphics.setColor(0, 0, 0, 255)
  for i=1,scores.size do
    local score = scores.scores[i]
    love.graphics.print(score.name,255,70+(i*20))
    love.graphics.print(score.score,400,70+(i*20))
  end

  love.graphics.setFont(smallFont)
  love.graphics.printf("press [Delete] to clear all scores", 0,SCREEN_HEIGHT-70,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.printf("press [Esc] to return to main menu", 0,SCREEN_HEIGHT-50,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
end

function menus._drawMenuAbout()

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(background, 0, 0)
  love.graphics.setFont(menuFont)
  
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf("About CounterSpell", 80,60,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  love.graphics.setFont(mainFont)

  love.graphics.print("CounterSpell vs. "..CS_VERSION, 100,200)
  love.graphics.print("Developed in 2015 by The Fried Chikens", 100,220)

  love.graphics.print("CounterSpell was developed using LOVE, the free 2D game engine.", 100,280)
  love.graphics.print("Visit love2d.org for more information.", 100,300)

  love.graphics.setFont(smallFont)
  love.graphics.printf("press [Esc] to return to main menu", 0,SCREEN_HEIGHT-50,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
end

function menus._drawMenuMain()
  
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(background, 0, 0)
  
  love.graphics.setFont(love.graphics.newFont("fonts/UbuntuMono-R.ttf", 100))
  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.printf("CounterSpell", 5,115,SCREEN_WIDTH,"center")

  love.graphics.setColor(0, 0, 0, 255) -- color = 0-255
  love.graphics.setFont(menuFont)

  if (mainMenuSelection == MAIN_MENU_START) then
    menus._drawSelectionBox(270)
  end
  
  love.graphics.printf("start", 0,270,SCREEN_WIDTH,"center") -- text,x,y

  if (mainMenuSelection == MAIN_MENU_HOW_TO_PLAY) then
    menus._drawSelectionBox(300)
  end
  love.graphics.printf("how to play",0,300,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align

  if (mainMenuSelection == MAIN_MENU_SETTINGS) then
    menus._drawSelectionBox(330)
  end
  love.graphics.printf("settings",0,330,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align

  if (mainMenuSelection == MAIN_MENU_HIGH_SCORES) then
    menus._drawSelectionBox(360)
  end
  love.graphics.printf("high scores",0,360,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  
  if (mainMenuSelection == MAIN_MENU_ABOUT) then
    menus._drawSelectionBox(390)
  end
  love.graphics.printf("about", 0,390,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align

  if (mainMenuSelection == MAIN_MENU_EXIT) then
    menus._drawSelectionBox(420)
  end
  love.graphics.printf("exit", 0,420,SCREEN_WIDTH,"center") -- text,x,y,wrap limit,align
  
  love.graphics.setFont(smallFont)
  love.graphics.printf("Use the [up] and [down] keys to navigate options and the [Enter] key to select.", 0,480,SCREEN_WIDTH,"center") -- text,x,y

end

local SELECT_HEIGHT = 23  -- screen 800 x 600
local SELECT_WIDTH = 300
function menus._drawSelectionBox(y)
  local selX = (SCREEN_WIDTH / 2) - (SELECT_WIDTH / 2)
  local selY = y
  love.graphics.setColor(80, 80, 80, 230)
  love.graphics.rectangle("fill",selX,selY,SELECT_WIDTH,SELECT_HEIGHT) -- mode, x, y, width, height
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(selX, selY,selX,selY + SELECT_HEIGHT) -- x1, y1, x2, y2, ...
  love.graphics.line(selX + SELECT_WIDTH,selY,selX + SELECT_WIDTH,selY + SELECT_HEIGHT) -- x1, y1, x2, y2, ...
  
  love.graphics.setColor(0, 0, 0)
end