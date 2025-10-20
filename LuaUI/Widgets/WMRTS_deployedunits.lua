--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_deployableunits.lua
--  brief:   interface for deployable unit in scenario
--  author:  Dario Molinaroli ( Molixx81 )
--	WARNING: set "wmrtsmission = 2;" in modoption to activate diary button in minumenu widget !!!!!!!!!!!!! WMRTS = nil or 0 -> isskirmish, =1 -> iscampaign; = 2 -> isscenario
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
#### -- all
Questo widget gestisce le unità dispiegate dal garage per le missioni scenario, monitorandone la posizione, se sono state distrutte ecc

]]--

local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local Pos_x_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local altezza_header					= 30								-- altezza header menu
local altezza_content					= 400								-- altezza contenuto
local larghezza_diarymenu				= 800 								-- larghezza
local altezza_diarymenu					= altezza_header+altezza_content	-- altezza ( h header + h contenuto)
local altezza_menubutton				= 25								-- altezza pulsanti di navigazione (maps, units, character ecc)
local larghezza_menubutton				= 76
local larghezza_avantidietro			= 25								-- larghezza pulsanti avanti / dietro
local altezza_avantidietro				= 25								-- altezza pulsanti avanti / dietro
local posy_menuicone             	    = 366								-- altezza del primo pulsante a destra del menu diario rispetto al fondo del content
local interassey_menuicone		        = 25+10								-- distanza y tra le origini di due pulsanti consecutivi
local autopopup							= 1									-- attiva l'apertura del diario quando si riceve il comando di nuova news
local autopause							= 1									-- attiva la pausa quando si riceve il comando di nuova news
local diarymenu_attivo					= false 							-- Indica se questo menu è aperto o meno
local margine_sx_icona_diarymenu		= 20  								-- distanza dal margine sinistro del background e l'icona del menu
local margine_dx_icone_diarymenu		= 10  								-- distanza dal bordo del diario alle icone di destra del menu
local margine_su_icona_diarymenu		= -30 								-- distanza di quanto sborda l'immagine dal bordo superiore del background
local mousex, mousey				   										-- posizione x e y del mouse, usata per rilevare la sua posizione e far apparire il selettore
local larghezza_icona_diary				= 40
local altezza_icona_diary				= 40
local posx_pulsavantidietro				= 650 								-- posizione x dei pulsanti avanti e dietro rispetto alla posizione del menu
local posy_pulsavantidietro				= 15 								-- posizione y dei pulsanti avanti e dietro rispetto alla posizione del menu
local larghezza_pagxdiy					= 75								-- larghezza intermezzo tra pulsante precedente e successivo (dove c'è il testo pagina 1 di 20 ad esempio)
local missione_attiva					= 0									-- se 0 partita skirmish, se 1 partita WMRTSmission, se 2 partita FLEAmission. Definira quali pulsanti devono apparire o meno (OBJ e diary)
-- variabili del selettore pulsanti categoria
local selettore_visibile = true
local selettore_buttons_visibile = false				
local posy_selettore					= 0									-- verrà determinata quando il mouse ci passa sopra i pulsanti di categoria (nella funzione "sempre")
local posx_selettore					= 0									-- verrà determinata quando il mouse ci passa sopra i pulsanti di categoria (nella funzione "sempre")

-- categoria di news da mostrare (cambia al cliccare dei pulsanti) e le pagine di categoria fino ad un max stabilito dalle variabili pagtot_xxx
local diarycategory				= 0		-- 0) visualizza le mappe, 1) la storia, 2) i suggerimenti, 3) i personaggi, 4) le unità

-- Variabili che definiscono le pagine totali leggibili per ogni categoria
local pagtot_maps				= 0		-- n° news attive inerenti alle mappe, parametro ricevuto dalla missione
local pagtot_story				= 0		-- n° news attive inerenti alla storia, parametro ricevuto dalla missione
local pagtot_hints				= 0		-- n° news attive inerenti ai suggerimenti, parametro ricevuto dalla missione
local pagtot_character			= 0		-- n° news attive inerenti ai personaggi, parametro ricevuto dalla missione
local pagtot_units				= 0		-- n° news attive inerenti alle unità, parametro ricevuto dalla missione

-- pagine correnti in visualizzazione per categoria
local pagcur_maps				= 0		-- pagina corrente di lettura (variabile con i tasti avanti e dietro fino ad un max definito da pagtot_xxx definito sopra
local pagcur_story				= 0		-- pagina corrente di lettura (variabile con i tasti avanti e dietro fino ad un max definito da pagtot_xxx definito sopra
local pagcur_hints				= 0		-- pagina corrente di lettura (variabile con i tasti avanti e dietro fino ad un max definito da pagtot_xxx definito sopra
local pagcur_character			= 0		-- pagina corrente di lettura (variabile con i tasti avanti e dietro fino ad un max definito da pagtot_xxx definito sopra
local pagcur_units				= 0		-- pagina corrente di lettura (variabile con i tasti avanti e dietro fino ad un max definito da pagtot_xxx definito sopra

-- variabili per "blinking" nuove news -- alla ricezione della rispettiva news il pulsante della categoria lampeggia per indicare una nuova news: new_maps = 1 -> lampeggia news map fino al suo click
local new_maps				= 0
local new_story				= 0
local new_hints				= 0
local new_character			= 0
local new_units				= 0

-- definizioni immagini bottoni e background
local headerdiarymenu 			= "LuaUI/Images/menu/diary/header_menu_bkgnd.png"
local contentdiarymenu			= "LuaUI/Images/menu/diary/contents/wmrtschara0.png"  				-- assumerà il valore di una delle news sotto, a seconda della categoria e della pagina che si sta guardando
local button_close				= "LuaUI/Images/menu/diary/menu_close.png"
local icona_diarymenu			= "LuaUI/Images/menu/diary/menu_diary_icon.png"

-- definizione delle immagini dei pulsanti di categoria
local button_mapmenu			= "LuaUI/Images/menu/diary/buttondiary_maps_off.png"
local button_storymenu			= "LuaUI/Images/menu/diary/buttondiary_story_off.png" 
local button_hintsmenu			= "LuaUI/Images/menu/diary/buttondiary_hint_off.png" 
local button_charmenu			= "LuaUI/Images/menu/diary/buttondiary_character_off.png" 
local button_unitsmenu			= "LuaUI/Images/menu/diary/buttondiary_units_off.png" 
local button_catover			= "LuaUI/Images/menu/diary/buttondiary_over.png" 
-- definizione delle immagini dei pulsanti avanti e dietro
local button_successiva			= "LuaUI/Images/menu/diary/btnnext.png"
local button_precedente			= "LuaUI/Images/menu/diary/btnprevious.png"

-- impostazione dei fonts
local font_intestazione				= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

-- impostazione del file di scrittura
local nomeFile = "deployedlist.wmr"  		-- definisco il file che voglio scrivere

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
	Pos_x_mainmenu = vsx/2 - larghezza_diarymenu/2
	Pos_y_mainmenu = vsy/2 - altezza_diarymenu/2
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
	if diarymenu_attivo and not Spring.IsGUIHidden() then
	-- Maps button
		if ((mousex >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (mousex <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (mousey >= Pos_y_mainmenu+posy_menuicone) and (mousey <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton))  then
					posx_selettore = Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu
					posy_selettore = Pos_y_mainmenu+posy_menuicone
					selettore_visibile = true
					selettore_buttons_visibile = false	
	-- Story button					
		elseif ((mousex >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (mousex <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (mousey >= Pos_y_mainmenu+posy_menuicone-interassey_menuicone) and (mousey <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-interassey_menuicone))   then
					posx_selettore = Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu
					posy_selettore = Pos_y_mainmenu+posy_menuicone-interassey_menuicone
					selettore_visibile = true
					selettore_buttons_visibile = false	
	-- hints button					
		elseif ((mousex >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (mousex <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (mousey >= Pos_y_mainmenu+posy_menuicone-2*interassey_menuicone) and (mousey <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-2*interassey_menuicone))   then
					posx_selettore = Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu
					posy_selettore = Pos_y_mainmenu+posy_menuicone-2*interassey_menuicone
					selettore_visibile = true
					selettore_buttons_visibile = false	
	-- character button					
		elseif ((mousex >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (mousex <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (mousey >= Pos_y_mainmenu+posy_menuicone-3*interassey_menuicone) and (mousey <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-3*interassey_menuicone))   then
					posx_selettore = Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu
					posy_selettore = Pos_y_mainmenu+posy_menuicone-3*interassey_menuicone
					selettore_visibile = true
					selettore_buttons_visibile = false	
	-- units button					
		elseif ((mousex >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (mousex <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (mousey >= Pos_y_mainmenu+posy_menuicone-4*interassey_menuicone) and (mousey <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-4*interassey_menuicone))   then		
					posx_selettore = Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu
					posy_selettore = Pos_y_mainmenu+posy_menuicone-4*interassey_menuicone
					selettore_visibile = true
					selettore_buttons_visibile = false	
		end -- condizioni if mouse etc
	end -- diary menu attivo etc
end -- function update

--------------------------------------
-- MOUSE IS OVER BUTTONS ###################################################
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile graphicsmenu_attivo è true.....
	if diarymenu_attivo and not Spring.IsGUIHidden() then
			-- Maps button
			return 
			((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton)) 
			or
			-- story button
			((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-interassey_menuicone)) 
			or
			-- hints button			
			((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-2*interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-2*interassey_menuicone)) 
			or
			-- character button			
			((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-3*interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-3*interassey_menuicone)) 
			or
			-- units button			
			((x >= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu) and (x <= Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton) and (y >= Pos_y_mainmenu+posy_menuicone-4*interassey_menuicone) and (y <= Pos_y_mainmenu+posy_menuicone+altezza_menubutton-4*interassey_menuicone)) 
			or
			-- pagina precedente
			((x >= Pos_x_mainmenu+posx_pulsavantidietro) and (x <= Pos_x_mainmenu+posx_pulsavantidietro+larghezza_avantidietro) and (y >= Pos_y_mainmenu-posy_pulsavantidietro) and (y <= Pos_y_mainmenu-posy_pulsavantidietro+altezza_avantidietro))
			or
			-- pagina successiva
			((x >= Pos_x_mainmenu+posx_pulsavantidietro+75) and (x <= Pos_x_mainmenu+posx_pulsavantidietro+75+larghezza_avantidietro) and (y >= Pos_y_mainmenu-posy_pulsavantidietro) and (y <= Pos_y_mainmenu-posy_pulsavantidietro+altezza_avantidietro))
	end --is gui hidden
end
--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX) ###########################################
--------------------------------------
function widget:MousePress(x, y, button)
	if diarymenu_attivo and not Spring.IsGUIHidden() then
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
	if diarymenu_attivo and not Spring.IsGUIHidden() then
	  if (Spring.GetGameSeconds() < 0.1) then
		return "Diary menu  (only works in game)"
	  else
		return "Diary menu"
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
		if ( autopopup == 1 and diarymenu_attivo == false) then		-- se l'autopopup è abilitato e il diario non è aperto
		diarycategory = 0 											-- imposto la categoria da visualizzare sul diario a "mappe"  ( = 0)
		diarycategorymanagement() 									-- chiamo la funzione per settare le immagini del diario		
		diarymenu_attivo = true 									-- apri il diario (che sarà già sulla pagina nuova da leggere)
		else 														-- altrimenti se l'autopopup non è attivo o il dirio è già aperto 
		new_maps = 1												-- evidenzio comunque la categoria maps								
		Spring.SendCommands("blink_wmrts_diary")					-- evidenzio il pulsante diario del minimenu
		end -- autopopup
-- nuova pagina diary story
	elseif command == 'diary_wmrts_story' then -- se ricevo una news inerente alla storia
		pagtot_story = Spring.GetGameRulesParam("wmrts_diary_story") or 0
		pagcur_story = pagtot_story									
		if ( autopopup == 1 and diarymenu_attivo == false) then		
		diarycategory = 1 											
		diarycategorymanagement() 									
		diarymenu_attivo = true 									
		else 														
		new_story = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup
-- nuova pagina diary hints
	elseif command == 'diary_wmrts_hints' then -- se ricevo una news inerente ai suggerimenti
		pagtot_hints = Spring.GetGameRulesParam("wmrts_diary_hints") or 0
		pagcur_hints = pagtot_hints
		if ( autopopup == 1 and diarymenu_attivo == false) then		
		diarycategory = 2 											
		diarycategorymanagement() 									
		diarymenu_attivo = true 									
		else 														
		new_hints = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup
-- nuova pagina diary character
	elseif command == 'diary_wmrts_character' then -- se ricevo una news inerente ai personaggi
		pagtot_character = Spring.GetGameRulesParam("wmrts_diary_character") or 0
		pagcur_character = pagtot_character
		if ( autopopup == 1 and diarymenu_attivo == false) then		
		diarycategory = 3 											
		diarycategorymanagement() 									
		diarymenu_attivo = true 									
		else 														
		new_character = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup
-- nuova pagina diary units
	elseif command == 'diary_wmrts_units' then -- se ricevo una news inerente alle unità
		pagtot_units = Spring.GetGameRulesParam("wmrts_diary_units") or 0
		pagcur_units = pagtot_units
		if ( autopopup == 1 and diarymenu_attivo == false) then		
		diarycategory = 4 											
		diarycategorymanagement() 									
		diarymenu_attivo = true 									
		else 														
		new_units = 1																		
		Spring.SendCommands("blink_wmrts_diary")					
		end -- autopopup	
-- comando apri menu diario
	elseif command == 'open_wmrts_diary' then -- se ricevo il comando di aprire il diario (dal minimenu)
		if autopopup == 0 then -- quando si apre il diario, prima di mostrarlo eseguire una funzione che controlla le pagine totali di ciascuna categoria. Se c'è almeno una pagina, mostra la pagina 1 anzichè la pagina 0 della categoria (che indicherebbe l'assenza di news di categoria)
			function primanews()
		end
		diarymenu_attivo = true
-- comando chiudi menu diario		
	elseif command == 'close_wmrts_diary' then -- se ricevo il comando di chiudere il diario (dal minimenu)
		diarymenu_attivo = false	
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
	if diarymenu_attivo and not Spring.IsGUIHidden() then
	if key == 0x01B then -- TASTO esc
			diarymenu_attivo = false 							-- chiudo il diario			
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
	if diarymenu_attivo then -- se il main menu è attivo, allora disegnalo
 -- compilare qui la finestra unità dispiegate in missione

	-- gui shader	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( Pos_x_mainmenu,Pos_y_mainmenu, Pos_x_mainmenu+larghezza_diarymenu, Pos_y_mainmenu+altezza_header + altezza_content,'WMRTS_diary_shad')
		end

	end -- if diarymenu_attivo	
end --drawscreen