local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = ReplicatedStorage.Libraries
local Roact = require(Lib.Roact)

local MapTile = Roact.Component:extend("MapTile")

-- These names need to match up with the tiles in the CONFIG module
local tileColors = {
	Water = Color3.fromRGB(43, 64, 255);
	Sand = Color3.fromRGB(255, 243, 135);
	Grass = Color3.fromRGB(98, 226, 81);
	Forest = Color3.fromRGB(54, 150, 76);
	Snow = Color3.new(1, 1, 1)
}

function MapTile:render()
	return Roact.createElement("Frame", {
		Name = "MapTile";
		Position = self.props.position;
		Size = self.props.size;
		BorderSizePixel = 0;
		BackgroundColor3 = tileColors[self.props.tileType] or Color3.new(1, 1, 1);
	}, {
		UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint")
	})
end

return MapTile
