PlayerPlattformCollision = {

  collisionClassA = 'Plattform',
  collisionClassB = 'Player',

  beginContact = function(plattform, player, contact)
    player.isOnGround = true 

    local plattformX = plattform.body:getX()
    local plattformY = plattform.body:getY()

    local playerX = player.physics.body:getX()
    local playerY = player.physics.body:getY()

    if playerY + player.height/8 > plattformY - plattform.object.height/2 then
      player.isOnGround = false 
    end

  end,

  endContact = function(plattform, player, contact)
    player.isOnGround = false 
  end,

  preSolve = function(plattform, player, contact)

    local plattformX = plattform.body:getX()
    local plattformY = plattform.body:getY()

    local playerX = player.physics.body:getX()
    local playerY = player.physics.body:getY()

    if playerY + player.height/8 > plattformY - plattform.object.height/2 then
      contact:setEnabled(false)
      player.isOnGround = false 

    end


  end, 

  postSolve = function(plattform, player, contact, normalimpulse, tangentimpulse)
  end,

  checkCollisionClassA = function(class) 
    return class == PlayerPlattformCollision.collisionClassA
  end,  

  checkCollisionClassB = function(class) 
    return class == PlayerPlattformCollision.collisionClassB
  end,

}