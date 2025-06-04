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

    enemy.physics.body:applyLinearImpulse( enemyImpulseX, enemyImpulseY )

    enemy:inputStart(Constants.PLAYER_DAMAGE_COMMAND)
    player:inputEnd(Constants.PLAYER_FIGHT_COMMAND)
    player:inputStart(Constants.PLAYER_HIT_COMMAND)

  end,

  endContact = function(enemy, player, contact)
  end,

  preSolve = function(enemy, player, contact)
  end, 

  postSolve = function(enemy, player, contact, normalimpulse, tangentimpulse)
  end,

  checkCollisionClassA = function(class) 
    return class == PlayerFightsCollision.collisionClassA
  end,  
  
  checkCollisionClassB = function(class) 
    return class == PlayerFightsCollision.collisionClassB
  end,

}