require 'src/Collisions/PlayerPlattformCollision'

function beginContact(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.beginContact(aObject, bObject, contact) end

end


function endContact(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.endContact(aObject, bObject, contact) end

end

function preSolve(a, b, contact)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerPlattformCollision.preSolve(aObject, bObject, contact) end

end

function postSolve(a, b, contact, normalimpulse, tangentimpulse)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

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