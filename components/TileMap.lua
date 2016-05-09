local TileMap = Component.create("TileMap")

function TileMap:initialize(mapFile)
  local map = love.filesystem.load(mapFile)()
  self.tileSize = map.tileSize
  self.tileSetImage = love.graphics.newImage(map.tileSetImage)
  self.tileMap = {}
  self.tileInfo = {}

  self.width = #(map.tileMap:match("[^\n]+"))
  self.height = 1

  for rowString in map.tileMap:gmatch("[^\n]+") do
    assert(#rowString == self.width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(self.width) .. ', but it is ' .. tostring(#rowString))
    local row = {}
    for char in rowString:gmatch(".") do
      table.insert(row, char)
    end
    table.insert(self.tileMap, row)
    self.height = self.height + 1
  end

  local tileSetImageWidth, tileSetImageHeight = self.tileSetImage:getWidth(), self.tileSetImage:getHeight()
  local tilesPerRow = math.floor(tileSetImageWidth / self.tileSize)

  for _, info in ipairs(map.tileInfo) do
    local c, tileIndex = info[1], info[2]
    local tileRow = math.floor(tileIndex / tilesPerRow)
    local tileColumn = tileIndex % tilesPerRow
    local x, y = tileColumn * self.tileSize, tileRow * self.tileSize
    self.tileInfo[c] = {
      quad = love.graphics.newQuad(x, y, self.tileSize, self.tileSize, tileSetImageWidth, tileSetImageHeight),
    }
  end
end

function TileMap:getTile(mapX, mapY)
  local char = self.tileMap[mapY][mapX]
  return self.tileInfo[char]
end
