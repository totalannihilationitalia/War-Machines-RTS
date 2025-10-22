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
local spawnCoorx = 0								-- coordinata x di spawn del comandante, cambierà valore poi nello script
local spawnCoorz = 0								-- coordinata z di spawn del comandante, cambierà valore poi nello script
local isunitsdeployed = Spring.GetModOptions().wmrtsunitdeploy or 0  -- verifico che il client abbia impostato la partita in modo che vi siano le unità dispiegate.
local slota_playername = Spring.GetModOptions().slota_owner or "empty"	 -- verifico chi è il nome giocatore proprietario degli slot player A
local slotb_playername = Spring.GetModOptions().slotb_owner or "empty"	 -- verifico chi è il nome giocatore proprietario degli slot player B
local slot_1a = Spring.GetModOptions().slot_1a or 0
local slot_2a = Spring.GetModOptions().slot_2a or 0
local slot_3a = Spring.GetModOptions().slot_3a or 0
local slot_4a = Spring.GetModOptions().slot_4a or 0
local slot_5a = Spring.GetModOptions().slot_5a or 0
local slot_6a = Spring.GetModOptions().slot_6a or 0
local slot_7a = Spring.GetModOptions().slot_7a or 0
local slot_8a = Spring.GetModOptions().slot_8a or 0
local slot_1b = Spring.GetModOptions().slot_1b or 0
local slot_2b = Spring.GetModOptions().slot_2b or 0
local slot_3b = Spring.GetModOptions().slot_3b or 0
local slot_4b = Spring.GetModOptions().slot_4b or 0
local slot_5b = Spring.GetModOptions().slot_5b or 0
local slot_6b = Spring.GetModOptions().slot_6b or 0
local slot_7b = Spring.GetModOptions().slot_7b or 0
local slot_8b = Spring.GetModOptions().slot_8b or 0
local deploy_radius = 30 	-- deployement radius from initial starting units

----
-- SYNC
---- 
if (gadgetHandler:IsSyncedCode()) then

--------------------------------------------------------------------------------
-- Funzione per ricercare ID corrispondente allo username e ##### implementare  configurare le variabili coordinate di spawn per le "deployed units" di quel team #############
--------------------------------------------------------------------------------
function GetTeamIDFromPlayerName(targetName)
  local playerIDs = Spring.GetPlayerList() 					-- crea una tabella di tutti i player connessi, AI e spettatori
  for _, playerID in ipairs(playerIDs) do					-- Per tutti gli elementi presenti nella tabella playerIDs, esegui il codice seguente (e per ogni elemento, assegna il valore numerico dell'ID del giocatore alla variabile playerID
    local playerInfo, isActive, isSpectator, teamID = Spring.GetPlayerInfo(playerID)
 --   if playerInfo and playerInfo.name == targetName then
    if playerInfo == targetName then
	-- ############## implementare qui la rilevazione delle spawn  "spawnCoorx" & "spawnCoorz"
	  spawnCoorx, _ ,spawnCoorz = Spring.GetTeamStartPosition(teamID) -- prelevo le coordinate x e z di partenza del team
      return teamID
    end
  end
  return nil
end
			
--------------------------------------------------------------------------------
-- Initialize
--------------------------------------------------------------------------------			
function gadget:Initialize()
end

--------------------------------------------------------------------------------
-- Game start
--------------------------------------------------------------------------------
function gadget:GameStart() 
  -- 1) Inizio a dispiegare le unità dello slot a
  local teamID_slota = GetTeamIDFromPlayerName(slota_playername) -- avvio la funzione per verificare a quale ID appartiene il giocatore a (settato poi da client)
  if teamID_slota then 			  -- se ha trovato corrispondenza assegna le unità al giocatore a
     Spring.Echo( "Trovato! Il giocatore '" .. slota_playername .. "' è nel team con ID: " .. tostring(teamID_slota).." e che parte dalla posizione x:" .. tostring(spawnCoorx).. " e z: ".. tostring(spawnCoorz) ) 	-- debug
	 Spring.CreateUnit(slot_1a,spawnCoorx,0,spawnCoorz,0,teamID_slota)
  else																													-- altrimenti se non ha trovato corrispondenza invia messaggio di errore
    Spring.Echo( "ATTENZIONE: Giocatore '" .. slota_playername .. "' non trovato nella partita." )						-- debug
  end
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