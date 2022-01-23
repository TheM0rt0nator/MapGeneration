local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local Lib = ReplicatedStorage.Libraries
local Roact = require(Lib.Roact)
local Map = require(Player.PlayerScripts.Client.Components.Map)

local Interface = Roact.Component:extend("Interface")

function Interface:init()
	self.children = {
		Map = Roact.createElement(Map);
	}
end

function Interface:render()
	return Roact.createElement("ScreenGui", {
		Name = "Interface";
	}, self.children)
end

return Interface
