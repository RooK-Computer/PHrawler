PlayerFightsCollision = {

  collisionClassA = 'Player',
  collisionClassB = 'FightOtherPlayer',

  beginContact = function(enemy, collision, contact)

    local player = collision.player



    local impulseX, impulseY = 50, -50
    if player.animationDirection == 'left' then 
      impulseX = -impulseX
    end

    enemy.health = enemy.health - 1 
    --enemy.health = 0 
    enemy.physics.body:applyLinearImpulse( impulseX, impulseY )

  end,

  endContact = function(plattform, player, contact)
  end,

  preSolve = function(plattform, player, contact)

    local plattformX = plattform.body:getX()
    local plattformY = plattform.body:getY()

    local playerX = player.physics.body:getX()
    local playerY = player.physics.body:getY()

  end, 

  postSolve = function(plattform, player, contact, normalimpulse, tangentimpulse)
  end,

}