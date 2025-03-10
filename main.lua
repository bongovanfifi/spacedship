
State = { entries = {} }


function State:update()
  for _, v in ipairs(self.entries) do
    if v.update ~= nil then
      v:update()
    end
  end
end

function State:draw()
  for _, v in ipairs(self.entries) do
    if v.draw ~= nil then
      v:draw()
    end
  end
end

function love.load()
end

triangle = {
  ax = 100,
  ay = 100,
  bx = 200,
  by = 100,
  cx = 150,
  cy = 200
}


function triangle:move_x(step)
  self.ax = self.ax + step
  self.bx = self.bx + step
  self.cx = self.cx + step
end

function triangle:move_y(step)
  self.ay = self.ay + step
  self.by = self.by + step
  self.cy = self.cy + step
end

function triangle:draw()
  love.graphics.polygon("fill", self.ax, self.ay, self.bx, self.by, self.cx, self.cy)
end

table.insert(State.entries, triangle)

MOVE_STEP = 5

function triangle:update()
  if love.keyboard.isDown("up") then
    self:move_y(MOVE_STEP * -1)
  elseif love.keyboard.isDown("down") then
    self:move_y(MOVE_STEP)
  elseif love.keyboard.isDown("left") then
    self:move_x(MOVE_STEP * -1)
  elseif love.keyboard.isDown("right") then
    self:move_x(MOVE_STEP)
  end
end

function love.update()
  State:update()
end

function love.draw()
  State:draw()
end
