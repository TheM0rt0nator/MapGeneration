-- Generates a Perlin noise value 

local PerlinNoise = {
	DEFAULT_AMPLITUDE = 1;
	DEFAULT_FREQUENCY = 1;
	DEFAULT_OCTAVES = 0;
}

local Rand = Random.new()

-- Return range: [-1, 1]
function PerlinNoise:noise(x: number, y: number, z: number, amplitude: number, frequency: number, octaves: number): number
	-- Set default values
	x = x or 0
	y = y or 0
	z = z or 0
	amplitude = amplitude or self.DEFAULT_AMPLITUDE
	frequency = frequency or self.DEFAULT_FREQUENCY
	octaves = octaves or self.DEFAULT_OCTAVES
	
	local perlinVal = amplitude * math.noise(x * frequency, y * frequency, z * frequency)
	if octaves > 0 then
		perlinVal = self:addOctaves(perlinVal, x, y, z, amplitude, octaves)
	end
    return math.clamp(perlinVal, -1, 1)
end

-- Adds Perlin noise at different amplitudes and frequencies together
function PerlinNoise:addOctaves(val: number, x: number, y: number, z: number, amplitude: number, octaves: number): number
	local totalAmplitude = 0
	for i = 1, octaves do
		local randomAmplitude = Rand:NextNumber(0, amplitude)
		local randomFrequency = amplitude / randomAmplitude
		val += randomAmplitude * math.noise(x * randomFrequency, y * randomFrequency, z * randomFrequency) / 2 ^ i
		totalAmplitude += randomAmplitude
	end

	return val / totalAmplitude
end

return PerlinNoise