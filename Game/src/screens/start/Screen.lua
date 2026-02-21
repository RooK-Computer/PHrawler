StartScreen = Screen:extend()
require 'src/screens/start/InputHandler'

function StartScreen:new(session)
  self.name = 'StartScreen'
  self.session = session
  
  self.audio = {}


  local allLevels = {}
  for i,levelID in ipairs(game.levels) do
    local level = Level(game.world, levelID)
    table.insert(allLevels, {id = levelID, label = level:getName()})
  end

  local supportedPlayerNumbers = {}
  
  for number=game.minSupportedPlayerNumber,game.maxSupportedPlayerNumber do 
    table.insert(supportedPlayerNumbers, {id = number, label = number})
  end

  self.menuItems = {
    { 
      name = 'start', 
      label = 'Start Game', 
      isActive = true,
      changeOption = function() end,
      selectOption = function() 
        game.switchScreen(PlayerSetupScreen(self.session))
      end
    },
    { 
      name ='players', 
      label = 'Players... ', 
      isActive = false, 
      options = supportedPlayerNumbers, 
      selectedOption = self.session:getPlayerNumber() - 1,
      changeOption = function(menuItem, direction)

        local newOptionIndex = StartScreen.changeOption(menuItem, direction) 
        local selectedPlayerNumber = menuItem.options[newOptionIndex]
                
        game.screen().session:setPlayerNumber(selectedPlayerNumber.id)
        game.screen():changeSelectedPlayerCharacters()

      end,
      selectOption = function() end
    },
    { 
      name = 'levels', 
      label = 'Level... ', 
      isActive = false, 
      options = allLevels, 
      selectedOption = 1,--TODO: we have to lookup the right index based on the currently selected level
      changeOption = function(menuItem, direction)

        local newOptionIndex = StartScreen.changeOption(menuItem, direction) 
        local selectedLevel = menuItem.options[newOptionIndex]
        game.screen().session:setSelectedLevel(selectedLevel.id)

      end,
      selectOption = function() end
    }
  }

  self.inputHandler = StartScreenInputHandler(self)
  self.activeItemIndex = self.menuItems[1]

  self.gameConfig = {
    level = game.selectedLevel

  }

  self:changeSelectedPlayerCharacters()

  return self
end


function StartScreen:load()

  self.font = love.graphics.newFont( Constants.GRAPHIC.FONTS.MENUFONT )
  self.font:setFilter("nearest")
  love.graphics.setFont(self.font)

  self.activeIndicator = love.graphics.newImage(Constants.GRAPHIC.INDICATOR.RIGHT)
  self.activeIndicator:setFilter("nearest")
  self.changeLeftIndicator = love.graphics.newImage(Constants.GRAPHIC.INDICATOR.LEFT)
  self.changeLeftIndicator:setFilter("nearest")
  self.changeRightIndicator = love.graphics.newImage(Constants.GRAPHIC.INDICATOR.RIGHT)
  self.changeRightIndicator:setFilter("nearest")
  
  self.audio.mainTheme = love.audio.newSource( Constants.AUDIO.TRACK_PATH .. 'Happy8bit.mp3', 'stream' )
  self.audio.mainTheme:setLooping(true)
  
  love.audio.setVolume( 0.25 )

end


function StartScreen:update(dt)

  for i,selectedPlayer in ipairs(self.selectedPlayerCharacters) do 

    selectedPlayer.anim:update(dt)

  end
end

function StartScreen.changeOption(menuItem, direction)

  local optionIndex = menuItem.selectedOption
  local newOptionIndex = optionIndex + 1
  if newOptionIndex > #menuItem.options then newOptionIndex = 1 end

  if direction=='left' then 
    newOptionIndex = optionIndex - 1 
    if newOptionIndex < 1 then newOptionIndex = #menuItem.options end
  end
  menuItem.selectedOption = newOptionIndex

  return newOptionIndex
end


function StartScreen:changeSelectedPlayerCharacters()
  local selectedPlayerNumber = self.session.setup.numberOfPlayers

  self.selectedPlayerCharacters = {}

  for i=1,selectedPlayerNumber do 
    local spritesheet = love.graphics.newImage('assets/players/player_' .. i .. '.png')
    local grid = anim8.newGrid( 64, 64, spritesheet:getWidth(), spritesheet:getHeight() )

    local anim = anim8.newAnimation( grid('1-8',1), 0.05)


    local selectedPlayerCharacter = {
      spritesheet = spritesheet,
      anim = anim
    }

    table.insert(self.selectedPlayerCharacters, selectedPlayerCharacter)

  end
end


function StartScreen:draw()
  love.graphics.clear(Colors.getYellowRGBA())

  local name = 'PHrawler'

  love.graphics.print({Colors.getPurpleRGBA(), name}, 
    100, 
    100,
    0,
    2
  )  

  local versionText = 'Version  ' .. tostring(game.version)


  love.graphics.print({Colors.getPurpleRGBA(), versionText}, 
    25, 
    game.windowHeight - 25 - self.font:getHeight(versionText),
    0,
    0.5
  )  


  local scale = 1
  local padding = 50
  local lineHeight = 0



  for i, menuItem in ipairs(self.menuItems) do

    local label = menuItem.label
    local x = game.windowWidth - padding - self.font:getWidth(label)*scale
    local y = game.windowHeight/2 + lineHeight - self.font:getHeight(label)*scale


    local selectedOption = ''
-- calculate width of string
    if (menuItem.options ~= nil) then

      selectedOption = menuItem.options[menuItem.selectedOption].label

      -- add padding for selected option
      x = x - self.font:getWidth(selectedOption)*scale - 20      

      -- add padding for change arrows
      x = x - self.changeLeftIndicator:getWidth() - self.changeRightIndicator:getWidth() - 30

    end

    local arrowOffsetX = 25
    local arrowOffsetY = 1

    -- Active Indicator
    if (menuItem.isActive) then
      love.graphics.draw(self.activeIndicator, x , y, 0, 1.5, 1.5, arrowOffsetX, arrowOffsetY)
      self.activeItemIndex = i
    end

    --Menu item label
    love.graphics.print({Colors.getPurpleRGBA(),label}, 
      x, 
      y,
      0,
      scale
    )  
    
    arrowOffsetX = 0
    arrowOffsetY = -1


    -- Arrow change to left
    if (menuItem.options ~= nil) then
      x = x + self.font:getWidth(label)*scale + 20
      love.graphics.draw(self.changeLeftIndicator, x, y, 0, scale, scale, arrowOffsetX, arrowOffsetY)
    end

    -- Selected Option

    if (menuItem.selectedOption ~= nil) then
      x = x + 30
      love.graphics.print({Colors.getPurpleRGBA(),selectedOption}, 
        x, 
        y,
        0,
        scale
      )  
    end

    -- Arrow change to right
    if (menuItem.options ~= nil) then
      x = x + self.font:getWidth(selectedOption)*scale + 20
      love.graphics.draw(self.changeRightIndicator, x, y, 0, scale, scale, arrowOffsetX, arrowOffsetY)

    end

    if (menuItem.name == 'players') then 
      local playerX = 50
      for i,selectedPlayer in ipairs(self.selectedPlayerCharacters) do 

        selectedPlayer.anim:draw(selectedPlayer.spritesheet, playerX, y, nil, scale, scale, 32, 32)

        playerX = playerX + 32

      end
    end

    lineHeight = lineHeight + 50

  end


end

function StartScreen:enter()
  game.inputManager.HandlerStack:push(self.inputHandler)
  self.audio.mainTheme:play()
end

function StartScreen:exit()
  game.inputManager.HandlerStack:pop()
end
