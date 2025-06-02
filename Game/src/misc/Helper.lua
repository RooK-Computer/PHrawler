Helper = {

  drawDebug = function(world, alpha)
    -- get the current color values to reapply
    local r, g, b, a = love.graphics.getColor()
    -- alpha value is optional
    alpha = alpha or 255
    -- Colliders debug
    love.graphics.setColor(222, 222, 222, alpha)
    local bodies = world:getBodies() 
    for _, body in ipairs(bodies) do
      local fixtures = body:getFixtures()
      for _, fixture in ipairs(fixtures) do
        if fixture:getShape():type() == 'PolygonShape' then
          love.graphics.polygon('line', body:getWorldPoints(fixture:getShape():getPoints()))
        elseif fixture:getShape():type() == 'EdgeShape' or fixture:getShape():type() == 'ChainShape' then
          local points = {body:getWorldPoints(fixture:getShape():getPoints())}
          for i = 1, #points, 2 do
            if i < #points-2 then love.graphics.line(points[i], points[i+1], points[i+2], points[i+3]) end
          end
        elseif fixture:getShape():type() == 'CircleShape' then
          local body_x, body_y = body:getPosition()
          local shape_x, shape_y = fixture:getShape():getPoint()
          local r = fixture:getShape():getRadius()
          love.graphics.circle('line', body_x + shape_x, body_y + shape_y, r, 360)
        end
      end
    end
    love.graphics.setColor(255, 255, 255, alpha)

    -- Joint debug
    love.graphics.setColor(222, 128, 64, alpha)
    local joints = world:getJoints()
    for _, joint in ipairs(joints) do
      local x1, y1, x2, y2 = joint:getAnchors()
      if x1 and y1 then love.graphics.circle('line', x1, y1, 4) end
      if x2 and y2 then love.graphics.circle('line', x2, y2, 4) end
    end
    love.graphics.setColor(255, 255, 255, alpha)

    love.graphics.setColor(r, g, b, a)

  end,

  deepCloneTable = function(t) -- deep-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
      if type(v) == "table" then
        target[k] = Helper.deepCloneTable(v)
      else
        target[k] = v
      end
    end
    setmetatable(target, meta)
    return target
  end,

  getPlayerById = function(id)

    player = nil

    for i = 1, #game.players do
      if game.players[i].id == id then player = game.players[i] end
    end

    return player

  end,

  shuffleArray = function(t)
    math.randomseed(os.time()) -- so that the results are always different
    local s = {}
    for i = 1, #t do s[i] = t[i] end
    for i = #t, 2, -1 do
        local j = math.random(i)
        s[i], s[j] = s[j], s[i]
    end
    return s
  end,

}