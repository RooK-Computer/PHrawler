require 'src/collisions/PlayerPlattformCollision'
require 'src/collisions/PlayerFightsCollision'

local Collissions = {
  PlayerPlattformCollision,
  PlayerFightsCollision,
}

function beginContact(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject == nil or bObject == nil then return end

  for i,collision in ipairs(Collissions) do
    if aObject.collisionClass == collision.collisionClassB and bObject.collisionClass == collision.collisionClassA then 
      aObject = b:getUserData()
      bObject = a:getUserData()
    end 

    if aObject.collisionClass == collision.collisionClassA and bObject.collisionClass == collision.collisionClassB then 
      collision.beginContact(aObject, bObject, contact) 
    end  
  end

end


function endContact(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject == nil or bObject == nil then return end


  for i,collision in ipairs(Collissions) do
    if aObject.collisionClass == collision.collisionClassB and bObject.collisionClass == collision.collisionClassA then 
      aObject = b:getUserData()
      bObject = a:getUserData()
    end 

    if aObject.collisionClass == collision.collisionClassA and bObject.collisionClass == collision.collisionClassB then collision.endContact(aObject, bObject, contact) end  
  end

end

function preSolve(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject == nil or bObject == nil then return end


  for i,collision in ipairs(Collissions) do
    if aObject.collisionClass == collision.collisionClassB and bObject.collisionClass == collision.collisionClassA then 
      aObject = b:getUserData()
      bObject = a:getUserData()
    end 

    if aObject.collisionClass == collision.collisionClassA and bObject.collisionClass == collision.collisionClassB then collision.preSolve(aObject, bObject, contact) end  
  end

end

function postSolve(a, b, contact, normalimpulse, tangentimpulse)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject == nil or bObject == nil then return end


  for i,collision in ipairs(Collissions) do
    if aObject.collisionClass == collision.collisionClassB and bObject.collisionClass == collision.collisionClassA then 
      aObject = b:getUserData()
      bObject = a:getUserData()
    end 

    if aObject.collisionClass == collision.collisionClassA and bObject.collisionClass == collision.collisionClassB then collision.postSolve(aObject, bObject, contact, normalimpulse, tangentimpulse) end  
  end

end


CollisionTemplate = {

  beginContact = function(a, b, contact)
  end,

  endContact = function(a, b, contact)
  end,

  preSolve = function(a, b, contact)
  end,

  postSolve = function(a, b, contact, normalimpulse, tangentimpulse)
  end,

}