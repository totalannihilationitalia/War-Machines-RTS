--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_exitmenu.lua
--  brief:   War Machines RTS exit to windows options
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2024.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_exitmenu",
    desc      = "WMRTS exit options",
    author    = "molixx81",
    date      = "10 Dicember, 2024",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true -- false at the moment, under test 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
-- aggiungere comando exit
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix -- 10/12/2024 -- designing EXIT menu
-- rev 1 by molix -- 03/01/2025 -- risolto problema di memoria e relativo crash in Spring 

-- definizione variabili
local vsx, vsy = widgetHandler:GetViewSizes()
local altezza_menu 							= 140
local larghezza_menu 						= 400
local interasse_righe 						= 20 					-- distanza tra le righe
local posx_menu = vsx/2 - larghezza_menu/2 							-- parte da sx
local posy_menu = vsy/2 - altezza_menu/2 							-- parte dal basso
local mostra_exitmenu 						= false 				-- mostra / nascondi menu
local larghezza_menu_buttons 				= 76 --114				-- like back button, close button
local altezza_menu_buttons 					= 25 --38				-- like back button, close button
local posx_menu_button						= 11					-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button 						= -10					-- position y of first menu button (from 0 ,0 of main menu)
local distance_x_menu_button 				= 300					-- x distance between menu buttons
local selettore_buttons_visibile 		 	= false					-- visibile o no
local posx_selettore_buttons 			 	= 0						-- posizione x del selettore dei pulsanti close, back ecc
local posy_selettore_buttons 			 	= 0						-- posizione y del selettore dei pulsanti close, back ecc

-- definizione immagini
local main_background				= "LuaUI/Images/menu/mainmenu/sfondo_sound.png"
local icona_menu_exit				= "LuaUI/Images/menu/mainmenu/icona_exit.png"
local buttons_back					= "LuaUI/Images/menu/mainmenu/menu_back.png"
local buttons_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"
local buttons_ok					= "LuaUI/Images/menu/mainmenu/menu_ok.png"
local selettore_button 				= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"

--caratteristche testo
local titolo_menu_col				= {0.8, 0.8, 1.0, 1}
local titolo_menu_dim	 			= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)

-- impostazione dei fonts
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

--------------------------------------
-- AGGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------
-- funzione aggiorno la geometria
local function UpdateGeometry() -- aggiorno geometria
  posx_menu = vsx/2 - larghezza_menu/2
  posy_menu = vsy/2 - altezza_menu/2
end
--UpdateGeometry()

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
	if command == 'open_WMRTS_exit' and not mostra_exitmenu then
		mostra_exitmenu = true
--		Spring.SendCommands("open_WMRTS_minimenuexit")  -- invio il comando open_WMRTS_xxxx per gestire la rispettiva icona del minimenu
	elseif command ==  'open_WMRTS_exit' and mostra_exitmenu then
		mostra_exitmenu = false
--		Spring.SendCommands("close_WMRTS_minimenuexit")  -- invio il comando close_WMRTS_xxxx per gestire la rispettiva icona del minimenu
-- invio il comando close_WMRTS_minimenu per gestire l'icona minimenu		---------------------------------------------------------------------------		
	end
end

--------------------------------------
-- ALLA PRESSIONE DEI PULSANTI
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
if mostra_exitmenu and not Spring.IsGUIHidden() then
	if key == 0x01B then -- TASTO esc
	mostra_exitmenu = false  
-- remove gui shader
			if (WG['guishader_api'] ~= nil) then
				WG['guishader_api'].RemoveRect('WMRTS_exit_option')
			end			
			return true
	end
end
	return false
end

--------------------------------------
-- SEMPRE
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if mostra_exitmenu and not Spring.IsGUIHidden() then
				-- backbutton
				if 	
				((mousex >= posx_menu+posx_menu_button) and (mousex <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (mousey >= posy_menu+posy_menu_button) and (mousey <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante back
				selettore_buttons_visibile = true
				Spring.Echo("test")
				posx_selettore_buttons = posx_menu+posx_menu_button 
				posy_selettore_buttons = posy_menu+posy_menu_button
				-- closebutton
				elseif 
				((mousex >= posx_menu+posx_menu_button+distance_x_menu_button) and (mousex <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (mousey >= posy_menu+posy_menu_button) and (mousey <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante close
				selettore_buttons_visibile = true
				posx_selettore_buttons = posx_menu+posx_menu_button+distance_x_menu_button
				posy_selettore_buttons = posy_menu+posy_menu_button
				elseif
				((mousex >= posx_menu+posx_menu_button+distance_x_menu_button/2) and (mousex <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button/2) and (mousey >= posy_menu+posy_menu_button) and (mousey <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante ok
				selettore_buttons_visibile = true
				posx_selettore_buttons = posx_menu+posx_menu_button+distance_x_menu_button/2
				posy_selettore_buttons = posy_menu+posy_menu_button
				else
				selettore_buttons_visibile = false
				end
	end
end

--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile mostra_exitmenus è true.....
if mostra_exitmenu and not Spring.IsGUIHidden() then
  return
  ((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante back
  or
  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante close  
  or
  ((x >= posx_menu+posx_menu_button+distance_x_menu_button/2) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button/2) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante ok
end
end

--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
if 	mostra_exitmenu and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return "Menu exit  (only works in game)"
  else
    return "Menu exit"
  end
end
end

--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX)
--------------------------------------
function widget:MousePress(x, y, button)
if mostra_exitmenu and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return false
  end
	if button== 1 then -- aggiunto rev1
		if (widget:IsAbove(x, y)) then
			if  ((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... se è sopra il pulsante back
				mostra_exitmenu = false  
				Spring.SendCommands("open_WMRTS_menu") -- invia comando per aprire menu principale di WMRTS
					if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_exit_option')
					end		
				return true        
			elseif  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante close
				mostra_exitmenu = false  
					if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_exit_option')
					end		
				return true       
			
			elseif  ((x >= posx_menu+posx_menu_button+distance_x_menu_button/2) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button/2) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante ok
				Spring.Echo("WIP: Exit to windows")
				Spring.SendCommands("QuitForce") -- invia comando per chiudere spring
				return true       
			end			
		end
	end-- if button == 1 aggiunto rev1
  return false
  end
end

--------------------------------------
-- DISEGNO IL SNDMENU
--------------------------------------
function widget:DrawScreen()
	if mostra_exitmenu then
  -- fade before the game starts  ("volume_master" command is not available)
  local alpha = (Spring.GetGameSeconds() < 0.1) and 0.2 or 0.9
  -- inserisco lo sfondo
 	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(	posx_menu,posy_menu,posx_menu+larghezza_menu,posy_menu+altezza_menu)	
	gl.Texture(false)	-- fine texture	
  
-- icona menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_menu_exit)	-- add the icon
	gl.TexRect(posx_menu+30,posy_menu+altezza_menu-30, posx_menu+30+60,posy_menu+altezza_menu+30)	
	gl.Texture(false)	-- fine texture		
	
--titolo menu
	titolo_menu_dim:SetTextColor(titolo_menu_col)
	titolo_menu_dim:Begin()
	titolo_menu_dim:Print("Exit menu", posx_menu+110,posy_menu+110,14,'ds') 
	titolo_menu_dim:End()
  
-- pulsante back, first button
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_back)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button,posy_menu+posy_menu_button, posx_menu+posx_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		

-- pulsante ok, secondo buttone
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_ok)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button+distance_x_menu_button/2,posy_menu+posy_menu_button, posx_menu+posx_menu_button+distance_x_menu_button/2+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)
	gl.Texture(false)	-- fine texture		
	
-- pulsante close, terzo buttone
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_close)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button+distance_x_menu_button,posy_menu+posy_menu_button, posx_menu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)
	gl.Texture(false)	-- fine texture			

-- riquadri di selezione dei menubuttons (close o back)
  	if selettore_buttons_visibile then
		gl.Color(1,1,1,1)
		gl.Texture(selettore_button)	-- add the selector
		gl.TexRect(posx_selettore_buttons,posy_selettore_buttons, posx_selettore_buttons+larghezza_menu_buttons,posy_selettore_buttons+altezza_menu_buttons)	
		gl.Texture(false)	-- fine texture			
	end

-- testi dei PULSANTI
	font_generale:Begin()
	font_generale:Print("MAIN MENU", posx_menu+posx_menu_button+ 45, posy_menu+posy_menu_button +9, 9, "ocn") -- BACK BUTTON
	font_generale:End()	

	font_generale:Begin()
	font_generale:Print("EXIT", posx_menu+posx_menu_button+distance_x_menu_button/2+ 45, posy_menu+posy_menu_button +9, 9, "ocn") -- OK BUTTON	
	font_generale:End()	
	
	font_generale:Begin()
	font_generale:Print("CLOSE", posx_menu+posx_menu_button+distance_x_menu_button +45 , posy_menu+posy_menu_button +9, 9, "ocn") -- close button
	font_generale:End()	

	font_generale:Begin()
	font_generale:Print("Do you want exit to Windows?",  posx_menu+190, posy_menu+60, 12, "ocn") -- frase
	font_generale:End()	
	
-- gui shader	
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( posx_menu,posy_menu, posx_menu+larghezza_menu, posy_menu+altezza_menu,'WMRTS_exit_option')
	end

   return
  end 
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
