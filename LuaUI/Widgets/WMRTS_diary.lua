--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_diary.lua
--  brief:   Diary / Briefing for War Machines RTS missions
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2025.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_diary",
    desc      = "WMRTS diary menu",
    author    = "molixx81",
    date      = "30 Giugno, 2025",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

--------------------------------------------------------------------------------
--[[

to do list 
-- all :D
1) Global Map info
2) Story of War
3) Hints
4) Character
5) Units

Pulsante close
Pulsante avanti e dietro (per leggere le storie della categoria
tra i due pulsanti la pagina 1/xx
Al momento ogni scheda sarà un immagine con nomeimmagine_ing.png (cosi da diversificare quando un domani ci sarà il multilingua).

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
local diarymenu_attivo					= true 								-- Indica se questo menu è aperto o meno
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
local contentdiarymenu			= "LuaUI/Images/menu/diary/content_menu_bkgnd.png"  				-- assumerà il valore di una delle news sotto, a seconda della categoria e della pagina che si sta guardando
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
local button_successiva			= "LuaUI/Images/menu/diary/btnprevious.png"
local button_precedente			= "LuaUI/Images/menu/diary/btnnext.png"

-- impostazione dei fonts
local font_intestazione				= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

-- tabella diario
local diaryData						= {}  -- ############################### ELIMINARE TABELLA, SI USANO LE VARIABILI

--------------------------------------
-- GESTIONE DELLE CATEGORIE DEL DIARIO -- Ogni volta che viene chiamata questa funziona si setta la categoria del diario ############################ al momento non viene mai richiamata#################
--------------------------------------
local function diarycategorymanagement()
		-- imposto la categoria del diario
	if diarycategory == 0 then 			-- sto leggendo categoria mappe globali
	contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtsmaps"..pagcur_maps..".png" -- imposto l'immagine che sarà inizialmente "wmrtsmaps0.png"
	-- imposto lo stato ON/OFF dei bottoni
	button_mapmenu			= "LuaUI/Images/menu/diary/buttondiary_maps_on.png"
	button_storymenu		= "LuaUI/Images/menu/diary/buttondiary_story_off.png" 
	button_hintsmenu		= "LuaUI/Images/menu/diary/buttondiary_hint_off.png" 
	button_charmenu			= "LuaUI/Images/menu/diary/buttondiary_character_off.png" 
	button_unitsmenu		= "LuaUI/Images/menu/diary/buttondiary_units_off.png" 
	elseif diarycategory == 1 then		-- sto leggendo categoria storia
	contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtsstory"..pagcur_story..".png"
	-- imposto lo stato ON/OFF dei bottoni	
	button_mapmenu			= "LuaUI/Images/menu/diary/buttondiary_maps_off.png"
	button_storymenu		= "LuaUI/Images/menu/diary/buttondiary_story_on.png" 
	button_hintsmenu		= "LuaUI/Images/menu/diary/buttondiary_hint_off.png" 
	button_charmenu			= "LuaUI/Images/menu/diary/buttondiary_character_off.png" 
	button_unitsmenu		= "LuaUI/Images/menu/diary/buttondiary_units_off.png" 	
	elseif diarycategory == 2 then		-- sto leggendo categoria suggerimenti
	contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtshints"..pagcur_hints..".png"
	-- imposto lo stato ON/OFF dei bottoni	
	button_mapmenu			= "LuaUI/Images/menu/diary/buttondiary_maps_off.png"
	button_storymenu		= "LuaUI/Images/menu/diary/buttondiary_story_off.png" 
	button_hintsmenu		= "LuaUI/Images/menu/diary/buttondiary_hint_on.png" 
	button_charmenu			= "LuaUI/Images/menu/diary/buttondiary_character_off.png" 
	button_unitsmenu		= "LuaUI/Images/menu/diary/buttondiary_units_off.png" 	
	elseif diarycategory == 3 then		-- sto leggendo categoria personaggi
	contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtschara"..pagcur_character..".png"
	-- imposto lo stato ON/OFF dei bottoni	
	button_mapmenu			= "LuaUI/Images/menu/diary/buttondiary_maps_off.png"
	button_storymenu		= "LuaUI/Images/menu/diary/buttondiary_story_off.png" 
	button_hintsmenu		= "LuaUI/Images/menu/diary/buttondiary_hint_off.png" 
	button_charmenu			= "LuaUI/Images/menu/diary/buttondiary_character_on.png" 
	button_unitsmenu		= "LuaUI/Images/menu/diary/buttondiary_units_off.png" 	
	elseif diarycategory == 4 then		-- sto leggendo categoria unità
	contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtsunits"..pagcur_units..".png"
	-- imposto lo stato ON/OFF dei bottoni	
	button_mapmenu			= "LuaUI/Images/menu/diary/buttondiary_maps_off.png"
	button_storymenu		= "LuaUI/Images/menu/diary/buttondiary_story_off.png" 
	button_hintsmenu		= "LuaUI/Images/menu/diary/buttondiary_hint_off.png" 
	button_charmenu			= "LuaUI/Images/menu/diary/buttondiary_character_off.png" 
	button_unitsmenu		= "LuaUI/Images/menu/diary/buttondiary_units_on.png" 	
	end
end

local function diarypagemanagementnext() -- in questa funzione imposto il contenuto in funzione della categoria selezionata e della pagina che si stà visualizzando
		-- imposto la pagina successiva per categoria, funzione richiamata quanto si preme sul pulsante "pagina successiva"
	if ((diarycategory == 0) and (pagcur_maps < pagtot_maps)) then -- se la categoria è mappe globali e la pagina è minore delle pagine totali, vai alla scheda successiva	
		pagcur_maps = pagcur_maps+1
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/diarycontent_map_"..pagcur_maps..".png"  			
		-- imposto la pagina successiva per categoria, funzione richiamata quanto si preme sul pulsante "pagina successiva"
	elseif ((diarycategory == 1) and (pagcur_story < pagtot_story)) then -- se la categoria è storyboard e la pagina è minore delle pagine totali, vai alla scheda successiva	
		pagcur_story = pagcur_story+1
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/diarycontent_story_"..pagcur_story..".png"  				
		-- imposto la pagina successiva per categoria, funzione richiamata quanto si preme sul pulsante "pagina successiva"
	elseif ((diarycategory == 2) and (pagcur_hints < pagtot_hints)) then -- se la categoria è hint e la pagina è minore delle pagine totali, vai alla scheda successiva	
		pagcur_hints = pagcur_hints+1	
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/diarycontent_hints_"..pagcur_hints..".png"  				
	-- imposto la pagina successiva per categoria, funzione richiamata quanto si preme sul pulsante "pagina successiva"
	elseif ((diarycategory == 3) and (pagcur_character < pagtot_character)) then -- se la categoria è personaggi e la pagina è minore delle pagine totali, vai alla scheda successiva	
		pagcur_character = pagcur_character+1	
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/diarycontent_character_"..pagcur_character..".png"  			
	-- imposto la pagina successiva per categoria, funzione richiamata quanto si preme sul pulsante "pagina successiva"
	elseif ((diarycategory == 4) and (pagcur_units < pagtot_units)) then -- se la categoria è unità e la pagina è minore delle pagine totali, vai alla scheda successiva	
		pagcur_units = pagcur_units+1	
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/diarycontent_units_"..pagcur_units..".png"  					
	end
end
	
local function diarypagemanagementprevious()
		-- imposto la pagina precedente per categoria, funzione richiamata quanto si preme sul pulsante "pagina precedente"
	if ((diarycategory == 0) and (pagcur_maps > 1)) then -- se la categoria è mappe globali e la pagina è minore delle pagine totali, vai alla scheda precedente	
		pagcur_maps = pagcur_maps-1
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtsmaps"..pagcur_maps..".png"  					
		-- imposto la pagina precedente per categoria, funzione richiamata quanto si preme sul pulsante "pagina precedente"
	elseif ((diarycategory == 1) and (pagcur_story > 1)) then -- se la categoria è storyboard e la pagina è minore delle pagine totali, vai alla scheda precedente	
		pagcur_story = pagcur_story-1
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtsstory"..pagcur_story..".png"  					
		-- imposto la pagina precedente per categoria, funzione richiamata quanto si preme sul pulsante "pagina precedente"
	elseif ((diarycategory == 2) and (pagcur_hints > 1)) then -- se la categoria è hint e la pagina è minore delle pagine totali, vai alla scheda precedente	
		pagcur_hints = pagcur_hints-1	
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtshints"..pagcur_hints..".png"  			
	-- imposto la pagina precedente per categoria, funzione richiamata quanto si preme sul pulsante "pagina precedente"
	elseif ((diarycategory == 3) and (pagcur_character > 1)) then -- se la categoria è personaggi e la pagina è minore delle pagine totali, vai alla scheda precedente	
		pagcur_character = pagcur_character-1	
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtschar"..pagcur_character..".png"  			
	-- imposto la pagina precedente per categoria, funzione richiamata quanto si preme sul pulsante "pagina precedente"
	elseif ((diarycategory == 4) and (pagcur_units > 1)) then -- se la categoria è unità e la pagina è minore delle pagine totali, vai alla scheda precedente	
		pagcur_units = pagcur_units-1	
		contentdiarymenu = "LuaUI/Images/menu/diary/contents/wmrtsunits"..pagcur_units..".png"  			
	end	
end
	
--------------------------------------
-- FUNZIONE CHECK STATO OPZIONI, viene richiamata in diverse fasi dello script per controllare lo stato delle opzioni 
--------------------------------------
local function check_options()
--[[
############## inserire le opzioni corrette (tipo autopopup ed eventuali numerazioni) ##################################
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
--[[ rimuovo temporaneamente fino a conclusione test ###########

-- eseguire verifica per capire se è richiesto il widget (ossia si sta giocando una missione, WMRTSmission == 1, altrimenti chiudi widget)
	if (Spring.GetGameRulesParam('WMRTSmission') == 1 or Spring.GetGameRulesParam('WMRTSmission') == '1') then
		missione_attiva = 1 -- mostrerà il diario per WMRTS Missions
	elseif (Spring.GetGameRulesParam('Fleabowl') == 1 or Spring.GetGameRulesParam('Fleabowl') == '1') then
		missione_attiva = 2 -- mostrerà il diario per FLEA Missions	
	else		
		widgetHandler:RemoveWidget() -- rimuovi il widget diario, è una partita skirmish
	end
	]]--
-- all'inizio imposto la posizione del mini menu
	Pos_x_mainmenu = vsx/2 - larghezza_diarymenu/2
	Pos_y_mainmenu = vsy/2 - altezza_diarymenu/2
-- avvio la funzione check_options()
	check_options()	
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
-- SEMPRE
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
-- MOUSE IS OVER BUTTONS 
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
-- MOUSE PRESS BUTTONS 1 (SX)
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

--------------------------------------
-- RICEVO LE INFORMAZIONI DURANTE LA MISSIONE SULLE PAGINE TOTALI DISPONIBILI
--------------------------------------
function widget:GameFrame(frame)
	if frame%30 == 0 then
-- ricevo il numero globale della mappa  ######################################### tramutare queste da tabella diarYdata a variabili
		diaryData["pagtot_maps"] 	= Spring.GetGameRulesParam("wmrts_diary_maps")	
-- ricevo il numero globale dello storyboard
		diaryData["pagtot_story"] = Spring.GetGameRulesParam("wmrts_diary_story")	
-- ricevo il numero globale dei suggerimenti
		diaryData["pagtot_hints"] = Spring.GetGameRulesParam("wmrts_diary_hints")	
-- ricevo il numero globale dei personaggi
		diaryData["pagtot_character"]= Spring.GetGameRulesParam("wmrts_diary_character")	
-- ricevo il numero globale delle unità
		diaryData["pagtot_units"]= Spring.GetGameRulesParam("wmrts_diary_units")			
	end
end

--------------------------------------
-- GESTIONE DEI COMANDI SPRING RICEVUTI
--------------------------------------	
function widget:TextCommand(command)
-- apertura e chiusura del menu
	if command == 'diary_WMRTS_maps' then -- se ricevo una news inerente alla mappa globale
		new_maps = 1
		if autopopup == 1 then diarymenu_attivo = true end -- se l'opzione autopopup è abilitata, apri automaticamente il diario
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_story' then -- se ricevo una news inerente alla storia
		new_story = 1
		if autopopup == 1 then diarymenu_attivo = true end 
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_hints' then -- se ricevo una news inerente ai suggerimenti
		new_hints = 1	
		if autopopup == 1 then diarymenu_attivo = true end
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_character' then -- se ricevo una news inerente ai personaggi
		new_character = 1		
		if autopopup == 1 then diarymenu_attivo = true end
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_units' then -- se ricevo una news inerente alle unità
		new_units = 1			
		if autopopup == 1 then diarymenu_attivo = true end		
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'open_WMRTS_diary' then -- se ricevo il comando di aprire il diario (dal minimenu)
		diarymenu_attivo = true
	elseif command == 'close_WMRTS_diary' then -- se ricevo il comando di chiudere il diario (dal minimenu)
		diarymenu_attivo = false		
	end	
end

--------------------------------------
-- ALLA PRESSIONE DEI TASTI 
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
	if diarymenu_attivo and not Spring.IsGUIHidden() then
		if key == 27 then -- TASTO esc  0x01B
			diarymenu_attivo = false 							-- chiudo il diario
			Spring.SendCommands("close_WMRTS_diary")			-- spengo il minipulsante menu del minimenu 
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
-- DISEGNO IL DIARY
-------------------------------------- 
 function widget:DrawScreen()
	if diarymenu_attivo then -- se il main menu è attivo, allora disegnalo

	-- inserisco il contenuto del diary
		gl.Color(1,1,1,1)
		gl.Texture(contentdiarymenu)	
		gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_diarymenu,Pos_y_mainmenu+altezza_content)	
		gl.Texture(false)	-- fine texture		
		
	-- inserisco l'header del diary
		gl.Color(1,1,1,1)
		gl.Texture(headerdiarymenu)	
		gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu+altezza_content,Pos_x_mainmenu+larghezza_diarymenu,Pos_y_mainmenu+altezza_content+altezza_header)	
		gl.Texture(false)	-- fine texture	
		
	-- Intestazione del menu
		-- testo
		font_intestazione:SetTextColor(1, 1, 1, 1)
		font_intestazione:Begin()
		font_intestazione:Print("Commander's logbook", Pos_x_mainmenu+70, Pos_y_mainmenu + 220+25,14,'ds')
		font_intestazione:End()	
		
	-- icona principale del menu
		gl.Color(1,1,1,1)
		gl.Texture(icona_diarymenu)	
		gl.TexRect(	Pos_x_mainmenu+margine_sx_icona_diarymenu,Pos_y_mainmenu+altezza_diarymenu+margine_su_icona_diarymenu,Pos_x_mainmenu+margine_sx_icona_diarymenu+larghezza_icona_diary,Pos_y_mainmenu+altezza_diarymenu+margine_su_icona_diarymenu+altezza_icona_diary)	
		gl.Texture(false)	-- fine texture	
		
	-- pulsante mappe
		if pagtot_maps > 0 then --disegna la riga dell'obiettivo 1	
			-- back
			gl.Color(1,1,1,1)
			gl.Texture(button_mapmenu)	-- definire icona ######################################################################################################################
			gl.TexRect(	Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu,Pos_y_mainmenu+posy_menuicone,Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton,Pos_y_mainmenu+posy_menuicone+altezza_menubutton)	
			gl.Texture(false)	-- fine texture	
			-- testo
			font_intestazione:SetTextColor(1, 1, 1, 1)
			font_intestazione:Begin()
			font_intestazione:Print("Global Map", Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+10,Pos_y_mainmenu+posy_menuicone,9,'ds')
			font_intestazione:End()		
		end
		
	-- pulsante story
		-- back
		gl.Color(1,1,1,1)
		gl.Texture(button_storymenu)	
		gl.TexRect(	Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu,Pos_y_mainmenu+posy_menuicone-interassey_menuicone,Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton,Pos_y_mainmenu+posy_menuicone+altezza_menubutton-interassey_menuicone)	
		gl.Texture(false)	-- fine texture	
		-- testo
		font_intestazione:SetTextColor(1, 1, 1, 1)
		font_intestazione:Begin()
		font_intestazione:Print("Story", Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+10,Pos_y_mainmenu+posy_menuicone-interassey_menuicone,9,'ds')
		font_intestazione:End()		

	-- pulsante hints
		-- back
		gl.Color(1,1,1,1)
		gl.Texture(button_hintsmenu)	
		gl.TexRect(	Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu,Pos_y_mainmenu+posy_menuicone-2*interassey_menuicone,Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton,Pos_y_mainmenu+posy_menuicone+altezza_menubutton-2*interassey_menuicone)	
		gl.Texture(false)	-- fine texture	
		-- testo
		font_intestazione:SetTextColor(1, 1, 1, 1)
		font_intestazione:Begin()
		font_intestazione:Print("Hints", Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+10,Pos_y_mainmenu+posy_menuicone-2*interassey_menuicone,9,'ds')
		font_intestazione:End()			

	-- pulsante characters
		-- back
		gl.Color(1,1,1,1)
		gl.Texture(button_charmenu)	
		gl.TexRect(	Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu,Pos_y_mainmenu+posy_menuicone-3*interassey_menuicone,Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton,Pos_y_mainmenu+posy_menuicone+altezza_menubutton-3*interassey_menuicone)	
		gl.Texture(false)	-- fine texture	
		-- testo
		font_intestazione:SetTextColor(1, 1, 1, 1)
		font_intestazione:Begin()
		font_intestazione:Print("Hints", Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+10,Pos_y_mainmenu+posy_menuicone-3*interassey_menuicone,9,'ds')
		font_intestazione:End()		

	-- pulsante units
		-- back
		gl.Color(1,1,1,1)
		gl.Texture(button_unitsmenu)	
		gl.TexRect(	Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu,Pos_y_mainmenu+posy_menuicone-4*interassey_menuicone,Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+larghezza_menubutton,Pos_y_mainmenu+posy_menuicone+altezza_menubutton-4*interassey_menuicone)	
		gl.Texture(false)	-- fine texture	
		-- testo
		font_intestazione:SetTextColor(1, 1, 1, 1)
		font_intestazione:Begin()
		font_intestazione:Print("Hints", Pos_x_mainmenu+larghezza_diarymenu+margine_dx_icone_diarymenu+10,Pos_y_mainmenu+posy_menuicone-4*interassey_menuicone,9,'ds')
		font_intestazione:End()	

	-- pulsante pagina precedente
	-- ########## da mostrare solo se la categoria corrente ha almeno 1 pagina ! ####################
		gl.Color(1,1,1,1)
		gl.Texture(button_precedente)	
		gl.TexRect(	Pos_x_mainmenu+posx_pulsavantidietro,Pos_y_mainmenu-posy_pulsavantidietro,Pos_x_mainmenu+posx_pulsavantidietro+larghezza_avantidietro,Pos_y_mainmenu-posy_pulsavantidietro+altezza_avantidietro)	
		gl.Texture(false)	-- fine texture	
	
	-- pulsante pagina successiva
	-- ########## da mostrare solo se la categoria corrente ha almeno 1 pagina ! ####################
		gl.Color(1,1,1,1)
		gl.Texture(button_successiva)	
		gl.TexRect(	Pos_x_mainmenu+posx_pulsavantidietro+larghezza_pagxdiy,Pos_y_mainmenu-posy_pulsavantidietro,Pos_x_mainmenu+posx_pulsavantidietro+larghezza_pagxdiy+larghezza_avantidietro,Pos_y_mainmenu-posy_pulsavantidietro+altezza_avantidietro)	
		gl.Texture(false)	-- fine texture		

	-- gui shader	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( Pos_x_mainmenu,Pos_y_mainmenu, Pos_x_mainmenu+larghezza_diarymenu, Pos_y_mainmenu+altezza_header + altezza_content,'WMRTS_diary_shad')
		end

	end -- if diarymenu_attivo	
end --drawscreen