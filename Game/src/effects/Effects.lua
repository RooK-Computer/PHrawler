require('src/effects/ScreenShakeEffect')

Effects = Object:extend()

function Effects:new()
  self.screenShake = ScreenShakeEffect({
    duration = 0.14,
    amplitude = 11,
    frequency = 14,
  })

  return self
end

function Effects:update(dt)
  self.screenShake:update(dt)
end

function Effects:triggerScreenShake(config)
  self.screenShake:start(config)
end

function Effects:getOffsetY()
  if self.screenShake:isActive() then
    local offsetY = self.screenShake:getOffsetY()
    if offsetY >= 0 then
      return math.floor(offsetY + 0.5)
    end
    return math.ceil(offsetY - 0.5)
  end

  return 0
end
