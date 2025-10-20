-- file: createdeployedunitsatstart.lua

function gadget:GetInfo()
    return {
        name      = "createdeployedunitsatstart",
        desc      = "Create deployable units ad start",
        author    = "molix",
        date      = "20/10/2025",
        license   = "GNU GPL, v2 or later",
        layer     = 0, -- Un layer basso per essere eseguito prima di altri gadget di gameover
        enabled   = true
    }
end
----- ########################################## completare
----- ########################################## completare
----- ########################################## completare
----- ########################################## completare

-- VARIABILI
local slot_1a = Spring.GetModOptions().udslot_1a or "empty"
local slot_2a = Spring.GetModOptions().udslot_2a or "empty"
local slot_3a = Spring.GetModOptions().udslot_3a or "empty"
local slot_4a = Spring.GetModOptions().udslot_4a or "empty"
local slot_5a = Spring.GetModOptions().udslot_5a or "empty"
local slot_6a = Spring.GetModOptions().udslot_6a or "empty"
local slot_7a = Spring.GetModOptions().udslot_7a or "empty"
local slot_8a = Spring.GetModOptions().udslot_8a or "empty"
local slot_1b = Spring.GetModOptions().udslot_1b or "empty"
local slot_2b = Spring.GetModOptions().udslot_2b or "empty"
local slot_3b = Spring.GetModOptions().udslot_3b or "empty"
local slot_4b = Spring.GetModOptions().udslot_4b or "empty"
local slot_5b = Spring.GetModOptions().udslot_5b or "empty"
local slot_6b = Spring.GetModOptions().udslot_6b or "empty"
local slot_7b = Spring.GetModOptions().udslot_7b or "empty"
local slot_8b = Spring.GetModOptions().udslot_8b or "empty"
local deploy_radius = 30 	-- deployement radius from commander

----
-- SYNC
---- 
if (gadgetHandler:IsSyncedCode()) then


	function gadget:Initialize()
	-- inserire qui tutti i caricamenti vari degli slot da dispiegare in gamestart

	end


	function gadget:GameStart() then
	-- dispiegare qui le unità
	end
----
-- UNSYNC
---- 
else

-- inserire varie funzioni "handler" per comunicare con WMRTS_deployedunits.lua widget

--[[
-- funzione HandleVictoryListEvent
local function HandleVictoryListEvent(cmd, winnerString)
	if Script.LuaUI('VictoryListEvent') then
		Script.LuaUI.VictoryListEvent(winnerString)
	end
end

-- all'inizio associo l'evento VictoryListEvent alla funzione HandleVictoryListEvent
function gadget:Initialize()
	gadgetHandler:AddSyncAction("VictoryListEvent", HandleVictoryListEvent)
end
]]--


end -- end unsync