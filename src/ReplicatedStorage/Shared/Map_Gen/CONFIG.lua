--[[
	Map Generator Configuration:
	- Higher amplitudes will give more of the extremities (e.g. more water and snow)
	- Higher frequencies is like zooming into/out of the map; you get more/less grouping of each tile
	- Octaves are when you add noise together of differrent frequencies and amplitudes, end up with a noisier image
]]

return {
	width = 50;
	height = 50;
	noiseAmplitude = 2;
	noiseFrequency = 5;
	noiseOctaves = 0;
	-- These must be in order from low to high
	tileTypes = {
		{"Water", 0.1};
		{"Sand", 0.2};
		{"Grass", 0.5};
		{"Forest", 0.99};
		{"Snow", 1}
	};
}
