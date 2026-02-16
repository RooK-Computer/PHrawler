PlayerFightsCollision = {

  collisionClassA = 'Player',
  collisionClassB = 'FightOtherPlayer',

  beginContact = function(enemy, collision, contact)

    local player = collision.player
    enemy:inputStart(Constants.PLAYER_DAMAGE_COMMAND)


    local enemyImpulseX, enemyImpulseY = 75, -100
    if player.animationDirection == Constants.PLAYER_DIRECTION_LEFT then 
      enemyImpulseX = -enemyImpulseX
    end

    enemy.physics.body:applyLinearImpulse( enemyImpulseX, enemyImpulseY )

    player:inputEnd(Constants.PLAYER_FIGHT_COMMAND)
    player:inputStart(Constants.FIST_HIT_TARGET_STATE)

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