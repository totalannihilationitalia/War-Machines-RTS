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

--[[ disposizione degli slots; C= commanter; 1÷8= slot1÷8
6 O 7 O 8
O O O O O
5 O C O 1
O O O O O
4 O 3 O 2
]]--

-- VARIABILI
local spawnCoorx = 0								-- coordinata x di spawn del comandante, cambierà valore poi nello script
local spawnCoorz = 0								-- coordinata z di spawn del comandante, cambierà valore poi nello script
local isunitsdeployed = Spring.GetModOptions().wmrtsunitdeploy or 0  -- verifico che il client abbia impostato la partita in modo che vi siano le unità dispiegate.
local slota_playername = Spring.GetModOptions().slota_owner or "empty"	 -- verifico chi è il nome giocatore proprietario degli slot player A
local slotb_playername = Spring.GetModOptions().slotb_owner or "empty"	 -- verifico chi è il nome giocatore proprietario degli slot player B
local slot_1a = Spring.GetModOptions().slot_1a or 0 -- verificare se rendere nil questa variabile in caso mancasse dallo script.txt ##################################################
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
local deploy_radius = 30 								-- deployement radius from initial starting units
local unitID_slot_1a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_2a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_3a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_4a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_5a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_6a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_7a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati
local unitID_slot_8a = nil								-- prenderà il valore dell'unità del rispettivo slot, per gestirne i dati

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
  if teamID_slota then 			 																																									-- se ha trovato corrispondenza assegna le unità al giocatore a
     Spring.Echo( "Trovato! Il giocatore '" .. slota_playername .. "' è nel team con ID: " .. tostring(teamID_slota).." e che parte dalla posizione x:" .. tostring(spawnCoorx).. " e z: ".. tostring(spawnCoorz) ) 	-- debug
	if (slot_1a ~= 1) and (slot_1a ~= 0) then 																																						-- se nello slot 1 è presente il nome dell'unità (e non è 1 o 0) 				
	 unitID_slot_1a= Spring.CreateUnit(slot_1a,spawnCoorx+deploy_radius,0,spawnCoorz,0,teamID_slota)							 																	-- imposto lo slot1a -- local risultato = deploy_radius / math.sin(math.rad(45)) teorema dei seni, in lua però devo convertire gli angoli in radianti
	 --Spring.Echo( "Trovato! Il giocatore '"
	end
	if (slot_2a ~= 1) and (slot_2a ~= 0) then 		
	 unitID_slot_2a= Spring.CreateUnit(slot_2a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot2a 
	end
	if (slot_3a ~= 1) and (slot_3a ~= 0) then 	
	 unitID_slot_3a= Spring.CreateUnit(slot_3a,spawnCoorx,0,spawnCoorz+deploy_radius,0,teamID_slota)																								-- imposto lo slot3a
	end
	if (slot_4a ~= 1) and (slot_4a ~= 0) then 	
	 unitID_slot_4a= Spring.CreateUnit(slot_4a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot4a
	end
	if (slot_5a ~= 1) and (slot_5a ~= 0) then 	
	 unitID_slot_5a= Spring.CreateUnit(slot_5a,spawnCoorx-deploy_radius,0,spawnCoorz,0,teamID_slota)																								-- imposto lo slot5a
	end
	if (slot_6a ~= 1) and (slot_6a ~= 0) then 	
	 unitID_slot_6a= Spring.CreateUnit(slot_6a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot6a
	end
	if (slot_7a ~= 1) and (slot_7a ~= 0) then 	
	 unitID_slot_7a= Spring.CreateUnit(slot_7a,spawnCoorx,0,spawnCoorz-deploy_radius,0,teamID_slota)																								-- imposto lo slot7a
	end
	if (slot_8a ~= 1) and (slot_8a ~= 0) then 		 
	 unitID_slot_8a= Spring.CreateUnit(slot_8a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot8a
	end	 
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