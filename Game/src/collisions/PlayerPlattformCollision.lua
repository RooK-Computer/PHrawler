PlayerPlattformCollision = {

  collisionClassA = 'Plattform',
  collisionClassB = {'Player', 'PlayerDrop', 'PlayerDropped'},

  beginContact = function(plattform, player, contact)
    
    if player.collisionClass == 'PlayerDropped' then return end
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
    
    if player.collisionClass == 'PlayerDropped' then 
      player.collisionClass = 'Player'
    end

    -- player dropped from plattform
    if player.collisionClass == 'PlayerDrop' then 
      player.collisionClass = 'PlayerDropped'
    end
    


  end,

  preSolve = function(plattform, player, contact)

    -- player wants to drop from plattform
    if player.collisionClass == 'PlayerDrop' then 
      player.isOnGround = false 
      contact:setEnabled(false)
      return
    end

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

    local check = false

    for _, collisionClass in ipairs(PlayerPlattformCollision.collisionClassB) do
      if class == collisionClass then check = true end
    end

    return check
  end,

}