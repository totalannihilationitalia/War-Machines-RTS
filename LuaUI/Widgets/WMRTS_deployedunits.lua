--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_deployableunits.lua
--  brief:   interface for deployable unit in scenario
--  author:  Dario Molinaroli ( Molixx81 )
--	WARNING: set "wmrtsunitdeploy = 1;" in modoption to activate diary button in minumenu widget !!!!!!!!!!!!! WMRTS = nil or 0 -> isskirmish, =1 -> iscampaign; = 2 -> isscenario
--  Copyright (C) 2025.
--  Licensed under the terms of the GNU GPL, v2 or later.
--	require gadget: createdeployedunitsatstart.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_deployedunits",
    desc      = "WMRTS deployed units",
    author    = "molixx81",
    date      = "20 Ottobre, 2025",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

-- 20/10/2025: released version 1 - Molix

--[[ to do list
#### -- all  :)
Questo widget gestisce le unità dispiegate dal garage per le missioni scenario, monitorandone la posizione, se sono state distrutte ecc

]]--

-- definizione dei comandi
local Echo 								= Spring.Echo 
-- definizione variabili di posizione e lunghezza menu e icone
local deployedunitsmenu_attivo			= true		 						-- Indica se questo menu è attivo o meno
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local larghezza_deploymenu				= 700 								-- larghezza
local altezza_deploymenu				= 270								-- altezza
local Pos_x_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local lato_quadrato_slots				= 71								-- è la larghezza fissa dello slot definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local margine_slots_sx					= 13 								-- margine sinistro della serie di slots a sinistra, definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local margine_slots_dx					= 367 								-- margine sinistro della serie di slots a destra, definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local interasse_slots					= 12								-- spazio tra uno slot e l'altro dello stesso team
local altezza_secriga					= 147+20								-- dal basso, altezza seconda riga degli slots dal margine inferiore definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local altezza_pririga					= 33+20								-- dal basso, altezza prima riga degli slots dal margine inferiore definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local posx_selettore_slots 				= 20
local posy_selettore_slots 				= 20
local selettore_slots_visibile = false										-- riquadro selezione slot visibile on/off
local selettore_buttons_visibile = false									-- riquadro selezione pulsante chiudi visibile on/off

local slota_playername = Spring.GetModOptions().slota_owner or nil	 		-- verifico chi è il nome giocatore proprietario degli slot player A
local slotb_playername = Spring.GetModOptions().slotb_owner or nil		 	-- verifico chi è il nome giocatore proprietario degli slot player B
-- SLOT A
local nomeunita_slot1a				= "1"									-- nome unità contenuta nello slot 1a, verrà definita in seguito tramite game rules. 
local nomeunita_slot2a				= "1"	
local nomeunita_slot3a				= "1"	
local nomeunita_slot4a				= "1"	
local nomeunita_slot5a				= "1"	
local nomeunita_slot6a				= "1"	
local nomeunita_slot7a				= "1"	
local nomeunita_slot8a				= "1"	
local slot1a_ID						= "0"									-- ID dell'unità contenuta nello slot1a
local slot2a_ID						= "0"
local slot3a_ID						= "0"
local slot4a_ID						= "0"
local slot5a_ID						= "0"
local slot6a_ID						= "0"
local slot7a_ID						= "0"
local slot8a_ID						= "0"
local stato_slot1a					= "0"									-- stato dell'unità contenuta nello slot 1a
local stato_slot2a					= "0"
local stato_slot3a					= "0"
local stato_slot4a					= "0"
local stato_slot5a					= "0"
local stato_slot6a					= "0"
local stato_slot7a					= "0"
local stato_slot8a					= "0"
-- SLOT B
local nomeunita_slot1b				= "1"									-- nome unità contenuta nello slot 1a, verrà definita in seguito tramite game rules. 
local nomeunita_slot2b				= "1"	
local nomeunita_slot3b				= "1"	
local nomeunita_slot4b				= "1"	
local nomeunita_slot5b				= "1"	
local nomeunita_slot6b				= "1"	
local nomeunita_slot7b				= "1"	
local nomeunita_slot8b				= "1"	
local slot1b_ID						= "0"									-- ID dell'unità contenuta nello slot1b
local slot2b_ID						= "0"
local slot3b_ID						= "0"
local slot4b_ID						= "0"
local slot5b_ID						= "0"
local slot6b_ID						= "0"
local slot7b_ID						= "0"
local slot8b_ID						= "0"
local stato_slot1b					= "0"									-- stato dell'unità contenuta nello slot 1b
local stato_slot2b					= "0"
local stato_slot3b					= "0"
local stato_slot4b					= "0"
local stato_slot5b					= "0"
local stato_slot6b					= "0"
local stato_slot7b					= "0"
local stato_slot8b					= "0"

-- impostazione dei fonts
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

-- impostazione del file di scrittura
local nomeFile = "destroyedlist.wmr"  										-- definisco il file che voglio scrivere

-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_menu_bkgnd.png"
local button_sel					= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"
local selettore_slots				= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_selettore.png"
local pulsante_close				= "LuaUI/Images/menu/mainmenu/menu_close.png"
local avatar_pla					= "LuaUI/Images/menu/mainmenu/menu_close.png" 				-- ######################################################### aggiungere codice come advplayerlist
local avatar_plb					= "LuaUI/Images/menu/mainmenu/menu_close.png"				-- ######################################################### aggiungere codice come advplayerlist
local slot_cross					= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_destroy.png"
local slot_empty					= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_empty.png"


--------------------------------------
-- FUNZIONE CHECK STATO OPZIONI, viene richiamata in diverse fasi dello script per controllare lo stato delle opzioni 
--------------------------------------
local function check_options()
--[[
############## inserire solo l'opzione autopopup on/off appena la si realizza!!!! #########################
-- all'inizio verifico anche il valore delle configurazioni
  valore_mapshading = Spring.GetConfigInt("AdvMapShading", 1)			-- booleano di default è true
  valore_unitshading = Spring.GetConfigInt("AdvModelShading", 1)			-- booleano di default è true
  valore_grass = Spring.GetConfigInt("GrassDetail", 1)   				-- booleano di default è true
  valore_hardwarecur = Spring.GetConfigInt("HardwareCursor", 0) 		-- booleano di default è falso
  valore_LUPS = Spring.GetConfigInt("LupsActive", 0) 					-- booleano di default è falso -> disattivo successivamente anche il Widget				## widget
  valore_bloom_shader = Spring.GetConfigInt("BloomshaderActive", 0)		-- booleano di default è falso -> disattivo successivamente anche il Widget			## widget
  valore_show_projeclight = Spring.GetConfigInt("ShowProjectile", 0)	-- booleano di default è falso  -> disattivo successivamente anche il Widget	## widget
  valore_xray = Spring.GetConfigInt("XrayActive", 0)					-- booleano di default è falso  -> disattivo successivamente anche il Widget			## widget
  valore_fullscreen = Spring.GetConfigInt("Fullscreen", 1) 				-- booleano di default è true
  valore_blinking = Spring.GetConfigInt("teamhighlight", 1)   			-- booleano di default è true
  valore_shadows = Spring.GetConfigInt("Shadows", 2) 					-- -1:=forceoff, 0:=off, 1:=full, 2:=fast (skip terrain)
  valore_showenvironmental = Spring.GetConfigInt("EnviroActive", 0)		-- booleano di default è falso ->  -> disattivo successivamente anche il Widget			## widget
  valore_antialiasing = Spring.GetConfigInt("MSAALevel", 0) 			-- valori da 0 a 32 MAX
  valore_watertype = Spring.GetConfigInt("Water", 1) 					-- Defines the type of water rendering. Can be set in game. Options are: 0 = Basic water, 1 = Reflective water, 2 = Reflective and Refractive water, 3 = Dynamic water, 4 = Bumpmapped water
  valore_vsynk = Spring.GetConfigInt("VSync", 0)   						-- valori 1 o 0 (default) abilita o disabilita standard VSynk
  valore_mapborders = Spring.GetConfigInt("MapBorder", 1)   			-- valori 1 (default) o 0 abilita o disabilita bordi della mappa
]]--
end

-- funzione per aggiornare gli slot del giocatore "a" (host). Setta il nome dell'unità e l'id dell'unità, se presente
function slota()
		-- slot1a
		nomeunita_slot1a = Spring.GetGameRulesParam("ud_unitnameslot1a") or "vuoto" 							-- dal gadget posso ricevere la variabile inerente al nome dell'unità o la variabile "vuoto" che indica slot non impostato o volutamente lasciato vuoto
		if nomeunita_slot1a ~= "vuoto" then		-- se lo slot non è vuoto...
		slot1a_ID = Spring.GetGameRulesParam("ud_idslot1a")														-- ... imposta l'ID dell'unità (necessario poi per identificarla al click sullo slot) ...
		stato_slot1a = Spring.GetGameRulesParam("ud_statusslot1a")												-- ... e imposta lo stato dell'unità (attivo, distrutto, ecc)
		end
		-- slot2a
		nomeunita_slot2a = Spring.GetGameRulesParam("ud_unitnameslot2a") or "vuoto"
		if nomeunita_slot2a ~= "vuoto" then		
		slot2a_ID = Spring.GetGameRulesParam("ud_idslot2a")		
		stato_slot2a = Spring.GetGameRulesParam("ud_statusslot2a")			
		end		
		-- slot3a
		nomeunita_slot3a = Spring.GetGameRulesParam("ud_unitnameslot3a") or "vuoto" 	
		if nomeunita_slot3a ~= "vuoto" then		
		slot3a_ID = Spring.GetGameRulesParam("ud_idslot3a")
		stato_slot3a = Spring.GetGameRulesParam("ud_statusslot3a")	
		end		
		-- slot4a
		nomeunita_slot4a = Spring.GetGameRulesParam("ud_unitnameslot4a") or "vuoto"
		if nomeunita_slot4a ~= "vuoto" then		
		slot4a_ID = Spring.GetGameRulesParam("ud_idslot4a")
		stato_slot4a = Spring.GetGameRulesParam("ud_statusslot4a")	
		end		
		-- slot5a
		nomeunita_slot5a = Spring.GetGameRulesParam("ud_unitnameslot5a") or "vuoto"
		if nomeunita_slot5a ~= "vuoto" then		
		slot5a_ID = Spring.GetGameRulesParam("ud_idslot5a")
		stato_slot5a = Spring.GetGameRulesParam("ud_statusslot5a")	
		end		
		-- slot6a
		nomeunita_slot6a = Spring.GetGameRulesParam("ud_unitnameslot6a") or "vuoto"
		if nomeunita_slot6a ~= "vuoto" then		
		slot6a_ID = Spring.GetGameRulesParam("ud_idslot6a")	
		stato_slot6a = Spring.GetGameRulesParam("ud_statusslot6a")
		end		
		-- slot7a
		nomeunita_slot7a = Spring.GetGameRulesParam("ud_unitnameslot7a") 	or "vuoto"
		if nomeunita_slot7a ~= "vuoto" then		
		slot7a_ID = Spring.GetGameRulesParam("ud_idslot7a")
		stato_slot7a = Spring.GetGameRulesParam("ud_statusslot7a")
		end		
		-- slot8a
		nomeunita_slot8a = Spring.GetGameRulesParam("ud_unitnameslot8a") or "vuoto"	
		if nomeunita_slot8a ~= "vuoto" then		
		slot8a_ID = Spring.GetGameRulesParam("ud_idslot8a")	
		stato_slot8a = Spring.GetGameRulesParam("ud_statusslot8a")
		end		
end		

-- funzione per aggiornare gli slot del giocatore "b" (host). Setta il nome dell'unità e l'id dell'unità, se presente
function slotb()
		-- slot1b
		nomeunita_slot1b = Spring.GetGameRulesParam("ud_unitnameslot1b") or "vuoto" 							-- dal gadget posso ricevere la variabile inerente al nome dell'unità o la variabile "vuoto" che indica slot non impostato o volutamente lasciato vuoto
		if nomeunita_slot1b ~= "vuoto" then		-- se lo slot non è vuoto...
		slot1b_ID = Spring.GetGameRulesParam("ud_idslot1b")														-- ... imposta l'ID dell'unità (necessario poi per identificarla al click sullo slot) ...
		stato_slot1b = Spring.GetGameRulesParam("ud_statusslot1b")												-- ... e imposta lo stato dell'unità (attivo, distrutto, ecc)
		end
		-- slot2b
		nomeunita_slot2b = Spring.GetGameRulesParam("ud_unitnameslot2b") or "vuoto"
		if nomeunita_slot2b ~= "vuoto" then		
		slot2b_ID = Spring.GetGameRulesParam("ud_idslot2b")		
		stato_slot2b = Spring.GetGameRulesParam("ud_statusslot2b")			
		end		
		-- slot3b
		nomeunita_slot3b = Spring.GetGameRulesParam("ud_unitnameslot3b") or "vuoto" 	
		if nomeunita_slot3b ~= "vuoto" then		
		slot3b_ID = Spring.GetGameRulesParam("ud_idslot3b")
		stato_slot3b = Spring.GetGameRulesParam("ud_statusslot3b")	
		end		
		-- slot4b
		nomeunita_slot4b = Spring.GetGameRulesParam("ud_unitnameslot4b") or "vuoto"
		if nomeunita_slot4b ~= "vuoto" then		
		slot4b_ID = Spring.GetGameRulesParam("ud_idslot4b")
		stato_slot4b = Spring.GetGameRulesParam("ud_statusslot4b")	
		end		
		-- slot5b
		nomeunita_slot5b = Spring.GetGameRulesParam("ud_unitnameslot5b") or "vuoto"
		if nomeunita_slot5b ~= "vuoto" then		
		slot5b_ID = Spring.GetGameRulesParam("ud_idslot5b")
		stato_slot5b = Spring.GetGameRulesParam("ud_statusslot5b")	
		end		
		-- slot6b
		nomeunita_slot6b = Spring.GetGameRulesParam("ud_unitnameslot6b") or "vuoto"
		if nomeunita_slot6b ~= "vuoto" then		
		slot6b_ID = Spring.GetGameRulesParam("ud_idslot6b")	
		stato_slot6b = Spring.GetGameRulesParam("ud_statusslot6b")
		end		
		-- slot7b
		nomeunita_slot7b = Spring.GetGameRulesParam("ud_unitnameslot7b") 	or "vuoto"
		if nomeunita_slot7b ~= "vuoto" then		
		slot7b_ID = Spring.GetGameRulesParam("ud_idslot7b")
		stato_slot7b = Spring.GetGameRulesParam("ud_statusslot7b")
		end		
		-- slot8b
		nomeunita_slot8b = Spring.GetGameRulesParam("ud_unitnameslot8b") or "vuoto"	
		if nomeunita_slot8b ~= "vuoto" then		
		slot8b_ID = Spring.GetGameRulesParam("ud_idslot8b")	
		stato_slot8b = Spring.GetGameRulesParam("ud_statusslot8b")
		end		
end	

--------------------------------------
-- INIZIALIZZO IL MENU 
--------------------------------------
function widget:Initialize()
-- controllo se l'opzione attiva unit deploy è abilitata
	local isunitsdeployed = Spring.GetModOptions().wmrtsunitdeploy or 0  		-- verifico che la lobby abbia impostato la modalità "deploy units", serve per disattivare o meno questo widget.
	if (isunitsdeployed == 0) 	then
	  widgetHandler:RemoveWidget() -- disattivo il widget
	end
-- controllo se giocatore è inserito nella lista proprietario slot a o slot b, altrimenti rimuovi il widget
	local myplayerID = Spring.GetLocalPlayerID ( ) 										-- rilevo l'id del giocatore locale
	local playerInfo, isActive, isSpectator, teamID = Spring.GetPlayerInfo(myplayerID)	-- tramite l'id trovo il nome del giocatore locale
	if playerInfo == slota_playername then
	Spring.Echo("SlotA owner<<<<<<<<<<<<<<")
	slota()
	elseif playerInfo == slotb_playername then
	slota()
	slotb()	
	-- inserire funzione slotb() ###############
		Spring.Echo("SlotB owner<<<<<<<<<<<<<<<<<<<<<<<<")
	else
	widgetHandler:RemoveWidget() -- disattivo il widget
	end
	
-- all'inizio imposto la posizione del mini menu
	Pos_x_mainmenu = vsx/2 - larghezza_deploymenu/2
	Pos_y_mainmenu = vsy/2 - altezza_deploymenu/2
-- avvio la funzione check_options()
	check_options()	
-- creo il file 
	local file = io.open(nomeFile, "a")									-- apro il file, "a" significa "append mode" (il file viene creato in precedenza)
	file:write(" \n") 													-- vado a capo
	file:write("[destroyedlist]\n") 									-- scrivo l'intestazione del gruppo di informazioni ini
	file:close()												        -- chiudi il file. Questo salva le modifiche e "libera" il file. Se non lo fai, il file potrebbe rimanere vuoto!		
 end

--------------------------------------
-- AGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------
-- funzione aggiorno la posizione del minimenu button in alto a destra
local function UpdateGeometry() -- aggiorno geometria
  Pos_x_mainmenu = vsx/2 - larghezza_deploymenu/2
  Pos_y_mainmenu = vsy/2 - altezza_deploymenu/2
end

--- funzione rilevamento delle dimensioni della finestra durante il resizing
function widget:ViewResize(viewSizeX, viewSizeY) -- quando si modifica la dimensione della finestra di spring, prelevane larghezza e altezza e fai partire la funzione "aggiorno geometria"
  vsx = viewSizeX
  vsy = viewSizeY
  UpdateGeometry()
end

--------------------------------------
-- SEMPRE 
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- slot_1a sx button
		if ((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot1a ~= "vuoto") and (stato_slot1a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_2a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot2a ~= "vuoto") and (stato_slot2a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_3a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot3a ~= "vuoto") and (stato_slot3a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_4a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot4a ~= "vuoto") and (stato_slot4a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false			
			end
	-- slot_5a sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot5a ~= "vuoto") and (stato_slot5a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_6a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots-1+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot6a ~= "vuoto") and (stato_slot6a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_7a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot7a ~= "vuoto") and (stato_slot7a ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_8a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot8a ~= "vuoto") and (stato_slot8a ~= "DESTROYED") then
			posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- slot_1b sx button
		if ((mousex >= Pos_x_mainmenu+margine_slots_dx) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot1b ~= "vuoto") and (stato_slot1b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_2b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot2b ~= "vuoto") and (stato_slot2b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_3b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot3b ~= "vuoto") and (stato_slot3b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_4b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (nomeunita_slot4b ~= "vuoto") and (stato_slot4b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false			
			end
	-- slot_5b sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot5b ~= "vuoto") and (stato_slot5b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_6b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots-1+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot6b ~= "vuoto") and (stato_slot6b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_7b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot7b ~= "vuoto") and (stato_slot7b ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_8b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (nomeunita_slot8b ~= "vuoto") and (stato_slot8b ~= "DESTROYED") then
			posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end			
	-- pulsante close
		elseif ((mousex >= Pos_x_mainmenu+600) and (mousex <= Pos_x_mainmenu+600+76) and (mousey >= Pos_y_mainmenu-12) and (mousey <= Pos_y_mainmenu+25-12))  then
--					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3
--					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = false
					selettore_buttons_visibile = true	
	-- altrimenti nascondi tutti i selettori
		else
					selettore_slots_visibile = false
					selettore_buttons_visibile = false			
		end -- condizioni if mouse etc
	end -- diary menu attivo etc
end -- function update

--------------------------------------
-- MOUSE IS OVER BUTTONS ###################################################
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile graphicsmenu_attivo è true.....
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
			return 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			-- slot_1 sx			
			((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_2 sx
			((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_3 sx	
			((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_4 sx		
			((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_5 sx		
			((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_6 sx
			((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_7 sx
			((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_8 sx
			((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))			
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			-- slot_1 dx			
			((x >= Pos_x_mainmenu+margine_slots_dx) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_2 dx
			((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_3 dx	
			((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_4 dx		
			((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_5 dx		
			((x >= Pos_x_mainmenu+margine_slots_dx) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_6 dx
			((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_7 dx
			((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_8 dx
			((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))						
			or
			-- close button
			((mousex >= Pos_x_mainmenu+600) and (mousex <= Pos_x_mainmenu+600+76) and (mousey >= Pos_y_mainmenu-12) and (mousey <= Pos_y_mainmenu+25-12))
	end --is gui hidden
end

--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX)
--------------------------------------
function widget:MousePress(x, y, button)
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
	  if (Spring.GetGameSeconds() < 0.1) then
		return false
	  end
		if button== 1 then 
			if (widget:IsAbove(x, y)) then
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
				-- clicco su slot1a button	--------------------------------------------------------------------------------------------
				if ((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot1a ~= "vuoto") and (stato_slot1a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot1a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot2a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot2a ~= "vuoto") and (stato_slot2a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot2a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot3a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot3a ~= "vuoto") and (stato_slot3a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot3a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot4a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot4a ~= "vuoto") and (stato_slot4a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot4a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true		
				-- clicco su slot5a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot5a ~= "vuoto") and (stato_slot5a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot5a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot6a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot6a ~= "vuoto") and (stato_slot6a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot6a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot7a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot7a ~= "vuoto") and (stato_slot7a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot7a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot8a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot8a ~= "vuoto") and (stato_slot8a ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot8a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end					
				return true				
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				-- clicco su slot1b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot1b ~= "vuoto") and (stato_slot1b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot1b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot2b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot2b ~= "vuoto") and (stato_slot2b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot2b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot3b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot3b ~= "vuoto") and (stato_slot3b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot3b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot4b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot4b ~= "vuoto") and (stato_slot4b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot4b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true		
				-- clicco su slot5b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot5b ~= "vuoto") and (stato_slot5b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot5b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot6b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot6b ~= "vuoto") and (stato_slot6b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot6b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot7b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot7b ~= "vuoto") and (stato_slot7b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot7b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot8b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (nomeunita_slot8b ~= "vuoto") and (stato_slot8b ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot8b_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end		
				return true
				-- clicco close button
				elseif ((mousex >= Pos_x_mainmenu+600) and (mousex <= Pos_x_mainmenu+600+76) and (mousey >= Pos_y_mainmenu-12) and (mousey <= Pos_y_mainmenu+25-12)) then		
				deployedunitsmenu_attivo = false
					if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_deploymenu_shad')
					end	
				end
			end
		end
	end 
end

--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE INSERENDO LE SPIEGAZIONI DEI PULSANTI ----------------------------
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
	  if (Spring.GetGameSeconds() < 0.1) then
		return "Units deploy menu  (only works in game)"
	  else
		return "Units deploy menu"
	  end
	end
end

--[[ disattivo la funzione
--------------------------------------
-- RICEVO LE INFORMAZIONI DURANTE LA MISSIONE SULLE PAGINE TOTALI DISPONIBILI
--------------------------------------
function widget:GameFrame(frame)
	if frame%30 == 0 then

	end
end
]]--

--------------------------------------
-- GESTIONE DEI COMANDI SPRING RICEVUTI
--------------------------------------	
function widget:TextCommand(command)
-- comando aggiornamento unità
	if command == 'wmrts_slotstatupdt' then 							-- se ricevo un comando "wmrts_slotstatupdt" aggiorno gli slot guardando i gamerules
		slota()										-- richiama funzione che aggiorna stato slot player_a
		slotb()										-- richiama funzione che aggiorna stato slot player_a
	end
end

--------------------------------------
-- ALLA PRESSIONE DEI TASTI 
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
		if key == 0x01B then -- TASTO esc
			deployedunitsmenu_attivo = false 							-- chiudo il diario			
	--			Spring.SendCommands("close_wmrts_diary")			-- spengo il minipulsante del deploy menu del minimenu  ############################################################### da fare!!!
			-- disabilito il guishader
				if (WG['guishader_api'] ~= nil) then
				WG['guishader_api'].RemoveRect('WMRTS_deploymenu_shad')
				end	
			return true
		end
	end
return false
end

--------------------------------------
-- DISEGNO IL DEPLOY MENU
-------------------------------------- 
 function widget:DrawScreen()
	if deployedunitsmenu_attivo then -- se il main menu è attivo, allora disegnalo
	-- inserisco il background del mainmenu
		gl.Color(1,1,1,1)
		gl.Texture(backgroundmainmenu)	
		gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_deploymenu,Pos_y_mainmenu+altezza_deploymenu)	
		gl.Texture(false)	-- fine texture	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot A ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- inserisco prima tutte le scritte statiche
		font_generale:Begin()	
		font_generale:Print(("SLOT 1"), Pos_x_mainmenu +47 , Pos_y_mainmenu+240, 9, "ocn") 		
		font_generale:Print(("SLOT 2"), Pos_x_mainmenu +132 , Pos_y_mainmenu+240, 9, "ocn") 		
		font_generale:Print(("SLOT 3"), Pos_x_mainmenu +215 , Pos_y_mainmenu+240, 9, "ocn") 
		font_generale:Print(("SLOT 4"), Pos_x_mainmenu +298 , Pos_y_mainmenu+240, 9, "ocn") 				
		font_generale:Print(("SLOT 5"), Pos_x_mainmenu +47 , Pos_y_mainmenu+126, 9, "ocn") 
		font_generale:Print(("SLOT 6"), Pos_x_mainmenu +132 , Pos_y_mainmenu+126, 9, "ocn") 			
		font_generale:Print(("SLOT 7"), Pos_x_mainmenu +215 , Pos_y_mainmenu+126, 9, "ocn") 
		font_generale:Print(("SLOT 8"), Pos_x_mainmenu +298 , Pos_y_mainmenu+126, 9, "ocn") 		
		font_generale:End()		
	-- inserisco lo slot1a		
	if (nomeunita_slot1a ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot1a), Pos_x_mainmenu +47 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot1a), Pos_x_mainmenu +47 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot1a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +47 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +47 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	if (stato_slot1a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot2a	
	if (nomeunita_slot2a ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot2a), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot2a), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot2a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (stato_slot2a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot3a
	if (nomeunita_slot3a ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot3a), Pos_x_mainmenu +215 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot3a), Pos_x_mainmenu +215 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot3a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (stato_slot3a ==	 "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot4a
	if (nomeunita_slot4a ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot4a), Pos_x_mainmenu +298 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot4a), Pos_x_mainmenu +298 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot4a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (stato_slot4a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot5a
	if (nomeunita_slot5a ~= "vuoto") then	
		font_generale:Begin()
		font_generale:Print((nomeunita_slot5a), Pos_x_mainmenu +47 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot5a), Pos_x_mainmenu +47 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot5a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (stato_slot5a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot6a
	if (nomeunita_slot6a ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot6a), Pos_x_mainmenu +132 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot6a), Pos_x_mainmenu +132 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot6a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else	
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (stato_slot6a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot7a
	if (nomeunita_slot7a ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot7a), Pos_x_mainmenu +215 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot7a), Pos_x_mainmenu +215 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot7a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (stato_slot7a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot8a
	if (nomeunita_slot8a ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot8a), Pos_x_mainmenu +298 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot8a), Pos_x_mainmenu +298 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot8a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture				
	end		
	if (stato_slot8a == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end		
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- inserisco prima tutte le scritte statiche
		font_generale:Begin()	
		--------############################################### sistemare posizioni
		font_generale:Print(("SLOT 1"), 50+Pos_x_mainmenu +47 , Pos_y_mainmenu+240, 9, "ocn") 		
		font_generale:Print(("SLOT 2"), 50+Pos_x_mainmenu +132 , Pos_y_mainmenu+240, 9, "ocn") 		
		font_generale:Print(("SLOT 3"), 50+Pos_x_mainmenu +215 , Pos_y_mainmenu+240, 9, "ocn") 
		font_generale:Print(("SLOT 4"), 50+Pos_x_mainmenu +298 , Pos_y_mainmenu+240, 9, "ocn") 				
		font_generale:Print(("SLOT 5"), 50+Pos_x_mainmenu +47 , Pos_y_mainmenu+126, 9, "ocn") 
		font_generale:Print(("SLOT 6"), 50+Pos_x_mainmenu +132 , Pos_y_mainmenu+126, 9, "ocn") 			
		font_generale:Print(("SLOT 7"), 50+Pos_x_mainmenu +215 , Pos_y_mainmenu+126, 9, "ocn") 
		font_generale:Print(("SLOT 8"), 50+Pos_x_mainmenu +298 , Pos_y_mainmenu+126, 9, "ocn") 		
		font_generale:End()		
	-- inserisco lo slot1b		
	if (nomeunita_slot1b ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot1b), Pos_x_mainmenu +47 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot1b), Pos_x_mainmenu +47 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot1b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +47 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +47 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	if (stato_slot1b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot2b	
	if (nomeunita_slot2b ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot2b), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot2b), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot2b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (stato_slot2b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot3b
	if (nomeunita_slot3b ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot3b), Pos_x_mainmenu +215 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot3b), Pos_x_mainmenu +215 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot3b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (stato_slot3b ==	 "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot4b
	if (nomeunita_slot4b ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot4b), Pos_x_mainmenu +298 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((stato_slot4b), Pos_x_mainmenu +298 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot4b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (stato_slot4b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot5b
	if (nomeunita_slot5b ~= "vuoto") then	
		font_generale:Begin()
		font_generale:Print((nomeunita_slot5b), Pos_x_mainmenu +47 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot5b), Pos_x_mainmenu +47 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot5b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (stato_slot5b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot6b
	if (nomeunita_slot6b ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot6b), Pos_x_mainmenu +132 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot6b), Pos_x_mainmenu +132 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot6b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else	
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (stato_slot6b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot7b
	if (nomeunita_slot7b ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot7b), Pos_x_mainmenu +215 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot7b), Pos_x_mainmenu +215 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot7b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (stato_slot7b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot8b
	if (nomeunita_slot8b ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((nomeunita_slot8b), Pos_x_mainmenu +298 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((stato_slot8b), Pos_x_mainmenu +298 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot8b..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture				
	end		
	if (stato_slot8b == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end				
	-- se il selettore slot è attivo, disegnalo nella posizione registrata in precedenza
		if selettore_slots_visibile then 
		gl.Color(1,1,1,1)
		gl.Texture(selettore_slots)	
		gl.TexRect(	posx_selettore_slots, posy_selettore_slots,posx_selettore_slots+lato_quadrato_slots+2, posy_selettore_slots+lato_quadrato_slots+2)	
		gl.Texture(false)	-- fine texture		
		end
	-- disegno il pulsante close
		gl.Color(1,1,1,1)
		gl.Texture(pulsante_close)	
		gl.TexRect(	Pos_x_mainmenu+600, Pos_y_mainmenu-12,Pos_x_mainmenu+676, Pos_y_mainmenu+13)	
		gl.Texture(false)	-- fine texture		
	-- disegno l'hover pulsante close selezionato
		if selettore_buttons_visibile then 	
		gl.Color(1,1,1,1)
		gl.Texture(button_sel)	
		gl.TexRect(	Pos_x_mainmenu+600, Pos_y_mainmenu-12,Pos_x_mainmenu+676, Pos_y_mainmenu+13)	
		gl.Texture(false)	-- fine texture				
		end
	-- disegno l'avatar giocatore a
		gl.Color(1,1,1,1)
		gl.Texture(avatar_pla)	
		gl.TexRect(	Pos_x_mainmenu+318, Pos_y_mainmenu+251,Pos_x_mainmenu+318+16, Pos_y_mainmenu+251+16)	
		gl.Texture(false)	-- fine texture		
	-- disegno l'avatar giocatore b
		gl.Color(1,1,1,1)
		gl.Texture(avatar_plb)	
		gl.TexRect(	Pos_x_mainmenu+366, Pos_y_mainmenu+251,Pos_x_mainmenu+366+16, Pos_y_mainmenu+251+16)	
		gl.Texture(false)	-- fine texture	
	-- gui shader	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_deploymenu,Pos_y_mainmenu+altezza_deploymenu,'WMRTS_deploymenu_shad')
		end
	end -- if deployedunitsmenu_attivo	
end --drawscreen