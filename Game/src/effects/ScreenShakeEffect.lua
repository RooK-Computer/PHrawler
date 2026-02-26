ScreenShakeEffect = Object:extend()

function ScreenShakeEffect:new(config)
  config = config or {}

  self.duration = config.duration or 0.08
  self.amplitude = config.amplitude or 4
  self.frequency = config.frequency or 75

  self.timeLeft = 0
  self.offsetY = 0
  self.active = false

  return self
end

function ScreenShakeEffect:start(config)
  config = config or {}

  if config.duration ~= nil then self.duration = config.duration end
  if config.amplitude ~= nil then self.amplitude = config.amplitude end
  if config.frequency ~= nil then self.frequency = config.frequency end

  self.timeLeft = self.duration
  self.offsetY = 0
  self.active = true
end

function ScreenShakeEffect:update(dt)
  if not self.active then return end

  self.timeLeft = self.timeLeft - dt

  if self.timeLeft <= 0 then
    self.timeLeft = 0
    self.offsetY = 0
    self.active = false
    return
  end

  local elapsed = self.duration - self.timeLeft
  local progress = elapsed / self.duration
  local damping = 1 - progress
  local wave = math.sin(elapsed * self.frequency * math.pi * 2)

  self.offsetY = wave * self.amplitude * damping
end

function ScreenShakeEffect:isActive()
  return self.active
end

function ScreenShakeEffect:getOffsetY()
  return self.offsetY
end
