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
-- slota
local slot_1a = Spring.GetModOptions().slot_1a or 0 						-- Leggo dal file di script.txt scritto dalla lobby di War Machines RTS. La variabile può essere da lobby: 0 -> slot intattivo della missione; 1 -> slot vuoto, l'utente non ha caricato alcuna unità; "nomeunità" -> lo slot contiene l'unità
local slot_2a = Spring.GetModOptions().slot_2a or 0
local slot_3a = Spring.GetModOptions().slot_3a or 0
local slot_4a = Spring.GetModOptions().slot_4a or 0
local slot_5a = Spring.GetModOptions().slot_5a or 0
local slot_6a = Spring.GetModOptions().slot_6a or 0
local slot_7a = Spring.GetModOptions().slot_7a or 0
local slot_8a = Spring.GetModOptions().slot_8a or 0
-- slotb
local slot_1b = Spring.GetModOptions().slot_1b or "vuoto"
local slot_2b = Spring.GetModOptions().slot_2b or "vuoto"
local slot_3b = Spring.GetModOptions().slot_3b or "vuoto"
local slot_4b = Spring.GetModOptions().slot_4b or "vuoto"
local slot_5b = Spring.GetModOptions().slot_5b or "vuoto"
local slot_6b = Spring.GetModOptions().slot_6b or "vuoto"
local slot_7b = Spring.GetModOptions().slot_7b or "vuoto"
local slot_8b = Spring.GetModOptions().slot_8b or "vuoto"
local deploy_radius = 100 								-- deployement radius from initial starting units
-- slota
local unitID_slot_1a =  "0"								-- Assegno un ID fittizio, serve a non mandare in errore il widget in fase di "Initialize" (solo la prima volta in caricamento) in quanto cerca subito i valori nome unità e ID.
local unitID_slot_2a =  "0"								-- dal gamestart queste variabili prenderanno i giusti valori impostati nelle rispettive funzioni di controllo
local unitID_slot_3a =  "0"	
local unitID_slot_4a =  "0"	
local unitID_slot_5a =  "0"	
local unitID_slot_6a =  "0"	
local unitID_slot_7a =  "0"	
local unitID_slot_8a =  "0"	
-- slotb
local unitID_slot_1b =  "0"								-- Assegno un ID fittizio, serve a non mandare in errore il widget in fase di "Initialize" (solo la prima volta in caricamento) in quanto cerca subito i valori nome unità e ID.
local unitID_slot_2b =  "0"								-- dal gamestart queste variabili prenderanno i giusti valori impostati nelle rispettive funzioni di controllo
local unitID_slot_3b =  "0"	
local unitID_slot_4b =  "0"	
local unitID_slot_5b =  "0"	
local unitID_slot_6b =  "0"	
local unitID_slot_7b =  "0"	
local unitID_slot_8b =  "0"	

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

-- controllo se l'opzione unit deploy è abilitata nel file script.txt (impostato dalla lobby), in caso negativo chiudo il gadget
  if (isunitsdeployed == 0) 	then
	Spring.Echo("Gadged disabled<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<") -- ########################### testare ########################
    gadgetHandler:RemoveGadget()
	return false -- disattivo il gadget
  end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
 -- All'inizio imposto solamente i nomi dell'unità, cosi vengono inviati correttamente i dati al widget in fase di inizializzazione, altrimenti il widget andrebbe in errore e non carica.
 -- Faccio questa operazione in quanto il widget deve caricare i dati in fase di "initialize", considerando anche il caso di reset del widget
	if slota_playername  then																																											-- se giocatore proprietario degli slotA esiste
	  local teamID_slota = GetTeamIDFromPlayerName(slota_playername) 																																	-- richiamo la funzione per verificare a quale ID appartiene il giocatore a (settato poi da client)
	  if teamID_slota then 			 																																									-- se ha trovato corrispondenza assegna le unità al giocatore a
		if (slot_1a ~= 1 and slot_1a ~= "1") and (slot_1a ~= 0 and slot_1a ~= "1") then 																												-- se nello slot 1 è presente il nome dell'unità (e non è ne 1 o 0 sia numero che stringa "1" o "0") 				
--		 unitID_slot_1a = Spring.CreateUnit(slot_1a,spawnCoorx+deploy_radius,0,spawnCoorz,0,teamID_slota)		-- spostato in gamestart altrimenti risultano unità "comandante" che incidono sull' endgame	-- creo l'unità dello slot1a definendone l'ID dell'unità (memorizzata in unitID_slot_1a). Per la posizione ho usato il teorema dei seni, in lua però devo convertire gli angoli in radianti
		 Spring.SetGameRulesParam("ud_unitnameslot1a", slot_1a)																																			-- setto il gamerule per lo slot1a = nome unità assegnata (verrà poi letto dal widget)
		 Spring.SetGameRulesParam("ud_statusslot1a", "active")	
		 Spring.SetGameRulesParam("ud_idslot1a", unitID_slot_1a)																																		-- in fase di inizializzazione questo ID gamerules prenderà il valore inizializzato in fase di dichiarazione. Non è il vero e proprio ID dell'unità, che ancora non esiste, ma permette al widget di non ricevere variabili NIL e non andare in errore in fase di caricamento iniziale.
		 Spring.Echo( "imposto da GADGET slot_1a= "..slot_1a.." e id= "..unitID_slot_1a)
		else
		 Spring.SetGameRulesParam("ud_unitnameslot1a", "vuoto")																																			-- altrimenti setto il gamerule per lo slot1a = vuoto (verrà poi letto dal widget)	
		end
		if (slot_2a ~= 1 and slot_2a ~= "1") and (slot_2a ~= 0 and slot_2a ~= "0") then 																												
--		 unitID_slot_2a= Spring.CreateUnit(slot_2a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot2a 
		 Spring.SetGameRulesParam("ud_unitnameslot2a", slot_2a)	
		 Spring.SetGameRulesParam("ud_statusslot2a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot2a", unitID_slot_2a)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot2a", "vuoto")		
		end
		if (slot_3a ~= 1 and slot_3a ~= "1") and (slot_3a ~= 0 and slot_3a ~= "0") then 	
--		 unitID_slot_3a= Spring.CreateUnit(slot_3a,spawnCoorx,0,spawnCoorz+deploy_radius,0,teamID_slota)																								-- imposto lo slot3a
		 Spring.SetGameRulesParam("ud_unitnameslot3a", slot_3a)	
		 Spring.SetGameRulesParam("ud_statusslot3a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot3a", unitID_slot_3a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot3a", "vuoto")		
		end
		if (slot_4a ~= 1 and slot_4a ~= "1") and (slot_4a ~= 0 and slot_4a ~= "0") then 	
--		 unitID_slot_4a= Spring.CreateUnit(slot_4a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot4a
		 Spring.SetGameRulesParam("ud_unitnameslot4a", slot_4a)	
		 Spring.SetGameRulesParam("ud_statusslot4a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot4a", unitID_slot_4a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot4a", "vuoto")		
		end
		if (slot_5a ~= 1 and slot_5a ~= "1") and (slot_5a ~= 0 and slot_5a ~= "0") then 	
--		 unitID_slot_5a= Spring.CreateUnit(slot_5a,spawnCoorx-deploy_radius,0,spawnCoorz,0,teamID_slota)																								-- imposto lo slot5a
		 Spring.SetGameRulesParam("ud_unitnameslot5a", slot_5a)
		 Spring.SetGameRulesParam("ud_statusslot5a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot5a", unitID_slot_5a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot5a", "vuoto")		
		end
		if (slot_6a ~= 1 and slot_6a ~= "1") and (slot_6a ~= 0 and slot_6a ~= "0") then 	
--		 unitID_slot_6a= Spring.CreateUnit(slot_6a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot6a
		 Spring.SetGameRulesParam("ud_unitnameslot6a", slot_6a)	
		 Spring.SetGameRulesParam("ud_statusslot6a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot6a", unitID_slot_6a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot6a", "vuoto")		
		end
		if (slot_7a ~= 1 and slot_7a ~= "1") and (slot_7a ~= 0 and slot_7a ~= "0") then 	
--		 unitID_slot_7a= Spring.CreateUnit(slot_7a,spawnCoorx,0,spawnCoorz-deploy_radius,0,teamID_slota)																								-- imposto lo slot7a
		 Spring.SetGameRulesParam("ud_unitnameslot7a", slot_7a)	
		 Spring.SetGameRulesParam("ud_statusslot7a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot7a", unitID_slot_7a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot7a", "vuoto")		
		end
		if (slot_8a ~= 1 and slot_8a ~= "1") and (slot_8a ~= 0 and slot_8a ~= "0") then 		 
--		 unitID_slot_8a= Spring.CreateUnit(slot_8a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot8a
		 Spring.SetGameRulesParam("ud_unitnameslot8a", slot_8a)	
		 Spring.SetGameRulesParam("ud_statusslot8a", "active")			 
		 Spring.SetGameRulesParam("ud_idslot8a", unitID_slot_8a)		 		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot8a", "vuoto")		
		end	 
	  else																																																-- altrimenti se non ha trovato corrispondenza invia messaggio di errore
--		Spring.Echo( "ATTENZIONE: giocatore proprietario dello slot a '" .. slota_playername .. "' non trovato nella partita." )																		-- debug, il proprietario dello slota (definito dalla lobby) non è stato trovato nel game
	  end
	end  -- end if slota_playername
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
 -- All'inizio imposto solamente i nomi dell'unità, cosi vengono inviati correttamente i dati al widget in fase di inizializzazione, altrimenti il widget andrebbe in errore e non carica.
 -- Faccio questa operazione in quanto il widget deve caricare i dati in fase di "initialize", considerando anche il caso di reset del widget
	if slotb_playername  then																																											-- se giocatore proprietario degli slotB esiste
	  local teamID_slotb = GetTeamIDFromPlayerName(slotb_playername) 																																	-- richiamo la funzione per verificare a quale ID appartiene il giocatore a (settato poi da client)
	  if teamID_slotb then 			 																																									-- se ha trovato corrispondenza assegna le unità al giocatore a
		if (slot_1b ~= 1 and slot_1b ~= "1") and (slot_1b ~= 0 and slot_1b ~= "1") then 																												-- se nello slot 1 è presente il nome dell'unità (e non è ne 1 o 0 sia numero che stringa "1" o "0") 				
		 Spring.SetGameRulesParam("ud_unitnameslot1b", slot_1b)																																			-- setto il gamerule per lo slot1b = nome unità assegnata (verrà poi letto dal widget)
		 Spring.SetGameRulesParam("ud_statusslot1b", "active")	
		 Spring.SetGameRulesParam("ud_idslot1b", unitID_slot_1b)																																		-- in fase di inizializzazione questo ID gamerules prenderà il valore inizializzato in fase di dichiarazione. Non è il vero e proprio ID dell'unità, che ancora non esiste, ma permette al widget di non ricevere variabili NIL e non andare in errore in fase di caricamento iniziale.
		 Spring.Echo("WMRTS_DEBUG_ID1:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_1b)		 
--		 Spring.Echo( "imposto da GADGET slot_1b= "..slot_1b.." e id= "..unitID_slot_1b) -- debug #############
		else
		 Spring.SetGameRulesParam("ud_unitnameslot1b", "vuoto")																																			-- altrimenti setto il gamerule per lo slot1b = vuoto (verrà poi letto dal widget)	
		end
		if (slot_2b ~= 1 and slot_2b ~= "1") and (slot_2b ~= 0 and slot_2b ~= "0") then 																												
		 Spring.SetGameRulesParam("ud_unitnameslot2b", slot_2b)	
		 Spring.SetGameRulesParam("ud_statusslot2b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot2b", unitID_slot_2b)	
		 Spring.Echo("WMRTS_DEBUG_ID2:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)			 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot2b", "vuoto")		
		end
		if (slot_3b ~= 1 and slot_3b ~= "1") and (slot_3b ~= 0 and slot_3b ~= "0") then 	
		 Spring.SetGameRulesParam("ud_unitnameslot3b", slot_3b)	
		 Spring.SetGameRulesParam("ud_statusslot3b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot3b", unitID_slot_3b)		
		 Spring.Echo("WMRTS_DEBUG_ID3:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)	 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot3b", "vuoto")		
		end
		if (slot_4b ~= 1 and slot_4b ~= "1") and (slot_4b ~= 0 and slot_4b ~= "0") then 	
		 Spring.SetGameRulesParam("ud_unitnameslot4b", slot_4b)	
		 Spring.SetGameRulesParam("ud_statusslot4b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot4b", unitID_slot_4b)	
		 Spring.Echo("WMRTS_DEBUG_ID4:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)			 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot4b", "vuoto")		
		end
		if (slot_5b ~= 1 and slot_5b ~= "1") and (slot_5b ~= 0 and slot_5b ~= "0") then 	
		 Spring.SetGameRulesParam("ud_unitnameslot5b", slot_5b)
		 Spring.SetGameRulesParam("ud_statusslot5b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot5b", unitID_slot_5b)	
		 Spring.Echo("WMRTS_DEBUG_ID5:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)			 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot5b", "vuoto")		
		end
		if (slot_6b ~= 1 and slot_6b ~= "1") and (slot_6b ~= 0 and slot_6b ~= "0") then 	
		 Spring.SetGameRulesParam("ud_unitnameslot6b", slot_6b)	
		 Spring.SetGameRulesParam("ud_statusslot6b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot6b", unitID_slot_6b)		
		 Spring.Echo("WMRTS_DEBUG_ID6:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)	 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot6b", "vuoto")		
		end
		if (slot_7b ~= 1 and slot_7b ~= "1") and (slot_7b ~= 0 and slot_7b ~= "0") then 	
		 Spring.SetGameRulesParam("ud_unitnameslot7b", slot_7b)	
		 Spring.SetGameRulesParam("ud_statusslot7b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot7b", unitID_slot_7b)	
		 Spring.Echo("WMRTS_DEBUG_ID7:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)			 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot7b", "vuoto")		
		end
		if (slot_8b ~= 1 and slot_8b ~= "1") and (slot_8b ~= 0 and slot_8b ~= "0") then 		 
		 Spring.SetGameRulesParam("ud_unitnameslot8b", slot_8b)	
		 Spring.SetGameRulesParam("ud_statusslot8b", "active")			 
		 Spring.SetGameRulesParam("ud_idslot8b", unitID_slot_8b)	
		 Spring.Echo("WMRTS_DEBUG_ID8:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"..unitID_slot_2b)			 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot8b", "vuoto")		
		end	 
	  else																																																-- altrimenti se non ha trovato corrispondenza invia messaggio di errore
--		Spring.Echo( "ATTENZIONE: giocatore proprietario dello slot b '" .. slotb_playername .. "' non trovato nella partita." )																		-- debug, il proprietario dello slotb (definito dalla lobby) non è stato trovato nel game
	  end
	
	end  -- end if slotb_playername	
	Spring.SendCommands("wmrts_slotstatupdt")			-- aggiorniamo il widget  
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
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
	if slota_playername  then																																											-- se giocatore proprietario degli slotA esiste
	  local teamID_slota = GetTeamIDFromPlayerName(slota_playername) -- richiamo la funzione per verificare a quale ID appartiene il giocatore a (settato poi da client)
	  if teamID_slota then 			 																																									-- se ha trovato corrispondenza assegna le unità al giocatore a
		 Spring.Echo( "Trovato! Il giocatore '" .. slota_playername .. "' è nel team con ID: " .. tostring(teamID_slota).." e che parte dalla posizione x:" .. tostring(spawnCoorx).. " e z: ".. tostring(spawnCoorz) ) 	-- debug
		if (slot_1a ~= 1 and slot_1a ~= "1") and (slot_1a ~= 0 and slot_1a ~= "1") then 																												-- se nello slot 1 è presente il nome dell'unità (e non è ne 1 o 0 sia numero che stringa "1" o "0") 				
		 unitID_slot_1a = Spring.CreateUnit(slot_1a,spawnCoorx+deploy_radius,0,spawnCoorz,0,teamID_slota)							 																	-- creo l'unità dello slot1a definendone l'ID dell'unità (memorizzata in unitID_slot_1a). Per la posizione ho usato il teorema dei seni, in lua però devo convertire gli angoli in radianti
		 Spring.SetGameRulesParam("ud_unitnameslot1a", slot_1a)																																			-- setto il gamerule per lo slot1a = nome unità assegnata (verrà poi letto dal widget)
		 Spring.SetGameRulesParam("ud_statusslot1a", "ACTIVE")			 																																-- setto il gamerulo per lo stato dello slotXa (attivo, distrutto)
		 Spring.SetGameRulesParam("ud_idslot1a", unitID_slot_1a)																																		-- setto il gamerule per l'ID dell' unità assegnata allo slot1a (verrà poi letto dal widget per catturare le informazioni sulla posizione dell'unita x)
		else
		 Spring.SetGameRulesParam("ud_unitnameslot1a", "vuoto")																																			-- altrimenti setto il gamerule per lo slot1a = vuoto (verrà poi letto dal widget)	
		end
		if (slot_2a ~= 1 and slot_2a ~= "1") and (slot_2a ~= 0 and slot_2a ~= "0") then 																												
		 unitID_slot_2a= Spring.CreateUnit(slot_2a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot2a 
		 Spring.SetGameRulesParam("ud_unitnameslot2a", slot_2a)	
		 Spring.SetGameRulesParam("ud_statusslot2a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot2a", unitID_slot_2a)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot2a", "vuoto")		
		end
		if (slot_3a ~= 1 and slot_3a ~= "1") and (slot_3a ~= 0 and slot_3a ~= "0") then 	
		 unitID_slot_3a= Spring.CreateUnit(slot_3a,spawnCoorx,0,spawnCoorz+deploy_radius,0,teamID_slota)																								-- imposto lo slot3a
		 Spring.SetGameRulesParam("ud_unitnameslot3a", slot_3a)	
		 Spring.SetGameRulesParam("ud_statusslot3a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot3a", unitID_slot_3a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot3a", "vuoto")		
		end
		if (slot_4a ~= 1 and slot_4a ~= "1") and (slot_4a ~= 0 and slot_4a ~= "0") then 	
		 unitID_slot_4a= Spring.CreateUnit(slot_4a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot4a
		 Spring.SetGameRulesParam("ud_unitnameslot4a", slot_4a)	
		 Spring.SetGameRulesParam("ud_statusslot4a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot4a", unitID_slot_4a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot4a", "vuoto")		
		end
		if (slot_5a ~= 1 and slot_5a ~= "1") and (slot_5a ~= 0 and slot_5a ~= "0") then 	
		 unitID_slot_5a= Spring.CreateUnit(slot_5a,spawnCoorx-deploy_radius,0,spawnCoorz,0,teamID_slota)																								-- imposto lo slot5a
		 Spring.SetGameRulesParam("ud_unitnameslot5a", slot_5a)	
		 Spring.SetGameRulesParam("ud_statusslot5a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot5a", unitID_slot_5a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot5a", "vuoto")		
		end
		if (slot_6a ~= 1 and slot_6a ~= "1") and (slot_6a ~= 0 and slot_6a ~= "0") then 	
		 unitID_slot_6a= Spring.CreateUnit(slot_6a,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot6a
		 Spring.SetGameRulesParam("ud_unitnameslot6a", slot_6a)	
		 Spring.SetGameRulesParam("ud_statusslot6a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot6a", unitID_slot_6a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot6a", "vuoto")		
		end
		if (slot_7a ~= 1 and slot_7a ~= "1") and (slot_7a ~= 0 and slot_7a ~= "0") then 	
		 unitID_slot_7a= Spring.CreateUnit(slot_7a,spawnCoorx,0,spawnCoorz-deploy_radius,0,teamID_slota)																								-- imposto lo slot7a
		 Spring.SetGameRulesParam("ud_unitnameslot7a", slot_7a)	
		 Spring.SetGameRulesParam("ud_statusslot7a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot7a", unitID_slot_7a)		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot7a", "vuoto")		
		end
		if (slot_8a ~= 1 and slot_8a ~= "1") and (slot_8a ~= 0 and slot_8a ~= "0") then 		 
		 unitID_slot_8a= Spring.CreateUnit(slot_8a,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slota)									-- imposto lo slot8a
		 Spring.SetGameRulesParam("ud_unitnameslot8a", slot_8a)	
		 Spring.SetGameRulesParam("ud_statusslot8a", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot8a", unitID_slot_8a)		 		 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot8a", "vuoto")		
		end	 
	  else																																																-- altrimenti se non ha trovato corrispondenza invia messaggio di errore
--		Spring.Echo( "ATTENZIONE: giocatore proprietario dello slot a '" .. slota_playername .. "' non trovato nella partita." )																		-- debug, il proprietario dello slota (definito dalla lobby) non è stato trovato nel game
	  end
	
	end  -- end if slota_playername
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	  
	if slotb_playername  then																																											-- se giocatore proprietario degli slotb esiste
	  local teamID_slotb = GetTeamIDFromPlayerName(slotb_playername) -- richiamo la funzione per verificare a quale ID appartiene il giocatore a (settato poi da client)
	  if teamID_slotb then 			 																																									-- se ha trovato corrispondenza assegna le unità al giocatore a
		 Spring.Echo( "Trovato! Il giocatore '" .. slotb_playername .. "' è nel team con ID: " .. tostring(teamID_slotb).." e che parte dalla posizione x:" .. tostring(spawnCoorx).. " e z: ".. tostring(spawnCoorz) ) 	-- debug
		if (slot_1b ~= 1 and slot_1b ~= "1") and (slot_1b ~= 0 and slot_1b ~= "1") then 																												-- se nello slot 1 è presente il nome dell'unità (e non è ne 1 o 0 sia numero che stringa "1" o "0") 				
		 unitID_slot_1b = Spring.CreateUnit(slot_1b,spawnCoorx+deploy_radius,0,spawnCoorz,0,teamID_slotb)							 																	-- creo l'unità dello slot1b definendone l'ID dell'unità (memorizzata in unitID_slot_1b). Per la posizione ho usato il teorema dei seni, in lua però devo convertire gli angoli in radianti
		 Spring.SetGameRulesParam("ud_unitnameslot1b", slot_1b)																																			-- setto il gamerule per lo slot1b = nome unità assegnata (verrà poi letto dal widget)
		 Spring.SetGameRulesParam("ud_statusslot1b", "ACTIVE")			 																																-- setto il gamerulo per lo stato dello slotXa (attivo, distrutto)
		 Spring.SetGameRulesParam("ud_idslot1b", unitID_slot_1b)																																		-- setto il gamerule per l'ID dell' unità assegnata allo slot1b (verrà poi letto dal widget per catturare le informazioni sulla posizione dell'unita x)
--		 Spring.Echo( "WMRTS_DEBUG_ID1:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_1b= "..slot_1b.." e id= "..unitID_slot_1b)
		else
		 Spring.SetGameRulesParam("ud_unitnameslot1b", "vuoto")																																			-- altrimenti setto il gamerule per lo slot1b = vuoto (verrà poi letto dal widget)	
		end
		if (slot_2b ~= 1 and slot_2b ~= "1") and (slot_2b ~= 0 and slot_2b ~= "0") then 																												
		 unitID_slot_2b= Spring.CreateUnit(slot_2b,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slotb)									-- imposto lo slot2b 
		 Spring.SetGameRulesParam("ud_unitnameslot2b", slot_2b)	
		 Spring.SetGameRulesParam("ud_statusslot2b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot2b", unitID_slot_2b)		
		 Spring.Echo( "WMRTS_DEBUG_ID2:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_2b= "..slot_2b.." e id= "..unitID_slot_2b)	 
		else
--		 Spring.SetGameRulesParam("ud_unitnameslot2b", "vuoto")		
		end
		if (slot_3b ~= 1 and slot_3b ~= "1") and (slot_3b ~= 0 and slot_3b ~= "0") then 	
		 unitID_slot_3b= Spring.CreateUnit(slot_3b,spawnCoorx,0,spawnCoorz+deploy_radius,0,teamID_slotb)																								-- imposto lo slot3b
		 Spring.SetGameRulesParam("ud_unitnameslot3b", slot_3b)	
		 Spring.SetGameRulesParam("ud_statusslot3b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot3b", unitID_slot_3b)	
--		 Spring.Echo( "WMRTS_DEBUG_ID3:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_3b= "..slot_3b.." e id= "..unitID_slot_3b)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot3b", "vuoto")		
		end
		if (slot_4b ~= 1 and slot_4b ~= "1") and (slot_4b ~= 0 and slot_4b ~= "0") then 	
		 unitID_slot_4b= Spring.CreateUnit(slot_4b,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz+deploy_radius * math.sin(math.rad(45)),0,teamID_slotb)									-- imposto lo slot4b
		 Spring.SetGameRulesParam("ud_unitnameslot4b", slot_4b)	
		 Spring.SetGameRulesParam("ud_statusslot4b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot4b", unitID_slot_4b)		
--		 Spring.Echo( "WMRTS_DEBUG_ID4:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_4b= "..slot_4b.." e id= "..unitID_slot_4b) 		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot4b", "vuoto")		
		end
		if (slot_5b ~= 1 and slot_5b ~= "1") and (slot_5b ~= 0 and slot_5b ~= "0") then 	
		 unitID_slot_5b= Spring.CreateUnit(slot_5b,spawnCoorx-deploy_radius,0,spawnCoorz,0,teamID_slotb)																								-- imposto lo slot5b
		 Spring.SetGameRulesParam("ud_unitnameslot5b", slot_5b)	
		 Spring.SetGameRulesParam("ud_statusslot5b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot5b", unitID_slot_5b)	
--		 Spring.Echo( "WMRTS_DEBUG_ID5:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_5b= "..slot_5b.." e id= "..unitID_slot_5b)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot5b", "vuoto")		
		end
		if (slot_6b ~= 1 and slot_6b ~= "1") and (slot_6b ~= 0 and slot_6b ~= "0") then 	
		 unitID_slot_6b= Spring.CreateUnit(slot_6b,spawnCoorx-deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slotb)									-- imposto lo slot6b
		 Spring.SetGameRulesParam("ud_unitnameslot6b", slot_6b)	
		 Spring.SetGameRulesParam("ud_statusslot6b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot6b", unitID_slot_6b)		 	
--		 Spring.Echo( "WMRTS_DEBUG_ID6:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_6b= "..slot_6b.." e id= "..unitID_slot_6b)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot6b", "vuoto")		
		end
		if (slot_7b ~= 1 and slot_7b ~= "1") and (slot_7b ~= 0 and slot_7b ~= "0") then 	
		 unitID_slot_7b= Spring.CreateUnit(slot_7b,spawnCoorx,0,spawnCoorz-deploy_radius,0,teamID_slotb)																								-- imposto lo slot7b
		 Spring.SetGameRulesParam("ud_unitnameslot7b", slot_7b)	
		 Spring.SetGameRulesParam("ud_statusslot7b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot7b", unitID_slot_7b)	
--		 Spring.Echo( "WMRTS_DEBUG_ID7:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_7b= "..slot_7b.." e id= "..unitID_slot_7b)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot7b", "vuoto")		
		end
		if (slot_8b ~= 1 and slot_8b ~= "1") and (slot_8b ~= 0 and slot_8b ~= "0") then 		 
		 unitID_slot_8b= Spring.CreateUnit(slot_8b,spawnCoorx+deploy_radius* math.sin(math.rad(45)),0,spawnCoorz-deploy_radius * math.sin(math.rad(45)),0,teamID_slotb)									-- imposto lo slot8b
		 Spring.SetGameRulesParam("ud_unitnameslot8b", slot_8b)	
		 Spring.SetGameRulesParam("ud_statusslot8b", "ACTIVE")			 
		 Spring.SetGameRulesParam("ud_idslot8b", unitID_slot_8b)	
--		 Spring.Echo( "WMRTS_DEBUG_ID8:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> imposto da GADGET slot_8b= "..slot_8b.." e id= "..unitID_slot_8b)		 
		else
		 Spring.SetGameRulesParam("ud_unitnameslot8b", "vuoto")		
		end	 
	  else																																																-- altrimenti se non ha trovato corrispondenza invia messaggio di errore
--		Spring.Echo( "ATTENZIONE: giocatore proprietario dello slot a '" .. slotb_playername .. "' non trovato nella partita." )																		-- debug, il proprietario dello slotb (definito dalla lobby) non è stato trovato nel game
	  end
	
	end  -- end if slotb_playername	
Spring.SendCommands("wmrts_slotstatupdt")			-- aggiorniamo il widget	
end -- end game start

--------------------------------------------------------------------------------
-- Unità distrutta
--------------------------------------------------------------------------------
function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)     															-- questa funzione viene chiamata ogni qualvolta viene distrutta una unità
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if unitID_slot_1a and unitID == unitID_slot_1a then  																	-- se l' ID dell'unita distrutta (unitID) corrisponde all' ID dell'unità contenuta nello slot 1a allora...
--    Spring.Echo("GADGET: Unità slot_1a distrutta. Invio messaggio al widget.")											-- messaggio di debug
    Spring.SetGameRulesParam("ud_statusslot1a", "DESTROYED")																-- ...imposto lo stato della regola Unit Deploy stato slot 1a (ud_unitnameslot1a)
	Spring.SendCommands("wmrts_slotstatupdt")																			-- invio il comando al widget che servirà a loro per aggiornare lo stato degli slots
  end
  if unitID_slot_2a and unitID == unitID_slot_2a then  																	-- ripeto per slot 2
    Spring.SetGameRulesParam("ud_statusslot2a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_3a and unitID == unitID_slot_3a then  																	-- ripeto per slot 3
    Spring.SetGameRulesParam("ud_statusslot3a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_4a and unitID == unitID_slot_4a then  																	-- ripeto per slot 4
    Spring.SetGameRulesParam("ud_statusslot4a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_5a and unitID == unitID_slot_5a then  																	-- ripeto per slot 5
    Spring.SetGameRulesParam("ud_statusslot5a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_6a and unitID == unitID_slot_6a then  																	-- ripeto per slot 6
    Spring.SetGameRulesParam("ud_statusslot6a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_7a and unitID == unitID_slot_7a then  																	-- ripeto per slot 7
    Spring.SetGameRulesParam("ud_statusslot7a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_8a and unitID == unitID_slot_8a then  																	-- ripeto per slot 8
    Spring.SetGameRulesParam("ud_statusslot8a", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end  
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  if unitID_slot_1b and unitID == unitID_slot_1b then  
    Spring.SetGameRulesParam("ud_statusslot1b", "DESTROYED")																-- ...imposto lo stato della regola Unit Deploy stato slot 1b (ud_unitnameslot1b)
	Spring.SendCommands("wmrts_slotstatupdt")																			-- invio il comando al widget che servirà a loro per aggiornare lo stato degli slots
  end
  if unitID_slot_2b and unitID == unitID_slot_2b then  																	-- ripeto per slot 2
    Spring.SetGameRulesParam("ud_statusslot2b", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_3b and unitID == unitID_slot_3b then  																	-- ripeto per slot 3
    Spring.SetGameRulesParam("ud_statusslot3b", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_4b and unitID == unitID_slot_4b then  																	-- ripeto per slot 4
    Spring.SetGameRulesParam("ud_statusslot4b", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_5b and unitID == unitID_slot_5b then  																	-- ripeto per slot 5
    Spring.SetGameRulesParam("ud_statusslot5b", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_6b and unitID == unitID_slot_6b then  																	-- ripeto per slot 6
    Spring.SetGameRulesParam("ud_statusslot6b", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_7b and unitID == unitID_slot_7b then  																	-- ripeto per slot 7
    Spring.SetGameRulesParam("ud_statusslot7b", "DESTROYED")
	Spring.SendCommands("wmrts_slotstatupdt")	
  end
  if unitID_slot_8b and unitID == unitID_slot_8b then  																	-- ripeto per slot 8
    Spring.SetGameRulesParam("ud_statusslot8b", "DESTROYED")
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