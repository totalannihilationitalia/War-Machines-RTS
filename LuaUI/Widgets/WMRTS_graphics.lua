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
-- sulle opzioni multiple (come la selezione water) cambiare opzione precedente o successiva cliccando il tasto sx o dx del mouse facendo venire fuori un icona doppia del mouse con cliccato il pulsante sinistro e destro e rispettive funzioni
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix
-- designing WMRTS graphics menu

-- definizione dei comandi
local Echo 								= Spring.Echo 
-- definizione variabili di posizione e lunghezza menu e icone
local graphicsmenu_attivo				= false -- Indica se questo menu è attivo o meno
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local larghezza_mainmenu				= 400*2 -- doppia rispetto a mainmenu
local altezza_mainmenu					= 200+50-- + 2 opzioni (da 25 l'una), rispetto a mainmenu
local Pos_x_mainmenu					= 20  	-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  	-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local margine_sx_scritte				= 60  	-- margine sinistro da cui partono le scritte del menu
local margine_inferiore					= 25    -- margine inferiore da cui parte la prima riga delle opzioni
local distanzax_icone_testi				= 20  	-- distanza x tra le icone (caselle di selezione on/off) ed il testo della medesima opzione
local distanzay_icone_testi				= 2   	-- distanza x tra le icone (caselle di selezione on/off) ed il testo della medesima opzione
local interpazio_icone					= 4		-- distanza x tra due icone consecutive (ad esempio per le opzioni che necessitano di una regolazione + e -)
local larghezza_icona_opzioni			= 20  	-- larghezza icona opzioni
local altezza_icona_opzioni				= 20  	-- altezza icona opzioni
local offsety_selettore					= -4	-- offset y selettore rispetto al testo selezionato
local altezza_selettore					= 24  	-- altezza del selettore
local selettore_visibile				= false -- visibile o no quando si passa sopra l'opzione (a casella singola) o sopra il pulsante + o - nel caso della casella doppia
local mousex, mousey				   			-- posizione x e y del mouse, usata per rilevare la sua posizione e far apparire il selettore
local posy_watertype					= 25	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_antialiasing					= 25	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_shadows						= 50	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_showenveronmental			= 50	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_fullscreen					= 75	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_blinking						= 75	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_projectiles					= 100	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_xray							= 100	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_bloomshader					= 125	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_lups							= 125	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_hardwarecur					= 150	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_showgrass					= 150	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_advmapshading				= 175	-- posizione y della rispettiva riga (dal fondo del background) 
local posy_unitshading					= 175	-- posizione y della rispettiva riga (dal fondo del background) 
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
local backgroundmainmenu 			= "LuaUI/Images/menu/mainmenu/main_menu_bkgnd.png"
local selettore 					= "LuaUI/Images/menu/mainmenu/main_menu_selection.png"
local selettore_button 				= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"
local icona_onoff 					= "LuaUI/Images/menu/mainmenu/graphics_onoff.png"
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
		Spring.SendCommands("open_WMRTS_minimenu")  -- invio il comando open_WMRTS_minimenu per gestire l'icona minimenu
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
-- INIZIALIZZO IL MENU 
--------------------------------------
function widget:Initialize()
-- all'inizio imposto la posizione del mini menu
  Pos_x_mainmenu = vsx/2 - larghezza_mainmenu/2
  Pos_y_mainmenu = vsy/2 - altezza_mainmenu/2
  endTime = false
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
--[[
--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile graphicsmenu_attivo è true.....
	if graphicsmenu_attivo and not Spring.IsGUIHidden() then
				-- menusetting
				return 	((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_menuset) and (y <= Pos_y_mainmenu+Posy_menuset + altezza_menu_buttons))
				or
				-- visualsetting
				((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_visuals) and (y <= Pos_y_mainmenu+Posy_visuals + altezza_menu_buttons))
				-- graphicssetting
				or 
				((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_graphics) and (y <= Pos_y_mainmenu+Posy_graphics + altezza_menu_buttons))
				-- soundsettings
				or 
				((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_snd) and (y <= Pos_y_mainmenu+Posy_snd + altezza_menu_buttons))
				-- exittowindows
				or 
				((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_exitgame) and (y <= Pos_y_mainmenu+Posy_exitgame + altezza_menu_buttons))
				-- backbutton
				or
				((mousex >= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button) and (mousex <= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button +larghezza_menu_buttons) and (mousey >= Pos_y_mainmenu+posy_menu_button) and (mousey <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons))
	end --is gui hidden
end
]]--
--[[
--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE INSERENDO LE SPIEGAZIONI DEI PULSANTI ----------------------------
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
if graphicsmenu_attivo and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return "Main menu  (only works in game)"
  else
    return "Menu Options"
  end
end
end
]]--
--[[
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
				-- menusetting		
			if ((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_menuset) and (y <= Pos_y_mainmenu+Posy_menuset + altezza_menu_buttons)) then
				Echo("test mainmenu")
				return true
				-- visualsetting				
			elseif ((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_visuals) and (y <= Pos_y_mainmenu+Posy_visuals + altezza_menu_buttons)) then
				Echo("test visual menu")
				return true		
				-- sndsetting					
				elseif ((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_snd) and (y <= Pos_y_mainmenu+Posy_snd + altezza_menu_buttons)) then
				Spring.SendCommands("close_WMRTS_menu")
				Spring.SendCommands("open_WMRTS_snd")
				return true					
				-- graphicssetting						
			elseif ((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_graphics) and (y <= Pos_y_mainmenu+Posy_graphics + altezza_menu_buttons)) then
				Echo("test graphics menu")
				return true					
				-- exit to windows						
			elseif ((x >= Pos_x_mainmenu) and (x <= Pos_x_mainmenu + larghezza_mainmenu) and (y >= Pos_y_mainmenu+Posy_exitgame) and (y <= Pos_y_mainmenu+Posy_exitgame + altezza_menu_buttons)) then
				Spring.SendCommands("close_WMRTS_menu")				
				Spring.SendCommands("open_WMRTS_exit")				
				return true				
				-- backbutton
			elseif ((mousex >= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button ) and (mousex <= Pos_x_mainmenu+posx_menu_button+distance_x_menu_button +larghezza_menu_buttons) and (mousey >= Pos_y_mainmenu+posy_menu_button) and (mousey <= Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)) then
				Spring.SendCommands("close_WMRTS_menu")	
				return true
				
			end -- posizioni menu
		end
	end
    return false
  end
  
end
]]--
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
	font_intestazione:Print("Game menu", Pos_x_mainmenu+70, Pos_y_mainmenu + 170,14,'ds')
	font_intestazione:End()	
	
-- icona principale del menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_graphicsmenu)	
	gl.TexRect(	Pos_x_mainmenu+margine_sx_icona_graphicsmenu,Pos_y_mainmenu+altezza_mainmenu+margine_su_icona_graphicsmenu,Pos_x_mainmenu+margine_sx_icona_graphicsmenu+larghezza_icona_graphicsmenu,Pos_y_mainmenu+altezza_mainmenu+margine_su_icona_graphicsmenu+altezza_icona_graphicsmenu)	
	gl.Texture(false)	-- fine texture	

-- voce advanced unit shading del menu
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use advanced unit shading", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_exitgame,12,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_onoff)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_unitshading - distanzay_icone_testi,Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_unitshading - distanzay_icone_testi+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce advanced map shading del menu
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Use advance map shading", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_snd ,12,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	gl.Texture(icona_onoff)	
	gl.TexRect(	Pos_x_mainmenu+larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni*2-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_advmapshading - distanzay_icone_testi,Pos_x_mainmenu +larghezza_mainmenu/2 + margine_sx_scritte-larghezza_icona_opzioni-distanzax_icone_testi-interpazio_icone,Pos_y_mainmenu +posy_advmapshading - distanzay_icone_testi+altezza_icona_opzioni)	
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
	gl.TexRect(Pos_x_mainmenu+posx_menu_button+distance_x_menu_button,Pos_y_mainmenu+posy_menu_button, Pos_x_mainmenu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons,Pos_y_mainmenu+posy_menu_button+altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		

-- testo pulsante close	
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Close", Pos_x_mainmenu+posx_menu_button+distance_x_menu_button + 28, Pos_y_mainmenu+posy_menu_button+5 ,12,'ds')
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

