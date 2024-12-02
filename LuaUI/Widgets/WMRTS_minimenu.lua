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

-- definizione dimensioni pulsanti minimenu
local larghezza_main_minimenu_button 	= 50 --- definire
local altezza_main_minimenu_button 		= 50 --- definire
local larghezza_minimenu_buttons 		= 50 -- definire
local altezza_minimenu_buttons 			= 50 -- definire
local margine_dx_minimenu 				= 10 -- da destra
local margine_su_minimenu 				= 10 -- da sopra
local interspazio_buttons				= 2  -- spazio tra un pulsante e l altro
local interspazio_funzionale_buttons	= 5  -- spazio tra una serie di pulsanti (menu) e l'altro (funzionali), ad esempio distanzio i pulsanti menu, sound ecc con i pulsanti idle, wind, ecc

-- definizione variabili
local show_mainmenu						= false					-- is mainmenu active?
-- local minimenu 							= false					-- show minimenu options?
-- local visualmenu 						= false					-- is visual menu options active?
-- local graphicsmenu 						= false					-- is graphics menu options active?
local show_sndmenu 						= false 				-- is sound menu options active?
local show_statisticsmenu				= false					-- is statistics table active?
local show_objmenu						= false 				-- is obj windows active? 
local show_losmenu						= false					-- is LOS windows active? -- or function active?? --todo
local show_idlemenu						= false					-- is idle windows active? -- or function active?? --todo
local show_wingmenu						= false					-- is wing windows active? -- or function active?? --todo
local show_tidalmenu					= false					-- is tidal windows active? -- or function active?? --todo

local Pos_x_minimenu_button										-- cossisponde al margine in basso a sx del minimenu_buttons
local Pos_y_minimenu_button										-- cossisponde al margine in basso a sx del minimenu_buttons
local vsx, vsy 						  	= gl.GetViewSizes()
local Pos_x_next_button_drawing									-- Usato nel drawing, il valore della posizione si sposterà man mano di quanti pulsanti sono attivi, cosi da disegnarli uno di fianco all'altro

local show_minimenu_statistics_button	= true
local show_minimenu_object_button		= true
local show_minimenu_snd_button			= true
local show_minimenu_los_button			= false
local show_minimenu_idle_button			= false
local show_minimenu_wind_button			= false					-- non è un bottone ma è una finestrella con il valore del vento
local show_minimenu_tidal_button		= false					-- non è un bottone ma è una finestrella con il valore delle maree

-- definizioni immagini bottoni
local mainminimenubutton_off = "LuaUI/Images/menu/main_menu_rest.png"
local mainminimenubutton_on = "LuaUI/Images/menu/main_menu_rest.png"
local statisticsbutton_off = "LuaUI/Images/menu/main_menu_rest.png"
local statisticsbutton_on = "LuaUI/Images/menu/main_menu_rest.png"
local objbutton_off = ""
local objbutton_on = ""
local idlebutton_off = ""
local idlebutton_on = ""
local losbutton_off = ""
local losbutton_on = ""
local wingbutton_off = ""
local wingbutton_on = ""
local tidebutton_off = ""
local tidebutton_on = ""
local sndbutton_off = ""
local sndbutton_on = ""

--------------------------------------
-- AGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------

-- funzione aggiorno la posizione del minimenu button in alto a destra
local function UpdateGeometry() -- aggiorno geometria
  Pos_x_minimenu_button = vsx - margine_dx_minimenu - larghezza_main_minimenu_button
  Pos_y_minimenu_button = vsy - margine_su_minimenu - altezza_main_minimenu_button
end


--- funzione rilevamento delle dimensioni della finestra durante il resizing
function widget:ViewResize(viewSizeX, viewSizeY) -- quando si modifica la dimensione della finestra di spring, prelevane larghezza e altezza e fai partire la funzione "aggiorno geometria"
  vsx = viewSizeX
  vsy = viewSizeY
  UpdateGeometry()
end

--------------------------------------
-- INIZIALIZZO IL MENU CARICANDO LE IMPOSTAZIONI DA "Spring.GetConfigInt" ( vedi Lua UnsyncedRead)
--------------------------------------
function widget:Initialize()
-- todo
end

--------------------------------------
-- DISEGNO IL MINIMENU
--------------------------------------
function widget:DrawScreen()

--[[
-- inserisco lo sfondo ---------------------------------------------------------------------------------------------------------- completare con il calcolo dei pulsanti attivi
	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(	posx_menu,posy_menu,posx_menu+larghezza_menu,posy_menu+altezza_menu)	
	gl.Texture(false)	-- fine texture	
--]]

-- inserisco il main_minimenu_button
	gl.Color(1,1,1,1)
		if show_mainmenu then -- se la finestra delle opzioni principali è attiva
		gl.Texture(mainminimenubutton_on)	
		else
		gl.Texture(mainminimenubutton_off)	
		end
	gl.TexRect(	Pos_x_minimenu_button,Pos_y_minimenu_button,Pos_x_minimenu_button+larghezza_main_minimenu_button,Pos_y_minimenu_button+altezza_main_minimenu_button)	
	gl.Texture(false)	-- fine texture	
	Pos_x_next_button_drawing = posx_menu - interspazio_buttons - larghezza_minimenu_buttons -- definisco la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
	
-- inserisco show statistics minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_statistics_button then 	-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_statisticsmenu then 		-- se la finestra (o funzione) delle statistiche è attiva:
				gl.Texture(statisticsbutton_on)		-- mostra il pulsante acceso
				else
				gl.Texture(statisticsbutton_off)	-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end
		
-- inserisco obj minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_object_button then 	-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_objmenu then 				-- se la finestra (o funzione) degli obiettivi è attiva:
				gl.Texture(objbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(objbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end
		
-- inserisco sound minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_snd_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_sndmenu then 				-- se la finestra (o funzione) degli obiettivi è attiva:
				gl.Texture(sndbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(sndbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end

-- se si vuole inserire il separatore tra i bottoni del menu ( menu, statistiche, suono e obiettivi) a quelli funzionali ( LOS, idle ecc) abilitare questa funzione:
	Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_funzionale_buttons

-- inserisco LOS minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_los_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_losmenu then 				-- se la finestra (o funzione) del LOS è attiva:
				gl.Texture(losbutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(losbutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end

-- inserisco idle minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_idle_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_idlemenu then 					-- se la finestra (o funzione) di idle è attiva:
				gl.Texture(idlebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(idlebutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end
		
-- inserisco wind minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_wind_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_wingmenu then 				-- se la finestra (o funzione) di wind è attiva:
				gl.Texture(idlebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(idlebutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end		
	
-- inserisco tidal minipulsante, se abilitato
	gl.Color(1,1,1,1)
		if show_minimenu_tidal_button then 			-- se il minipulsante è attivo per vederlo nel minimenù:
				if show_tidalmenu then 				-- se la finestra (o funzione) di tidal è attiva:
				gl.Texture(idlebutton_on)			-- mostra il pulsante acceso
				else
				gl.Texture(idlebutton_off)			-- altrimenti mostra il pulsante spento	
				end
			gl.TexRect(	Pos_x_next_button_drawing,Pos_y_minimenu_button,Pos_x_next_button_drawing+larghezza_minimenu_buttons,Pos_y_minimenu_button+altezza_minimenu_buttons)	
			gl.Texture(false)	-- fine texture	
			Pos_x_next_button_drawing = Pos_x_next_button_drawing - interspazio_buttons - larghezza_minimenu_buttons -- traslo la posizione di partenza per disegnare il pulsante successivo (se sarà presente)
		end			
end -- end DrawScreen


