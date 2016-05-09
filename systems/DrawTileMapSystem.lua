local DrawTileMapSystem = class("DrawTileMapSystem", System)

function DrawTileMapSystem:draw()
  for i, e in pairs(self.targets) do
    local map = e:get("TileMap")
    for mapY, row in ipairs(map.tileMap) do
      for mapX, char in ipairs(row) do
        local x, y = (mapX - 1) * map.tileSize, (mapY - 1) * map.tileSize
        local tile = map:getTile(mapX, mapY)
        love.graphics.draw(map.tileSetImage, tile.quad , x, y)
      end
    end
  end
end

function DrawTileMapSystem:requires()
    return {"TileMap"}
end

return DrawTileMapSystem
