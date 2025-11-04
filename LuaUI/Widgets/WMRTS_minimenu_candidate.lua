--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_minimenu.lua
--  brief:   War Machines RTS options minimenu
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2024.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_mini menu",
    desc      = "WMRTS mini-menù options",
    author    = "molixx81",
    date      = "02 Dicember, 2024",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
-- pulsanti piccoli / grossi
-- gestire se si vuole il LOS attivo alla partenza oppure no
-- inserire nel DrawMapDataMinimenu() i markers sugli estrattori di metallo
-- inserire il pulsante harvester
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix -- 02/12/2024 -- designing top right WMRTS mini-menù
-- rev 1 by molix -- 24/12/2024 -- integrato il controllo del LOS cosi che si interfacci correttamente con il minimenu
-- rev 2 by molix -- 03/01/2025 -- risolto problema di memoria e relativo crash in Spring. Ottimizzato il codice.
-- rev 3 by molix -- 28/01/2025 -- aggiunto minipulsante "show terrain resources"
-- rev 4 by molix -- 02/06/2025 -- aggiunta la funzione "blinking" al pulsante objective quando si riceve il comando: Spring.SendCommands("blink_WMRTS_obj")
-- rev 5 by molix -- 26/09/2025 -- aggiunto check is WMRTSmission ? se si fai apparire i pulsante objectives e diary
-- rev 6 by molix -- 04/11/2025 -- aggiunto unit's deployment system 
-- rev 7 by molix -- 04/11/2025 -- change code logic due upvalue, using tables, the variables are  becoming many

-- definizione pulsanti minimenu
local larghezza_main_minimenu_button 	= 50 	-- larghezza del pulsante "main menu" del minimenu (più largo degli altri)
local larghezza_minimenu_buttons 		= 35 	-- larghezza di tutti i pulsanti del minimenu
local altezza_minimenu_buttons 			= 35 	-- altezza di tutti i pulanti del minimenu
local margine_dx_minimenu 				= 5 	-- da destra
local margine_su_minimenu 				= 5		-- da sopra
local margine_giu_minimenu 				= 5 	-- margine dal sotto il pulsante al bordo del background
local margine_sx_minimenu 				= 5 	-- margine da sinistra dell'ultimo pulsante a sx, serve a creare l'ultimo blocco del background image
local interspazio_buttons				= 2 	-- spazio tra un pulsante e l altro
local interspazio_button_separator		= 5 	-- spazio tra una serie di pulsanti (menu) e l'altro (funzionali), ad esempio distanzio i pulsanti menu, sound ecc con i pulsanti builder, wind, ecc
-- local objbuttosinblinking				= 0		-- 1 se c'è una notifica
-- local diarybuttosinblinking				= 0		-- 1 se c'è una notifica
--local Button_[6].isBlinking				= 0		-- 1 se c'è una notifica
--local Button_[1].showMiniButton	= true 		--######## eliminare e sostituire da tabelle
--local Button_[2].showMiniButton		= true 		--######## eliminare e sostituire da tabelle
--local Button_[3].showMiniButton		= true 		--######## eliminare e sostituire da tabelle
--local Button_[4].showMiniButton			= true 		--######## eliminare e sostituire da tabelle
--local show_minimenu_los_button			= true 		--######## eliminare e sostituire da tabelle
--local Button_[6].showMiniButton			= true 		--######## eliminare e sostituire da tabelle
--local Button_[7].showMiniButton		= true 		--######## eliminare e sostituire da tabelle
--local Button_[8].showMiniButton			= true 		--######## eliminare e sostituire da tabelle					-- non è un bottone ma è una finestrella con il valore del vento
--local Button_[9].showMiniButton		= true 		--######## eliminare e sostituire da tabelle					-- non è un bottone ma è una finestrella con il valore delle maree
--local Button_[10].showMiniButton 	= true 		--######## eliminare e sostituire da tabelle
-- inizializzo le tabelle dei pulsanti
local Button_ ={
	{ name = "statistics_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5}, 		-- Button_[1]. = name of button, show relative minibutton, show/open relative menu, is button blinking (due alert), is mouse over, posx of button
	{ name = "object_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},				-- Button_[2].
	{ name = "diary_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},				-- Button_[3].
	{ name = "snd_butto", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},					-- Button_[4].
	{ name = "los_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},				-- Button_[5].
	{ name = "unitdeploy_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},			-- Button_[6].
	{ name = "builder_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},			-- Button_[7].
	{ name = "wind_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},				-- Button_[8].
	{ name = "tidal_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},				-- Button_[9].
	{ name = "resources_button", showMiniButton = true, showMenu = false, isBlinking= false, mouseOver = false, Pos_x_button = 5},			-- Button_[10].
}  
local missione_attiva					= 0						-- se 0 partita skirmish, se 1 partita WMRTSmission, se 2 partita FLEAmission. Definira quali pulsanti devono apparire o meno (OBJ e diary)

-- definizione variabili di posizione e lunghezza
local Pos_x_minimenu_button		        = 200					-- corrisponde alla distanza X tra il vertice in basso a sx del minimenu_buttons e il margine destro del monitor
local Pos_y_minimenu_button				= 200 					-- corrisponde alla distanza Y tra il vertice in basso a sx del minimenu_buttons e il margine superiore del monitor
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local Pos_x_next_button_drawing					-- Usato nel drawing, il valore della posizione si sposterà man mano di quanti pulsanti sono attivi, cosi da disegnarli uno di fianco all'altro
--local Button_[1].Pos_x_button			= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
--local Button_[2].Pos_x_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)	
--local Button_[3].Pos_x_button				= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)	
-- local Button_[6].Pos_x_button				= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)	
--local Button_[4].Pos_x_button			= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
-- local Button_[5].Pos_x_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
-- local Button_[7].Pos_x_button				= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
-- local Button_[8].Pos_x_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
-- local Button_[9].Pos_x_button				= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
--local Button_[10].Pos_x_button			= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_riquadro_button				= 5		-- posizione X del riquadro per evidenziare l' "above" sui pulsanti generici
local Pos_y_riquadro_button				= 5		-- posizione Y del riquadro per evidenziare l' "above" sui pulsanti generici
local Pos_x_riquadro_mainbutton			= 5		-- posizione X del riquadro per evidenziare l' "above" sul pulsante main menu
local Pos_y_riquadro_mainbutton			= 5		-- posizione Y del riquadro per evidenziare l' "above" sul pulsante main menu

-- definizione variabili MENU aperti/chiusi
local show_mainmenu						= false	 		 															-- is mainmenu active?
-- local Button_[4].showMenu 						= false 		--######## eliminare e sostituire da tabelle 				-- is sound menu options active?
-- local Button_[1].showMenu				= false	 		--######## eliminare e sostituire da tabelle				-- is statistics table active?
-- local Button_[2].showMenu						= false  		--######## eliminare e sostituire da tabelle				-- is obj windows active? 
-- local Button_[6].showMenu					= false	 		--######## eliminare e sostituire da tabelle				-- is units deploy active?
-- local Button_[3].showMenu					= false  		--######## eliminare e sostituire da tabelle				-- is diary windows active?
-- local Button_[5].showMenu						= false	 		--######## eliminare e sostituire da tabelle				-- is LOS windows active? -- or function active?? --todo
-- local Button_[7].showMenu					= false	 		--######## eliminare e sostituire da tabelle				-- is builder windows active? -- or function active?? --todo
-- local Button_[8].showMenu						= false	 		--######## eliminare e sostituire da tabelle				-- is wing windows active? -- or function active?? --todo
-- local Button_[9].showMenu					= false 		--######## eliminare e sostituire da tabelle					-- is tidal windows active? -- or function active?? --todo
-- local Button_[10].showMenu				= false	 		--######## eliminare e sostituire da tabelle				-- is resources widget active? 
local valore_resourcesmenu				= 0						-- assumera un valore in funzione delle impostazioni caricate nel springconfig... indica l'ultimo stato del "show map resources"

-- definizioni immagini ON/OFF bottoni e background
local mainminimenubutton_off = "LuaUI/Images/menu/minimenu/main_menu_off.png"
local mainminimenubutton_on = "LuaUI/Images/menu/minimenu/main_menu_on.png"
local statisticsbutton_off = "LuaUI/Images/menu/minimenu/statisticsbutton_off.png"
local statisticsbutton_on = "LuaUI/Images/menu/minimenu/statisticsbutton_on.png"
local objbutton_off = "LuaUI/Images/menu/minimenu/objbutton_off.png"
local objbutton_on = "LuaUI/Images/menu/minimenu/objbutton_on.png"
local objbutton_blinking = "LuaUI/Images/menu/minimenu/objbutton_blinking.png"
local deploy_off = "LuaUI/Images/menu/minimenu/garagebutton_off.png"
local deploy_on = "LuaUI/Images/menu/minimenu/garagebutton_on.png"
local deploy_blinking = "LuaUI/Images/menu/minimenu/garagebutton_blink.png"
local diarybutton_off = "LuaUI/Images/menu/minimenu/diarybutton_off.png"
local diarybutton_on = "LuaUI/Images/menu/minimenu/diarybutton_on.png"
local diarybutton_blinking = "LuaUI/Images/menu/minimenu/diarybutton_blinking.png"
local builderbutton_off = "LuaUI/Images/menu/minimenu/builderbutton_off.png"
local builderbutton_on = "LuaUI/Images/menu/minimenu/builderbutton_on.png"
local losbutton_off = "LuaUI/Images/menu/minimenu/losbutton_off.png"
local losbutton_on = "LuaUI/Images/menu/minimenu/losbutton_on.png"
local windbutton_off = "LuaUI/Images/menu/minimenu/windbutton_off.png"
local windbutton_on = "LuaUI/Images/menu/minimenu/windbutton_on.png"
local tidebutton_off = "LuaUI/Images/menu/minimenu/tidebutton_off.png"
local tidebutton_on = "LuaUI/Images/menu/minimenu/tidebutton_on.png"
local sndbutton_off = "LuaUI/Images/menu/minimenu/sndbutton_off.png"
local sndbutton_on = "LuaUI/Images/menu/minimenu/sndbutton_on.png"
local minimenu_bkgnd_btn = "LuaUI/Images/menu/minimenu/minimenu_bkgnd_btn.png"
local minimenu_bkgnd_dx = "LuaUI/Images/menu/minimenu/minimenu_bkgnd_dx.png"
local minimenu_bkgnd_separator = "LuaUI/Images/menu/minimenu/minimenu_bkgnd_separator.png"
local minimenu_bkgnd_sx = "LuaUI/Images/menu/minimenu/minimenu_bkgnd_sx.png"
local selettore_mainmini = "LuaUI/Images/menu/minimenu/selettore_main.png"
local selettore_minibutton = "LuaUI/Images/menu/minimenu/selettore_btn.png"
local resourcebutton_on = "LuaUI/Images/menu/minimenu/resourcesbutton_on.png"
local resourcebutton_off = "LuaUI/Images/menu/minimenu/resourcesbutton_off.png"

local show_selettore_mainmini = false			-- mostra o no il selettore arancione sul mainmini
local show_selettore_minibutton = false			-- mostra o no il selettore arancione sui minibutton

-- definizioni variabili di gestione del LOS
local UltimaMapDrawMode = Spring.GetMapDrawMode()

-- definizioni variabili di gestione wind e tidal
local forzatidal
local forzawind

-- impostazione dei fonts
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

--------------------------------------
-- AGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------
-- funzione aggiorno la posizione del minimenu button in alto a destra
local function UpdateGeometry() -- aggiorno geometria
  Pos_x_minimenu_button = vsx - margine_dx_minimenu - larghezza_main_minimenu_button
  Pos_y_minimenu_button = vsy - margine_su_minimenu - altezza_minimenu_buttons
end

--- funzione rilevamento delle dimensioni della finestra durante il resizing
function widget:ViewResize(viewSizeX, viewSizeY) -- quando si modifica la dimensione della finestra di spring, prelevane larghezza e altezza e fai partire la funzione "aggiorno geometria"
  vsx = viewSizeX
  vsy = viewSizeY
  UpdateGeometry()
end

--------------------------------------
-- FUNZIONE CHECK STATO OPZIONI, viene richiamata in diverse fasi dello script per controllare lo stato delle opzioni 
--------------------------------------
local function check_options()
-- all'inizio verifico anche il valore delle configurazioni
  valore_resourcesmenu = Spring.GetConfigInt("mostraresources", 0)				-- booleano di default è falso  -> disattivo successivamente anche il Widget			## widget
	if valore_resourcesmenu == 0 then
	  Button_[10].showMenu = false
	else
		Button_[10].showMenu = true
	end
end

--------------------------------------
-- INIZIALIZZO IL MENU 
--------------------------------------
function widget:Initialize()
-- preleva il valore da modoptions
	missione_attiva = tonumber(Spring.GetModOptions().wmrtsmission) or 0 -- prendi il valore dalle opzioni wmrtsmission o 0
-- all'inizio imposto la posizione del mini menu
	Pos_x_minimenu_button = vsx - margine_dx_minimenu - larghezza_main_minimenu_button
	Pos_y_minimenu_button = vsy - margine_su_minimenu - altezza_minimenu_buttons
-- avvio la funzione check_options()
	check_options()  
-- carico le impostazioni del LOS (se era visibile, diventa visibile, se era invisibile, non lo vedo)  
	if (Spring.GetGameFrame() > 0 and UltimaMapDrawMode == "los") then
		AttivaLOS()
		Button_[5].showMenu = true
	else
		DisattivaLOS()
		Button_[5].showMenu = false
	end  
end

--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile mostra_soundsettings è true.....
	if not Spring.IsGUIHidden() then
				-- mainmenu
				return 	((x >= Pos_x_minimenu_button) and (x <= Pos_x_minimenu_button + larghezza_main_minimenu_button) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton main menu
				or
				-- sound
				((x >= Button_[4].Pos_x_button) and (x <= Button_[4].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  --se è sopra il minibutton sound
				-- statistics
				or 
				((x >= Button_[1].Pos_x_button) and (x <= Button_[1].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- obj
				or 
				((x >= Button_[2].Pos_x_button) and (x <= Button_[2].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- deploy units
				or 
				((x >= Button_[6].Pos_x_button) and (x <= Button_[6].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- diary
				or 
				((x >= Button_[3].Pos_x_button) and (x <= Button_[3].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- LOS
				or 
				((x >= Button_[5].Pos_x_button) and (x <= Button_[5].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- builder
				or 
				((x >= Button_[7].Pos_x_button) and (x <= Button_[7].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- wind
				or 
				((x >= Button_[8].Pos_x_button) and (x <= Button_[8].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  --se è sopra il minibutton 
				-- tidal
				or 
				((x >= Button_[9].Pos_x_button) and (x <= Button_[9].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
	--	end -- isabove
	
	end --is gui hidden
--return 
end

--------------------------------------
-- FUNZIONI ATTIVA/DISATTIVA LOS
--------------------------------------

function AttivaLOS()
    if Spring.GetMapDrawMode()~="los" then
        Spring.SendCommands("togglelos")
		Button_[5].showMenu = true
    end
end

function DisattivaLOS()
    if Spring.GetMapDrawMode()=="los" then
        Spring.SendCommands("togglelos")
		Button_[5].showMenu = false		
    end
end

--------------------------------------
-- ALLA PARTENZA DEL GIOCO 
--------------------------------------
function widget:GameStart()
-- avvia il LOS  (se non si è spettatori)
	if Spring.GetSpectatingState() then
		DisattivaLOS()
	else
		AttivaLOS()
	end
end

--------------------------------------
-- GESTIONE PRESSIONE PULSANTE 1 DEL MOUSE -- TASTO SX
--------------------------------------
function widget:MousePress(x, y, button)
	if not Spring.IsGUIHidden() then
			if (Spring.GetGameSeconds() < 0.1) then
				return false
			end
		if button== 1 then -- pulsante sx
			if (widget:IsAbove(x, y)) then
		-- mainmenu
				-- si attiva
				if not show_mainmenu and((x >= Pos_x_minimenu_button) and (x <= Pos_x_minimenu_button + larghezza_main_minimenu_button) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  then --se è sopra il minibutton main menu
				Spring.SendCommands("open_WMRTS_menu") 	-- open_WMRTS_menu
				Spring.SendCommands("close_WMRTS_obj") 			-- chiudo gli obiettivi	
				Spring.SendCommands("close_WMRTS_graphics") 	-- close WMRTS_graphics	
				Spring.SendCommands("close_WMRTS_visuals") 		-- close WMRTS_graphics					
				Spring.SendCommands("close_WMRTS_exit") 		-- close WMRTS_exit	
				Spring.SendCommands("close_WMRTS_snd")			-- close wmrts_sndmenu		
				Spring.SendCommands("close_wmrts_diary") 		-- chiudo le altre cose		
				Spring.SendCommands("close_WMRTS_statistics")	-- chiuso le statistiche				
				
				show_mainmenu = true					-- attivo il pulsante "menu" del minimenu
				return true
				-- si disattiva
				elseif show_mainmenu and((x >= Pos_x_minimenu_button) and (x <= Pos_x_minimenu_button + larghezza_main_minimenu_button) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  then --se è sopra il minibutton main menu
				Spring.SendCommands("close_WMRTS_menu") -- close_WMRTS_menu
--				Spring.SendCommands("close_WMRTS_snd")	-- close_WMRTS_sndmenu
				show_mainmenu = false					-- disattivo il pulsante "menu" del minimenu
				return true				
		-- sound 
				-- si attiva
				elseif not Button_[4].showMenu and (Button_[4].showMiniButton and ((x >= Button_[4].Pos_x_button) and (x <= Button_[4].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton sound
				Spring.SendCommands("open_WMRTS_snd")		-- open wmrts_sndmenu
				Spring.SendCommands("close_WMRTS_obj") 			-- chiudo gli obiettivi	
				Spring.SendCommands("close_WMRTS_menu") 		-- close_WMRTS_menu
				Spring.SendCommands("close_WMRTS_graphics") 	-- close WMRTS_graphics	
				Spring.SendCommands("close_WMRTS_visuals") 		-- close WMRTS_graphics					
				Spring.SendCommands("close_WMRTS_exit") 		-- close WMRTS_exit	
				Spring.SendCommands("close_wmrts_diary") 		-- chiudo le altre cose		
				Spring.SendCommands("close_WMRTS_statistics")	-- chiuso le statistiche		
				show_mainmenu = false
				return true	
				-- si disattiva
				elseif Button_[4].showMenu and (Button_[4].showMiniButton and ((x >= Button_[4].Pos_x_button) and (x <= Button_[4].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton sound
				Spring.SendCommands("close_WMRTS_snd")
				return true	
		-- statistics
				-- si attiva				
				elseif not Button_[1].showMenu and (Button_[1].showMiniButton and((x >= Button_[1].Pos_x_button) and (x <= Button_[1].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("open_WMRTS_statistics")
				Spring.SendCommands("close_WMRTS_obj") 			-- chiudo gli obiettivi	
				Spring.SendCommands("close_WMRTS_menu") 		-- close_WMRTS_menu
				Spring.SendCommands("close_WMRTS_graphics") 	-- close WMRTS_graphics	
				Spring.SendCommands("close_WMRTS_visuals") 		-- close WMRTS_graphics					
				Spring.SendCommands("close_WMRTS_exit") 		-- close WMRTS_exit	
				Spring.SendCommands("close_WMRTS_snd")			-- close wmrts_sndmenu		
				Spring.SendCommands("close_wmrts_diary") 		-- chiudo le altre cose		
				show_mainmenu = false				
				return true	
				-- si disattiva				
				elseif Button_[1].showMenu and (Button_[1].showMiniButton and((x >= Button_[1].Pos_x_button) and (x <= Button_[1].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("close_WMRTS_statistics")
				return true					
		-- obj
				-- si attiva			
				elseif not Button_[2].showMenu and (Button_[2].showMiniButton and((x >= Button_[2].Pos_x_button) and (x <= Button_[2].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("open_WMRTS_obj")
				Spring.SendCommands("close_WMRTS_menu") 		-- close_WMRTS_menu
				Spring.SendCommands("close_WMRTS_graphics") 	-- close WMRTS_graphics	
				Spring.SendCommands("close_WMRTS_visuals") 		-- close WMRTS_graphics					
				Spring.SendCommands("close_WMRTS_exit") 		-- close WMRTS_exit	
				Spring.SendCommands("close_WMRTS_snd")			-- close wmrts_sndmenu		
				Spring.SendCommands("close_wmrts_diary") 		-- chiudo le altre cose		
				Spring.SendCommands("close_WMRTS_statistics")	-- chiuso le statistiche			
				Button_[2].isBlinking = false -- set blinking to 0 cosi nel caso resetta le notifiche all'apertura degli obiettivi	
				show_mainmenu = false				
				return true			
				-- si disattiva			
				elseif Button_[2].showMenu and (Button_[2].showMiniButton and((x >= Button_[2].Pos_x_button) and (x <= Button_[2].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("close_WMRTS_obj")
				return true		
		-- deploymenu
				-- si attiva			
				elseif not Button_[6].showMenu and (Button_[6].showMiniButton and((x >= Button_[6].Pos_x_button) and (x <= Button_[6].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("open_wmrts_unitdepl")		-- apro lo units deploy menu
				Spring.SendCommands("close_wmrts_diary")		-- chiudo il diario 
				Spring.SendCommands("close_WMRTS_obj") 			-- chiudo gli obiettivi	
				Spring.SendCommands("close_WMRTS_menu") 		-- close_WMRTS_menu
				Spring.SendCommands("close_WMRTS_graphics") 	-- close WMRTS_graphics	
				Spring.SendCommands("close_WMRTS_visuals") 		-- close WMRTS_graphics					
				Spring.SendCommands("close_WMRTS_exit") 		-- close WMRTS_exit	
				Spring.SendCommands("close_WMRTS_snd")			-- close wmrts_sndmenu		
				Spring.SendCommands("close_WMRTS_statistics")	-- chiuso le statistiche
				show_mainmenu = false				
				Button_[6].isBlinking = false -- set blinking to 0 cosi nel caso resetta le notifiche all'apertura del diario	
				return true			
				-- si disattiva			
				elseif Button_[6].showMenu and (Button_[6].showMiniButton and((x >= Button_[6].Pos_x_button) and (x <= Button_[6].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("close_wmrts_unitdepl")
				return true				
		-- diary
				-- si attiva			
				elseif not Button_[3].showMenu and (Button_[3].showMiniButton and((x >= Button_[3].Pos_x_button) and (x <= Button_[3].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("open_wmrts_diary") 
				Spring.SendCommands("close_WMRTS_obj") 			-- chiudo gli obiettivi	
				Spring.SendCommands("close_WMRTS_menu") 		-- close_WMRTS_menu
				Spring.SendCommands("close_WMRTS_graphics") 	-- close WMRTS_graphics	
				Spring.SendCommands("close_WMRTS_visuals") 		-- close WMRTS_graphics					
				Spring.SendCommands("close_WMRTS_exit") 		-- close WMRTS_exit	
				Spring.SendCommands("close_WMRTS_snd")			-- close wmrts_sndmenu		
				Spring.SendCommands("close_WMRTS_statistics")	-- chiuso le statistiche
				show_mainmenu = false				
				Button_[3].isBlinking = false -- set blinking to false cosi nel caso resetta le notifiche all'apertura del diario	
				return true			
				-- si disattiva			
				elseif Button_[3].showMenu and (Button_[3].showMiniButton and((x >= Button_[3].Pos_x_button) and (x <= Button_[3].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("close_wmrts_diary")
				return true				
		-- LOS
				-- si attiva		
				elseif (Button_[5].showMiniButton and((x >= Button_[5].Pos_x_button) and (x <= Button_[5].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
					if Spring.GetMapDrawMode()~="los" then
						Spring.SendCommands("togglelos")
						Button_[5].showMenu = true
						else
						Spring.SendCommands("togglelos")
						Button_[5].showMenu = false
					end
				-- eseguire codice
				-- 		AttivaLOS()
				return true	
		-- builder
				-- si attiva			
				elseif not Button_[7].showMenu and (Button_[7].showMiniButton and ((x >= Button_[7].Pos_x_button) and (x <= Button_[7].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("open_WMRTS_buildermenu")
				Button_[7].showMenu = true				
				return true	
				-- si disattiva			
				elseif Button_[7].showMenu and (Button_[7].showMiniButton and ((x >= Button_[7].Pos_x_button) and (x <= Button_[7].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				Spring.SendCommands("close_WMRTS_buildermenu")
				Button_[7].showMenu = false
				return true					
		-- wind
				elseif (Button_[8].showMiniButton and ((x >= Button_[8].Pos_x_button) and (x <= Button_[8].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				-- eseguire codice
				return true	
		-- tidal
				elseif (Button_[9].showMiniButton and((x >= Button_[9].Pos_x_button) and (x <= Button_[9].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				-- eseguire codice
				return true	
				
		-- resources
				elseif ((x >= Button_[10].Pos_x_button) and (x <= Button_[10].Pos_x_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then
				valore_resourcesmenu = valore_resourcesmenu + 1
					if valore_resourcesmenu > 1 then
					 valore_resourcesmenu = 0
					end
					if valore_resourcesmenu == 0 then
						Spring.SendCommands({"luaui disablewidget Mex Placement Handler"}) 				-- disabilito il widget
						Spring.SetConfigInt("mostraresources", 0)
						Button_[10].showMenu = false
					elseif valore_resourcesmenu == 1 then
						Spring.SendCommands({"luaui enablewidget Mex Placement Handler"}) 				-- disabilito il widget
						Spring.SetConfigInt("mostraresources", 1)		
						Button_[10].showMenu = true
					end				
				return true
				end-- posizioni
			end -- isabove
		end -- button 1
	end -- not gui hidden
end -- function	

--------------------------------------
-- GESTIONE DEI COMANDI SPRING RICEVUTI
--------------------------------------				
function widget:TextCommand(command) 
-- apertura e chiusura main menu (icona on off del minimenu
	if command == 'open_WMRTS_minimenu' then
		show_mainmenu = true ----------------------------------- bottone minimenu ON
	end
	if command == 'close_WMRTS_minimenu' then
		show_mainmenu = false  ----------------------------------- bottone minimenu OFF
	end	
-- apertura e chiusura obj menu
	if command == 'open_WMRTS_obj' then
		Button_[2].showMenu = true
	end
	if command == 'close_WMRTS_obj' then
		Button_[2].showMenu = false
	end		
-- blinking del obj menu
	if command == 'blink_WMRTS_obj' and Button_[2].showMenu == false then
	-- evidenza obj button
	Button_[2].isBlinking = true
	end		
-- apertura e chiusura diary menu
	if command == 'open_wmrts_diary' then
		Button_[3].showMenu = true
	end
	if command == 'close_wmrts_diary' then
		Button_[3].showMenu = false
	end		
-- blinking del diary menu
	if command == 'blink_wmrts_diary' and Button_[3].showMenu == false then
	-- lampeggia diary button
	Button_[3].isBlinking = true
	end		
-- Stopblinking del diary menu
	if command == 'stopblink_wmrts_diary' and Button_[3].showMenu == false then
	-- smetti di lampeggiare diary button
	Button_[3].isBlinking = false
	end				
-- apertura e chiusura statistics menu
	if command == 'open_WMRTS_statistics' then
		Button_[1].showMenu = true
	end
	if command == 'close_WMRTS_statistics' then
		Button_[1].showMenu = false
	end	
-- apertura e chiusura statistics menu
	if command == 'open_WMRTS_snd' then
		Button_[4].showMenu = true
	end
	if command == 'close_WMRTS_snd' then
		Button_[4].showMenu = false
	end		
-- apertura e chiusura los
	if command == 'open_WMRTS_los' then
		Button_[5].showMenu = true
	end
	if command == 'close_WMRTS_los' then
		Button_[5].showMenu = false
	end	
-- apertura e chiusura builder
	if command == 'open_WMRTS_buildermenu' then
		Button_[7].showMenu = true
	end
	if command == 'close_WMRTS_buildermenu' then
		Button_[7].showMenu = false
	end			
end				
		
--------------------------------------
-- SEMPRE
--------------------------------------
function widget:Update(dt)
-- verifico la posizione del mouse, serve per gestire i selettori
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if not Spring.IsGUIHidden() then
--		if (Spring.GetGameSeconds() < 0.1) then
--			return false
--		end
				-- menusetting
				if 	((mousex >= Pos_x_minimenu_button) and (mousex <= Pos_x_minimenu_button + larghezza_main_minimenu_button) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su mainmenu minibutton
				show_selettore_mainmini = true
				else
				show_selettore_mainmini = false
				end
				-- tutti i minibutton menu:
				-- ############################################################################### Inserire anche la condizione in cui il pulsante non è nascosto!! ################################
				-- ############################################################################### Inserire anche la condizione in cui il pulsante non è nascosto!! ################################				
				-- sound
				if 	((mousex >= Button_[4].Pos_x_button) and (mousex <= Button_[4].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su snd minibutton
				Pos_x_riquadro_button =	Button_[4].Pos_x_button
				show_selettore_minibutton = true
				-- obj				
				elseif  ((mousex >= Button_[2].Pos_x_button) and (mousex <= Button_[2].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su obj minibutton
				Pos_x_riquadro_button =	Button_[2].Pos_x_button
				show_selettore_minibutton = true
				-- deploy units			
				elseif  ((mousex >= Button_[6].Pos_x_button) and (mousex <= Button_[6].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su obj minibutton
				Pos_x_riquadro_button =	Button_[6].Pos_x_button
				show_selettore_minibutton = true						
				-- diary			
				elseif  ((mousex >= Button_[3].Pos_x_button) and (mousex <= Button_[3].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su obj minibutton
				Pos_x_riquadro_button =	Button_[3].Pos_x_button
				show_selettore_minibutton = true				
				-- statistics				
				elseif  ((mousex >= Button_[1].Pos_x_button) and (mousex <= Button_[1].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su statistics minibutton
				Pos_x_riquadro_button =	Button_[1].Pos_x_button
				show_selettore_minibutton = true	
				-- builder					
				elseif  ((mousex >= Button_[7].Pos_x_button) and (mousex <= Button_[7].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su builder minibutton
				Pos_x_riquadro_button =	Button_[7].Pos_x_button
				show_selettore_minibutton = true	
				-- LOS					
				elseif  ((mousex >= Button_[5].Pos_x_button) and (mousex <= Button_[5].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su los minibutton
				Pos_x_riquadro_button =	Button_[5].Pos_x_button
				show_selettore_minibutton = true	
				-- Wind					
				elseif  ((mousex >= Button_[8].Pos_x_button) and (mousex <= Button_[8].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su wind minibutton
				Pos_x_riquadro_button =	Button_[8].Pos_x_button
				show_selettore_minibutton = true					
				-- Tidal					
				elseif  ((mousex >= Button_[9].Pos_x_button) and (mousex <= Button_[9].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su tidal minibutton
				Pos_x_riquadro_button =	Button_[9].Pos_x_button
				show_selettore_minibutton = true	
				-- Resources					
				elseif  ((mousex >= Button_[10].Pos_x_button) and (mousex <= Button_[10].Pos_x_button + larghezza_minimenu_buttons) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su resources minibutton
				Pos_x_riquadro_button =	Button_[10].Pos_x_button
				show_selettore_minibutton = true				
				-- altrimenti se il cursore non è sopra alcuno dei suddetti buttons, nascondilo				
				else 
				show_selettore_minibutton = false
				end
	end -- isguihidden
-- imposto la variabilw forzatidal forzawind e le trasformo in valori interi
	forzatidal = Game.tidal
	_,_,_, forzawind = Spring.GetWind()	
	forzawind = math.floor(forzawind) -- vado a far diventare intero il valore di forzawind (che avrebbe 9 decimali)
end
	
--------------------------------------
-- ALLA PRESSIONE DEI TASTI --------------------------------------------------------------- spostare questa funzione nel minimenu! in modo da gestire l'apertura del menu col tasto esc solamente quando non ci sono altri elementi aperti
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
-- se premo il tasto L 
	if key == 108 then -- TASTO L
		if Spring.GetMapDrawMode()=="los" then --mostro o nascondo il LOS
        Spring.SendCommands("togglelos")
		Button_[5].showMenu = false	
		return true
		else 
        Spring.SendCommands("togglelos")
		Button_[5].showMenu = true	
		return true		
		end
	end
-- se premo il tasto esc 
	if key == 27 then -- TASTO esc 0x01B
		-- se non ci sono selezionate le unità, ed il mainmenu è disattivato e il sndmenu (e altri menu) non è attivo: apro il mainmenu
		if not show_mainmenu and not Button_[4].showMenu and not Button_[2].showMenu and not Button_[3].showMenu and not Button_[1].showMenu and not Spring.IsGUIHidden() and Spring.GetSelectedUnitsCount() == 0 then
		Spring.SendCommands("open_WMRTS_menu") 				-- apro il mainmenu (widget main menu)
		show_mainmenu = true								-- accendo il minipulsante menu del minimenu
		return true
		-- se ci sono selezionate le unità, il menu non si apre e si deselezionano le unità selezionate (o si interrompono le funzioni che si stanno eseguendo col mouse, come costruzione, ordini, waypoint ecc)
		elseif not show_mainmenu and not Spring.IsGUIHidden() and Spring.GetSelectedUnitsCount() > 0 then
		Spring.SendCommands("Deselect")	
		show_mainmenu = false
		return true
		end
	end	 													-- lo spegnimento del minipulsante menu del minimenu e la chiusura del menu (widget), avviene dai rispettivi widget (main menu & co). 	
	return false
end
	
--------------------------------------
-- DISEGNO IL MINIMENU
--------------------------------------
local function DrawMainMiniMenu()
-- inserisco il main_minimenu_button
------------------------------------	
	-- sfondo, primo blocco a dx
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_dx)	
	gl.TexRect(	Pos_x_minimenu_button,Pos_y_minimenu_button-margine_giu_minimenu,vsx,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
		if show_mainmenu then -- se la finestra delle opzioni principali è attiva
		gl.Texture(mainminimenubutton_on)	
		else
		gl.Texture(mainminimenubutton_off)	
		end
	gl.TexRect(	Pos_x_minimenu_button,Pos_y_minimenu_button,Pos_x_minimenu_button+larghezza_main_minimenu_button,Pos_y_minimenu_button+altezza_minimenu_buttons)	
	gl.Texture(false)	-- fine texture	
	Pos_x_next_button_drawing = Pos_x_minimenu_button - interspazio_buttons - larghezza_minimenu_buttons -- definisco la posizione di partenza per disegnare il pulsante del sound (se sarà presente)
	
-- inserisco sound minipulsante, se abilitato
------------------------------------
		if Button_[4].showMiniButton then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[4].Pos_x_button = Pos_x_next_button_drawing	-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if Button_[4].showMenu then 				-- se la finestra (o funzione) degli obiettivi è attiva:
				gl.Texture(sndbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(sndbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante show statistics (se sarà presente)
		end

-- inserisco show statistics minipulsante, se abilitato
------------------------------------
		if Button_[1].showMiniButton then 	-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[1].Pos_x_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if Button_[1].showMenu then 		-- se la finestra (o funzione) delle statistiche è attiva:
				gl.Texture(statisticsbutton_on)		-- mostra il pulsante acceso
				else
				gl.Texture(statisticsbutton_off)	-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante degli obj (se sarà presente)
		end
		
-- inserisco obj minipulsante, se abilitato
------------------------------------
		if Button_[2].showMiniButton then 	-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[2].Pos_x_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if Button_[2].showMenu then 				-- se la finestra (o funzione) degli obiettivi è attiva:
				gl.Texture(objbutton_on)			-- mostra il pulsante acceso
				else
					if Button_[2].isBlinking then
						gl.Texture(objbutton_blinking)			-- mostra il pulsante blinking
					else				
						gl.Texture(objbutton_off)			-- altrimenti mostra il pulsante spento	
					end
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante LOS (se sarà presente)
		end

-- inserisco units deploy minipulsante, se abilitato
------------------------------------
		if Button_[6].showMiniButton then 	-- se il minipulsante è attivo e non si sta giocando una partita skirmish (diverso da 0) per vederlo nel minimenù:
	Button_[6].Pos_x_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if Button_[6].showMenu then 				-- se la finestra (o funzione) del diario è attiva:
				gl.Texture(diarybutton_on)				-- mostra il pulsante acceso ###############################
				else
					if Button_[6].isBlinking == true then
						gl.Texture(diarybutton_blinking)			-- mostra il pulsante blinking ###########
					else				
						gl.Texture(diarybutton_off)			-- altrimenti mostra il pulsante spento	 ##############
					end
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante SUCCESSIVO (se sarà presente)
		
	end

-- inserisco diary minipulsante, se abilitato
------------------------------------
		if (Button_[3].showMiniButton and (missione_attiva ~= 0)) then 	-- se il minipulsante è attivo e non si sta giocando una partita skirmish (diverso da 0) per vederlo nel minimenù:
	Button_[3].Pos_x_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if Button_[3].showMenu then 				-- se la finestra (o funzione) del diario è attiva:
				gl.Texture(diarybutton_on)			-- mostra il pulsante acceso
				else
					if Button_[3].isBlinking then
						gl.Texture(diarybutton_blinking)			-- mostra il pulsante blinking
					else				
						gl.Texture(diarybutton_off)			-- altrimenti mostra il pulsante spento	
					end
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante SUCCESSIVO (se sarà presente)
		end
end

local function DrawSeparatorMiniMenu()
		
-- se si vuole inserire il separatore tra i bottoni del menu ( menu, statistiche, suono e obiettivi) a quelli funzionali ( LOS, builder ecc) inserire questa funzione:
------------------------------------
	Pos_x_next_button_drawing = Pos_x_next_button_drawing + interspazio_buttons + larghezza_minimenu_buttons - interspazio_button_separator -- riposiziono al precedente pulsante il "posizionatore_x_next_button" e lo sposto di quanto è larga la variabile del separatore
	-- sfondo del blocco separatore
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_separator)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+interspazio_button_separator,vsy)	
	gl.Texture(false)	-- fine texture				
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante LOS (se sarà presente)
end

local function DrawVisualsMiniMenu()
-- inserisco LOS minipulsante, se abilitato
------------------------------------
		if Button_[5].showMiniButton then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[5].Pos_x_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante	
				if Button_[5].showMenu then 				-- se la finestra (o funzione) del LOS è attiva:
				gl.Texture(losbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(losbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante builder (se sarà presente)
		end

-- inserisco builder minipulsante, se abilitato
------------------------------------
		if Button_[7].showMiniButton then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[7].Pos_x_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if Button_[7].showMenu then 					-- se la finestra (o funzione) di builder è attiva:
				gl.Texture(builderbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(builderbutton_off)			-- altrimenti mostra il pulsante spento	
				end
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
	gl.Texture(false)	-- fine texture	
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante wind (se sarà presente)
		end
end

local function DrawMapDataMinimenu()
-- inserisco wind minipulsante, se abilitato
------------------------------------
		if Button_[8].showMiniButton then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[8].Pos_x_button = Pos_x_next_button_drawing	-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if Button_[8].showMenu then 				-- se la finestra (o funzione) di wind è attiva:
				gl.Texture(windbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(windbutton_off)			-- altrimenti mostra il pulsante spento	
				end
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
	gl.Texture(false)	-- fine texture	
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante tidal (se sarà presente)
	-- Valore del vento	
    font_generale:Begin()
	font_generale:Print(forzawind, Button_[8].Pos_x_button+17, Pos_y_minimenu_button+12, 15, "ocn") -- valore del vento trasformato in stringa
	font_generale:End()	
		end		
	
-- inserisco tidal minipulsante, se abilitato
------------------------------------
		if Button_[9].showMiniButton then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[9].Pos_x_button = Pos_x_next_button_drawing			-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if Button_[9].showMenu then 				-- se la finestra (o funzione) di tidal è attiva:
				gl.Texture(tidebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(tidebutton_off)			-- altrimenti mostra il pulsante spento	
				end
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
	gl.Texture(false)	-- fine texture	
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		-- Valore delle maree
    font_generale:Begin()
	font_generale:Print(forzatidal, Button_[9].Pos_x_button+17, Pos_y_minimenu_button+12, 15, "ocn") -- valore del vento
	font_generale:End()	
		end		

-- inserisco resources minipulsante, se abilitato
------------------------------------
		if Button_[10].showMiniButton then 				-- se il minipulsante è attivo per vederlo nel minimenù:
	Button_[10].Pos_x_button = Pos_x_next_button_drawing			-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if Button_[10].showMenu then 				-- se la finestra (o funzione) di tidal è attiva:
				gl.Texture(resourcebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(resourcebutton_off)			-- altrimenti mostra il pulsante spento	
				end
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
	gl.Texture(false)	-- fine texture	
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end		
		
-- inserisco l'ultima parte (sx) del background del minimenu	
------------------------------------
	Pos_x_next_button_drawing = Pos_x_next_button_drawing + interspazio_buttons + larghezza_minimenu_buttons - margine_sx_minimenu -- riposiziono al precedente pulsante il "posizionatore_x_next_button" e lo sposto di quanto è largo il margine_sx_minimenu
	-- sfondo del blocco separatore
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_sx)	
	gl.TexRect(Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+margine_sx_minimenu,vsy)	
	gl.Texture(false)	-- fine texture			

-- inserisco il selettore del minimenu button, se visibile
------------------------------------
	if show_selettore_mainmini then
		gl.Color(1,1,1,1)
		gl.Texture(selettore_mainmini)	
		gl.TexRect(	Pos_x_minimenu_button,Pos_y_minimenu_button,Pos_x_minimenu_button+larghezza_main_minimenu_button,Pos_y_minimenu_button+altezza_minimenu_buttons)	
		gl.Texture(false)	-- fine texture			
	end
	
-- inserisco il selettore del mini button menu, se visibile
------------------------------------
	if show_selettore_minibutton then
		gl.Color(1,1,1,1)
		gl.Texture(selettore_minibutton)	
		gl.TexRect(	Pos_x_riquadro_button,Pos_y_minimenu_button,Pos_x_riquadro_button+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
		gl.Texture(false)	-- fine texture			
	end

-- Aggiungo GUI shader
----------------------------
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect(Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu, vsx, vsy,'WMRTS menu')
	end

end -- end DrawScreen

function widget:DrawScreen()
	if (not Spring.IsGUIHidden()) then

		DrawMainMiniMenu() 			-- carico il minimenu principale (main menu, statistics e obj)
		DrawSeparatorMiniMenu() 	-- inserisco il separatore
		DrawVisualsMiniMenu()		-- inserisco il minimenu visuals (LOS e Builder)
		DrawSeparatorMiniMenu() 	-- inserisco il separatore
		DrawMapDataMinimenu()		-- inserisco il minimenu mapdata (Wind value e Tidal value)
	end
end

--------------------------------------
-- GESTIONE SALVATAGGIO DATA
--------------------------------------
function widget:GetConfigData() --save config
	return {UltimaMapDrawMode=Spring.GetMapDrawMode()} 					-- salvataggio della variabile UltimaMapDrawMode (che memorizza se il LOS è stato lasciato attivo o meno)
end

--------------------------------------
-- GESTIONE CARICAMENTO DATA
--------------------------------------
function widget:SetConfigData(data) --load config
	if data.UltimaMapDrawMode then										-- se nel caricamento c'è la variabile: UltimaMapDrawMode
		UltimaMapDrawMode = data.UltimaMapDrawMode						-- allora definiscila
	end
end
