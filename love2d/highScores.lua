highScores = {} -- package name

function highScores:new(obj)
  obj = obj or {}   -- create object if user does not provide one
  setmetatable(obj, self)
  self.__index = self

  -- 1=right, 2=down, 3=left, 4=up
  obj.scores = {}
  obj.size = 0
  obj.filename = ""

  return obj
end

function highScores:load(filename,size)
  self.size = size
  self.filename = filename
  local fileExists = love.filesystem.exists(filename)
  local file=love.filesystem.newFile(filename)
  if not fileExists then
    print ("creating high score file...")
    self:clearScores()
    self:save()
    return
  end
  file:open("r")
  for line in file:lines() do
    local commaLoc = line:find(",")
    local name = line:sub(1,commaLoc-1)
    local score = tonumber(line:sub(commaLoc+1))
    self:addScore(name,score)
  end
  file:close()
end

function highScores:addScore(name,score)
  local scoreObj = {}
  scoreObj.name = name
  scoreObj.score = score
  name:gsub(","," ")
  local insertIndex = nil
  for i,existingScore in ipairs(self.scores) do
    if score > existingScore.score then
      insertIndex = i
      break
    end
  end
  if insertIndex == nil then
    table.insert(self.scores,scoreObj)
  else
    table.insert(self.scores,insertIndex,scoreObj)
  end
end

function highScores:clearScores()
  self.scores = {}
  for i=1,self.size do
    local scoreObj = {}
    scoreObj.name = "empty"
    scoreObj.score = 0
    table.insert(self.scores,scoreObj)
  end
end

function highScores:isHighScore(score)
  local isHighScore = false
  local lowestScore = self.scores[self.size]
  if score > lowestScore.score then
    isHighScore = true
  end
  return isHighScore
end

function highScores:save()
  -- only saves the number of scores specified in size attribute
  local file=love.filesystem.newFile(self.filename)
  file:open("w")
  for i=1,self.size do
    local score = self.scores[i]
    file:write(score.name..","..score.score.."\r\n")
  end
  file:close()
end