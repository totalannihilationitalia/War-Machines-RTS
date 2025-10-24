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

-- rev 0 del 24/10/2025 by molix: Creo il gadget

-- VARIABILI
local spawnCoorx = 0														-- coordinata x di spawn del comandante, cambierà valore poi nello script
local spawnCoorz = 0														-- coordinata z di spawn del comandante, cambierà valore poi nello script
local isunitsdeployed = Spring.GetModOptions().wmrtsunitdeploy or 0  		-- verifico che la lobby richieda la modalità deploy units, serve per disattivare o meno questo gadget.
local slota_playername = Spring.GetModOptions().slota_owner or nil	 		-- verifico chi è il nome giocatore proprietario degli slot player A
local slotb_playername = Spring.GetModOptions().slotb_owner or nil		 	-- verifico chi è il nome giocatore proprietario degli slot player B
local slot_1a = Spring.GetModOptions().slot_1a or 0 						-- verificare se rendere nil questa variabile in caso mancasse dallo script.txt ##################################################
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
local deploy_radius = 100 								-- deployement radius from initial starting units
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
-- Controllo se l'utente è spettatore
--  local myTeamID = Spring.GetLocalTeamID()
--  local teamInfo = Spring.GetTeamInfo(myTeamID)
--  if teamInfo and teamInfo.spectator then
--    return false -- disattivo il gadget
--  end

-- controllo se l'opzione attiva unit deploy è abilitata
  if (isunitsdeployed == 0) 	then
    return false -- disattivo il gadget
  end
end

--------------------------------------------------------------------------------
-- Game start
--------------------------------------------------------------------------------
function gadget:GameStart() 

--[[ disposizione degli slots; C= commander; 1÷8= slot1÷8
6 O 7 O 8
O O O O O
5 O C O 1
O O O O O
4 O 3 O 2
]]--  
-- 1) Inizio a dispiegare le unità dello slot A mantenendo la suddetta disposizione
	if slota_playername  then																																											-- se giocatore proprietario degli slotA esiste
	  local teamID_slota = GetTeamIDFromPlayerName(slota_playername) -- richiamo la funzione per verificare a quale ID appartiene il giocatore a (settato poi da client)
	  if teamID_slota then 			 																																									-- se ha trovato corrispondenza assegna le unità al giocatore a
		 Spring.Echo( "Trovato! Il giocatore '" .. slota_playername .. "' è nel team con ID: " .. tostring(teamID_slota).." e che parte dalla posizione x:" .. tostring(spawnCoorx).. " e z: ".. tostring(spawnCoorz) ) 	-- debug
		if (slot_1a ~= 1 and slot_1a ~= "1") and (slot_1a ~= 0 and slot_1a ~= "1") then 																												-- se nello slot 1 è presente il nome dell'unità (e non è ne 1 o 0 sia numero che stringa "1" o "0") 				
		 unitID_slot_1a = Spring.CreateUnit(slot_1a,spawnCoorx+deploy_radius,0,spawnCoorz,0,teamID_slota)							 																	-- creo l'unità dello slot1a definendone l'ID dell'unità (memorizzata in unitID_slot_1a). Per la posizione ho usato il teorema dei seni, in lua però devo convertire gli angoli in radianti
		 Spring.SetGameRulesParam("ud_statusslot1a", slot_1a)																																			-- setto il gamerule per lo slot1a = nome unità assegnata (verrà poi letto dal widget)
		 Spring.SetGameRulesParam("ud_idslot1a", unitID_slot_1a)																																				-- setto il gamerule per l'ID dell' unità assegnata allo slot1a (verrà poi letto dal widget per catturare le informazioni sulla posizione dell'unita x)
		 Spring.Echo( "imposto da GADGET slot_1a= "..slot_1a.." e id= "..unitID_slot_1a)
		else
		 Spring.SetGameRulesParam("ud_statusslot1a", "vuoto")																																			-- altrimenti setto il gamerule per lo slot1a = vuoto (verrà poi letto dal widget)	
		end
		if (slot_2a ~= 1 and slot_2a ~= "1") and (slot_2a ~= 0 and slot_2a ~= "0") then 																												
		 unitID_slot_2a= Spring.CreateUnit(slot_2a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot2a 
		 Spring.SetGameRulesParam("ud_statusslot2a", slot_2a)	
		 Spring.SetGameRulesParam("ud_idslot2a", unitID_slot_2a)		 
		else
		 Spring.SetGameRulesParam("ud_statusslot2a", "vuoto")		
		end
		if (slot_3a ~= 1 and slot_3a ~= "1") and (slot_3a ~= 0 and slot_3a ~= "0") then 	
		 unitID_slot_3a= Spring.CreateUnit(slot_3a,spawnCoorx,0,spawnCoorz+deploy_radius,0,teamID_slota)																								-- imposto lo slot3a
		 Spring.SetGameRulesParam("ud_statusslot3a", slot_3a)	
		 Spring.SetGameRulesParam("ud_idslot2a", unitID_slot_3a)		 		 
		else
		 Spring.SetGameRulesParam("ud_statusslot3a", "vuoto")		
		end
		if (slot_4a ~= 1 and slot_4a ~= "1") and (slot_4a ~= 0 and slot_4a ~= "0") then 	
		 unitID_slot_4a= Spring.CreateUnit(slot_4a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot4a
		 Spring.SetGameRulesParam("ud_statusslot4a", slot_4a)	
		 Spring.SetGameRulesParam("ud_idslot2a", unitID_slot_4a)		 		 
		else
		 Spring.SetGameRulesParam("ud_statusslot4a", "vuoto")		
		end
		if (slot_5a ~= 1 and slot_5a ~= "1") and (slot_5a ~= 0 and slot_5a ~= "0") then 	
		 unitID_slot_5a= Spring.CreateUnit(slot_5a,spawnCoorx-deploy_radius,0,spawnCoorz,0,teamID_slota)																								-- imposto lo slot5a
		 Spring.SetGameRulesParam("ud_statusslot5a", slot_5a)	
		 Spring.SetGameRulesParam("ud_idslot5a", unitID_slot_5a)		 		 
		else
		 Spring.SetGameRulesParam("ud_statusslot5a", "vuoto")		
		end
		if (slot_6a ~= 1 and slot_6a ~= "1") and (slot_6a ~= 0 and slot_6a ~= "0") then 	
		 unitID_slot_6a= Spring.CreateUnit(slot_6a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot6a
		 Spring.SetGameRulesParam("ud_statusslot6a", slot_6a)	
		 Spring.SetGameRulesParam("ud_idslot6a", unitID_slot_6a)		 		 
		else
		 Spring.SetGameRulesParam("ud_statusslot6a", "vuoto")		
		end
		if (slot_7a ~= 1 and slot_7a ~= "1") and (slot_7a ~= 0 and slot_7a ~= "0") then 	
		 unitID_slot_7a= Spring.CreateUnit(slot_7a,spawnCoorx,0,spawnCoorz-deploy_radius,0,teamID_slota)																								-- imposto lo slot7a
		 Spring.SetGameRulesParam("ud_statusslot7a", slot_7a)	
		 Spring.SetGameRulesParam("ud_idslot7a", unitID_slot_7a)		 		 
		else
		 Spring.SetGameRulesParam("ud_statusslot7a", "vuoto")		
		end
		if (slot_8a ~= 1 and slot_8a ~= "1") and (slot_8a ~= 0 and slot_8a ~= "0") then 		 
		 unitID_slot_8a= Spring.CreateUnit(slot_8a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot8a
		 Spring.SetGameRulesParam("ud_statusslot8a", slot_8a)	
		 Spring.SetGameRulesParam("ud_idslot8a", unitID_slot_8a)		 		 		 
		else
		 Spring.SetGameRulesParam("ud_statusslot8a", "vuoto")		
		end	 
	  else																																																-- altrimenti se non ha trovato corrispondenza invia messaggio di errore
--		Spring.Echo( "ATTENZIONE: giocatore proprietario dello slot a '" .. slota_playername .. "' non trovato nella partita." )																		-- debug, il proprietario dello slota (definito dalla lobby) non è stato trovato nel game
	  end
	
	end  -- end if slota_playername
Spring.SendCommands("wmrts_slotstatupdt")			-- aggiorniamo il widget	
end -- end game start

--------------------------------------------------------------------------------
-- Unità distrutta
--------------------------------------------------------------------------------
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)     															-- questa funzione viene chiamata ogni qualvolta viene distrutta una unità
  if unitID_slot_1a and unitID == unitID_slot_1a then  																	-- se l' ID dell'unita distrutta (unitID) corrisponde all' ID dell'unità contenuta nello slot 1a allora...
--    Spring.Echo("GADGET: Unità slot_1a distrutta. Invio messaggio al widget.")											-- messaggio di debug
    Spring.SetGameRulesParam("ud_statusslot1a", "destroy")																-- imposto lo stato della regola Unit Deploy stato slot 1a (ud_statusslot1a)
	Spring.SendCommands("wmrts_slotstatupdt")																			-- invio il comando al widget che servirà a loro per aggiornare lo stato degli slots
  end
  if unitID_slot_2a and unitID == unitID_slot_2a then  																	-- ripeto per slot 2
    Spring.SetGameRulesParam("ud_statusslot2a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_3a and unitID == unitID_slot_3a then  																	-- ripeto per slot 3
    Spring.SetGameRulesParam("ud_statusslot3a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_4a and unitID == unitID_slot_4a then  																	-- ripeto per slot 4
    Spring.SetGameRulesParam("ud_statusslot4a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_5a and unitID == unitID_slot_5a then  																	-- ripeto per slot 5
    Spring.SetGameRulesParam("ud_statusslot5a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_6a and unitID == unitID_slot_6a then  																	-- ripeto per slot 6
    Spring.SetGameRulesParam("ud_statusslot6a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_7a and unitID == unitID_slot_7a then  																	-- ripeto per slot 7
    Spring.SetGameRulesParam("ud_statusslot7a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_8a and unitID == unitID_slot_8a then  																	-- ripeto per slot 8
    Spring.SetGameRulesParam("ud_statusslot8a", "destroy")
	Spring.SendCommands("wmrts_slotstatupdt")	
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