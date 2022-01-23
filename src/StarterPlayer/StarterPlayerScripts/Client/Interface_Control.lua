local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local Lib = ReplicatedStorage.Libraries
local Roact = require(Lib.Roact)
local Interface = require(Player.PlayerScripts.Client.Components.Interface)

local Interface_Control = {}

Roact.mount(Roact.createElement(Interface), Player.PlayerGui)

return Interface_Control
