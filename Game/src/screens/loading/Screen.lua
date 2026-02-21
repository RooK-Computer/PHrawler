
LoadingScreen = Screen:extend()

function LoadingScreen:new(session)
    self.session = session
    self.loading = false
    self.loadingDone = false
    self.timer = 3
    self.font = nil
    return self
end

function LoadingScreen:load()
    self.font = love.graphics.newFont( Constants.GRAPHIC.FONTS.MENUFONT,32 )
end

function LoadingScreen:update(dt)
    if self.loading == true and self.loadingDone==true then
        self.timer = self.timer - dt
        if self.timer <= 0 then
            game.switchScreen(LevelScreen(self.session))
        end
    end
end

function LoadingScreen:draw()
  love.graphics.clear( 255/255, 220/255, 0, 1)
  local loadingInitialized = false
  if self.loading == false then
    self.loading = true
    loadingInitialized = true
  end
  if self.loading == true and self.loadingDone==false then
    local width = self.font:getWidth("Loading...")
    love.graphics.print({{144/255, 0, 255/255},"Loading..."},self.font,game.windowWidth/2 - width / 2, game.windowHeight/2 - self.font:getHeight()/2)
  elseif self.loading == true and self.loadingDone==true then
    local text = "Match starts in "..tostring(math.floor(self.timer)+1)
    local width = self.font:getWidth(text)
    love.graphics.print({{144/255, 0, 255/255},text},self.font,game.windowWidth/2 - width / 2, game.windowHeight/2 -self.font:getHeight()/2)
  end
  if loadingInitialized==true then
    self.session.instance.world = love.physics.newWorld(0, game.gravity)
    self.session.instance.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    self.session.instance.level = Level(self.session.instance.world, self.session.setup.selectedLevel)
    self.session.instance.level:setupLevel()

    love.graphics.setDefaultFilter('nearest', 'nearest') -- best for pixel art
    love.graphics.setFont(game.defaultFont)


    local playerNumber = self.session.setup.numberOfPlayers
    local playersConfig = self.session.setup.players

    for i,playerConfig in ipairs(playersConfig) do
        local player =  Player(playerConfig, self.session)
        player:setStartingPoint(self.session.instance.level:getStartingPoint(i))
        player:setup()

        table.insert(self.session.instance.players, player)
        local input = PlayerInput(nil,player,{player.config.registeredGamepad},player.controls.inputs.gamepad)
        table.insert(self.session.instance.playerinputs,input)
    end
    self.session.instance.loaded=true
    self.loadingDone = true
  end
end