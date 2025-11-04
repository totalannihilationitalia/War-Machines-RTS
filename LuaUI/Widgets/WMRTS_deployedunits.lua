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

local slotsDataA = {}														-- creo tabella slotsDataA
local slotsDataB = {}														-- creo tabella slotsDataB
for i = 1, 8 do																-- riempio provvisoriamente le tabelle
  slotsDataA[i] = { id = "0", status = "0", name = "vuoto" }
  slotsDataB[i] = { id = "0", status = "0", name = "vuoto" }
end
-- impostazione dei fonts
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

-- impostazione del file di scrittura
local nomeFile = "destroyedlist.wmr"  										-- definisco il file che voglio scrivere

-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_menu_bkgnd.png"
local button_sel					= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"
local selettore_slots				= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_selettore.png"
local pulsante_close				= "LuaUI/Images/menu/mainmenu/menu_close.png"
local slot_cross					= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_destroy.png"
local slot_empty					= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_empty.png"
local avatar_pla					= "av0"				
local avatar_plb					= "av0"				

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
-- riempio i dati tabella per ogni slot del gruppo a
 slotsDataA[1].name = Spring.GetGameRulesParam("ud_unitnameslot1a") or "vuoto" 	
		if slotsDataA[1].name ~= "vuoto" then		-- se lo slot non è vuoto...  
		 slotsDataA[1].id = Spring.GetGameRulesParam("ud_idslot1a")	
		 slotsDataA[1].status = Spring.GetGameRulesParam("ud_statusslot1a")	
		end
 slotsDataA[2].name = Spring.GetGameRulesParam("ud_unitnameslot2a") or "vuoto" 	
		if slotsDataA[2].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataA[2].id = Spring.GetGameRulesParam("ud_idslot2a")	
		 slotsDataA[2].status = Spring.GetGameRulesParam("ud_statusslot2a")	
		end
 slotsDataA[3].name = Spring.GetGameRulesParam("ud_unitnameslot3a") or "vuoto" 
		if slotsDataA[3].name ~= "vuoto" then		-- se lo slot non è vuoto... 
		 slotsDataA[3].id = Spring.GetGameRulesParam("ud_idslot3a")	
		 slotsDataA[3].status = Spring.GetGameRulesParam("ud_statusslot3a")	
		end
 slotsDataA[4].name = Spring.GetGameRulesParam("ud_unitnameslot4a") or "vuoto" 	
		if slotsDataA[4].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataA[4].id = Spring.GetGameRulesParam("ud_idslot4a")	
		 slotsDataA[4].status = Spring.GetGameRulesParam("ud_statusslot4a")	
		end
 slotsDataA[5].name = Spring.GetGameRulesParam("ud_unitnameslot5a") or "vuoto" 	
		if slotsDataA[5].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataA[5].id = Spring.GetGameRulesParam("ud_idslot5a")	
		 slotsDataA[5].status = Spring.GetGameRulesParam("ud_statusslot5a")	
		end
 slotsDataA[6].name = Spring.GetGameRulesParam("ud_unitnameslot6a") or "vuoto" 	
		if slotsDataA[6].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataA[6].id = Spring.GetGameRulesParam("ud_idslot6a")	
		 slotsDataA[6].status = Spring.GetGameRulesParam("ud_statusslot6a")	
		end
 slotsDataA[7].name = Spring.GetGameRulesParam("ud_unitnameslot7a") or "vuoto" 
		if slotsDataA[7].name ~= "vuoto" then		-- se lo slot non è vuoto... 
		 slotsDataA[7].id = Spring.GetGameRulesParam("ud_idslot7a")	
		 slotsDataA[7].status = Spring.GetGameRulesParam("ud_statusslot7a")	
		end
 slotsDataA[8].name = Spring.GetGameRulesParam("ud_unitnameslot8a") or "vuoto" 	
		if slotsDataA[8].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataA[8].id = Spring.GetGameRulesParam("ud_idslot8a")	
		 slotsDataA[8].status = Spring.GetGameRulesParam("ud_statusslot8a")	
		end
end		

-- funzione per aggiornare gli slot del giocatore "b" (client). Setta il nome dell'unità e l'id dell'unità, se presente
function slotb()
-- riempio i dati tabella per ogni slot del gruppo b
 slotsDataB[1].name = Spring.GetGameRulesParam("ud_unitnameslot1b") or "vuoto" 	
		if slotsDataB[1].name ~= "vuoto" then		-- se lo slot non è vuoto...  
		 slotsDataB[1].id = Spring.GetGameRulesParam("ud_idslot1b")	
		 slotsDataB[1].status = Spring.GetGameRulesParam("ud_statusslot1b")	
		end
 slotsDataB[2].name = Spring.GetGameRulesParam("ud_unitnameslot2b") or "vuoto" 	
		if slotsDataB[2].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataB[2].id = Spring.GetGameRulesParam("ud_idslot2b")	
		 slotsDataB[2].status = Spring.GetGameRulesParam("ud_statusslot2b")	
		end
 slotsDataB[3].name = Spring.GetGameRulesParam("ud_unitnameslot3b") or "vuoto" 
		if slotsDataB[3].name ~= "vuoto" then		-- se lo slot non è vuoto... 
		 slotsDataB[3].id = Spring.GetGameRulesParam("ud_idslot3b")	
		 slotsDataB[3].status = Spring.GetGameRulesParam("ud_statusslot3b")	
		end
 slotsDataB[4].name = Spring.GetGameRulesParam("ud_unitnameslot4b") or "vuoto" 	
		if slotsDataB[4].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataB[4].id = Spring.GetGameRulesParam("ud_idslot4b")	
		 slotsDataB[4].status = Spring.GetGameRulesParam("ud_statusslot4b")	
		end
 slotsDataB[5].name = Spring.GetGameRulesParam("ud_unitnameslot5b") or "vuoto" 	
		if slotsDataB[5].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataB[5].id = Spring.GetGameRulesParam("ud_idslot5b")	
		 slotsDataB[5].status = Spring.GetGameRulesParam("ud_statusslot5b")	
		end
 slotsDataB[6].name = Spring.GetGameRulesParam("ud_unitnameslot6b") or "vuoto" 	
		if slotsDataB[6].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataB[6].id = Spring.GetGameRulesParam("ud_idslot6b")	
		 slotsDataB[6].status = Spring.GetGameRulesParam("ud_statusslot6b")	
		end
 slotsDataB[7].name = Spring.GetGameRulesParam("ud_unitnameslot7b") or "vuoto" 
		if slotsDataB[7].name ~= "vuoto" then		-- se lo slot non è vuoto... 
		 slotsDataB[7].id = Spring.GetGameRulesParam("ud_idslot7b")	
		 slotsDataB[7].status = Spring.GetGameRulesParam("ud_statusslot7b")	
		end
 slotsDataB[8].name = Spring.GetGameRulesParam("ud_unitnameslot8b") or "vuoto" 	
		if slotsDataB[8].name ~= "vuoto" then		-- se lo slot non è vuoto...
		 slotsDataB[8].id = Spring.GetGameRulesParam("ud_idslot8b")	
		 slotsDataB[8].status = Spring.GetGameRulesParam("ud_statusslot8b")	
		end
end	

--------------------------------------------------------------------------------
-- FUNZIONE PER CODIFICA HEX
--------------------------------------------------------------------------------
function avatar_hex(str)
    if type(str) ~= "string" then
        return "INVALID_INPUT_TO_HEX" 
--		Spring.Echo("WMRTS_deployedunits error: not string submitted")
    end
    if #str == 0 then return "" end -- Stringa vuota rimane vuota

    local hex = ''
    for i = 1, #str do
        hex = hex .. string.format('%02x', string.byte(str, i))
    end
    return hex
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
	if slota_playername and (playerInfo == slota_playername) then
	slota()
	elseif playerInfo == slotb_playername then
	slotb()		
	else
	widgetHandler:RemoveWidget() -- disattivo il widget
	end
-- imposto gli avatar
	if slota_playername	then
		local avatar_pla_hex = "avatar_"..avatar_hex(slota_playername) or nil -- eseguo la funzione per impostare l'avatar, se per caso non dovesse essere scritta nel file script, imposta nil
		avatar_pla = Spring.GetModOptions()[avatar_pla_hex] or "av0"
	end
	if slotb_playername	then
		local avatar_plb_hex = "avatar_"..avatar_hex(slotb_playername) or nil 
		avatar_plb = Spring.GetModOptions()[avatar_plb_hex] or "av0"		
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
			if (slotsDataA[1].name ~= "vuoto") and (slotsDataA[1].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_2a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataA[2].name ~= "vuoto") and (slotsDataA[2].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_3a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataA[3].name ~= "vuoto") and (slotsDataA[3].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_4a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataA[4].name ~= "vuoto") and (slotsDataA[4].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false			
			end
	-- slot_5a sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataA[5].name ~= "vuoto") and (slotsDataA[5].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_6a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots-1+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataA[6].name ~= "vuoto") and (slotsDataA[6].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_7a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataA[7].name ~= "vuoto") and (slotsDataA[7].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_8a sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataA[8].name ~= "vuoto") and (slotsDataA[8].status ~= "DESTROYED") then
			posx_selettore_slots = Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- slot_1b sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataB[1].name ~= "vuoto") and (slotsDataB[1].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_2b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataB[2].name ~= "vuoto") and (slotsDataB[2].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_3b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataB[3].name ~= "vuoto") and (slotsDataB[3].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_4b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
			if (slotsDataB[4].name ~= "vuoto") and (slotsDataB[4].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_secriga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false			
			end
	-- slot_5b sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataB[5].name ~= "vuoto") and (slotsDataB[5].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_6b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots-1+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataB[6].name ~= "vuoto") and (slotsDataB[6].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_7b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataB[7].name ~= "vuoto") and (slotsDataB[7].status ~= "DESTROYED") then
					posx_selettore_slots = Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2-1
					posy_selettore_slots = Pos_y_mainmenu+altezza_pririga-1
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
			end
	-- slot_8b sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
			if (slotsDataB[8].name ~= "vuoto") and (slotsDataB[8].status ~= "DESTROYED") then
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
-- MOUSE IS OVER BUTTONS 
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
			or
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
			((x >= Pos_x_mainmenu+600) and (x <= Pos_x_mainmenu+600+76) and (y >= Pos_y_mainmenu-12) and (y <= Pos_y_mainmenu+25-12))			
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
					if (slotsDataA[1].name ~= "vuoto") and (slotsDataA[1].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[1].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot2a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[2].name ~= "vuoto") and (slotsDataA[2].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[2].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot3a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[3].name ~= "vuoto") and (slotsDataA[3].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[3].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot4a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[4].name ~= "vuoto") and (slotsDataA[4].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[4].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true		
				-- clicco su slot5a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[5].name ~= "vuoto") and (slotsDataA[5].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[5].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot6a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[6].name ~= "vuoto") and (slotsDataA[6].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[6].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot7a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[7].name ~= "vuoto") and (slotsDataA[7].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[7].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot8a button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataA[8].name ~= "vuoto") and (slotsDataA[8].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataA[8].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end					
				return true	
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- slot B ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				-- clicco su slot1b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[1].name ~= "vuoto") and (slotsDataB[1].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[1].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot2b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[2].name ~= "vuoto") and (slotsDataB[2].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[2].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot3b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[3].name ~= "vuoto") and (slotsDataB[3].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[3].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot4b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_secriga) and (y <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[4].name ~= "vuoto") and (slotsDataB[4].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[4].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true		
				-- clicco su slot5b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[5].name ~= "vuoto") and (slotsDataB[5].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[5].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot6b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[6].name ~= "vuoto") and (slotsDataB[6].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[6].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot7b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[7].name ~= "vuoto") and (slotsDataB[7].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[7].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end
				return true
				-- clicco su slot8b button	--------------------------------------------------------------------------------------------
				elseif ((x >= Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3) and (x <= Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (y >= Pos_y_mainmenu+altezza_pririga) and (y <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)) then
					-- inserire la condizione nel caso in cui l'unità è impostata (altrimenti se fosse morta e/o non dispiegata il widget da errore)
					if (slotsDataB[8].name ~= "vuoto") and (slotsDataB[8].status ~= "DESTROYED") then
					Spring.SendCommands("Deselect") 				-- deseleziono tutto
					Spring.SelectUnitMap({ [slotsDataB[8].id] = true })	-- seleziono l'unità dello slot
					Spring.SendCommands("track")					-- eseguo un track sull'unità dello slot 
					end		
				return true
				end
				
				-- clicco close button
				if ((mousex >= Pos_x_mainmenu+600) and (mousex <= Pos_x_mainmenu+600+76) and (mousey >= Pos_y_mainmenu-12) and (mousey <= Pos_y_mainmenu+25-12)) then		
				deployedunitsmenu_attivo = false
				Spring.SendCommands("close_wmrts_unitdepl")				
					if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_deploymenu_shad')
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
		slota()										-- richiama funzione che aggiorna stato slot player_a
		slotb()										-- richiama funzione che aggiorna stato slot player_b
	elseif command == 'open_wmrts_unitdepl' then 							-- se ricevo un comando "open_wmrts_unitdepl" apri la pagina deploy
		deployedunitsmenu_attivo = true
	elseif command == 'close_wmrts_unitdepl' then 							-- se ricevo un comando "open_wmrts_unitdepl" apri la pagina deploy
		deployedunitsmenu_attivo = false
	end		
end

--------------------------------------
-- ALLA PRESSIONE DEI TASTI 
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
		if key == 0x01B then -- TASTO esc
			deployedunitsmenu_attivo = false 							-- chiudo il deploymenu			
			Spring.SendCommands("close_wmrts_unitdepl")
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
	if (slotsDataA[1].name ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((slotsDataA[1].name), Pos_x_mainmenu +47 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataA[1].status), Pos_x_mainmenu +47 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[1].name..".wmr")	
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
	if (slotsDataA[1].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot2a	
	if (slotsDataA[2].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataA[2].name), Pos_x_mainmenu +132 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataA[2].status), Pos_x_mainmenu +132 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[2].name..".wmr")	
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
	if (slotsDataA[2].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot3a
	if (slotsDataA[3].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataA[3].name), Pos_x_mainmenu +215 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataA[3].status), Pos_x_mainmenu +215 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[3].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +215 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +215 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (slotsDataA[3].status ==	 "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot4a
	if (slotsDataA[4].name ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((slotsDataA[4].name), Pos_x_mainmenu +298 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataA[4].status), Pos_x_mainmenu +298 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[4].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +298 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +298 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (slotsDataA[4].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot5a
	if (slotsDataA[5].name ~= "vuoto") then	
		font_generale:Begin()
		font_generale:Print((slotsDataA[5].name), Pos_x_mainmenu +47 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataA[5].status), Pos_x_mainmenu +47 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[5].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +47 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +47 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (slotsDataA[5].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot6a
	if (slotsDataA[6].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataA[6].name), Pos_x_mainmenu +132 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataA[6].status), Pos_x_mainmenu +132 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[6].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else	
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +132 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +132 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (slotsDataA[6].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot7a
	if (slotsDataA[7].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataA[7].name), Pos_x_mainmenu +215 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataA[7].status), Pos_x_mainmenu +215 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[7].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +215 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +215 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (slotsDataA[7].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot8a
	if (slotsDataA[8].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataA[8].name), Pos_x_mainmenu +298 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataA[8].status), Pos_x_mainmenu +298 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataA[8].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +298 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +298 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture				
	end		
	if (slotsDataA[8].status == "DESTROYED") then -- se distrutta disegno la croce sopra
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
		font_generale:Print(("SLOT 1"), Pos_x_mainmenu +47+354 , Pos_y_mainmenu+240, 9, "ocn") 		
		font_generale:Print(("SLOT 2"), Pos_x_mainmenu +132+354 , Pos_y_mainmenu+240, 9, "ocn") 		
		font_generale:Print(("SLOT 3"), Pos_x_mainmenu +215+354 , Pos_y_mainmenu+240, 9, "ocn") 
		font_generale:Print(("SLOT 4"), Pos_x_mainmenu +298+354 , Pos_y_mainmenu+240, 9, "ocn") 				
		font_generale:Print(("SLOT 5"), Pos_x_mainmenu +47+354 , Pos_y_mainmenu+126, 9, "ocn") 
		font_generale:Print(("SLOT 6"), Pos_x_mainmenu +132+354 , Pos_y_mainmenu+126, 9, "ocn") 			
		font_generale:Print(("SLOT 7"), Pos_x_mainmenu +215+354 , Pos_y_mainmenu+126, 9, "ocn") 
		font_generale:Print(("SLOT 8"), Pos_x_mainmenu +298+354 , Pos_y_mainmenu+126, 9, "ocn") 		
		font_generale:End()		
	-- inserisco lo slot1b		
	if (slotsDataB[1].name ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((slotsDataB[1].name), Pos_x_mainmenu +401 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataB[1].status), Pos_x_mainmenu +401 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[1].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +401 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +401 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	if (slotsDataB[1].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot2b	
	if (slotsDataB[2].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataB[2].name), Pos_x_mainmenu +486 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataB[2].status), Pos_x_mainmenu +486 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[2].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +486 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +486 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (slotsDataB[2].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot3b
	if (slotsDataB[3].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataB[3].name), Pos_x_mainmenu +569 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataB[3].status), Pos_x_mainmenu +569 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[3].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +569 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +569 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (slotsDataB[3].status ==	 "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot4b
	if (slotsDataB[4].name ~= "vuoto") then
		font_generale:Begin()	
		font_generale:Print((slotsDataB[4].name), Pos_x_mainmenu +652 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print((slotsDataB[4].status), Pos_x_mainmenu +652 , Pos_y_mainmenu+145, 9, "ocn") 
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[4].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +652 , Pos_y_mainmenu+157, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +652 , Pos_y_mainmenu+145, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	end		
	if (slotsDataB[4].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot5b
	if (slotsDataB[5].name ~= "vuoto") then	
		font_generale:Begin()
		font_generale:Print((slotsDataB[5].name), Pos_x_mainmenu +401 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataB[5].status), Pos_x_mainmenu +401 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[5].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +401 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +401 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (slotsDataB[5].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot6b
	if (slotsDataB[6].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataB[6].name), Pos_x_mainmenu +486 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataB[6].status), Pos_x_mainmenu +486 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[6].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else	
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +486 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +486 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (slotsDataB[6].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end	
	-- inserisco lo slot7b
	if (slotsDataB[7].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataB[7].name), Pos_x_mainmenu +569 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataB[7].status), Pos_x_mainmenu +569 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[7].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +569 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +569 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture		
	end		
	if (slotsDataB[7].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture			
	end
	-- inserisco lo slot8b
	if (slotsDataB[8].name ~= "vuoto") then	
		font_generale:Begin()	
		font_generale:Print((slotsDataB[8].name), Pos_x_mainmenu +652 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print((slotsDataB[8].status), Pos_x_mainmenu +652 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()			
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/menu/unitsdeploy/"..slotsDataB[8].name..".wmr")	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture	
	else		
		font_generale:Begin()	
		font_generale:Print(("NOT"), Pos_x_mainmenu +652 , Pos_y_mainmenu+43, 9, "ocn") 
		font_generale:Print(("DEPLOYED"), Pos_x_mainmenu +652 , Pos_y_mainmenu+31, 9, "ocn") 	
		font_generale:End()		
		gl.Color(1,1,1,1)
		gl.Texture(slot_empty)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
		gl.Texture(false)	-- fine texture				
	end		
	if (slotsDataB[8].status == "DESTROYED") then -- se distrutta disegno la croce sopra
		gl.Color(1,1,1,1)
		gl.Texture(slot_cross)	
		gl.TexRect(	Pos_x_mainmenu+margine_slots_dx+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga,Pos_x_mainmenu+margine_slots_dx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3,Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots)	
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
		font_generale:Begin()	
		font_generale:SetTextColor(1,1,1,1)	
		font_generale:Print(("CLOSE"), Pos_x_mainmenu +645, Pos_y_mainmenu-3, 9, "ocn") -- close button
		font_generale:End()		
	-- disegno l'hover pulsante close selezionato
		if selettore_buttons_visibile then 	
		gl.Color(1,1,1,1)
		gl.Texture(button_sel)	
		gl.TexRect(	Pos_x_mainmenu+600, Pos_y_mainmenu-12,Pos_x_mainmenu+676, Pos_y_mainmenu+13)	
		gl.Texture(false)	-- fine texture				
		end
	-- disegno l'avatar giocatore a
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/advplayerslist/avatar/"..avatar_pla..".png")	
		gl.TexRect(	Pos_x_mainmenu+318, Pos_y_mainmenu+251,Pos_x_mainmenu+318+16, Pos_y_mainmenu+251+16)	
		gl.Texture(false)	-- fine texture		
		if slota_playername then
		font_generale:Begin()	
		font_generale:SetTextColor(1,1,1,1)	
		font_generale:Print("Owner of Slots A: "..slota_playername, Pos_x_mainmenu +310, Pos_y_mainmenu+256, 9, "orn") -- slot A owner
		font_generale:End()			
		else
		font_generale:Begin()	
		font_generale:SetTextColor(1,1,1,1)	
		font_generale:Print("Owner of Slots A: Unassigned player", Pos_x_mainmenu +310, Pos_y_mainmenu+256, 9, "orn") -- slot A owner
		font_generale:End()					
		end
	-- disegno l'avatar giocatore b
		gl.Color(1,1,1,1)
		gl.Texture("LuaUI/Images/advplayerslist/avatar/"..avatar_plb..".png")	
		gl.TexRect(	Pos_x_mainmenu+367, Pos_y_mainmenu+251,Pos_x_mainmenu+367+16, Pos_y_mainmenu+251+16)	
		gl.Texture(false)	-- fine texture		
		if slotb_playername then
		font_generale:Begin()	
		font_generale:SetTextColor(1,1,1,1)	
		font_generale:Print("Owner of Slots B: "..slotb_playername, Pos_x_mainmenu +390, Pos_y_mainmenu+256, 9, "oln") -- slot A owner
		font_generale:End()			
		else
		font_generale:Begin()	
		font_generale:SetTextColor(1,1,1,1)	
		font_generale:Print("Owner of Slots B: Unassigned player", Pos_x_mainmenu +390, Pos_y_mainmenu+256, 9, "oln") -- slot A owner
		font_generale:End()					
		end

	-- gui shader	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_deploymenu,Pos_y_mainmenu+altezza_deploymenu,'WMRTS_deploymenu_shad')
		end
	end -- if deployedunitsmenu_attivo	
end --drawscreen