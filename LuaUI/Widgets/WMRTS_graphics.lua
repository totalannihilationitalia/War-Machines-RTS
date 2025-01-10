--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_graphics.lua
--  brief:   War Machines RTS options mainmenu
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2024.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_graphics",
    desc      = "WMRTS graphics options",
    author    = "molixx81",
    date      = "07 Gennaio, 2025",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
-- verificare se fare o predisporre su due pagine (intesi come tabs)
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix
-- designing WMRTS graphics menu

-- definizione dei comandi
local Echo 								= Spring.Echo 
-- definizione variabili di posizione e lunghezza menu e icone
local graphicsmenu_attivo				= false 							-- Indica se questo menu è attivo o meno
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local larghezza_mainmenu				= 400*2 							-- doppia rispetto a mainmenu
local altezza_mainmenu					= 200+50							-- + 2 opzioni (da 25 l'una), rispetto a mainmenu
local Pos_x_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local margine_sx_scritte				= 80  								-- margine sinistro da cui partono le scritte del menu
local margine_inferiore					= 25    							-- margine inferiore da cui parte la prima riga delle opzioni
local distanzax_icone_testi				= -6  								-- distanza x tra le icone (caselle di selezione on/off) ed il testo della medesima opzione
local distanzay_icone_testi				= 2   								-- distanza x tra le icone (caselle di selezione on/off) ed il testo della medesima opzione
local larghezza_icona_opzioni			= 20  								-- larghezza icona opzioni
local interpazio_icone					= larghezza_icona_opzioni + 4		-- distanza x tra due icone consecutive (ad esempio per le opzioni che necessitano di una regolazione + e -)
local altezza_icona_opzioni				= 20  								-- altezza icona opzioni
local offsety_selettore					= -4								-- offset y selettore rispetto al testo selezionato
local altezza_selettore					= 24  								-- altezza del selettore
local selettore_visibile				= false 							-- visibile o no quando si passa sopra l'opzione (a casella singola) o sopra il pulsante + o - nel caso della casella doppia
local mousex, mousey				   										-- posizione x e y del mouse, usata per rilevare la sua posizione e far apparire il selettore
local posy_riga1						= 25    							-- posizione y della prima riga (dal fondo del background) di opzioni
local posy_riga2						= 50    							-- posizione y della seconda riga (dal fondo del background) di opzioni
local posy_riga3						= 75    							-- posizione y della terza riga (dal fondo del background) di opzioni 
local posy_riga4						= 100   							-- posizione y della quarta riga (dal fondo del background) di opzioni 
local posy_riga5						= 125    							-- posizione y della quinta riga (dal fondo del background) di opzioni 
local posy_riga6						= 150    							-- posizione y della sesta riga (dal fondo del background) di opzioni 
local posy_riga7						= 175    							-- posizione y della settima riga (dal fondo del background) di opzioni 
-- definizione valori delle opzioni
local valore_mapshading
local valore_unitshading
local valore_grass					-- verificare!!!!!!!!!!!!!!!!!!!
local valore_hardwarecur
local valore_LUPS
local valore_bloom_shader
local valore_show_projeclight
local valore_xray
local valore_hardwarecur
local valore_blinking				-- verificare!!!!!!!!!!!!!!!!!!!
local valore_shadows
local valore_showenvironmental
local valore_antialiasing
local valore_watertype
-- icona principale del menu
local larghezza_icona_graphicsmenu			= 40
local altezza_icona_graphicsmenu			= 40
local margine_sx_icona_graphicsmenu			= 20  	-- distanza dal margine sinistro del background e l'icona del menu
local margine_su_icona_graphicsmenu			= -30 	-- distanza di quanto sborda l'immagine dal bordo superiore del background
-- pulsanti back / close
local larghezza_menu_buttons 			= 76  		-- like back button, close button
local altezza_menu_buttons 				= 25  		-- like back button, close button
local distance_x_menu_button 			= 300 		-- distanza tra i due pulsanti 
local posx_menu_button = 11					  		-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button = -10				 		-- position y of first menu button (from 0 ,0 of main menu)
local selettore_buttons_visibile 		= false		-- visibile o no
local posx_selettore_buttons 						-- posizione x del selettore dei pulsanti close, back ecc
local posy_selettore_buttons 						-- posizione y del selettore dei pulsanti close, back ecc
-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/mainmenu/graph_menu_bkgnd.png"
local selettore 					= "LuaUI/Images/menu/mainmenu/main_menu_selection.png"
local selettore_button 				= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"
local icona_on 						= "LuaUI/Images/menu/mainmenu/graphics_on.png"
local icona_off 					= "LuaUI/Images/menu/mainmenu/graphics_off.png"
local icona_prec 					= "LuaUI/Images/menu/mainmenu/graphics_prec.png"
local icona_succ						= "LuaUI/Images/menu/mainmenu/graphics_succ.png"
local icona_graphicsmenu			= "LuaUI/Images/menu/mainmenu/icona_main_menu.png"
local button_back					= "LuaUI/Images/menu/mainmenu/menu_back.png"
local button_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"
-- impostazione dei fonts
local font_intestazione				= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

--------------------------------------
-- AGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------
-- funzione aggiorno la posizione del minimenu button in alto a destra
local function UpdateGeometry() -- aggiorno geometria
  Pos_x_mainmenu = vsx/2 - larghezza_mainmenu/2
  Pos_y_mainmenu = vsy/2 - altezza_mainmenu/2
end

--- funzione rilevamento delle dimensioni della finestra durante il resizing
function widget:ViewResize(viewSizeX, viewSizeY) -- quando si modifica la dimensione della finestra di spring, prelevane larghezza e altezza e fai partire la funzione "aggiorno geometria"
  vsx = viewSizeX
  vsy = viewSizeY
  UpdateGeometry()
end

--------------------------------------
-- GESTIONE DEI COMANDI SPRING RICEVUTI
--------------------------------------	
function widget:TextCommand(command)
-- apertura e chiusura del menu
	if command == 'open_WMRTS_graphics' and not graphicsmenu_attivo then
		graphicsmenu_attivo = true
-- VALUTARE SE SONO NECESSARI ALTRI COMANDI ----------------------------------------------------------------------------------------------------		
--	elseif command ==  'close_WMRTS_graphics' and graphicsmenu_attivo then
--		graphicsmenu_attivo = false
--		Spring.SendCommands("close_WMRTS_minimenu")  -- invio il comando close_WMRTS_minimenu per gestire l'icona minimenu
-- invio il comando close_WMRTS_minimenu per gestire l'icona minimenu		---------------------------------------------------------------------------		
	end
end

--[[
--------------------------------------
-- ALLA PRESSIONE DEI TASTI --------------------------------------------------------------- spostare questa funzione nel minimenu! in modo da gestire l'apertura del menu col tasto esc solamente quando non ci sono altri elementi aperti
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
if graphicsmenu_attivo and not Spring.IsGUIHidden() then
	if key == 27 then -- TASTO esc  0x01B
	Spring.SendCommands("close_WMRTS_menu")
--------------------------------------------------------------------------------------------------------------- introdurre queste righe per disabilitare lo shader, quando lo installi nel drawing
--				if (WG['guishader_api'] ~= nil) then
--					WG['guishader_api'].RemoveRect('WMRTS_snd_option')
--				end			
			return true
	end
elseif not graphicsmenu_attivo 	and not Spring.IsGUIHidden() then
	if key == 27 then -- TASTO esc 0x01B
	Spring.SendCommands("open_WMRTS_menu")
			return true
	end
end
	
	return false
end
]]--

--------------------------------------
-- FUNZIONE CHECK STATO OPZIONI, viene richiamata in diverse fasi dello script per controllare lo stato delle opzioni 
--------------------------------------
local function check_options()
-- all'inizio verifico anche il valore delle configurazioni
  valore_mapshading = Spring.GetConfigInt("AdvMapShading", 1)			-- booleano di default è true
  valore_unitshading = Spring.GetConfigInt("AdvUnitShading", 1)			-- booleano di default è true
--  valore_grass = Spring.GetConfigInt("xxxxxxx", 1)   				----------------- non esiste grass ON/OFF
  valore_hardwarecur = Spring.GetConfigInt("HardwareCursor", 0) 		-- booleano di default è falso
  valore_LUPS = Spring.GetConfigInt("LupsActive", 0) 					-- booleano di default è falso -> disattivo successivamente anche il Widget				## widget
  valore_bloom_shader = Spring.GetConfigInt("BloomshaderActive", 0)		-- booleano di default è falso -> disattivo successivamente anche il Widget			## widget
  valore_show_projeclight = Spring.GetConfigInt("ShowProjectile", 0)	-- booleano di default è falso  -> disattivo successivamente anche il Widget	## widget
  valore_xray = Spring.GetConfigInt("XrayActive", 0)					-- booleano di default è falso  -> disattivo successivamente anche il Widget			## widget
  valore_hardwarecur = Spring.GetConfigInt("Fullscreen", 1) 			-- booleano di default è true
--  valore_blinking = Spring.GetConfigInt("xxxxxxx", 1)   			----------------- non esiste è un widget???
  valore_shadows = Spring.GetConfigInt("Shadows", 2) 					-- -1:=forceoff, 0:=off, 1:=full, 2:=fast (skip terrain)
  valore_showenvironmental = Spring.GetConfigInt("EnviroActive", 0)		-- booleano di default è falso ->  -> disattivo successivamente anche il Widget			## widget
  valore_antialiasing = Spring.GetConfigInt("MSAALevel", 0) 			-- valori da 0 a 32 MAX
  valore_watertype = Spring.GetConfigInt("Water", 1) 					-- Defines the type of water rendering. Can be set in game. Options are: 0 = Basic water, 1 = Reflective water, 2 = Reflective and Refractive water, 3 = Dynamic water, 4 = Bumpmapped water
  
--[[ ESEMPIO DA UTILIZZARE PER IL CHECK OPTIONS
Spring.GetConfigInt ( string name [, number default ] ) 
return: nil | number configInt 
Spring.GetConfigFloat ( string name [, number default ] ) 
return: nil | number configFloat 
New in version 104.0
Spring.GetConfigString ( string name [, number default ] ) 
return: nil | string configString 
]]--

--[[
  volume_master = Spring.GetConfigInt("snd_volmaster", 60) 	-- prelevo il valore del volume master
  volume_master = volume_master * 0.01						-- e lo converto in numero da 0 a 1
  volume_music = Spring.GetConfigInt("snd_volmusic", 60)
  volume_music = volume_music * 0.01  
  volume_battle = Spring.GetConfigInt("snd_volbattle", 60)
  volume_battle = volume_battle * 0.01  
]]--
--[[
---------------------------
-- TEAM CURSOR ESEMPIO DI SIMPLE MENU
---------------------------					
	elseif cmd == "teamcursopt" then
			if Button[12]["click"] then
			Spring.SetConfigInt("showteamcurs",0)
			Spring.SendCommands({"luaui disablewidget AllyCursors"}) 			
		else
			Spring.SetConfigInt("showteamcurs",1)
			Spring.SendCommands({"luaui enablewidget AllyCursors"}) 			
		end	
]]--
--[[
--ESEMPIO  
valore_mostracurs=Spring.GetConfigInt("showteamcurs",0) -- se non esiste di default è 0 ma anche il widget deve essere disabilitato.
if valore_mostracurs = 0 then
			Spring.SendCommands({"luaui disablewidget AllyCursors"}) 	-- disabilito il widget
end
]]--
 
end

--------------------------------------
-- INIZIALIZZO IL MENU 
--------------------------------------
function widget:Initialize()
-- all'inizio imposto la posizione del mini menu
	Pos_x_mainmenu = vsx/2 - larghezza_mainmenu/2
	Pos_y_mainmenu = vsy/2 - altezza_mainmenu/2
-- avvio la funzione check_options()
	check_options()
 end

--[[
--------------------------------------
-- SEMPRE
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if graphicsmenu_attivo and not Spring.IsGUIHidden() then
				-- ADVANCEMAPSHADING
				if 	((mousex >= Pos_x_mainmenu) and (mousex <= Pos_x_mainmenu + larghezza_mainmenu/2) and (mousey >= Pos_y_mainmenu+Posy_menuset+offsety_selettore) and (mousey <= Pos_y_mainmenu+Posy_menuset + altezza_menu_buttons+offsety_selettore)) then
				selettore_visibile = true
				posy_selettore = Posy_menuset																
				elseif
				-- visualsetting
				((mousex >= Pos_x_mainmenu) and (mousex <= Pos_x_mainmenu + larghezza_mainmenu) and (mousey >= Pos_y_mainmenu+Posy_visuals+offsety_selettore) and (mousey <= Pos_y_mainmenu+Posy_visuals + altezza_menu_buttons+offsety_selettore)) then
				selettore_visibile = true
				posy_selettore = Posy_visuals	
				else
				selettore_buttons_visibile = false
				selettore_visibile = false
				end
	end
end
]]--
--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile graphicsmenu_attivo è true.....
	if graphicsmenu_attivo and not Spring.IsGUIHidden() then
			-- Advanced map shading A SINISTRA icona "ON/OFF"
			return ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Advanced unit shading A DESTRA icona "ON/OFF"			
			or
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Show grass on maps  A SINISTRA icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- hardware cursor A DESTRA  icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni	)) 
			-- LUPS effect  A SINISTRA icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Bloom shader A DESTRA  icona "ON/OFF"	
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Show ground projectile light  A SINISTRA icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- X-RAY A DESTRA  icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Fullscreen  A SINISTRA icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Blinking units A DESTRA  icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- shadows icona "<-"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- shadows icona "->"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni))
--			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Show environment effects (snow, rain, etc) 	icona "<-"		
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Show environment effects (snow, rain, etc) 	icona "->"		
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Set Antialiasing level  icona "<-"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Set Antialiasing level  icona "->"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni))			
			-- Water type 	icona "<-"		
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Water type 	icona "->"		
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni))
	end --is gui hidden
end
--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE INSERENDO LE SPIEGAZIONI DEI PULSANTI ----------------------------
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
if graphicsmenu_attivo and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return "Graphics options menu  (only works in game)"
  else
    return "Graphics options menu"
  end
end
end
--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX)
--------------------------------------
function widget:MousePress(x, y, button)
if graphicsmenu_attivo and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return false
  end
	if button== 1 then -- aggiunto rev1
		if (widget:IsAbove(x, y)) then
				-- Advanced map shading A SINISTRA icona "ON/OFF"
			if ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_mapshading = valore_mapshading + 1
				if valore_mapshading > 1 then
				 valore_mapshading = 0
				end
				if valore_mapshading == 0 then
				Spring.SendCommands("AdvMapShading 0")
				Spring.SetConfigInt("AdvMapShading", 0)	
--				Echo("System: Disable advanced map shading,  maybe you need to restart the game. If you don't see any differences, maybe your graphics card doesn't support the shader.")
--				Spring.SendCommands({"luaui disablewidget AllyCursors"}) 	-- disabilito il widget
				elseif valore_mapshading == 1 then
				Spring.SendCommands("AdvMapShading 1")
				Spring.SetConfigInt("AdvMapShading", 1)					
--				Echo("System: Enable advanced map shading, maybe you need to restart the game. If you do not see any differents, maybe your graphics card doesn't support the shader.")				
--				Spring.SendCommands({"luaui enablewidget AllyCursors"}) 	-- disabilito il widget
				end
				return true
				-- Advanced unit shading A DESTRA icona "ON/OFF"			
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Advanced unit shading")
				return true		
				-- Show grass on maps  A SINISTRA icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Show grass")
				return true
				-- hardware cursor A DESTRA  icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni	)) then
				Echo("test hardware cursor")
				return true				
				-- LUPS effect  A SINISTRA icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test LUPS effect")
				return true
				-- Bloom shader A DESTRA  icona "ON/OFF"	
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Bloom shader")
				return true		
				-- Show ground projectile light  A SINISTRA icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Show ground projectile light")
				return true
				-- X-RAY A DESTRA  icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test X-RAY")
				return true					
				-- Fullscreen  A SINISTRA icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Fullscreen")
				return true
				-- Blinking units A DESTRA  icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Blinking")
				return true						
				-- shadows icona "<-"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test shadows indietro")
				return true
				-- shadows icona "->"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then							
				Echo("test shadows avanti")
				return true				
					-- Show environment effects (snow, rain, etc) 	icona "<-"		
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test environment")
				return true		
				-- Set Antialiasing level  icona "<-"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Antialiasing indietro")
				return true
				-- Set Antialiasing level  icona "->"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then							
				Echo("test Antialiasing avanti")
				return true		
				-- Water type 	icona "<-"		
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Water type indietro")
				return true		
				-- Water type 	icona "->"		
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				Echo("test Water type avanti")
				return true					
			end -- posizioni menu
		end -- isAbove
	end -- button = 1
    return false
  end -- GUIHidden
end -- function
--------------------------------------
-- DISEGNO IL MINIMENU
--------------------------------------
function widget:DrawScreen()
if graphicsmenu_attivo then -- se il main menu è attivo, allora disegnalo

-- inserisco il background del mainmenu
	gl.Color(1,1,1,1)
	gl.Texture(backgroundmainmenu)	
	gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_mainmenu,Pos_y_mainmenu+altezza_mainmenu)	
	gl.Texture(false)	-- fine texture	

-- Intestazione del menu
	-- testo
	font_intestazione:SetTextColor(1, 1, 1, 1)
	font_intestazione:Begin()
	font_intestazione:Print("Grapichs options", Pos_x_mainmenu+70, Pos_y_mainmenu + 220,14,'ds')
	font_intestazione:End()	
	
-- icona principale del menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_graphicsmenu)	
	gl.TexRect(	Pos_x_mainmenu+margine_sx_icona_graphicsmenu,Pos_y_mainmenu+altezza_mainmenu+margine_su_icona_graphicsmenu,Pos_x_mainmenu+margine_sx_icona_graphicsmenu+larghezza_icona_graphicsmenu,Pos_y_mainmenu+altezza_mainmenu+margine_su_icona_graphicsmenu+altezza_icona_graphicsmenu)	
	gl.Texture(false)	-- fine texture	

-- voce dx advanced unit shading 
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use advanced unit shading", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga7,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx advanced map shading 
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use advanced map shading", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga7 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_mapshading == 0 then
	gl.Texture(icona_off)	
	elseif valore_mapshading == 1 then
	gl.Texture(icona_on)		
	end	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		

-- voce dx hardware cursor
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use hardware cursor", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga6,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx Show grass on maps
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show grass on maps", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga6 ,12,'ds')
	font_generale:End()
	-- icona	
--	gl.Color(1,1,1,1)
--	gl.Texture(icona_on)	
--	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)	
--	gl.Texture(false)	-- fine texture		
	
-- voce dx bloom shader cursor
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use bloom shader", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga5,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx LUPS
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use LUPS effects", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga5 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		

-- voce dx x-ray
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use X-ray effects on units", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga4,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx ground projectiles
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show ground projectile light", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga4 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		

-- voce dx Blinking units
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Blinking units", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga3,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx fullscreen
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Fullscreen", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga3 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		
	
-- voce dx environments
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show environment effects (snow, rain, etc)", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga2,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_on)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx shadows
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Shadows", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga2 ,12,'ds')
	font_generale:End()
	-- icona down
	gl.Color(1,1,1,1)
	gl.Texture(icona_prec)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		
	-- icona up
	gl.Color(1,1,1,1)
	gl.Texture(icona_succ)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		

-- voce dx Water rendering
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Water rendering type", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga1,12,'ds')
	font_generale:End()		
	-- icona down
	gl.Color(1,1,1,1)
	gl.Texture(icona_prec)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	-- icona up
	gl.Color(1,1,1,1)
	gl.Texture(icona_succ)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture			
	
-- voce sx antialiasing
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Set Antialiasing level", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga1 ,12,'ds')
	font_generale:End()
	-- icona down
	gl.Color(1,1,1,1)
	gl.Texture(icona_prec)	
	gl.TexRect(	Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi,Pos_x_mainmenu +margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	-- icona up
	gl.Color(1,1,1,1)
	gl.Texture(icona_succ)	
	gl.TexRect(	Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi,Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture			
	
-- riquadro selettore delle opzioni del menu----------------------------------------------
	if  selettore_visibile then
	gl.Color(1,1,1,1)
	gl.Texture(selettore)	
	gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu + posy_selettore+offsety_selettore,Pos_x_mainmenu + 400 ,Pos_y_mainmenu + posy_selettore+offsety_selettore+altezza_selettore)	
	gl.Texture(false)	-- fine texture		
	end
	
-- pulsanti close e back (se presente)----------------------------------------------
	-- pulsante close
  	gl.Color(1,1,1,1)
	gl.Texture(button_close)	
	gl.TexRect(Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_mainmenu/2,Pos_y_mainmenu+posy_menu_button, Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons+larghezza_mainmenu/2,Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		

-- testo pulsante close	
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Close", Pos_x_mainmenu+posx_menu_button+distance_x_menu_button + 28+larghezza_mainmenu/2, Pos_y_mainmenu+posy_menu_button+5 ,12,'ds')
	font_generale:End()		

-- riquadro selettore dei pulsanti back, close ecc----------------------------------------------
	if  selettore_buttons_visibile then
	gl.Color(1,1,1,1)
	gl.Texture(selettore_button)	
	gl.TexRect(	posx_selettore_buttons,posy_selettore_buttons,posx_selettore_buttons+larghezza_menu_buttons ,posy_selettore_buttons + altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		
	end
	
end -- if graphicsmenu_attivo	
end --drawscreen

