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
local deployedunitsmenu_attivo			= false		 						-- Indica se questo menu è attivo o meno
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local larghezza_deploymenu				= 700 								-- larghezza
local altezza_deploymenu				= 250								-- altezza
local Pos_x_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local lato_quadrato_slots				= 71								-- è la larghezza fissa dello slot definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local margine_slots_sx					= 13 								-- margine sinistro della serie di slots a sinistra, definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local margine_slots_dx					= 367 								-- margine sinistro della serie di slots a destra, definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local interasse_slots					= 12								-- spazio tra uno slot e l'altro dello stesso team
local altezza_secriga					= 104								-- dal basso, altezza seconda riga degli slots dal margine inferiore definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local altezza_pririga					= 33								-- dal basso, altezza prima riga degli slots dal margine inferiore definita dall'immagine unitsdeploy_menu_bkgnd.png, vedere dimensioni_tabella_garage_slots.pdf per maggiori dettagli
local posx_selettore_slots = 20
local posy_selettore_slots = 20
local selettore_slots_visibile = false										-- riquadro selezione slot visibile on/off
local selettore_buttons_visibile = false									-- riquadro selezione pulsante chiudi visibile on/off

-- impostazione del file di scrittura
local nomeFile = "deployedlist.wmr"  										-- definisco il file che voglio scrivere

-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/unitsdeploy/unitsdeploy_menu_bkgnd.png"

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

--------------------------------------
-- INIZIALIZZO IL MENU 
--------------------------------------
function widget:Initialize()
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
  Pos_x_mainmenu = vsx/2 - larghezza_diarymenu/2
  Pos_y_mainmenu = vsy/2 - altezza_diarymenu/2
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
					posx_selettore_slots = Pos_x_mainmenu + -- configurarla manualmente ################################
					posy_selettore_slots = Pos_y_mainmenu + -- configurarla manualmente ################################
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_2 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + 
					posy_selettore_slots = Pos_y_mainmenu + 
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_3 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + 
					posy_selettore_slots = Pos_y_mainmenu + 
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_4 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + 
					posy_selettore_slots = Pos_y_mainmenu + 
					selettore_slots_visibile = true
					selettore_buttons_visibile = false			

	-- slot_5 sx button
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + -- configurarla manualmente ################################
					posy_selettore_slots = Pos_y_mainmenu + -- configurarla manualmente ################################
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_6 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + 
					posy_selettore_slots = Pos_y_mainmenu + 
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_7 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + 
					posy_selettore_slots = Pos_y_mainmenu + 
					selettore_slots_visibile = true
					selettore_buttons_visibile = false	
	-- slot_8 sx button					
		elseif ((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))  then
					posx_selettore_slots = Pos_x_mainmenu + 
					posy_selettore_slots = Pos_y_mainmenu + 
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
			((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_3 sx	
			((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_4 sx		
			((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_secriga) and (mousey <= Pos_y_mainmenu+altezza_secriga+lato_quadrato_slots))
			or
			-- slot_5 sx		
			((mousex >= Pos_x_mainmenu+margine_slots_sx) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_6 sx
			((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*1) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*1) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_7 sx
			((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*2) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*2) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))
			or
			-- slot_8 sx
			((mousex >= Pos_x_mainmenu+margine_slots_sx+(lato_quadrato_slots+interasse_slots)*3) and (mousex <= Pos_x_mainmenu+margine_slots_sx+lato_quadrato_slots+(lato_quadrato_slots+interasse_slots)*3) and (mousey >= Pos_y_mainmenu+altezza_pririga) and (mousey <= Pos_y_mainmenu+altezza_pririga+lato_quadrato_slots))			
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
				-- clicco su Maps button	--------------------------------------------------------------------------------------------
				if((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton)) then
				new_maps = 0 -- resetto il blinking della categoria
					if ((pagcur_maps == 0) and (pagtot_maps > 0)) then -- se la pagina della categoria selezionata = 0 (0 = no news di categoria) ma c'è almeno una pagina (pagtot_xxxx >0 ) inerente alla categoria, allora imposta la prima pagina di categoria
					pagcur_maps = 1
					end
				diarycategory = 0 -- setto la categoria da mostrare su mappe 
				diarycategorymanagement() -- chiamo la funzione per settare le immagini del diario
				return true
				-- clicco su Story button	--------------------------------------------------------------------------------------------
				elseif
				((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-interassey_menuicone)) then
				new_story = 0 -- resetto il blinking della categoria			
					if ((pagcur_story == 0) and (pagtot_story > 0)) then -- se la pagina della categoria selezionata = 0 (0 = no news di categoria) ma c'è almeno una pagina (pagtot_xxxx >0 ) inerente alla categoria, allora imposta la prima pagina di categoria
					pagcur_story = 1
					end				
				diarycategory = 1 -- setto la categoria da mostrare su story 	
				diarycategorymanagement() -- chiamo la funzione per settare le immagini del diario				
				return true
				-- clicco su hints button	--------------------------------------------------------------------------------------------		
				elseif
				((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-2*interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-2*interassey_menuicone)) then
				new_hints = 0 -- resetto il blinking della categoria
					if ((pagcur_hints == 0) and (pagtot_hints > 0)) then -- se la pagina della categoria selezionata = 0 (0 = no news di categoria) ma c'è almeno una pagina (pagtot_xxxx >0 ) inerente alla categoria, allora imposta la prima pagina di categoria
					pagcur_hints = 1
					end								
				diarycategory = 2 -- setto la categoria da mostrare su hint 	
				diarycategorymanagement() -- chiamo la funzione per settare le immagini del diario				
				return true			
				-- clicco su character button	--------------------------------------------------------------------------------------------
				elseif
				((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-3*interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-3*interassey_menuicone)) then
				new_character = 0 -- resetto il blinking della categoria			
					if ((pagcur_character == 0) and (pagtot_character > 0)) then -- se la pagina della categoria selezionata = 0 (0 = no news di categoria) ma c'è almeno una pagina (pagtot_xxxx >0 ) inerente alla categoria, allora imposta la prima pagina di categoria
					pagcur_character = 1
					end		
				diarycategory = 3 -- setto la categoria da mostrare su character 	
				diarycategorymanagement() -- chiamo la funzione per settare le immagini del diario				
				return true		
				-- clicco su units button	--------------------------------------------------------------------------------------------	
				elseif
				((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-4*interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-4*interassey_menuicone)) then
				new_units = 0 -- resetto il blinking della categoria
					if ((pagcur_units == 0) and (pagtot_units > 0)) then -- se la pagina della categoria selezionata = 0 (0 = no news di categoria) ma c'è almeno una pagina (pagtot_xxxx >0 ) inerente alla categoria, allora imposta la prima pagina di categoria
					pagcur_units = 1
					end		
				diarycategory = 4 -- setto la categoria da mostrare su units 			
				diarycategorymanagement() -- chiamo la funzione per settare le immagini del diario				
				Spring.Echo(pagtot_units)	
				Spring.Echo("click_units")
				return true		
				-- clicco su pagina precedente	--------------------------------------------------------------------------------------------	
				elseif
				((x >= Pos_x_mainmenu+posx_pulsavantidietro) and (x <= Pos_x_mainmenu+posx_pulsavantidietro+larghezza_avantidietro) and (y >= Pos_y_mainmenu-posy_pulsavantidietro) and (y <= Pos_y_mainmenu-posy_pulsavantidietro+altezza_avantidietro)) then
					diarypagemanagementprevious() -- esegui funzione per pagina precedente
					Spring.Echo("test_indietro")
				return true		
				-- clicco su pagina successiva	--------------------------------------------------------------------------------------------	
				elseif
				((x >= Pos_x_mainmenu+posx_pulsavantidietro+75) and (x <= Pos_x_mainmenu+posx_pulsavantidietro+75+larghezza_avantidietro) and (y >= Pos_y_mainmenu-posy_pulsavantidietro) and (y <= Pos_y_mainmenu-posy_pulsavantidietro+altezza_avantidietro)) then
					diarypagemanagementnext() -- esegui funzione per pagina successiva
					Spring.Echo("test_avanti")
				return true		
				------------------------ ################## manca pulsante close
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
-- nuova pagina diary maps
	if command == 'diary_wmrts_maps' then 			-- se ricevo un comando "news mappe" da mission editor , questo è preceduto da un aggiornamento relativo delle pagine totali delle mappe. vedi tab. tab "gestione del diario" in Mission_editor_hints.ods
	-- ricevo prima il numero di pagine totali della categoria "mappa" disponibili per la lettura
		pagtot_maps = Spring.GetGameRulesParam("wmrts_diary_maps") or 0
		Spring.Echo ("le pagine totali sono "..pagtot_maps)
		pagcur_maps = pagtot_maps									-- setto la pagina corrente delle mappe = all'ultima pagina delle pagine totali precedentemente impostatate da mission editor
		if ( autopopup == 1 and deployedunitsmenu_attivo == false) then		-- se l'autopopup è abilitato e il diario non è aperto
		diarycategory = 0 											-- imposto la categoria da visualizzare sul diario a "mappe"  ( = 0)
		diarycategorymanagement() 									-- chiamo la funzione per settare le immagini del diario		
		deployedunitsmenu_attivo = true 									-- apri il diario (che sarà già sulla pagina nuova da leggere)
		else 														-- altrimenti se l'autopopup non è attivo o il dirio è già aperto 
		new_maps = 1												-- evidenzio comunque la categoria maps								
		Spring.SendCommands("blink_wmrts_diary")					-- evidenzio il pulsante diario del minimenu
		end -- autopopup
-- nuova pagina diary story
	elseif command == 'diary_wmrts_story' then -- se ricevo una news inerente alla storia
		pagtot_story = Spring.GetGameRulesParam("wmrts_diary_story") or 0
		pagcur_story = pagtot_story									
		if ( autopopup == 1 and deployedunitsmenu_attivo == false) then		
		diarycategory = 1 											
		diarycategorymanagement() 									
		deployedunitsmenu_attivo = true 									
		else 														
		new_story = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup
-- nuova pagina diary hints
	elseif command == 'diary_wmrts_hints' then -- se ricevo una news inerente ai suggerimenti
		pagtot_hints = Spring.GetGameRulesParam("wmrts_diary_hints") or 0
		pagcur_hints = pagtot_hints
		if ( autopopup == 1 and deployedunitsmenu_attivo == false) then		
		diarycategory = 2 											
		diarycategorymanagement() 									
		deployedunitsmenu_attivo = true 									
		else 														
		new_hints = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup
-- nuova pagina diary character
	elseif command == 'diary_wmrts_character' then -- se ricevo una news inerente ai personaggi
		pagtot_character = Spring.GetGameRulesParam("wmrts_diary_character") or 0
		pagcur_character = pagtot_character
		if ( autopopup == 1 and deployedunitsmenu_attivo == false) then		
		diarycategory = 3 											
		diarycategorymanagement() 									
		deployedunitsmenu_attivo = true 									
		else 														
		new_character = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup
-- nuova pagina diary units
	elseif command == 'diary_wmrts_units' then -- se ricevo una news inerente alle unità
		pagtot_units = Spring.GetGameRulesParam("wmrts_diary_units") or 0
		pagcur_units = pagtot_units
		if ( autopopup == 1 and deployedunitsmenu_attivo == false) then		
		diarycategory = 4 											
		diarycategorymanagement() 									
		deployedunitsmenu_attivo = true 									
		else 														
		new_units = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup	
-- comando apri menu diario
	elseif command == 'open_wmrts_diary' then -- se ricevo il comando di aprire il diario (dal minimenu)
		if autopopup == 0 then -- quando si apre il diario, prima di mostrarlo eseguire una funzione che controlla le pagine totali di ciascuna categoria. Se c'è almeno una pagina, mostra la pagina 1 anzichè la pagina 0 della categoria (che indicherebbe l'assenza di news di categoria)
			function primanews()
		end
		deployedunitsmenu_attivo = true
-- comando chiudi menu diario		
	elseif command == 'close_wmrts_diary' then -- se ricevo il comando di chiudere il diario (dal minimenu)
		deployedunitsmenu_attivo = false	
			-- disabilito il guishader
				if (WG['guishader_api'] ~= nil) then
				WG['guishader_api'].RemoveRect('WMRTS_diary_shad')
				end			
	end	
	end
end

--------------------------------------
-- ALLA PRESSIONE DEI TASTI 
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
	if deployedunitsmenu_attivo and not Spring.IsGUIHidden() then
	if key == 0x01B then -- TASTO esc
			deployedunitsmenu_attivo = false 							-- chiudo il diario			
			Spring.SendCommands("close_wmrts_diary")			-- spengo il minipulsante menu del minimenu 
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
-- DISEGNO IL DIARY ###################################################
-------------------------------------- 
 function widget:DrawScreen()
	if deployedunitsmenu_attivo then -- se il main menu è attivo, allora disegnalo
	-- inserisco il background del mainmenu
		gl.Color(1,1,1,1)
		gl.Texture(backgroundmainmenu)	
		gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_deploymenu,Pos_y_mainmenu+altezza_deploymenu)	
		gl.Texture(false)	-- fine texture	

	-- gui shader	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( Pos_x_mainmenu,Pos_y_mainmenu, Pos_x_mainmenu+larghezza_diarymenu, Pos_y_mainmenu+altezza_header + altezza_content,'WMRTS_diary_shad')
		end

	end -- if deployedunitsmenu_attivo	
end --drawscreen