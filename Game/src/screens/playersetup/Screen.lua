require 'src/screens/playersetup/View'
require 'src/screens/playersetup/GridLayoutView'
require 'src/screens/playersetup/PlayerSlotView'
require 'src/screens/playersetup/PlayerSetupInputHandler'
require 'src/screens/playersetup/PlayerSetupPlayerInputHandler'

PlayerSetupScreen = Screen:extend()

function PlayerSetupScreen:new(session)
    self.session = session
    self.models={}
    self.availablePlayerSlots={}
    self.activePlayerSlots={}
    self.view = GridLayoutView()
    self.view:setX(0)
    self.view:setY(100)
    self.view:setWidth(game.windowWidth)
    self.view:setHeight(game.windowHeight-100)
    self.inputHandler = PlayerSetupInputHandler(self)
end

function PlayerSetupScreen:load()
    self.font = love.graphics.newFont( Constants.GRAPHIC.FONTS.MENUFONT )
    self.font:setFilter("nearest")

    for i=1,self.session:getPlayerNumber() do
        local view = PlayerSlotView()
        view.name = 'Player '..i
        table.insert(self.availablePlayerSlots,view)
        self.view:addSubview(view)
    end
    for i=1,24 do 
        table.insert(self.models,"player_"..i)
    end
end

function PlayerSetupScreen:enter()
    game.inputManager.HandlerStack:push(self.inputHandler)
end

function PlayerSetupScreen:exit()
    game.inputManager.HandlerStack:popUpTo(self.inputHandler,true)
    love.audio.stop()
end

function PlayerSetupScreen:findNextModel(current)
    if #self.activePlayerSlots == 0 then
        return current
    end
    local modelsToSearch = tableExt.copy(self.models)
    for k,v in ipairs(self.activePlayerSlots) do
        if v.player ~= current then
            local pos = tableExt.find(modelsToSearch,v.player)
            table.remove(modelsToSearch,pos)
        end
    end
    local pos = tableExt.find(modelsToSearch,current)
    if pos == nil then
        print(current)
        print('===')
        for k,v in pairs(modelsToSearch) do
            print(k..':'..v)
        end
    end
    pos = pos + 1
    if pos > #modelsToSearch then
        pos = 1
    end
    return modelsToSearch[pos]
end

function PlayerSetupScreen:findPreviousModel(current)
    if #self.activePlayerSlots == 0 then
        return current
    end
    local modelsToSearch = tableExt.copy(self.models)
    for k,v in ipairs(self.activePlayerSlots) do
        if v.player ~= current then
            local pos = tableExt.find(modelsToSearch,v.player)
            table.remove(modelsToSearch,pos)
        end
    end
    local pos = tableExt.find(modelsToSearch,current)
    pos = pos - 1
    if pos < 1 then
        pos = #modelsToSearch
    end
    return modelsToSearch[pos]
end

function PlayerSetupScreen:registerNewPlayer(gamepad)
    if #self.availablePlayerSlots > 0 then
        local slot = self.availablePlayerSlots[1]
        slot.gamepad=gamepad
        slot.player = self:findNextModel("player_1")
        table.insert(self.activePlayerSlots,slot)
        table.remove(self.availablePlayerSlots,1)
        local handler = PlayerSetupPlayerInputHandler(gamepad,slot,self)
        game.inputManager.HandlerStack:push(handler)
    end
end

function PlayerSetupScreen:goBack()
    game.switchScreen(StartScreen())
end

function PlayerSetupScreen:readyCheck()
    local allReady=#self.availablePlayerSlots == 0
    for k,v in ipairs(self.activePlayerSlots) do
        if v.ready == false then
            allReady = false
        end
    end
    if allReady then
        local config = PlayersConfig.get(self.session.setup.numberOfPlayers)
        for i,v in ipairs(self.activePlayerSlots) do
            config[i].name = 'Player '..i
            config[i].id = v.player
            config[i].registeredGamepad = v.gamepad
        end
        self.session.setup.players = config
        game.switchScreen(LevelScreen(self.session))
    end
end

function PlayerSetupScreen:update(dt)
    for i,v in ipairs(self.activePlayerSlots) do
        if v.wantsNextModel then
            v.player = self:findNextModel(v.player)
            v.wantsNextModel = false
        end
        if v.wantsPreviousModel then
            v.player = self:findPreviousModel(v.player)
            v.wantsPreviousModel = false
        end
    end
    self.view:update(dt)
end

function PlayerSetupScreen:draw()
  love.graphics.clear( Colors.getYellowRGBA())
  local width = self.font:getWidth("Choose your looks!")
  love.graphics.print({Colors.getPurpleRGBA(),"Choose your looks!"},self.font,game.windowWidth/2-width/2,100/2 - self.font:getHeight()/2)
  self.view:viewdraw()
end