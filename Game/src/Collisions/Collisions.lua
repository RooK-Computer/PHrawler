require 'src/Collisions/PlayerOnPlattform'


collisionText = ""

function beginContact(a, b, coll)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerOnPlattform.beginContact(aObject, bObject, coll) end

  local x,y = coll:getNormal()
  collisionText = aObject.collisionClass .." colliding with "..bObject.collisionClass .." with a vector normal of: "..x..", "..y
end


function endContact(a, b, coll)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerOnPlattform.endContact(aObject, bObject, coll) end

  collisionText = bObject.collisionClass .." uncolliding with ".. bObject.collisionClass
end

function preSolve(a, b, coll)
  local aObject = a:getUserData()
  local bObject = b:getUserData()

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerOnPlattform.preSolve(aObject, bObject, coll) end

  collisionText = aObject.collisionClass .." touching "..bObject.collisionClass

end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
  local aObject = a:getUserData()
  local bObject = b:getUserData()
-- we won't do anything with this function

  if aObject.collisionClass == 'Plattform' and bObject.collisionClass == 'Player' then PlayerOnPlattform.postSolve(aObject, bObject, normalimpulse, tangentimpulse) end

end


CollisionTemplate = {

  beginContact = function()
  end,

  endContact = function()
  end,

  preSolve = function()
  end,

  postSolve = function()
  end,

}