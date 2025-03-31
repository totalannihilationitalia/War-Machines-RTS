--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_graphics.lua
--  brief:   War Machines RTS options mainmenu
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2025.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_visuals",
    desc      = "WMRTS visuals options",
    author    = "molixx81",
    date      = "31 Marzo, 2025",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
-- niente al momento
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix -- 31/03/2025 -- designing WMRTS visuals menu


-- definizione dei comandi
local Echo 								= Spring.Echo 
-- definizione variabili di posizione e lunghezza menu e icone
local visualsmenu_attivo				= false 							-- Indica se questo menu è attivo o meno
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local larghezza_mainmenu				= 700 								-- doppia rispetto a mainmenu
local altezza_mainmenu					= 276								-- + 2 opzioni (da 25 l'una), rispetto a mainmenu ATTENZIONE!!!! utilizzare solo numeri pari per divisioni /2!!! altrimenti le immagini potrebbero diventare sgranate!
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
local posy_selettore					= 0									-- posizione Y del selettore delle opzioni (verrà calcolato successivamente)
local posx_selettore					= 0									-- posizione x del selettore delle opzioni (verrà calcolato successivamente)
local mousex, mousey				   										-- posizione x e y del mouse, usata per rilevare la sua posizione e far apparire il selettore
local posy_riga1						= 25    							-- posizione y della prima riga di opzioni (dal fondo del background) di opzioni
local posy_riga2						= 50    							-- posizione y della seconda riga di opzioni (dal fondo del background) di opzioni
local posy_riga3						= 75    							-- posizione y della terza riga di opzioni (dal fondo del background) di opzioni 
local posy_riga4						= 100   							-- posizione y della quarta riga di opzioni (dal fondo del background) di opzioni 
local posy_riga5						= 125    							-- posizione y della quinta riga di opzioni (dal fondo del background) di opzioni 
local posy_riga6						= 150    							-- posizione y della sesta riga di opzioni (dal fondo del background) di opzioni 
local posy_riga7						= 175    							-- posizione y della settima riga di opzioni (dal fondo del background) di opzioni 
local posy_riga8						= 200    							-- posizione y dell' ottava riga di opzioni (dal fondo del background) di opzioni 
local posy_riga9						= 225    							-- posizione y dell' ottava riga di opzioni (dal fondo del background) di opzioni 
-- definizione valori delle opzioni
local valore_showunitrank  		
local valore_unitshealt			
local valore_showeta					
local valore_showunitsaura			
local valore_camerashake					
local valore_verticalline			
local valore_teammateselunits		
local valore_showingamealert
local 					
local valore_blinking				-- ########################################### sostituire
local valore_shadows				-- ########################################### sostituire
local valore_showenvironmental		-- ########################################### sostituire
local valore_antialiasing			-- ########################################### sostituire
local valore_watertype				-- ########################################### sostituire
local valore_showdps					-- ########################################### sostituire
local valore_mapborders				-- ########################################### sostituire
-- icona principale del menu
local larghezza_icona_graphicsmenu			= 40
local altezza_icona_graphicsmenu			= 40
local margine_sx_icona_graphicsmenu			= 20  	-- distanza dal margine sinistro del background e l'icona del menu
local margine_su_icona_graphicsmenu			= -30 	-- distanza di quanto sborda l'immagine dal bordo superiore del background
-- pulsanti back / close
local larghezza_menu_buttons 			= 76  		-- like back button, close button
local altezza_menu_buttons 				= 25  		-- like back button, close button
local distance_x_menu_button 			= 250 		-- distanza tra i due pulsanti 
local posx_menu_button = 11					  		-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button = -10				 		-- position y of first menu button (from 0 ,0 of main menu)
local selettore_buttons_visibile 		= false		-- visibile o no
local posx_selettore_buttons 		= 100					-- posizione x del selettore dei pulsanti close, back ecc
local posy_selettore_buttons 		= 100			-- posizione y del selettore dei pulsanti close, back ecc
-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/mainmenu/graph_menu_bkgnd.png"
local selettore 					= "LuaUI/Images/menu/mainmenu/menu_options_selection.png"
local selettore_button 				= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"
local icona_on 						= "LuaUI/Images/menu/mainmenu/graphics_on.png"
local icona_off 					= "LuaUI/Images/menu/mainmenu/graphics_off.png"
local icona_prec 					= "LuaUI/Images/menu/mainmenu/graphics_prec.png"
local icona_succ					= "LuaUI/Images/menu/mainmenu/graphics_succ.png"
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
	if command == 'open_WMRTS_visuals' then
		visualsmenu_attivo = true
	elseif command == 'close_WMRTS_visuals' then
		visualsmenu_attivo = false		
	end
end

--------------------------------------
-- ALLA PRESSIONE DEI TASTI 
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
	if visualsmenu_attivo and not Spring.IsGUIHidden() then
		if key == 27 then -- TASTO esc  0x01B
			visualsmenu_attivo = false 						-- chiudo graphicsmenu
			Spring.SendCommands("close_WMRTS_minimenu")			-- spengo il minipulsante menu del minimenu
			-- disabilito il guishader
				if (WG['guishader_api'] ~= nil) then
				WG['guishader_api'].RemoveRect('WMRTS_Guishader')
				end	
			return true
		end

	end
	
return false
end

--------------------------------------
-- FUNZIONE CHECK STATO OPZIONI, viene richiamata in diverse fasi dello script per controllare lo stato delle opzioni 
--------------------------------------
local function check_options()
-- all'inizio verifico anche il valore delle configurazioni
  valore_showunitrank = Spring.GetConfigInt("AdvMapShading", 1)			-- booleano di default è true  --################## definire configurazione da widget
  valore_unitshealt = Spring.GetConfigInt("AdvModelShading", 1)		-- booleano di default è true  --################## definire configurazione da widget
  valore_showeta = Spring.GetConfigInt("GrassDetail", 1)   				-- booleano di default è true --################## definire configurazione da widget
  valore_showunitsaura = Spring.GetConfigInt("HardwareCursor", 0) 		-- booleano di default è falso --################## definire configurazione da widget
  valore_camerashake = Spring.GetConfigInt("LupsActive", 0) 					-- booleano di default è falso -> disattivo successivamente anche il Widget				## widget --################## definire configurazione da widget
  valore_verticalline = Spring.GetConfigInt("BloomshaderActive", 0)		-- booleano di default è falso -> disattivo successivamente anche il Widget			## widget --################## definire configurazione da widget
  valore_teammateselunits = Spring.GetConfigInt("ShowProjectile", 0)	-- booleano di default è falso  -> disattivo successivamente anche il Widget	## widget --################## definire configurazione da widget
  valore_showingamealert = Spring.GetConfigInt("XrayActive", 0)					-- booleano di default è falso  -> disattivo successivamente anche il Widget			## widget--################## definire configurazione da widget
  valore_mapborder = Spring.GetConfigInt("Fullscreen", 1) 				-- booleano di default è true--################## definire configurazione da widget
  valore_blinking = Spring.GetConfigInt("teamhighlight", 1)   			-- booleano di default è true--################## definire configurazione da widget
  valore_shadows = Spring.GetConfigInt("Shadows", 2) 					-- -1:=forceoff, 0:=off, 1:=full, 2:=fast (skip terrain)--################## definire configurazione da widget
  valore_showenvironmental = Spring.GetConfigInt("EnviroActive", 0)		-- booleano di default è falso ->  -> disattivo successivamente anche il Widget			## widget--################## definire configurazione da widget
  valore_antialiasing = Spring.GetConfigInt("MSAALevel", 0) 			-- valori da 0 a 32 MAX--################## definire configurazione da widget
  valore_watertype = Spring.GetConfigInt("Water", 1) 					-- Defines the type of water rendering. Can be set in game. Options are: 0 = Basic water, 1 = Reflective water, 2 = Reflective and Refractive water, 3 = Dynamic water, 4 = Bumpmapped water--################## definire configurazione da widget
  valore_showdps = Spring.GetConfigInt("VSync", 0)   						-- valori 1 o 0 (default) abilita o disabilita standard VSynk--################## definire configurazione da widget
  valore_mapborders = Spring.GetConfigInt("MapBorder", 1)   			-- valori 1 (default) o 0 abilita o disabilita bordi della mappa--################## definire configurazione da widget
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

--------------------------------------
-- SEMPRE
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if visualsmenu_attivo and not Spring.IsGUIHidden() then
			-- Advanced map shading A SINISTRA icona "ON/OFF"			
			if ((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true
				selettore_buttons_visibile = false
			-- Advanced unit shading A DESTRA icona "ON/OFF"			
			elseif ((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20				
--				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone
				selettore_visibile = true			
				selettore_buttons_visibile = false
			-- Show grass on maps  A SINISTRA icona "ON/OFF" 
			elseif ((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false				
			-- Show mapborders  A SINISTRA icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)) then			
				posy_selettore = Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true			
				selettore_buttons_visibile = false
			-- hardware cursor A DESTRA  icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni	)) then
				posy_selettore = Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- LUPS effect  A SINISTRA icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Bloom shader A DESTRA  icona "ON/OFF"	
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Show ground projectile light  A SINISTRA icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- X-RAmousey A DESTRA  icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true
				selettore_buttons_visibile = false
			-- Fullscreen  A SINISTRA icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Blinking units A DESTRA  icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Vsync A DESTRA  icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true		
				selettore_buttons_visibile = false
			-- shadows icona "<-"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- shadows icona "->"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (mousey >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni))then
				posy_selettore = Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Show environment effects (snow, rain, etc) 	icona "ON/OFF"
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true	
				selettore_buttons_visibile = false			
			-- Set Antialiasing level  icona "<-"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Set Antialiasing level  icona "->"
			elseif((mousex >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (mousex <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (mousey >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Water type 	icona "<-"		
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (mousey >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				posy_selettore = Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- Water type 	icona "->"		
			elseif((mousex >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (mousex <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (mousey >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (mousey <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni))then
				posy_selettore = Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi - 2
				posx_selettore = Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone-20	
				selettore_visibile = true	
				selettore_buttons_visibile = false
			-- BACK button			
			elseif((mousex >= Pos_x_mainmenu+posx_menu_button) and (mousex <= Pos_x_mainmenu+posx_menu_button+larghezza_menu_buttons) and (mousey >= Pos_y_mainmenu+posy_menu_button) and (mousey <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons))then
				posx_selettore_buttons = Pos_x_mainmenu+posx_menu_button
				posy_selettore_buttons = Pos_y_mainmenu+posy_menu_button				
				selettore_visibile = false	
				selettore_buttons_visibile = true
			-- CLOSE button						
			elseif((mousex >= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_mainmenu/2) and (mousex <= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons+larghezza_mainmenu/2) and (mousey >= Pos_y_mainmenu+posy_menu_button) and (mousey <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons))then
				posx_selettore_buttons = Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_mainmenu/2
				posy_selettore_buttons = Pos_y_mainmenu+posy_menu_button
				selettore_visibile = false	
				selettore_buttons_visibile = true				
			else 
				selettore_visibile = false
				selettore_buttons_visibile = false
			end --if posxy mouse
	end
end

--------------------------------------
-- MOUSE IS OVER BUTTONS --> fare riferimento a "Elenco opzioni Graphics_visuals.ods" per la disposizione delle opzioni
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile visualsmenu_attivo è true.....
	if visualsmenu_attivo and not Spring.IsGUIHidden() then
			-- Advanced map shading A SINISTRA icona "ON/OFF"
			return ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Advanced unit shading A DESTRA icona "ON/OFF"			
			or
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Show grass on maps  A SINISTRA icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Show mapborders  A SINISTRA icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)) 			
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
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- Vsync A DESTRA  icona "ON/OFF"
			or 
			((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- shadows icona "<-"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) 
			-- shadows icona "->"
			or 
			((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni))
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
			-- BACK button	
			or
			((x >=Pos_x_mainmenu+posx_menu_button) and (x <= Pos_x_mainmenu+posx_menu_button+larghezza_menu_buttons) and (y >= Pos_y_mainmenu+posy_menu_button) and (y <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons))
			-- CLOSE button						
			or
			((x >= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_mainmenu/2) and (x <= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons+larghezza_mainmenu/2) and (y >= Pos_y_mainmenu+posy_menu_button) and (y <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons))
	end --is gui hidden
end
--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE INSERENDO LE SPIEGAZIONI DEI PULSANTI ----------------------------
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
if visualsmenu_attivo and not Spring.IsGUIHidden() then
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
if visualsmenu_attivo and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return false
  end
	if button== 1 then -- aggiunto rev1
		if (widget:IsAbove(x, y)) then
				-- SHOW UNITS RANK A SINISTRA icona "ON/OFF" -- ########################################## se clicco sull'icona della relativa opzione, aggiungo +1 al valore, di conseguenza diventa 0 o 1. Serve per impostare poi la grafica corretta della casella di selezione ON/OFF
			if ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_showunitrank = valore_showunitrank + 1
				if valore_showunitrank > 1 then
				 valore_showunitrank = 0
				end
				if valore_showunitrank == 0 then
					Spring.SendCommands("AdvMapShading 0") -- ##########################
					Spring.SetConfigInt("AdvMapShading", 0)	-- ##########################
				elseif valore_showunitrank == 1 then
					Spring.SendCommands("AdvMapShading 1") -- ##########################
					Spring.SetConfigInt("AdvMapShading", 1)		-- ##########################
					Echo("May require a reboot for the changes to take effect")
				end
				return true
				-- show unit healt A DESTRA icona "ON/OFF" -- ################################# se clicco sull'icona della relativa opzione, aggiungo +1 al valore, di conseguenza diventa 0 o 1. Serve per impostare poi la grafica corretta della casella di selezione ON/OFF			
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_unitshealt = valore_unitshealt + 1
				if valore_unitshealt > 1 then
					valore_unitshealt = 0
				end
				if valore_unitshealt == 0 then
					Spring.SendCommands("AdvModelShading 0") -- ##########################
					Spring.SetConfigInt("AdvModelShading", 0)	-- ##########################
				elseif valore_unitshealt == 1 then
					Spring.SendCommands("AdvModelShading 1") -- ##########################
					Spring.SetConfigInt("AdvModelShading", 1)	-- ##########################	
				end
				return true		
				-- Show ETA  A SINISTRA icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_showeta = valore_showeta + 1
				if valore_showeta > 1 then
					valore_showeta = 0
				end
				if valore_showeta == 0 then
					Spring.SendCommands("GrassDetail 0")
					Spring.SetConfigInt("GrassDetail", 0)	
				elseif valore_showeta == 1 then
					Spring.SendCommands("GrassDetail 1")
					Spring.SetConfigInt("GrassDetail", 1)		
				end
				return true
				-- Show map borders A SINISTRA RIGA 8 icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_mapborders = valore_mapborders + 1
				if valore_mapborders > 1 then
					valore_mapborders = 0
				end
				if valore_mapborders == 0 then
					Spring.SendCommands("MapBorder 0")
					Spring.SetConfigInt("MapBorder", 0)	
				elseif valore_mapborders == 1 then
					Spring.SendCommands("MapBorder 1")
					Spring.SetConfigInt("MapBorder", 1)		
				end
				return true				
				-- units AUREA A DESTRA  icona "ON/OFF" -- se clicco sull'icona della relativa opzione, aggiungo +1 al valore, di conseguenza diventa 0 o 1. Serve per impostare poi la grafica corretta della casella di selezione ON/OFF
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni	)) then
				valore_showunitsaura = valore_showunitsaura + 1
				if valore_showunitsaura > 1 then
					valore_showunitsaura = 0
				end
				if valore_showunitsaura == 0 then
					Spring.SendCommands("HardwareCursor 0")
					Spring.SetConfigInt("HardwareCursor", 0)	
				elseif valore_showunitsaura == 1 then
					Spring.SendCommands("HardwareCursor 1")
					Spring.SetConfigInt("HardwareCursor", 1)	
				end
				return true				
				-- Camera shake effect  A SINISTRA icona "ON/OFF"	 WIDGET
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_camerashake = valore_camerashake + 1
				if valore_camerashake > 1 then
				 valore_camerashake = 0
				end
				if valore_camerashake == 0 then
					Spring.SendCommands({"luaui disablewidget Lups"}) 				-- disabilito il widget
					Spring.SendCommands({"luaui disablewidget LupsManager"}) 		-- disabilito il widget
					Spring.SetConfigInt("LupsActive", 0)	
				elseif valore_camerashake == 1 then
					Spring.SendCommands({"luaui enablewidget Lups"}) 				-- abilito il widget
					Spring.SendCommands({"luaui enablewidget LupsManager"}) 		-- abilito il widget
					Spring.SetConfigInt("LupsActive", 1)					
				end				
				return true
				-- show vertical line A DESTRA  icona "ON/OFF"	 WIDGET	
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_verticalline = valore_verticalline + 1
				if valore_verticalline > 1 then
				 valore_verticalline = 0
				end
				if valore_verticalline == 0 then
					Spring.SendCommands({"luaui disablewidget Bloom Shader"}) 		-- disabilito il widget
					Spring.SetConfigInt("BloomshaderActive", 0)	
				elseif valore_verticalline == 1 then
					Spring.SendCommands({"luaui enablewidget Bloom Shader"}) 		-- abilito il widget
					Spring.SetConfigInt("BloomshaderActive", 1)					
				end				
				return true		
				-- Show teammates selected units  A SINISTRA icona "ON/OFF"	 WIDGET
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_teammateselunits = valore_teammateselunits + 1
				if valore_teammateselunits > 1 then
				 valore_teammateselunits = 0
				end
				if valore_teammateselunits == 0 then
					Spring.SendCommands({"luaui disablewidget Projectile lights"}) 		-- disabilito il widget
					Spring.SetConfigInt("ShowProjectile", 0)	
				elseif valore_teammateselunits == 1 then
					Spring.SendCommands({"luaui enablewidget Projectile lights"}) 		-- abilito il widget
					Spring.SetConfigInt("ShowProjectile", 1)					
				end		
				return true
				-- shown ingame alert A DESTRA  icona "ON/OFF"	 WIDGET
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_showingamealert = valore_showingamealert + 1
				if valore_showingamealert > 1 then
				 valore_showingamealert = 0
				end
				if valore_showingamealert == 0 then
					Spring.SendCommands({"luaui disablewidget XrayShader"}) 		-- disabilito il widget
					Spring.SetConfigInt("XrayActive", 0)	
				elseif valore_showingamealert == 1 then
					Spring.SendCommands({"luaui enablewidget XrayShader"}) 		-- abilito il widget
					Spring.SetConfigInt("XrayActive", 1)					
				end		
				return true					
				-- Mapborder  A SINISTRA icona "ON/OFF" -- se clicco sull'icona della relativa opzione, aggiungo +1 al valore, di conseguenza diventa 0 o 1. Serve per impostare poi la grafica corretta della casella di selezione ON/OFF
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_mapborder = valore_mapborder + 1
				if valore_mapborder > 1 then
					valore_mapborder = 0
				end
				if valore_mapborder == 0 then
					Spring.SendCommands("Fullscreen 0")
					Spring.SetConfigInt("Fullscreen", 0)	
				elseif valore_mapborder == 1 then
					Spring.SendCommands("Fullscreen 1")
					Spring.SetConfigInt("Fullscreen", 1)		
				end
				return true
				-- Blinking units A DESTRA  icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_blinking = valore_blinking + 1
				if valore_blinking > 1 then
					valore_blinking = 0
				end
				if valore_blinking == 0 then
					Spring.SendCommands("TeamHighlight 0")
					Spring.SetConfigInt("TeamHighlight", 0)	
				elseif valore_blinking == 1 then
					Spring.SendCommands("TeamHighlight 1")
					Spring.SetConfigInt("TeamHighlight", 1)		
				end
				return true						
				-- shadows icona "<-"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_shadows = valore_shadows - 1
				if valore_shadows < 0 then
					valore_shadows = 0
				end
				if valore_shadows == 0 then
					Spring.SendCommands("Shadows 0")
					Spring.SetConfigInt("Shadows", 0)	
				elseif valore_shadows == 1 then
					Spring.SendCommands("Shadows 1")
					Spring.SetConfigInt("Shadows", 1)		
				elseif valore_shadows == 2 then
					Spring.SendCommands("Shadows 2")
					Spring.SetConfigInt("Shadows", 2)	
				end
				return true
				-- shadows icona "->"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then							
				valore_shadows = valore_shadows + 1
				if valore_shadows > 2 then
					valore_shadows = 2
				end
				if valore_shadows == 0 then
					Spring.SendCommands("Shadows 0")
					Spring.SetConfigInt("Shadows", 0)	
				elseif valore_shadows == 1 then
					Spring.SendCommands("Shadows 1")
					Spring.SetConfigInt("Shadows", 1)		
				elseif valore_shadows == 2 then
					Spring.SendCommands("Shadows 2")
					Spring.SetConfigInt("Shadows", 2)	
				end				
				return true				
					-- Show environment effects (snow, rain, etc) 	icona "ON/OFF"	 WIDGET
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_showenvironmental = valore_showenvironmental + 1
				if valore_showenvironmental > 1 then	
					valore_showenvironmental = 0
				end 
				if valore_showenvironmental == 0 then
					Spring.SendCommands({"luaui disablewidget Snow"}) 		-- disabilito il widget
					Spring.SetConfigInt("EnviroActive", 0)	
				elseif valore_showenvironmental == 1 then
					Spring.SendCommands({"luaui enablewidget Snow"}) 		-- abilito il widget
					Spring.SetConfigInt("EnviroActive", 1)					
				end					
--			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)) then
--				Echo("test environment")
--				return true		
				-- Set Antialiasing level  icona "<-"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_antialiasing = valore_antialiasing - 1
				Echo("Restart is require for changes to take effect")
				if valore_antialiasing < 0 then
					valore_antialiasing = 0
				end
				Spring.SendCommands("MSAALevel "..valore_antialiasing)
				Spring.SetConfigInt("MSAALevel", valore_antialiasing)					
				return true
				-- Set Antialiasing level  icona "->"
			elseif ((x >= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then							
				valore_antialiasing = valore_antialiasing + 1
				Echo("Restart is require for changes to take effect")				
				if valore_antialiasing > 32 then
					valore_antialiasing = 32	
				end
				Spring.SendCommands("MSAALevel "..valore_antialiasing)
				Spring.SetConfigInt("MSAALevel", valore_antialiasing)	
				return true		
				-- Water type 	icona "<-"		
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_watertype = valore_watertype - 1
				if valore_watertype < 0 then
					valore_watertype = 0
				end
				if valore_watertype == 0 then
					Spring.SendCommands("Water 0")
					Spring.SetConfigInt("Water", 0)	
				elseif valore_watertype == 1 then
					Spring.SendCommands("Water 1")
					Spring.SetConfigInt("Water", 1)		
				elseif valore_watertype == 2 then
					Spring.SendCommands("Water 2")
					Spring.SetConfigInt("Water", 2)	
				elseif valore_watertype == 3 then
					Spring.SendCommands("Water 3")
					Spring.SetConfigInt("Water", 3)	
				elseif valore_watertype == 4 then
					Spring.SendCommands("Water 4")
					Spring.SetConfigInt("Water", 4)						
				end		
				return true		
				-- Water type 	icona "->"		
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi) and (y >= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga1 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_watertype = valore_watertype + 1
				if valore_watertype > 4 then
					valore_watertype = 4
				end
				if valore_watertype == 0 then
					Spring.SendCommands("Water 0")
					Spring.SetConfigInt("Water", 0)	
				elseif valore_watertype == 1 then
					Spring.SendCommands("Water 1")
					Spring.SetConfigInt("Water", 1)		
				elseif valore_watertype == 2 then
					Spring.SendCommands("Water 2")
					Spring.SetConfigInt("Water", 2)	
				elseif valore_watertype == 3 then
					Spring.SendCommands("Water 3")
					Spring.SetConfigInt("Water", 3)	
				elseif valore_watertype == 4 then
					Spring.SendCommands("Water 4")
					Spring.SetConfigInt("Water", 4)						
				end		
				return true			
				-- Show DPS A DESTRA RIGA 3  icona "ON/OFF"
			elseif ((x >= Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone) and (x <= Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone) and (y >= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi) and (y <= Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)) then
				valore_showdps = valore_showdps + 1
				if valore_showdps > 1 then
					valore_showdps = 0
				end
				if valore_showdps == 0 then
					Spring.SendCommands("VSync 0")
					Spring.SetConfigInt("VSync", 0)	
				elseif valore_showdps == 1 then
					Spring.SendCommands("VSync 1")
					Spring.SetConfigInt("VSync", 1)		
				end
				return true		

			-- BACK button	
			elseif ((x >=Pos_x_mainmenu+posx_menu_button) and (x <= Pos_x_mainmenu+posx_menu_button+larghezza_menu_buttons) and (y >= Pos_y_mainmenu+posy_menu_button) and (y <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)) then
			Spring.Echo("tornare indietro")
			return true
			
			-- CLOSE button						
			elseif ((x >= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_mainmenu/2) and (x <= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons+larghezza_mainmenu/2) and (y >= Pos_y_mainmenu+posy_menu_button) and (y <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)) then
			Spring.Echo("chiudere")
			return true		


				
			end -- posizioni menu
		end -- isAbove
	end -- button = 1
    return false
  end -- GUIHidden
end -- function

local function drawingpulsanti()
-- pulsanti close e back 
-- pulsante back, first button
  	gl.Color(1,1,1,1)
	gl.Texture(button_back)	-- add the icon
	gl.TexRect(Pos_x_mainmenu+posx_menu_button,Pos_y_mainmenu+posy_menu_button, Pos_x_mainmenu+posx_menu_button+larghezza_menu_buttons,Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		

	-- pulsante close
  	gl.Color(1,1,1,1)
	gl.Texture(button_close)	
	gl.TexRect(Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_mainmenu/2,Pos_y_mainmenu+posy_menu_button, Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons+larghezza_mainmenu/2,Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		

-- testi dei PULSANTI back e close
	-- testo main menu (back)
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print(("MAIN MENU"), Pos_x_mainmenu+posx_menu_button+ 45, Pos_y_mainmenu+posy_menu_button +9, 9, "ocn") -- BACK BUTTON	
	font_generale:End()	
	-- testo pulsante close	
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Close", Pos_x_mainmenu+posx_menu_button+distance_x_menu_button + 28+larghezza_mainmenu/2, Pos_y_mainmenu+posy_menu_button+5 ,12,'ds')
	font_generale:End()		
end

--------------------------------------
-- DISEGNO IL MINIMENU
--------------------------------------
function widget:DrawScreen()
if visualsmenu_attivo then -- se il main menu è attivo, allora disegnalo

-- inserisco il background del mainmenu
	gl.Color(1,1,1,1)
	gl.Texture(backgroundmainmenu)	
	gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_mainmenu,Pos_y_mainmenu+altezza_mainmenu)	
	gl.Texture(false)	-- fine texture	

-- Intestazione del menu
	-- testo
	font_intestazione:SetTextColor(1, 1, 1, 1)
	font_intestazione:Begin()
	font_intestazione:Print("Grapichs options", Pos_x_mainmenu+70, Pos_y_mainmenu + 220+25,14,'ds')
	font_intestazione:End()	
	
-- icona principale del menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_graphicsmenu)	
	gl.TexRect(	Pos_x_mainmenu+margine_sx_icona_graphicsmenu,Pos_y_mainmenu+altezza_mainmenu+margine_su_icona_graphicsmenu,Pos_x_mainmenu+margine_sx_icona_graphicsmenu+larghezza_icona_graphicsmenu,Pos_y_mainmenu+altezza_mainmenu+margine_su_icona_graphicsmenu+altezza_icona_graphicsmenu)	
	gl.Texture(false)	-- fine texture	

-- voce dx unit healt
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show units healt", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga7,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	if valore_unitshealt == 0 then
	gl.Texture(icona_off)	
	elseif valore_unitshealt == 1 then
	gl.Texture(icona_on)		
	end	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx showunitrank
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show units rank", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga7 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_showunitrank == 0 then
	gl.Texture(icona_off)	
	elseif valore_showunitrank == 1 then
	gl.Texture(icona_on)		
	end	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga7 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		

-- voce dx units aurea
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show units aurea", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga6,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	if valore_showunitsaura == 0 then
	gl.Texture(icona_off)	
	elseif valore_showunitsaura == 1 then
	gl.Texture(icona_on)		
	end	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx Show ETA
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show grass on maps", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga6 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_showeta == 0 then
	gl.Texture(icona_off)	
	elseif valore_showeta == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu+ margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga6 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce dx bloom shader cursor
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show vertical lines", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga5,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	if valore_verticalline == 0 then
	gl.Texture(icona_off)	
	elseif valore_verticalline == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx LUPS
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Camera shake effect", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga5 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_camerashake == 0 then
	gl.Texture(icona_off)	
	elseif valore_camerashake == 1 then
	gl.Texture(icona_on)		
	end	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga5 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		

-- voce dx show ingame alert
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show teammates cursor", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga4,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	if valore_showingamealert == 0 then
	gl.Texture(icona_off)	
	elseif valore_showingamealert == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx ground projectiles
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show teammates selected units", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga4 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_teammateselunits == 0 then
	gl.Texture(icona_off)	
	elseif valore_teammateselunits == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga4 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		

-- voce dx Blinking units
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Blinking units", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga8,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	if valore_blinking == 0 then
	gl.Texture(icona_off)	
	elseif valore_blinking == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		

-- voce dx Show DPS
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Show DPS", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga3,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	if valore_showdps == 0 then
	gl.Texture(icona_off)	
	elseif valore_showdps == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga3 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		

-- voce sx mapborders
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Map borders", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga8 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_mapborders == 0 then
	gl.Texture(icona_off)	
	elseif valore_mapborders == 1 then
	gl.Texture(icona_on)		
	end	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga8 - distanzay_icone_testi+altezza_icona_opzioni)
	gl.Texture(false)	-- fine texture		
	
-- voce sx mapborder
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Map border", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga3 ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	if valore_mapborder == 0 then
	gl.Texture(icona_off)	
	elseif valore_mapborder == 1 then
	gl.Texture(icona_on)		
	end	
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
		if valore_showenvironmental == 0 then
	gl.Texture(icona_off)	
	elseif valore_showenvironmental == 1 then
	gl.Texture(icona_on)		
	end		
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_riga2 - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sx shadows
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
		if valore_shadows == 0 then
			font_generale:Print("Shadows: OFF", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga2 ,12,'ds')	
		elseif valore_shadows == 1 then
			font_generale:Print("Shadows: Full (Units + Terrains)", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga2 ,12,'ds')	
		elseif valore_shadows == 2 then		
			font_generale:Print("Shadows: Only units", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga2 ,12,'ds')			
		end		
	
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
		if valore_watertype == 0 then
			font_generale:Print("Water render: Basic", Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga1,12,'ds')
		elseif valore_watertype == 1 then
			font_generale:Print("Water render: Reflective",  Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga1,12,'ds')
		elseif valore_watertype == 2 then		
			font_generale:Print("Water render: Reflective and Refractive",  Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga1,12,'ds')	
		elseif valore_watertype == 3 then		
			font_generale:Print("Water render:  Dynamic water",  Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga1,12,'ds')
		elseif valore_watertype == 4 then		
			font_generale:Print("Water render:  Bumpmapped water",  Pos_x_mainmenu + margine_sx_scritte+ larghezza_mainmenu/2, Pos_y_mainmenu + posy_riga1,12,'ds')
		end			
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
	font_generale:Print(("Antialiasing level: "..valore_antialiasing), Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + posy_riga1 ,12,'ds')
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
	gl.TexRect(	posx_selettore,posy_selettore,posx_selettore + larghezza_mainmenu/2 , posy_selettore + altezza_selettore)	
	gl.Texture(false)	-- fine texture		
	end
-- disegno i pulsanti close e back	
drawingpulsanti()

-- riquadro selettore dei pulsanti back, close ecc----------------------------------------------
	if  selettore_buttons_visibile then
	gl.Color(1,1,1,1)
	gl.Texture(selettore_button)	
	gl.TexRect(	posx_selettore_buttons,posy_selettore_buttons,posx_selettore_buttons+larghezza_menu_buttons ,posy_selettore_buttons + altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		
	end
	
-- add gui shader----------------------------------------------
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect(Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_mainmenu,Pos_y_mainmenu+altezza_mainmenu,'WMRTS_Guishader')
	end
	
end -- if visualsmenu_attivo	
end --drawscreen

