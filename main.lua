-- Importing lovetoys
require('lib.lovetoys.lovetoys')

-- Components
require("components/TileMap")

-- Systems
DrawTileMapSystem = require("systems/DrawTileMapSystem")

local TileMap =  Component.load({"TileMap"})

function love.load()
  -- A new instance of an Engine is beeing created.
  engine = Engine()
  -- A new instance of an EventManger is beeing created.
  eventmanager = EventManager()

  mapEntity = Entity()
  mapEntity:add(TileMap("maps/map1.lua"))
  engine:addEntity(mapEntity)

  engine:addSystem(DrawTileMapSystem())
end

function love.update(dt)
  engine:update(dt)
end

function love.draw()
  engine:draw()
end
