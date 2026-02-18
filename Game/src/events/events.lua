function player_died_event(playerName)
end
  
-- registers event and callback-function
love.handlers[Constants.EVENT_PLAYER_DIED] = player_died_event
