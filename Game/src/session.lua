
GameSession = Object:extend()

function GameSession:new()
     self.setup = {
        numberOfPlayers = 2,
        selectedLevel = Constants.LEVEL_1,
        players = {}
     }
     self.instance = {
        loaded = false,
        world = nil,
        level = nil,
        players = {},
        playerinputs = {}
     }
end

function GameSession:getPlayerNumber()
    return self.setup.numberOfPlayers
end

function GameSession:setPlayerNumber(number)
    self.setup.numberOfPlayers = number
end

function GameSession:getSelectedLevel()
    return self.setup.selectedLevel
end

function GameSession:setSelectedLevel(level)
    self.setup.selectedLevel = level
end