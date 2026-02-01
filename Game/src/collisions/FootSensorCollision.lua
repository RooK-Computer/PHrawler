FootSensorCollision = {

  beginContact = function(object1, object2, contact)
    
    if object1.isFootSensor then
      object1.player.isOnGround = true
      
      if object2.collisionClass == 'WorldLimit' and object2.object.properties.isWorldGround then
        object1.player.canNotDrop = true
      end
    end
    
  end,

  endContact = function(object1, object2, contact)    
   if object1.collisionClass == 'Player' then
        object1.canNotDrop = false
    end
  end, 

  preSolve = function(object1, object2, contact)
  end,

  postSolve = function(object1, object2, contact, normalimpulse, tangentimpulse)
  end,

  checkCollisionClassA = function(class) 
    return true
  end,  

  checkCollisionClassB = function(class) 
    return true
  end,

}