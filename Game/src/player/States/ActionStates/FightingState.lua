FightingState = State:extend()

function FightingState:new(player)
  self.player = player
  self.name = Constants.FIGHT_STATE

  self.player.anim = player.animations[Constants.FIGHT_STATE][player.animationDirection]


  local offsetX = player.width/5

  if player.animationDirection == 'left' then offsetX = -player.width/5 end

  local shape = love.physics.newRectangleShape(offsetX, 0, 15, player.height/3)
  local fixture = love.physics.newFixture(player.physics.body, shape)
  fixture:setUserData({player = player, collisionClass = 'FightOtherPlayer'})  
  fixture:setSensor(true)

  self.player.physics.fightFixture = fixture

  return self

end


function FightingState:input(command)

  local player = self.player
  if command == Constants.PLAYER_HIT_COMMAND then return HitState(player) end

end


function FightingState:update(dt)

  local player = self.player
  player.anim = player.animations[Constants.FIGHT_STATE][player.animationDirection]
  
end


function FightingState:inputEnd(command)
  local player = self.player
  player.anim = player.animations[Constants.IDLE_STATE][player.animationDirection]
  player.physics.fightFixture:destroy()

  return ActionIdleState:new(player)

end