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
    enabled   = false -- false at the moment, under test 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
- pulsanti piccoli / grossi
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix
-- designing top right WMRTS mini-menù

-- definizione pulsanti minimenu
local larghezza_main_minimenu_button 	= 50 	-- larghezza del pulsante "main menu" del minimenu (più largo degli altri)
local larghezza_minimenu_buttons 		= 35 	-- larghezza di tutti i pulsanti del minimenu
local altezza_minimenu_buttons 			= 35 	-- altezza di tutti i pulanti del minimenu
local margine_dx_minimenu 				= 5 	-- da destra
local margine_su_minimenu 				= 50	-- da sopra
local margine_giu_minimenu 				= 5 	-- margine dal sotto il pulsante al bordo del background
local margine_sx_minimenu 				= 5 	-- margine da sinistra dell'ultimo pulsante a sx, serve a creare l'ultimo blocco del background image
local interspazio_buttons				= 2 	-- spazio tra un pulsante e l altro
local interspazio_button_separator		= 5 	-- spazio tra una serie di pulsanti (menu) e l'altro (funzionali), ad esempio distanzio i pulsanti menu, sound ecc con i pulsanti idle, wind, ecc
local show_minimenu_statistics_button	= true
local show_minimenu_object_button		= true
local show_minimenu_snd_button			= true
local show_minimenu_los_button			= true
local show_minimenu_idle_button			= true
local show_minimenu_wind_button			= true					-- non è un bottone ma è una finestrella con il valore del vento
local show_minimenu_tidal_button		= true					-- non è un bottone ma è una finestrella con il valore delle maree
-- definizione variabili di posizione e lunghezza
local Pos_x_minimenu_button		        = 200					-- cossisponde al margine in basso a sx del minimenu_buttons
local Pos_y_minimenu_button				= 200 					-- cossisponde al margine in basso a sx del minimenu_buttons
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local Pos_x_next_button_drawing					-- Usato nel drawing, il valore della posizione si sposterà man mano di quanti pulsanti sono attivi, cosi da disegnarli uno di fianco all'altro
local Pos_x_statistics_button			= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_obj_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)	
local Pos_x_snd_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_los_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_idle_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_wind_button					= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_tidal_button				= 5		-- servirà per capire la posizione del rispettivo bottone (esempio per cliccare sopra)
local Pos_x_riquadro_button				= 5		-- posizione X del riquadro per evidenziare l' "above" sui pulsanti generici
local Pos_y_riquadro_button				= 5		-- posizione Y del riquadro per evidenziare l' "above" sui pulsanti generici
local Pos_x_riquadro_mainbutton			= 5		-- posizione X del riquadro per evidenziare l' "above" sul pulsante main menu
local Pos_y_riquadro_mainbutton			= 5		-- posizione Y del riquadro per evidenziare l' "above" sul pulsante main menu

-- definizione variabili MENU aperti/chiusi
local show_mainmenu						= false					-- is mainmenu active?
local show_sndmenu 						= false 				-- is sound menu options active?
local show_statisticsmenu				= false					-- is statistics table active?
local show_objmenu						= false 				-- is obj windows active? 
local show_losmenu						= false					-- is LOS windows active? -- or function active?? --todo
local show_idlemenu						= false					-- is idle windows active? -- or function active?? --todo
local show_wingmenu						= false					-- is wing windows active? -- or function active?? --todo
local show_tidalmenu					= false					-- is tidal windows active? -- or function active?? --todo

-- definizioni immagini ON/OFF bottoni e background
local mainminimenubutton_off = "LuaUI/Images/menu/minimenu/main_menu_off.png"
local mainminimenubutton_on = "LuaUI/Images/menu/minimenu/main_menu_on.png"
local statisticsbutton_off = "LuaUI/Images/menu/minimenu/statisticsbutton_off.png"
local statisticsbutton_on = "LuaUI/Images/menu/minimenu/statisticsbutton_on.png"
local objbutton_off = "LuaUI/Images/menu/minimenu/objbutton_off.png"
local objbutton_on = "LuaUI/Images/menu/minimenu/objbutton_on.png"
local idlebutton_off = "LuaUI/Images/menu/minimenu/idlebutton_off.png"
local idlebutton_on = "LuaUI/Images/menu/minimenu/idlebutton_on.png"
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
local show_selettore_mainmini = false
local show_selettore_minibutton = false

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
-- INIZIALIZZO IL MENU 
--------------------------------------
function widget:Initialize()
-- all'inizio imposto la posizione del mini menu
  Pos_x_minimenu_button = vsx - margine_dx_minimenu - larghezza_main_minimenu_button
  Pos_y_minimenu_button = vsy - margine_su_minimenu - altezza_minimenu_buttons
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
				((x >= Pos_x_snd_button) and (x <= Pos_x_snd_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  --se è sopra il minibutton sound
				-- statistics
				or 
				((x >= Pos_x_statistics_button) and (x <= Pos_x_statistics_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- obj
				or 
				((x >= Pos_x_obj_button) and (x <= Pos_x_obj_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- LOS
				or 
				((x >= Pos_x_los_button) and (x <= Pos_x_los_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- idle
				or 
				((x >= Pos_x_idle_button) and (x <= Pos_x_idle_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
				-- wind
				or 
				((x >= Pos_x_wind_button) and (x <= Pos_x_wind_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  --se è sopra il minibutton 
				-- tidal
				or 
				((x >= Pos_x_tidal_button) and (x <= Pos_x_tidal_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))   --se è sopra il minibutton 
	--	end -- isabove
	
	end --is gui hidden
--return 
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
				if ((x >= Pos_x_minimenu_button) and (x <= Pos_x_minimenu_button + larghezza_main_minimenu_button) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons))  then --se è sopra il minibutton main menu
--				show_mainmenu = true
				Spring.SendCommands("open_WMRTS_menu") -- open_WMRTS_menu
				-- inviare springcommand per apertura rispettivo menu
				return true
		-- sound
				elseif (show_minimenu_snd_button and ((x >= Pos_x_snd_button) and (x <= Pos_x_snd_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton sound
--				show_sndmenu = true
				Spring.SendCommands("open_WMRTS_snd")
				return true	
		-- statistics
				elseif (show_minimenu_statistics_button and((x >= Pos_x_statistics_button) and (x <= Pos_x_statistics_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
--				show_statisticsmenu	= true
				Spring.SendCommands("open_WMRTS_statistics")
				return true	
		-- obj
				elseif (show_minimenu_object_button and((x >= Pos_x_obj_button) and (x <= Pos_x_obj_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
--				show_objmenu = true
				Spring.SendCommands("open_WMRTS_obj")
				return true			
		-- LOS
				elseif (show_minimenu_los_button and((x >= Pos_x_los_button) and (x <= Pos_x_los_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				-- eseguire codice
				return true	
		-- idle
				elseif (show_minimenu_idle_button and ((x >= Pos_x_idle_button) and (x <= Pos_x_idle_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				-- eseguire codice
				return true	
		-- wind
				elseif (show_minimenu_wind_button and ((x >= Pos_x_wind_button) and (x <= Pos_x_wind_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				-- eseguire codice
				return true	
		-- tidal
				elseif (show_minimenu_tidal_button and((x >= Pos_x_tidal_button) and (x <= Pos_x_tidal_button + larghezza_minimenu_buttons) and (y >= Pos_y_minimenu_button) and (y <= Pos_y_minimenu_button+altezza_minimenu_buttons)))  then --se è sopra il minibutton 
				-- eseguire codice
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
		show_objmenu = true
	end
	if command == 'close_WMRTS_obj' then
		show_objmenu = false
	end		
-- apertura e chiusura statistics menu
	if command == 'open_WMRTS_statistics' then
		show_statisticsmenu = true
	end
	if command == 'close_WMRTS_statistics' then
		show_statisticsmenu = false
	end	
-- apertura e chiusura statistics menu
	if command == 'open_WMRTS_snd' then
		show_sndmenu = true
	end
	if command == 'close_WMRTS_snd' then
		show_sndmenu = false
	end		
end		
		
--------------------------------------
-- SEMPRE
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if not Spring.IsGUIHidden() then
--		if (Spring.GetGameSeconds() < 0.1) then
--			return false
--		end
				-- menusetting
				if 	((mousex >= Pos_x_minimenu_button) and (mousex <= Pos_x_minimenu_button + larghezza_main_minimenu_button) and (mousey >= Pos_y_minimenu_button) and (mousey <= Pos_y_minimenu_button+altezza_minimenu_buttons)) then -- su mainmenu
				show_selettore_mainmini = true
				else
				show_selettore_mainmini = false
				end

	
	end
end
		
--------------------------------------
-- DISEGNO IL MINIMENU
--------------------------------------
function widget:DrawScreen()
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
		if show_minimenu_snd_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_snd_button = Pos_x_next_button_drawing	-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if show_sndmenu then 				-- se la finestra (o funzione) degli obiettivi è attiva:
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
		if show_minimenu_statistics_button then 	-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_statistics_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if show_statisticsmenu then 		-- se la finestra (o funzione) delle statistiche è attiva:
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
		if show_minimenu_object_button then 	-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_obj_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante
				if show_objmenu then 				-- se la finestra (o funzione) degli obiettivi è attiva:
				gl.Texture(objbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(objbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante LOS (se sarà presente)
		end
		
-- se si vuole inserire il separatore tra i bottoni del menu ( menu, statistiche, suono e obiettivi) a quelli funzionali ( LOS, idle ecc) inserire questa funzione:
------------------------------------
	Pos_x_next_button_drawing = Pos_x_next_button_drawing + interspazio_buttons + larghezza_minimenu_buttons - interspazio_button_separator -- riposiziono al precedente pulsante il "posizionatore_x_next_button" e lo sposto di quanto è larga la variabile del separatore
	-- sfondo del blocco separatore
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_separator)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+interspazio_button_separator,vsy)	
	gl.Texture(false)	-- fine texture				
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante LOS (se sarà presente)

-- inserisco LOS minipulsante, se abilitato
------------------------------------
		if show_minimenu_los_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_los_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante	
				if show_losmenu then 				-- se la finestra (o funzione) del LOS è attiva:
				gl.Texture(losbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(losbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante idle (se sarà presente)
		end

-- inserisco idle minipulsante, se abilitato
------------------------------------
		if show_minimenu_idle_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_idle_button = Pos_x_next_button_drawing		-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if show_idlemenu then 					-- se la finestra (o funzione) di idle è attiva:
				gl.Texture(idlebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(idlebutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante wind (se sarà presente)
		end
		
-- se si vuole inserire il separatore tra i bottoni del menu ( menu, statistiche, suono e obiettivi) a quelli funzionali ( LOS, idle ecc) inserire questa funzione:
------------------------------------
	Pos_x_next_button_drawing = Pos_x_next_button_drawing + interspazio_buttons + larghezza_minimenu_buttons - interspazio_button_separator -- riposiziono al precedente pulsante il "posizionatore_x_next_button" e lo sposto di quanto è larga la variabile del separatore
	-- sfondo del blocco separatore
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_separator)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+interspazio_button_separator,vsy)	
	gl.Texture(false)	-- fine texture				
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante LOS (se sarà presente)

-- inserisco wind minipulsante, se abilitato
------------------------------------
		if show_minimenu_wind_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_wind_button = Pos_x_next_button_drawing	-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if show_wingmenu then 				-- se la finestra (o funzione) di wind è attiva:
				gl.Texture(idlebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(idlebutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante tidal (se sarà presente)
		end		
	
-- inserisco tidal minipulsante, se abilitato
------------------------------------
		if show_minimenu_tidal_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
	Pos_x_tidal_button = Pos_x_next_button_drawing			-- questa variabile verrà utilizzata per funzioni come click con il mouse sinistro (per identificare la posizione x iniziale del pulsante)		
	-- sfondo del blocco, se attivo
	gl.Color(1,1,1,1)
	gl.Texture(minimenu_bkgnd_btn)	
	gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu,Pos_x_next_button_drawing+larghezza_minimenu_buttons+interspazio_buttons,vsy)	
	gl.Texture(false)	-- fine texture	
	-- pulsante			
				if show_tidalmenu then 				-- se la finestra (o funzione) di tidal è attiva:
				gl.Texture(idlebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(idlebutton_off)			-- altrimenti mostra il pulsante spento	
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

-- Aggiungo GUI shader
----------------------------
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect(Pos_x_next_button_drawing,Pos_y_minimenu_button-margine_giu_minimenu, vsx, vsy,'WMRTS menu')
	end

return
end -- end DrawScreen


