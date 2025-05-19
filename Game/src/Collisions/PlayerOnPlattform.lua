PlayerOnPlattform = {

  beginContact = function(plattform, player, coll)
      player.isOnGround = true 
  end,

  endContact = function(plattform, player, coll)
      player.isOnGround = false 
  end,

  preSolve = function(plattform, player, coll)
  end, 

  postSolve = function(plattform, player, normalimpulse, tangentimpulse)
  end,

}