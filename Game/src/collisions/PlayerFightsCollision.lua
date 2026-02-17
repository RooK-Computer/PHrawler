PlayerFightsCollision = {

  collisionClassA = 'Player',
  collisionClassB = 'FightOtherPlayer',

  beginContact = function(enemy, collision, contact)

    local player = collision.player
    enemy:inputStart(Constants.PLAYER_DAMAGE_COMMAND)
    
    local x, y = player.physics.body:getLinearVelocity()

    local enemyImpulseX, enemyImpulseY = player.physics.body:getLinearVelocity()
    if enemyImpulseX > 100 then enemyImpulseX = 100 end
    if enemyImpulseX <= 0 then enemyImpulseX = -125 
          if player.animationDirection == Constants.PLAYER_DIRECTION_RIGHT then enemyImpulseX = -enemyImpulseX end
      end

    
    if enemyImpulseY < -150 then enemyImpulseY = -150 end
    if enemyImpulseY > -100 then enemyImpulseY = -100 end


    enemy.physics.body:applyLinearImpulse( enemyImpulseX, enemyImpulseY )

    player:inputEnd(Constants.PLAYER_FIST_HIT_TARGET_COMMAND)

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