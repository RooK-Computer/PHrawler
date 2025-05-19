require 'src/Collisions/PlayerPlattformCollision'


collisionText = ""

function beginContact(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.beginContact(aObject, bObject, contact) end

  local x,y = contact:getNormal()
  collisionText = aObject.collisionClass .." colliding with "..bObject.collisionClass .." with a vector normal of: "..x..", "..y
end


function endContact(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.endContact(aObject, bObject, contact) end

  collisionText = aObject.collisionClass .." uncolliding with ".. bObject.collisionClass
end

function preSolve(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.preSolve(aObject, bObject, contact) end

  collisionText = aObject.collisionClass .." touching "..bObject.collisionClass

end

function postSolve(a, b, contact, normalimpulse, tangentimpulse)
  local aObject = a:getUserData()
  local bObject = b:getUserData()
-- we won't do anything with this function

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.postSolve(aObject, bObject, contact, normalimpulse, tangentimpulse) end

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