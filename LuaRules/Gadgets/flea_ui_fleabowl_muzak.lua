function gadget:GetInfo()
	return {
	name = "Fleabowl Muzak",
	desc = "Plays final battle and boss death music",
	author = "Deadnight Warrior", -- edit by molix
	date = "29 Sep 2011",
	license = "GTFO",
	layer = 1,
	enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then
	function gadget:Initialize()
	 -- if Spring.GetSpectatingState() or Spring.IsReplay() then
		 -- gadgetHandler:RemoveGadget()
		 -- return true
	 -- end	
	end
	function gadget:UnitCreated(unitID, unitDefID, unitTeam)
		if UnitDefs[unitDefID].name == "juju" then
			Spring.PlaySoundStream("sounds/finalbattle.ogg")
		end
	end
	function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
		if UnitDefs[unitDefID].name == "juju" then
			Spring.StopSoundStream()
			Spring.PlaySoundStream("sounds/fleabossdead.ogg")
		end
	end
end