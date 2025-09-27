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
-- rev 0 by molix -- 23/12/2024 -- New WMRTS obj interface, integrated with WMRTS minimenu
-- rev 1 by molix -- 03/01/2025 -- risolto problema di memoria e relativo crash in Spring 
-- rev 2 by molix -- 26/09/2025 -- rimosso il gui shader quando si riceve il comando di chiudere obj menu
end

--------------------------------------------------------------------------------
--[[
to do list 
-- fare in modo che in base al numero di missioni escono n righe di missioni
-- per farlo fare in modo di costruire il menu riga per riga in funzione delle missioni (bckgnd, nome miss1, descrizione miss1, bckgnd, nome miss2, descrizione miss2, ecc)
-- Aggiungere le icone alle missioni (in base al tipo, difendi, attacca, cerca, ecc)
-- Nel caso in cui la partita non sia una missione, visualizzare starting metal, starting energy, deathmode, ed eventualmente altri parametri dello skirmish
]]--
--------------------------------------------------------------------------------

-- definizione dei comandi
local Echo 							= Spring.Echo 
-- definizione variabili di posizione e lunghezza menu e icone
local vsx, vsy = widgetHandler:GetViewSizes()
local altezza_briefing 						 = 70 -- 140
local larghezza_menu 			 		 = 400
local posx_menu = vsx/2 - larghezza_menu/2 			-- parte da sx
local posy_menu = vsy/2 - altezza_briefing/2 			-- parte dal basso
local mostra_objsetting = false 					-- show obj options
local larghezza_menu_buttons 		     = 76		-- like back button, close button
local altezza_briefing_buttons				 = 25		-- like back button, close button
local posx_menu_button 					 = 11		-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button					 = -10		-- position y of first menu button (from 0 ,0 of main menu)
local distance_x_menu_button 			 = 300		-- x distance between menu buttons
local margine_sx 						 = 30		-- il margine dei testi dal bordo sinistro del background
local margine_superiore					 = 45 		-- il margine dal bordo superiore alla prima riga degli obiettivi
local interasse_righe_missioni			 = 20 		-- distanza tra le righe degli obiettivi
local selettore_buttons_visibile 		 = false	-- visibile o no
local posx_selettore_buttons 			 = 0		-- posizione x del selettore dei pulsanti close, back ecc
local posy_selettore_buttons 			 = 0		-- posizione y del selettore dei pulsanti close, back ecc
local posizione_riga_calcolata			 = 0		-- posizione calcoloata delle righe degli obiettivi

-- definizione immagini
local main_background				= "LuaUI/Images/menu/mainmenu/sfondo_obj.png"
local icona_menu_obj				= "LuaUI/Images/menu/mainmenu/menu_obj_icon.png"
local buttons_back					= "LuaUI/Images/menu/mainmenu/menu_back.png"
local buttons_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"
local selettore_button 				= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"

local iconaobj1					-- definirà il tipo di icona
local iconaobj2					-- definirà il tipo di icona
local iconaobj3					-- definirà il tipo di icona
local iconaobj4					-- definirà il tipo di icona
local iconaobj5					-- definirà il tipo di icona
local basePath 						= "LuaUI/Images/menu/mainmenu/"  -- percorso base per icone
local row_backgroundObj				= "LuaUI/Images/menu/mainmenu/sfondo_rowobj.png"
local row_backgroundEnd				= "LuaUI/Images/menu/mainmenu/sfondo_rowobjend.png"

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
  posy_menu = vsy/2 - altezza_briefing/2
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
			-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_obj_option')
				end				
	end	
end

--------------------------------------
-- ALLA PRESSIONE DEI PULSANTI
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
if mostra_objsetting and not Spring.IsGUIHidden() then
	if key == 0x01B then -- TASTO esc
	mostra_objsetting = false  
	Spring.SendCommands("close_WMRTS_obj") 		-- invia comando per spegnere il minibutton obj del minimenu	
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
-- SEMPRE
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if mostra_objsetting and not Spring.IsGUIHidden() then
				-- backbutton
				if 	
				((mousex >= posx_menu+posx_menu_button+distance_x_menu_button) and (mousex <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (mousey >= posy_menu+posy_menu_button-posizione_riga_calcolata) and (mousey <= posy_menu+posy_menu_button+altezza_briefing_buttons-posizione_riga_calcolata)) then -- .... il pulsante close
				selettore_buttons_visibile = true
				posx_selettore_buttons = posx_menu+posx_menu_button+distance_x_menu_button
				posy_selettore_buttons = posy_menu+posy_menu_button-posizione_riga_calcolata
				else
				selettore_buttons_visibile = false
				end
	end
end

--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile mostra_objsettings è true.....
if mostra_objsetting and not Spring.IsGUIHidden() then
  return 
  -- disabilito il back button
  --((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_briefing_buttons)) -- .... il pulsante back
  --or
  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button-posizione_riga_calcolata) and (y <= posy_menu+posy_menu_button+altezza_briefing_buttons-posizione_riga_calcolata)) -- .... il pulsante close  
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
	-- se clicca sul pulsante close			
	  if  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button-posizione_riga_calcolata) and (y <= posy_menu+posy_menu_button+altezza_briefing_buttons-posizione_riga_calcolata)) then -- .... il pulsante close
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
--		missionData["numero_obiettivi_attivi"] 	= Spring.GetGameRulesParam("noobjactive")
		
	    -- ricevo lo stato della missione 1 -- example Spring.SetGameRulesParam("uploadobj1", "Defend the containers around the trains")
		missionData["Objective 1"] 	= Spring.GetGameRulesParam("uploadobj1")
		-- ricevo lo stato della missione 2
		missionData["Objective 2"] 	= Spring.GetGameRulesParam("uploadobj2")
		-- ricevo lo stato della missione 3
		missionData["Objective 3"] 	= Spring.GetGameRulesParam("uploadobj3")
		-- ricevo lo stato della missione 4
		missionData["Objective 4"] 	= Spring.GetGameRulesParam("uploadobj4")
	    -- ricevo lo stato della missione 5
		missionData["Objective 5"] 	= Spring.GetGameRulesParam("uploadobj5")
		-- ricevo il titolo della missione 1 -- example Spring.SetGameRulesParam("settitolo1", "In progress")
		missionData["titoloobj1"] 	= Spring.GetGameRulesParam("settitolo1")
		-- ricevo il titolo della missione 2
		missionData["titoloobj2"] 	= Spring.GetGameRulesParam("settitolo2")
		-- ricevo il titolo della missione 3
		missionData["titoloobj3"] 	= Spring.GetGameRulesParam("settitolo3")
		-- ricevo il titolo della missione 4
		missionData["titoloobj4"] 	= Spring.GetGameRulesParam("settitolo4")
		-- ricevo il titolo della missione 5
		missionData["titoloobj5"] 	= Spring.GetGameRulesParam("settitolo5")
		-- ricevo la tipologia di missione 1, serve per stabilire l'icona -- example Spring.SetGameRulesParam("setobjtype", "defend") -- defend, secure, attack, destroy, aggiungere qui altre se si vuole
		missionData["typeobj1"] 	= Spring.GetGameRulesParam("settype1")
		missionData["typeobj2"] 	= Spring.GetGameRulesParam("settype2")
		missionData["typeobj3"] 	= Spring.GetGameRulesParam("settype3")
		missionData["typeobj4"] 	= Spring.GetGameRulesParam("settype4")
		missionData["typeobj5"] 	= Spring.GetGameRulesParam("settype5")		
		
		-----------------
		-- elaboro le informazioni delle icone
		-----------------
		
		-- carico la tipologia di missione per stabilire l'icona
	local tipoObiettivo1 = missionData["typeobj1"]
	local tipoObiettivo2 = missionData["typeobj2"]
	local tipoObiettivo3 = missionData["typeobj3"]
	local tipoObiettivo4 = missionData["typeobj4"]
	local tipoObiettivo5 = missionData["typeobj5"]

		-- setto le rispettiva icone
		-- icona 1
	if tipoObiettivo1 then -- Controlla se tipoObiettivo1 non è nil
		iconaobj1 = basePath .. "obj_"..tipoObiettivo1 .. ".png"
		else		 -- se è di tipo nil	
		iconaobj1 = basePath .. "obj_none.png"	
	end
		-- icona 2
	if tipoObiettivo2 then 
		iconaobj2 = basePath .. "obj_"..tipoObiettivo2 .. ".png"
		else		 -- se è di tipo nil	
		iconaobj2 = basePath .. "obj_none.png"	
	end		
		-- icona 3
	if tipoObiettivo3 then 
		iconaobj3 = basePath .. "obj_"..tipoObiettivo3 .. ".png"
		else		 -- se è di tipo nil	
		iconaobj3 = basePath .. "obj_none.png"	
	end			
		-- icona 4
	if tipoObiettivo4 then 
		iconaobj4 = basePath .. "obj_"..tipoObiettivo4 .. ".png"
		else		 -- se è di tipo nil	
		iconaobj4 = basePath .. "obj_none.png"	
	end			
		-- icona 5		
	if tipoObiettivo5 then 
		iconaobj5 = basePath .. "obj_"..tipoObiettivo5 .. ".png"
		else		 -- se è di tipo nil	
		iconaobj5 = basePath .. "obj_none.png"	
	end			
	end -- frame%30
end

--------------------------------------
-- DISEGNO L' OBJ MENU
--------------------------------------
function widget:DrawScreen()

	if mostra_objsetting then
	posizione_riga_calcolata = 0 -- resetto la posizione delle rige del menu


-- inserisco lo sfondo
 	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(	posx_menu,posy_menu,posx_menu+larghezza_menu,posy_menu+altezza_briefing)	
	gl.Texture(false)	-- fine texture	
  
-- icona menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_menu_obj)	-- add the icon
	gl.TexRect(posx_menu+20,posy_menu+altezza_briefing-30, posx_menu+20+40,posy_menu+altezza_briefing+40-30)	
	gl.Texture(false)	-- fine texture		
	
--titolo menu
	titolo_menu_dim:SetTextColor(titolo_menu_col)
	titolo_menu_dim:Begin()
	titolo_menu_dim:Print("Objectives", posx_menu+70,posy_menu+altezza_briefing-30,14,'ds') 
	titolo_menu_dim:End()



-- disegno le icone delle missioni
	

-- testi delle missioni
	
-- scrivo nel menu i titoli degli obiettivi (distruggi x, difendi y ecc) impostabili dalla funzione function widget:GameFrame(frame)
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
if missionData["Objective 1"] ~= nil then --disegna la riga dell'obiettivo 1
	-- sfondo riga
	gl.Color(1,1,1,1)
	gl.Texture(row_backgroundObj)
	gl.TexRect(	posx_menu,posy_menu-posizione_riga_calcolata,posx_menu+larghezza_menu,posy_menu-posizione_riga_calcolata-interasse_righe_missioni )		
--	gl.TexRect(	posx_menu+posx_menu_button+distance_x_menu_button,posx_menu+10+12,posy_menu + altezza_briefing - margine_superiore-5+12)	
	gl.Texture(false)	
	-- icona missione
	gl.Color(1,1,1,1)
	gl.Texture(iconaobj1)	 
	gl.TexRect(	posx_menu+10,posy_menu -15-posizione_riga_calcolata,posx_menu+10+13,posy_menu -2-posizione_riga_calcolata)	
	gl.Texture(false)		
	-- titolo
	myFont:Begin()	
	myFont:Print(missionData["titoloobj1"] or "-", posx_menu+margine_sx, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	-- descrizione
	myFont:Print(missionData["Objective 1"] or "-", posx_menu+margine_sx+100, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	myFont:End()
	-- ricalcolo nuova riga	
	posizione_riga_calcolata = posizione_riga_calcolata+interasse_righe_missioni	
	end	-- obiettivo 1
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
if missionData["Objective 2"] ~= nil then --disegna la riga dell'obiettivo 2
	-- sfondo riga
	gl.Color(1,1,1,1)
	gl.Texture(row_backgroundObj)
	gl.TexRect(	posx_menu,posy_menu-posizione_riga_calcolata,posx_menu+larghezza_menu,posy_menu-posizione_riga_calcolata-interasse_righe_missioni )			
	gl.Texture(false)	
	-- icona missione
	gl.Color(1,1,1,1)
	gl.Texture(iconaobj2)	 
	gl.TexRect(	posx_menu+10,posy_menu -15-posizione_riga_calcolata,posx_menu+10+13,posy_menu -2-posizione_riga_calcolata)		
	gl.Texture(false)		
	-- titolo
	myFont:Begin()	
	myFont:Print(missionData["titoloobj2"] or "-", posx_menu+margine_sx, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	-- descrizione
	myFont:Print(missionData["Objective 2"] or "-", posx_menu+margine_sx+100, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	myFont:End()
	-- ricalcolo nuova riga
	posizione_riga_calcolata = posizione_riga_calcolata+interasse_righe_missioni	
	end	-- obiettivo 2
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
if missionData["Objective 3"] ~= nil then --disegna la riga dell'obiettivo 3
	-- sfondo riga
	gl.Color(1,1,1,1)
	gl.Texture(row_backgroundObj)
	gl.TexRect(	posx_menu,posy_menu-posizione_riga_calcolata,posx_menu+larghezza_menu,posy_menu-posizione_riga_calcolata-interasse_righe_missioni )		
	gl.Texture(false)	
	-- icona missione
	gl.Color(1,1,1,1)
	gl.Texture(iconaobj3)	 
	gl.TexRect(	posx_menu+10,posy_menu -15-posizione_riga_calcolata,posx_menu+10+13,posy_menu -2-posizione_riga_calcolata)	
	gl.Texture(false)		
	-- titolo
	myFont:Begin()	
	myFont:Print(missionData["titoloobj3"] or "-", posx_menu+margine_sx, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	-- descrizione
	myFont:Print(missionData["Objective 3"] or "-", posx_menu+margine_sx+100, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	myFont:End()
	-- ricalcolo nuova riga
	posizione_riga_calcolata = posizione_riga_calcolata+interasse_righe_missioni		
	end	-- obiettivo 3
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
if missionData["Objective 4"] ~= nil then --disegna la riga dell'obiettivo 4
	-- sfondo riga
	gl.Color(1,1,1,1)
	gl.Texture(row_backgroundObj)
	gl.TexRect(	posx_menu,posy_menu-posizione_riga_calcolata,posx_menu+larghezza_menu,posy_menu-posizione_riga_calcolata-interasse_righe_missioni )		
	gl.Texture(false)	
	-- icona missione
	gl.Color(1,1,1,1)
	gl.Texture(iconaobj4)	 
	gl.TexRect(	posx_menu+10,posy_menu -15-posizione_riga_calcolata,posx_menu+10+13,posy_menu -2-posizione_riga_calcolata)		
	gl.Texture(false)		
	-- titolo
	myFont:Begin()	
	myFont:Print(missionData["titoloobj4"] or "-", posx_menu+margine_sx, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	-- descrizione
	myFont:Print(missionData["Objective 4"] or "-", posx_menu+margine_sx+100, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	myFont:End()
	-- ricalcolo nuova riga
	posizione_riga_calcolata = posizione_riga_calcolata+interasse_righe_missioni		
	end	-- obiettivo 4
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
if missionData["Objective 5"] ~= nil then --disegna la riga dell'obiettivo 5
	-- sfondo riga
	gl.Color(1,1,1,1)
	gl.Texture(row_backgroundObj)
	gl.TexRect(	posx_menu,posy_menu-posizione_riga_calcolata,posx_menu+larghezza_menu,posy_menu-posizione_riga_calcolata-interasse_righe_missioni )			
	gl.Texture(false)	
	-- icona missione
	gl.Color(1,1,1,1)
	gl.Texture(iconaobj5)	 
	gl.TexRect(	posx_menu+10,posy_menu -15-posizione_riga_calcolata,posx_menu+10+13,posy_menu -2-posizione_riga_calcolata)	
	gl.Texture(false)		
	-- titolo
	myFont:Begin()	
	myFont:Print(missionData["titoloobj5"] or "-", posx_menu+margine_sx, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	-- descrizione
	myFont:Print(missionData["Objective 5"] or "-", posx_menu+margine_sx+100, posy_menu -posizione_riga_calcolata-8 ,12,'vs')
	myFont:End()
	-- ricalcolo nuova riga
	posizione_riga_calcolata = posizione_riga_calcolata+interasse_righe_missioni		
	end	-- obiettivo 5	
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
	-- sfondo riga terminae
	gl.Color(1,1,1,1)
	gl.Texture(row_backgroundEnd)
	gl.TexRect(	posx_menu,posy_menu-posizione_riga_calcolata,posx_menu+larghezza_menu,posy_menu-posizione_riga_calcolata-interasse_righe_missioni )			
	gl.Texture(false)		
	-- ricalcolo nuova riga
	posizione_riga_calcolata = posizione_riga_calcolata+interasse_righe_missioni	
		
-- ricevo lo stato degli obiettivi (in progess, complete, failed ecc) impostabili dalla funzione function widget:GameFrame(frame)
--	myFont:Begin()	
--[[	
--	myFont:End()	
	myFont:Begin()		

	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 3"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_briefing - margine_superiore - interasse_righe_missioni * 2,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 4"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_briefing - margine_superiore - interasse_righe_missioni * 3,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 5"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_briefing - margine_superiore - interasse_righe_missioni * 4,12,'vs')
	myFont:End()	
			
	--reset state
--	gl.Texture(false)
--	gl.Color(1,1,1,1)
]]--

-- pulsante close, second button
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_close)	-- add the icon
	-- aggiungere anche l'altezza della riga terminale ala 7 qui di seguito ----------------------- ########################################################
	gl.TexRect(posx_menu+posx_menu_button+distance_x_menu_button,posy_menu+posy_menu_button-posizione_riga_calcolata, posx_menu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_briefing_buttons-posizione_riga_calcolata)
	gl.Texture(false)	-- fine texture			

-- testi dei PULSANTI
	myFont:Begin()	
	myFont:SetTextColor(1,1,1,1)	
	myFont:Print(("CLOSE"), posx_menu+posx_menu_button+distance_x_menu_button +45 , posy_menu+posy_menu_button +9-posizione_riga_calcolata, 9, "ocn") -- close button
	myFont:End()


-- riquadri di selezione dei menubuttons (close o back)
  	if selettore_buttons_visibile then
		gl.Color(1,1,1,1)
		gl.Texture(selettore_button)	-- add the selector
		gl.TexRect(posx_selettore_buttons,posy_selettore_buttons, posx_selettore_buttons+larghezza_menu_buttons,posy_selettore_buttons+altezza_briefing_buttons)	
		gl.Texture(false)	-- fine texture			
	end

	-- gui shader	
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect( posx_menu,posy_menu, posx_menu+larghezza_menu, posy_menu+altezza_briefing,'WMRTS_obj_option')
	end

  return
  end -- mostra_objsetting = true
end