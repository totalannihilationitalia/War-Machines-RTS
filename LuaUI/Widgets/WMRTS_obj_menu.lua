--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_obj_menu.lua
--  brief:   War Machines RTS objectives menu
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2024.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


function widget:GetInfo()
	return {
		name    = "WMRTS_objmenu",
		desc    = "Shows War Machines RTS objectives during missions",
		author  = "Molix",
		date    = "23/12/2024",
		license   = "GNU GPL, v2 or later",
		layer   = 0,
		enabled = true
	}
--rev0: 23/12/2024 New WMRTS obj interface, integrated with WMRTS minimenu
end

--------------------------------------------------------------------------------
--[[
to do list 
-- fare in modo che in base al numero di missioni escono n righe di missioni
-- per farlo fare in modo di costruire il menu riga per riga in funzione delle missioni (bckgnd, nome miss1, descrizione miss1, bckgnd, nome miss2, descrizione miss2, ecc)
]]--
--------------------------------------------------------------------------------

-- definizione dei comandi
local Echo 							= Spring.Echo 
-- definizione variabili di posizione e lunghezza menu e icone
local vsx, vsy = widgetHandler:GetViewSizes()
local altezza_menu = 140
local larghezza_menu = 400
local posx_menu = vsx/2 - larghezza_menu/2 	-- parte da sx
local posy_menu = vsy/2 - altezza_menu/2 	-- parte dal basso
local mostra_objsetting = false 			-- show obj options
local larghezza_menu_buttons = 76 --114		-- like back button, close button
local altezza_menu_buttons = 25 --38		-- like back button, close button
local posx_menu_button = 11					-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button = -10				-- position y of first menu button (from 0 ,0 of main menu)
local distance_x_menu_button = 300			-- x distance between menu buttons
local margine_sx = 30						-- il margine dei testi dal bordo sinistro del background
local margine_superiore = 45 				-- il margine dal bordo superiore alla prima riga degli obiettivi
local interasse_righe = 20 					-- distanza tra le righe degli obiettivi

-- definizione immagini
local main_background				= "LuaUI/Images/menu/mainmenu/sfondo_sound.png"
local icona_menu_obj				= "LuaUI/Images/menu/mainmenu/menu_obj_icon.png"
local buttons_back					= "LuaUI/Images/menu/mainmenu/menu_back.png"
local buttons_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"

--caratteristche testo
local myFont	 					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)
local titolo_menu_col				= {0.8, 0.8, 1.0, 1}
local titolo_menu_dim	 			= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)

--stringe per l'elenco degli obiettivi
local missionData						= {}

--------------------------------------
-- AGGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------
-- funzione aggiorno la geometria
local function UpdateGeometry() -- aggiorno geometria
  posx_menu = vsx/2 - larghezza_menu/2
  posy_menu = vsy/2 - altezza_menu/2
end

-- funzione rilevamento delle dimensioni della finestra durante il resizing
function widget:ViewResize(viewSizeX, viewSizeY) -- quando si modifica la dimensione della finestra di spring, prelevane larghezza e altezza e fai partire la funzione "aggiorno geometria"
  vsx = viewSizeX
  vsy = viewSizeY
  UpdateGeometry()
end

--------------------------------------
-- RICEZIONE DEI COMANDI TESTUALI INTERNI AL GIOCO
--------------------------------------
function widget:TextCommand(command)

	if command == 'open_WMRTS_obj' then
		mostra_objsetting = true
	end
	if command == 'close_WMRTS_obj' then
		mostra_objsetting = false
	end	
end

--------------------------------------
-- ALLA PRESSIONE DEI PULSANTI
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
if mostra_objsetting and not Spring.IsGUIHidden() then
	if key == 0x01B then -- TASTO esc
	mostra_objsetting = false  
--		if ButtonMenu.click then ------------------------------------------------------------------------------- inserire il suono di chiusura finestra
--			ButtonMenu.click = false
--			PlaySoundFile(TEST_SOUND)		
			-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_obj_option')
				end			
			return true
--		end
	end
end
	
	return false
end

--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile mostra_objsettings è true.....
if mostra_objsetting and not Spring.IsGUIHidden() then
  return 
  -- disabilito il back button
  --((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante back
  --or
  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante close  
end
end

--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
if mostra_objsetting and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return "Objectives  (only works in game)"
  else
    return "Objectives"
  end
end
end

--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX)
--------------------------------------
function widget:MousePress(x, y, button)
if mostra_objsetting and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return false
  end
  if button== 1 then -- aggiunto rev1
  if (widget:IsAbove(x, y)) then
--[[	-- disabilito il back button
	-- se clicca sul pulsante back
		if  ((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante back
				mostra_objsetting = false  
--		if ButtonMenu.click then
--			ButtonMenu.click = false
--			PlaySoundFile(TEST_SOUND)		
			-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_obj_option')
				end		
			Spring.SendCommands("close_WMRTS_obj") -- invia il comando per chiudere il obj button sul minimenu
			Spring.SendCommands("open_WMRTS_menu") -- invia comando per aprire menu principale di WMRTS
			return true    
--]]			
	-- se clicca sul pulsante close			
	  if  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante close
	Spring.SendCommands("close_WMRTS_obj") -- invia il comando per chiudere il obj button sul minimenu	
	mostra_objsetting = false  -- chiudo il menu soundsettings
--		if ButtonMenu.click then
--			ButtonMenu.click = false
--			PlaySoundFile(TEST_SOUND)		
			-- remove gui shader
		if (WG['guishader_api'] ~= nil) then
			WG['guishader_api'].RemoveRect('WMRTS_obj_option')
		end		
	
   return true       
	
	
	end
	
  end

  end-- if button == 1 aggiunto rev1
  return false
end
end

--------------------------------------
-- RICEVO GLI OBIETTIVI DURANTE LA MISSIONE
--------------------------------------
function widget:GameFrame(frame)
	if frame%30 == 0 then
		-- ricevo il numero degli obiettivi attivi per la missione
		missionData["numero_obiettivi_attivi"] 	= Spring.GetGameRulesParam("noobjactive")
		
	    -- ricevo lo stato della missione 1
		missionData["Objective 1"] 	= Spring.GetGameRulesParam("uploadobj1")
		-- ricevo lo stato della missione 2
		missionData["Objective 2"] 	= Spring.GetGameRulesParam("uploadobj2")
		-- ricevo lo stato della missione 3
		missionData["Objective 3"] 	= Spring.GetGameRulesParam("uploadobj3")
		-- ricevo lo stato della missione 4
		missionData["Objective 4"] 	= Spring.GetGameRulesParam("uploadobj4")
	    -- ricevo lo stato della missione 5
		missionData["Objective 5"] 	= Spring.GetGameRulesParam("uploadobj5")
		-- ricevo il titolo della missione 1
		missionData["titoloobj1"] 	= Spring.GetGameRulesParam("settitolo1")
		-- ricevo il titolo della missione 2
		missionData["titoloobj2"] 	= Spring.GetGameRulesParam("settitolo2")
		-- ricevo il titolo della missione 3
		missionData["titoloobj3"] 	= Spring.GetGameRulesParam("settitolo3")
		-- ricevo il titolo della missione 4
		missionData["titoloobj4"] 	= Spring.GetGameRulesParam("settitolo4")
		-- ricevo il titolo della missione 5
		missionData["titoloobj5"] 	= Spring.GetGameRulesParam("settitolo5")

	end
end

--------------------------------------
-- DISEGNO L' OBJ MENU
--------------------------------------
function widget:DrawScreen()
	if mostra_objsetting then

-- inserisco lo sfondo
 	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(	posx_menu,posy_menu,posx_menu+larghezza_menu,posy_menu+altezza_menu)	
	gl.Texture(false)	-- fine texture	
  
-- icona menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_menu_obj)	-- add the icon
	gl.TexRect(posx_menu+20,posy_menu+107, posx_menu+20+40,posy_menu+147)	
	gl.Texture(false)	-- fine texture		
	
--titolo menu
	titolo_menu_dim:SetTextColor(titolo_menu_col)
	titolo_menu_dim:Begin()
	titolo_menu_dim:Print("Objectives:", posx_menu+70,posy_menu+106,14,'ds') 
	titolo_menu_dim:End()

-- pulsante close, second button
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_close)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button+distance_x_menu_button,posy_menu+posy_menu_button, posx_menu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)
	gl.Texture(false)	-- fine texture			

-- testi dei PULSANTI
	gl.LoadFont("FreeSansBold.otf",14, 1.9, 40):SetTextColor(0.5,0.5,0.5,0.5)
	gl.Text(string.format("CLOSE"), posx_menu+posx_menu_button+distance_x_menu_button +45 , posy_menu+posy_menu_button +9, 9, "ocn") -- close button
	
-- testi delle missioni
	myFont:Begin()		
	myFont:SetTextColor(1,1,1,1)
	
-- scrivo nel menu i titoli degli obiettivi (distruggi x, difendi y ecc) impostabili dalla funzione function widget:GameFrame(frame)
	myFont:Print(missionData["titoloobj1"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore ,12,'vs')
	myFont:Print(missionData["titoloobj2"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 1,12,'vs')
	myFont:Print(missionData["titoloobj3"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 2,12,'vs')
	myFont:Print(missionData["titoloobj4"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 3,12,'vs')
	myFont:Print(missionData["titoloobj5"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 4,12,'vs')
	myFont:SetTextColor(cWhite)

-- ricevo lo stato degli obiettivi (in progess, complete, failed ecc) impostabili dalla funzione function widget:GameFrame(frame)
	myFont:Print(missionData["Objective 1"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore ,12,'vs')
	myFont:Print(missionData["Objective 2"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 1,12,'vs')
	myFont:Print(missionData["Objective 3"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 2,12,'vs')
	myFont:Print(missionData["Objective 4"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 3,12,'vs')
	myFont:Print(missionData["Objective 5"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 4,12,'vs')
	myFont:End()
		
	--reset state
	gl.Texture(false)
	gl.Color(1,1,1,1)

	-- gui shader	
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect( posx_menu,posy_menu, posx_menu+larghezza_menu, posy_menu+altezza_menu,'WMRTS_obj_option')
	end

 
          

  return
  end -- mostra_objsetting = true
end