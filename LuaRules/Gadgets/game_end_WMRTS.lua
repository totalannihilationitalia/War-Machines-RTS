

function gadget:GetInfo()
	return {
		name      = "winning team",
		desc      = "A list of winning team",
		author    = "molix",
		date      = "jan, 2019",
		license   = "GNU GPL, v2 or later",
		layer     = 10, -- must be higher than layer for game_gameover gadget, otherwise GameOver callin is trapped
		enabled   = true  --  loaded by default?
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

	function gadget:Initialize()
--			local Echo = Spring.Echo
--			Echo ("gadget winning list started")
	end

	function gadget:GameOver()
			local Echo = Spring.Echo
			Echo ("_-end.-.game-_")
	end


