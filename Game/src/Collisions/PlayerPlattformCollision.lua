PlayerPlattformCollision = {

  beginContact = function(plattform, player, contact)
    player.isOnGround = true 

    local plattformX = plattform.body:getX()
    local plattformY = plattform.body:getY()

    local playerX = player.physics.body:getX()
    local playerY = player.physics.body:getY()

    if playerY + player.height/8> plattformY - 5 then
      contact:setEnabled(false)
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

    if playerY + player.height/8> plattformY - 5 then
      contact:setEnabled(false)
      player.isOnGround = false 

    end


  end, 

  postSolve = function(plattform, player, contact, normalimpulse, tangentimpulse)
  end,

}