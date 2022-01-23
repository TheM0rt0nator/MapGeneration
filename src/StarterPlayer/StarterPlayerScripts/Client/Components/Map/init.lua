local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared

local Lib = ReplicatedStorage.Libraries
local Roact = require(Lib.Roact)
local MapTile = require(script.MapTile)
local MapGenerator = require(Shared.Map_Gen)
local CONFIG = require(Shared.Map_Gen.CONFIG)

local Map = Roact.Component:extend("Map")

function Map:init()
	self:setState({
		map = MapGenerator:generate()
	})
end

function Map:render()
	local mapTiles = {}

	local tileWidth = math.min(1 / CONFIG.width, 1 / CONFIG.height)
	-- Loop through the generated map and create a tile for each pixel, with the generated tile type
	for index, tile in pairs(self.state.map) do
		local lastIndex = index - 1
		local currentRow = math.floor(lastIndex / CONFIG.width)
		local xPos = (lastIndex - (currentRow * CONFIG.width)) * tileWidth
		local yPos = currentRow * tileWidth
		local newTile = Roact.createElement(MapTile, {
			size = UDim2.new(tileWidth, 0, tileWidth, 0);
			position = UDim2.new(xPos, 0, yPos, 0);
			tileType = tile;
		})

		table.insert(mapTiles, newTile)
	end

	return Roact.createElement("Frame", {
		Name = "Map";
		AnchorPoint = Vector2.new(0.5, 0.5);
		Position = UDim2.new(0.5, 0, 0.5, 0);
		Size = UDim2.new(0.5, 0, 0.5, 0);
		BackgroundTransparency = 1;
	}, {
		UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint");

		MapTiles = Roact.createFragment(mapTiles);

		GenerateButton = Roact.createElement("TextButton", {
			Size = UDim2.new(0.3, 0, 0.3, 0);
			Position = UDim2.new(1.5, 0, 0.5, 0);
			AnchorPoint = Vector2.new(0.5, 0.5);
			Text = "Generate";
			[Roact.Event.MouseButton1Click] = function()
				-- Re-render the map with the new map
				self:setState({
					map = MapGenerator:generate()
				})
			end;
		})
	})
end

return Map
