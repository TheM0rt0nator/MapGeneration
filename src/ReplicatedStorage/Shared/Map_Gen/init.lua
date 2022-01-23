local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = ReplicatedStorage.Libraries

local Noise = require(Lib.Noise)
local CONFIG = require(script.CONFIG)

local Rand = Random.new()

local MapGenerator = {}

-- Returns a table containing the tile types in order from left to right
function MapGenerator:generate()
	local w: number, h: number = CONFIG.width, CONFIG.height
	local heightMap = self:createHeightMap(w, h)
	local map = self:chooseTiles(w, h, heightMap)
	return map
end

-- Returns a height map using Perlin noise
function MapGenerator:createHeightMap(w: number, h: number)
	local heightMap = {}
	local startVal = Rand:NextNumber(1, 100)
	-- Make a table for each row in the height map, and add the noise values
	for y = 1, h do
		heightMap[y] = {}
		for x = 1, w do
			local nx, ny = (startVal + (x / w)) - 0.5, (startVal + (y / h)) - 0.5
			local noiseVal = Noise:getNoise("Perlin", nx, ny, 0, CONFIG.noiseAmplitude, CONFIG.noiseFrequency, CONFIG.noiseOctaves);
			-- Squash the value to make it between 0 and 1
			noiseVal = math.clamp((noiseVal + 1) / 2, 0, 1)
			heightMap[y][x] = noiseVal
		end
	end
	return heightMap
end

-- Chooses the tiles based on their frequency defined in CONFIG
function MapGenerator:chooseTiles(w: number, h: number, heightMap)
	local map = {}
	local tileTypes = CONFIG.tileTypes
	-- Iterate through the noise and decide what each tile will be
	for y = 1, h do
		for x = 1, w do
			local mapIndex = ((y - 1) * w) + x
			for _, tileInfo in pairs(tileTypes) do
				local tileFrequency = tileInfo[2]
				if heightMap[y][x] <= tileFrequency then
					map[mapIndex] = tileInfo[1]
					break
				end
			end
		end
	end
	return map
end

return MapGenerator
