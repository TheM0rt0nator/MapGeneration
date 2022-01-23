-- Generates any type of noise, providing the required noise module is parented to this module

local Noise = {}

-- Compile all of the types of noises we have into this module
for _, module in pairs(script:GetChildren()) do
	Noise[module.Name] = require(module)
end

-- Returns a table of noise with the given constraints
-- Allows for 2d or 3d noise
function Noise:getNoise(noiseType: string, ...): number
	assert(typeof(noiseType) == "string" and self[noiseType] and typeof(self[noiseType]) == "table", "noiseType argument must be a valid type of noise")
	return self[noiseType]:noise(...)
end

return Noise