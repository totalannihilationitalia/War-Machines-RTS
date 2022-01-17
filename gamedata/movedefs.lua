local moveDefs = {
	{
		name = "AKBOT2",
		crushstrength = 50,
		depthmod = 0,
		footprintx = 2,
		footprintz = 2,
		maxslope = 15, -- era 36
		maxwaterdepth = 5000,
		maxwaterslope = 50,
		
	},
	{
		name = "AKBOTBOMB2",
		crushstrength = 50,
		depthmod = 0,
		footprintx = 2,
		footprintz = 2,
		maxslope = 15, -- era 36
		maxwaterdepth = 5000,
		maxwaterslope = 50,
		depthModParams = {
			constantCoeff = 1.5,
		},
		
	},
	{
		name = "ANT",
		footprintX = 1,
		footprintZ = 1,
		maxWaterDepth = 2,
		crushStrength = 0,
		speedModClass = 1, -- 0 = tank, 1 = kbot, 2 = hover, 3 = ship 
	},
	{
		name = "ATANK3",
		crushstrength = 30,
		depthmod = 0,
		footprintx = 3,
		footprintz = 3,
		maxslope = 15, --36
		maxwaterdepth = 5000,
		maxwaterslope = 80,
	},
	{
		name = "BOAT4",
		crushstrength = 40,
		footprintx = 3,
		footprintz = 3,
		minwaterdepth = 8,
	},
	{
		name = "BOAT5",
		crushstrength = 50,
		footprintx = 4,
		footprintz = 4,
		minwaterdepth = 10,
	},
	--[[ 
	{
		name = "DBOAT3",
		crushstrength = 30,
		footprintx = 3,
		footprintz = 3,
		minwaterdepth = 15,
	},
	]]--
	{
		name = "CRITTERH",
		crushstrength = 0,
		footprintx = 1,
		footprintz = 1,
		maxslope = 50,
		maxwaterslope = 255,
		maxWaterDepth = 255,
		minwaterdepth = 15,
		speedModClass = 2, -- 0 = tank, 1 = kbot, 2 = hover, 3 = ship 
	},
	{
		name = "DBOAT6",
		crushstrength = 252,
		footprintx = 6,
		footprintz = 6,
		minwaterdepth = 15,
	},
	{
		name = "HAKBOT4",
		crushstrength = 252,
		depthmod = 0,
		footprintx = 4,
		footprintz = 4,
		maxslope = 15, -- era 36
		maxwaterdepth = 5000,
		maxwaterslope = 80,
	},
	--[[
	{
		name = "HDBOAT8",
		crushstrength = 1400,
		footprintx = 8,
		footprintz = 8,
		minwaterdepth = 15,
	},
	]]--
	{
		name = "HKBOT3",
		crushstrength = 1400,
		footprintx = 3,
		footprintz = 3,
		maxslope = 15, -- era 36
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	 {
		name = "HKBOT4",
		crushstrength = 1400,
		footprintx = 4,
		footprintz = 4,
		maxslope = 15, -- era 36
		maxwaterdepth = 26,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "HKBOT5",
		crushstrength = 1400,
		footprintx = 5,
		footprintz = 5,
		maxslope = 15, -- era 36
		maxwaterdepth = 30,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "HOVER3",
		badslope = 22,
		badwaterslope = 255,
		crushstrength = 25,
		footprintx = 3,
		footprintz = 3,
		maxslope = 15, -- era 22
		maxwaterslope = 255,
	},
	{
		name = "HHOVER3",
		badslope = 22,
		badwaterslope = 255,
		crushstrength = 252,
		footprintx = 3,
		footprintz = 3,
		maxslope = 15, -- era 22
		maxwaterslope = 255,
	},
	{
		name = "HOVER4",
		badslope = 22,
		badwaterslope = 255,
		crushstrength = 25,
		footprintx = 4,
		footprintz = 4,
		maxslope = 15, -- era 22
		maxwaterslope = 255,
	},
	{
		name = "HTANK3",
		crushstrength = 250,
		footprintx = 3,
		footprintz = 3,
		maxslope = 18,
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "HTANK4",
		crushstrength = 250,
		footprintx = 4,
		footprintz = 4,
		maxslope = 18,
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "HTKBOT4",
		crushstrength = 252,
		footprintx = 4,
		footprintz = 4,
		maxslope = 15, -- era 80
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "KBOT1",
		crushstrength = 5,
		footprintx = 1,
		footprintz = 1,
		maxslope = 15, -- era 36
		maxwaterdepth = 5,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
		
	},
	{
		name = "KBOT2",
		crushstrength = 10,
		footprintx = 2,
		footprintz = 2,
		maxslope = 15, -- era 36
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "TANK2",
		crushstrength = 15,
		footprintx = 2,
		footprintz = 2,
		maxslope = 18,
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "TANK3",
		crushstrength = 30,
		footprintx = 3,
		footprintz = 3,
		maxslope = 18,
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "TKBOT2",
		crushstrength = 15,
		footprintx = 2,
		footprintz = 2,
		maxwaterdepth = 22,
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "TKBOT3",
		crushstrength = 15,
		footprintx = 3,
		footprintz = 3,
		maxwaterdepth = 22,
speedModClass = 0, -- 0 = tank, 1 = kbot, 2 = hover, 3 = ship 
		depthModParams = {
			minHeight = 4,
			linearCoeff = 0.03,
			maxValue = 0.7,
		}
	},
	{
		name = "VKBOT3",
		crushstrength = 1400,
		depthmod = 0,
		footprintx = 3,
		footprintz = 3,
		maxslope = 24,
		maxwaterdepth = 5000,
		maxwaterslope = 30,
	},
	{
		name = "VKBOT5",
		crushstrength = 1400,
		depthmod = 0,
		footprintx = 5,
		footprintz = 5,
		maxslope = 24,
		maxwaterdepth = 5000,
		maxwaterslope = 30,
	},
	{
		name = "VKBOT8",
		crushstrength = 1400,
		depthmod = 0,
		footprintx = 7,
		footprintz = 7,
		maxslope = 24,
		maxwaterdepth = 5000,
		maxwaterslope = 30,
	},
	
	-- Subs
	{
		name = "UBOAT3",
		footprintx = 2,
		footprintz = 2,
		minwaterdepth = 15,
		crushstrength = 5,
		subMarine = 1,
	},
	--[[
	{
		name = "UBOAT4",
		footprintx = 4,
		footprintz = 4,
		minwaterdepth = 40,
		crushstrength = 5,
		subMarine = 1,
	},
	]]--
	{
		name = "NANO",
		crushstrength = 0,
		footprintx = 3,
		footprintz = 3,
		maxslope = 18,
		maxwaterdepth = 0,
	},
}

return moveDefs

