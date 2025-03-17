State = {
  ids = {},
  players = {},
  increments = { LastId = 0, PlayerId = 0 }
}

MOVE_STEP = 3
SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()


local function increment(name)
  State.increments[name] = State.increments[name] + 1
  return State.increments[name]
end


local function create_player(hitbox, pos)
  local new_id = increment("LastId")
  local new_player_id = increment("PlayerId")
  local player = {
    id = new_id,
    player_id = new_player_id,
    pos = pos,
    hitbox = hitbox,
  }
  State.ids[new_id] = true
  State.players[new_id] = player
  return player
end

local function move(t, dx, dy)
  if dx ~= 0 and dy ~= 0 then
    dx = dx * 0.7071
    dy = dy * 0.7071
  end
  t.pos[1] = t.pos[1] + dx * MOVE_STEP
  t.pos[2] = t.pos[2] + dy * MOVE_STEP
end

local function update_players()
  for _, v in pairs(State["players"]) do
    if v.player_id == 1 then
      local dx, dy = 0, 0
      if love.keyboard.isDown("up") then dy = dy - 1 end
      if love.keyboard.isDown("down") then dy = dy + 1 end
      if love.keyboard.isDown("left") then dx = dx - 1 end
      if love.keyboard.isDown("right") then dx = dx + 1 end
      move(v, dx, dy)
    elseif v.player_id == 2 then
      local dx, dy = 0, 0
      if love.keyboard.isDown("w") then dy = dy - 1 end
      if love.keyboard.isDown("s") then dy = dy + 1 end
      if love.keyboard.isDown("a") then dx = dx - 1 end
      if love.keyboard.isDown("d") then dx = dx + 1 end
      move(v, dx, dy)
    end
  end
end

local function draw_player_hitboxes()
  for _, v in pairs(State.players) do
    local offset_hitbox = {}
    for i = 1, #v.hitbox, 2 do
      offset_hitbox[i] = v.hitbox[i] + v.pos[1]
      offset_hitbox[i + 1] = v.hitbox[i + 1] + v.pos[2]
    end
    love.graphics.polygon("fill", unpack(offset_hitbox))
    -- says its deprecated, dont see a good alternative, not sure it really is in love2ds lua version?
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", v.pos[1], v.pos[2], 5)
    love.graphics.setColor(1, 1, 1) -- Reset color
  end
end

function love.load()
  create_player({ 25, 0, 0, 50, 50, 50 }, { 100, 100 })
  create_player({ 0, 0, 500, 0, 500, 200, 0, 200 }, { 300, 0 })
end

function love.update()
  update_players()
end

function love.draw()
  draw_player_hitboxes()
end

-- TODO: just use Box2D for all of this, probably a lot faster, get things like bouncing out of the box