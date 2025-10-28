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
local altezza_deploymenu				= 250								-- altezza
local Pos_x_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local lato_quadrato_slots				= 71								-- è la larghezza fissa dello slot definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local margine_slots_sx					= 13 								-- margine sinistro della serie di slots a sinistra, definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local margine_slots_dx					= 367 								-- margine sinistro della serie di slots a destra, definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local interasse_slots					= 12								-- spazio tra uno slot e l'altro dello stesso team
local altezza_secriga					= 147								-- dal basso, altezza seconda riga degli slots dal margine inferiore definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local altezza_pririga					= 33								-- dal basso, altezza prima riga degli slots dal margine inferiore definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local posx_selettore_slots 				= 20
local posy_selettore_slots 				= 20
local selettore_slots_visibile = false										-- riquadro selezione slot visibile on/off
local selettore_buttons_visibile = false									-- riquadro selezione pulsante chiudi visibile on/off

local slota_playername = Spring.GetModOptions().slota_owner or nil	 		-- verifico chi è il nome giocatore proprietario degli slot player A
local slotb_playername = Spring.GetModOptions().slotb_owner or nil		 	-- verifico chi è il nome giocatore proprietario degli slot player B
local nomeunita_slot1a				= "1"									-- nome unità contenuta nello slot 1a, verrà definita in seguito tramite game rules. "1" di default (slot vuoto / unità non dispiegata)
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

-- impostazione dei fonts
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

-- impostazione del file di scrittura
local nomeFile = "destroyedlist.wmr"  										-- definisco il file che voglio scrivere

-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_menu_bkgnd.png"
local selettore_slots				= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_selettore.png"
local pulsante_close				= "LuaUI/Images/menu/mainmenu/menu_close.png"
local avatar_pla					= "LuaUI/Images/menu/mainmenu/menu_close.png" 				-- ######################################################### aggiungere codice come advplayerlist
local avatar_plb					= "LuaUI/Images/menu/mainmenu/menu_close.png"				-- ######################################################### aggiungere codice come advplayerlist


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
		nomeunita_slot1a = Spring.GetGameRulesParam("ud_unitnameslot1a") or "vuoto" 							-- ricevo l'immagine impostata nello slot 1a del gamerules, altrimenti imposta su "vuoto"
		if nomeunita_slot1a ~= "vuoto" then		-- se lo slot non è vuoto...
		slot1a_ID = Spring.GetGameRulesParam("ud_idslot1a")														-- ... imposta l'ID dell'unità (necessario poi per identificarla al click sullo slot)
		end
		-- slot2a
		nomeunita_slot2a = Spring.GetGameRulesParam("ud_unitnameslot2a") or "vuoto"
		if nomeunita_slot2a ~= "vuoto" then		
		slot2a_ID = Spring.GetGameRulesParam("ud_idslot2a")		
		end		
		-- slot3a
		nomeunita_slot3a = Spring.GetGameRulesParam("ud_unitnameslot3a") or "vuoto" 	
		if nomeunita_slot3a ~= "vuoto" then		
		slot3a_ID = Spring.GetGameRulesParam("ud_idslot3a")
		end		
		-- slot4a
		nomeunita_slot4a = Spring.GetGameRulesParam("ud_unitnameslot4a") or "vuoto"
		if nomeunita_slot4a ~= "vuoto" then		
		slot4a_ID = Spring.GetGameRulesParam("ud_idslot4a")
		end		
		-- slot5a
		nomeunita_slot5a = Spring.GetGameRulesParam("ud_unitnameslot5a") or "vuoto"
		if nomeunita_slot5a ~= "vuoto" then		
		slot5a_ID = Spring.GetGameRulesParam("ud_idslot5a")
		end		
		-- slot6a
		nomeunita_slot6a = Spring.GetGameRulesParam("ud_unitnameslot6a") or "vuoto"
		if nomeunita_slot6a ~= "vuoto" then		
		slot6a_ID = Spring.GetGameRulesParam("ud_idslot6a")	
		end		
		-- slot7a
		nomeunita_slot7a = Spring.GetGameRulesParam("ud_unitnameslot7a") 	or "vuoto"
		if nomeunita_slot7a ~= "vuoto" then		
		slot7a_ID = Spring.GetGameRulesParam("ud_idslot7a")
		end		
		-- slot8a
		nomeunita_slot8a = Spring.GetGameRulesParam("ud_unitnameslot8a") or "vuoto"	
		if nomeunita_slot8a ~= "vuoto" then		
		slot8a_ID = Spring.GetGameRulesParam("ud_idslot8a")	
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
-- SEMPRE ##############################################
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
	-- slot_1 sx button
		if ((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_2 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_3 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_4 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false			

	-- slot_5 sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_6 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_7 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_8 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots
					selettore_slots_visibile = true
					selettore_buttons_visibile = false		
		end -- condizioni if mouse etc
	end -- diary menu attivo etc
end -- function update

--------------------------------------
-- MOUSE IS OVER BUTTONS ###################################################
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile graphicsmenu_attivo è true.....
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
			-- slot_1 sx
			return 
			
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
			
	end --is gui hidden
end

--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX) ###########################################
--------------------------------------
function widget:MousePress(x, y, button)
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
	  if (Spring.GetGameSeconds() < 0.1) then
		return false
	  end
		if button== 1 then 
			if (widget:IsAbove(x, y)) then
				-- clicco su slot1a button	--------------------------------------------------------------------------------------------
				if ((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot1a ~= 1) and (ud_unitnameslot1a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot1a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot2a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot2a ~= 1) and (ud_unitnameslot2a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot2a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot3a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot3a ~= 1) and (ud_unitnameslot3a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot3a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot4a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot4a ~= 1) and (ud_unitnameslot4a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot4a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				-- clicco su slot5a button	--------------------------------------------------------------------------------------------
				if ((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot5a ~= 1) and (ud_unitnameslot5a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot5a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot6a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot6a ~= 1) and (ud_unitnameslot6a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot6a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot7a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot7a ~= 1) and (ud_unitnameslot7a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot7a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot8a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (ud_unitnameslot8a ~= 1) and (ud_unitnameslot8a ~= "destroy") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slot8a_ID] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end					
				return true				
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
--[[	-- ricevo prima il numero di pagine totali della categoria "mappa" disponibili per la lettura
		nomeunita_slot1a = Spring.GetGameRulesParam("ud_unitnameslot1a") 	--ricevo l'immagine impostata nello slot 1a del gamerules
--		Spring.Echo("WMRTS Debug: dal WIDGET ---- l unità ricevuta è: "..nomeunita_slot1a)
		slot1a_ID = Spring.GetGameRulesParam("ud_idslot1a")			
		-- slot2a
		nomeunita_slot2a = Spring.GetGameRulesParam("ud_unitnameslot2a") 	
		slot2a_ID = Spring.GetGameRulesParam("ud_idslot2a")				
		-- slot3a
		nomeunita_slot3a = Spring.GetGameRulesParam("ud_unitnameslot3a") 	
		slot3a_ID = Spring.GetGameRulesParam("ud_idslot3a")		
		-- slot4a
		nomeunita_slot4a = Spring.GetGameRulesParam("ud_unitnameslot4a") 	
		slot4a_ID = Spring.GetGameRulesParam("ud_idslot4a")		
		-- slot5a
		nomeunita_slot5a = Spring.GetGameRulesParam("ud_unitnameslot5a") 	
		slot5a_ID = Spring.GetGameRulesParam("ud_idslot5a")		
		-- slot6a
		nomeunita_slot6a = Spring.GetGameRulesParam("ud_unitnameslot6a") 	
		slot6a_ID = Spring.GetGameRulesParam("ud_idslot6a")		
		-- slot7a
		nomeunita_slot7a = Spring.GetGameRulesParam("ud_unitnameslot7a") 	
		slot7a_ID = Spring.GetGameRulesParam("ud_idslot7a")		
		-- slot8a
		nomeunita_slot8a = Spring.GetGameRulesParam("ud_unitnameslot8a") 	
		slot8a_ID = Spring.GetGameRulesParam("ud_idslot8a")				
	end
	]]--
		slota()										-- richiama funzione che aggiorna stato slot player_a
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
				WG['guishader_api'].RemoveRect('WMRTS_diary_shad')
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
	-- inserisco lo slot1a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot1a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot2a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot2a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot3a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot3a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot4a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot4a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot5a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot5a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot6a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot6a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot7a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot7a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- inserisco lo slot8a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..nomeunita_slot8a..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	-- se il selettore slot è attivo, disegnalo nella posizione registrata in precedenza
		if selettore_slots_visibile then 
		gl.Color(1,1,1,1)
		gl.Texture(selettore_slots)	
		gl.TexRect(	posx_selettore_slots, posy_selettore_slots,posx_selettore_slots+lato_quadrato_slots, posy_selettore_slots+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
		end
	-- disegno il pulsante close
		if selettore_slots_visibile then 
		gl.Color(1,1,1,1)
		gl.Texture(pulsante_close)	
		gl.TexRect(	Pos_x_mainmenu+500, Pos_y_mainmenu+50,Pos_x_mainmenu+500+76, Pos_y_mainmenu+50+25)	
		gl.Texture(false)	-- fine texture		
		end		
	-- disegno l'avatar giocatore a
		gl.Color(1,1,1,1)
		gl.Texture(avatar_pla)	
		gl.TexRect(	Pos_x_mainmenu+318, Pos_y_mainmenu+231,Pos_x_mainmenu+318+16, Pos_y_mainmenu+231+16)	
		gl.Texture(false)	-- fine texture		
	-- disegno l'avatar giocatore b
		gl.Color(1,1,1,1)
		gl.Texture(avatar_plb)	
		gl.TexRect(	Pos_x_mainmenu+366, Pos_y_mainmenu+231,Pos_x_mainmenu+366+16, Pos_y_mainmenu+231+16)	
		gl.Texture(false)	-- fine texture	
	--	testi slots player a
		font_generale:Begin()
		-- slot 1
		font_generale:Print(("NAME"), Pos_x_mainmenu +45 , Pos_y_mainmenu+9, 9, "ocn") 
		font_generale:Print(("STATUS"), Pos_x_mainmenu +45 , Pos_y_mainmenu+15, 9, "ocn") 
		font_generale:Print(("SLOT 1"), Pos_x_mainmenu +45 , Pos_y_mainmenu+20, 9, "ocn") 		
--
--		[...] inserire tutti gli altri slots ##########################################
--		
		-- slot 5
		font_generale:Print(("NAME"), Pos_x_mainmenu +45 , Pos_y_mainmenu+9, 9, "ocn") 
		font_generale:Print(("STATUS"), Pos_x_mainmenu +45 , Pos_y_mainmenu+15, 9, "ocn") 
		font_generale:Print(("SLOT 5"), Pos_x_mainmenu +45 , Pos_y_mainmenu+20, 9, "ocn") 			
		font_generale:End()	
	-- gui shader	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_deploymenu,Pos_y_mainmenu+altezza_deploymenu,'WMRTS_diary_shad')
		end
	end -- if deployedunitsmenu_attivo	
end --drawscreen