FightState = State:extend()

function FightState:new(player)
  FightState.super.new(self, player)
  
  self.name = Constants.FIGHT_STATE

  return self
end

function FightState:enterState()
  
  local player = self.player
  
  player.anim = player.animations[Constants.FIGHT_STATE][player.animationDirection]

  if player.physics.fightFixture ~= nil and not player.physics.fightFixture:isDestroyed() then return self end

  local offsetX = player.width/5

  if player.animationDirection == Constants.PLAYER_DIRECTION_LEFT then offsetX = -player.width/5 end

  local shape = love.physics.newRectangleShape(offsetX, 0, 15, player.height/3)
  local fixture = love.physics.newFixture(player.physics.body, shape)
  fixture:setUserData({player = player, collisionClass = 'FightOtherPlayer'})  
  fixture:setSensor(true)

  player.physics.fightFixture = fixture

  return self.name

end

function FightState:input(command)
  FightState.super.input(self, command)
  local player = self.player

  if command == Constants.PLAYER_FIST_HIT_TARGET_COMMAND then return Constants.FIST_HIT_TARGET_STATE end

end


function FightState:update(dt)
  local player = self.player
  
  player.anim = player.animations[Constants.FIGHT_STATE][player.animationDirection]

end


function FightState:inputEnd(command)
  local player = self.player
  
  player.anim = player.animations[Constants.IDLE_STATE][player.animationDirection]
  if not player.physics.fightFixture:isDestroyed() then player.physics.fightFixture:destroy() end
  
  if command == Constants.PLAYER_FIST_HIT_TARGET_COMMAND then return Constants.FIST_HIT_TARGET_STATE end

  return Constants.IDLE_STATE

end