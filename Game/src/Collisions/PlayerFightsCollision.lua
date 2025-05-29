PlayerFightsCollision = {

  collisionClassA = 'Player',
  collisionClassB = 'FightOtherPlayer',

  beginContact = function(enemy, collision, contact)

    local player = collision.player

    local enemyImpulseX, enemyImpulseY = 100, -100
    if player.animationDirection == 'left' then 
      enemyImpulseX = -enemyImpulseX
    end

    local playerImpulseX, playerImpulseY = -enemyImpulseX, enemyImpulseY
    player.physics.body:applyLinearImpulse( playerImpulseX, playerImpulseY )

    enemy.health = enemy.health - 1 
    enemy.physics.body:applyLinearImpulse( enemyImpulseX, enemyImpulseY )
    enemy:inputStart(Constants.PLAYER_HIT_COMMAND)

  end,

  endContact = function(enemy, player, contact)
  end,

  preSolve = function(enemy, player, contact)
  end, 

  postSolve = function(enemy, player, contact, normalimpulse, tangentimpulse)
  end,

}