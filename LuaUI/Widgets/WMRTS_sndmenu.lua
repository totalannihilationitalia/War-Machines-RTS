--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_sndmenu.lua
--  brief:   War Machines RTS sounds options
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2024.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_sndmenu",
    desc      = "WMRTS sound options",
    author    = "molixx81",
    date      = "04 Dicember, 2024",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true -- false at the moment, under test 
  }
end

local TEST_SOUND = LUAUI_DIRNAME .. 'Sounds/pop.wav'

local function PlayTestSound()
  Spring.PlaySoundFile(TEST_SOUND, 1.0)
end

-- definizione variabili
local volume_master = 1.0					-- volume sounmaster
local volume_music = 1.0 					-- volume music
local volume_battle = 1.0 					-- volume battle
local vsx, vsy = widgetHandler:GetViewSizes()
local larghezza_barre =  200 				-- larghezza barre volume
local altezza_barre = 10					-- altezza barre volume
local altezza_menu = 140
local larghezza_menu = 400
local margine_barre_sx = 150				-- il margine sinistro delle barre dal background
local margine_barre_giu = 40 				-- il margine sotto delle barre dal background
local interasse_righe = 20 					-- distanza tra le righe
local posx_menu = vsx/2 - larghezza_menu/2 	-- parte da sx
local posy_menu = vsy/2 - altezza_menu/2 	-- parte dal basso
local mostra_soundsetting = false 			-- show sound options at start?
local larghezza_menu_buttons = 76 --114		-- like back button, close button
local altezza_menu_buttons = 25 --38		-- like back button, close button
local posx_menu_button = 11					-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button = -10				-- position y of first menu button (from 0 ,0 of main menu)
local distance_x_menu_button = 300			-- x distance between menu buttons

-- definizione immagini
local main_background				= "LuaUI/Images/menu/mainmenu/sfondo_sound.png"
local icona_menu_sound				= "LuaUI/Images/tweaksettings/mainmenu/menu_sound_icon.png"
local buttons_back					= "LuaUI/Images/menu/mainmenu/menu_back.png"
local buttons_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"

--caratteristche testo
local titolo_menu_col						= {0.8, 0.8, 1.0, 1}
local titolo_menu_dim	 					= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)

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

	if command == 'open_WMRTS_snd' then
		mostra_soundsetting = true
	end
	if command == 'close_WMRTS_snd' then
		mostra_soundsetting = false
	end	
end

--------------------------------------
-- ALLA PRESSIONE DEI PULSANTI
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
if mostra_soundsetting and not Spring.IsGUIHidden() then
	if key == 0x01B then -- TASTO esc
	mostra_soundsetting = false  
--		if ButtonMenu.click then
--			ButtonMenu.click = false
--			PlaySoundFile(TEST_SOUND)		
			-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('WMRTS_snd_option')
				end			
			return true
--		end
	end
end
	
	return false
end

--------------------------------------------------------------------------------

local function Calcvolume_master(x)
  volume_master = (x - (posx_menu + margine_barre_sx)) / ((posx_menu + margine_barre_sx+ larghezza_barre) - (posx_menu + margine_barre_sx))
  if (volume_master > 100) then
    volume_master = 1
  elseif (volume_master < 0) then
    volume_master = 0
  end
end

local function Calcvolume_music(x)
  volume_music = (x - (posx_menu + margine_barre_sx)) / ((posx_menu + margine_barre_sx+ larghezza_barre) - (posx_menu + margine_barre_sx))
  if (volume_music > 100) then
    volume_music = 1
  elseif (volume_music < 0) then
    volume_music = 0
  end
end

local function Calcvolume_battle(x)
  volume_battle = (x - (posx_menu + margine_barre_sx)) / ((posx_menu + margine_barre_sx+ larghezza_barre) - (posx_menu + margine_barre_sx))
  if (volume_battle > 100) then
    volume_battle = 1
  elseif (volume_battle < 0) then
    volume_battle = 0
  end
end

--------------------------------------
-- INIZIALIZZO IL MENU CARICANDO LE IMPOSTAZIONI DA "Spring.GetConfigInt" ( vedi Lua UnsyncedRead)
--------------------------------------
function widget:Initialize()
  volume_master = Spring.GetConfigInt("snd_volmaster", 60) 	-- prelevo il valore del volume master
  volume_master = volume_master * 0.01						-- e lo converto in numero da 0 a 1
  volume_music = Spring.GetConfigInt("snd_volmusic", 60)
  volume_music = volume_music * 0.01  
  volume_battle = Spring.GetConfigInt("snd_volbattle", 60)
  volume_battle = volume_battle * 0.01  
end

--------------------------------------
-- MOUSE IS OVER BUTTONS
--------------------------------------
function widget:IsAbove(x, y) -- se il mouse è sopra, gui non è nascosto e la variabile mostra_soundsettings è true.....
if mostra_soundsetting and not Spring.IsGUIHidden() then
  return ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu) and (y <= posy_menu +margine_barre_giu + altezza_barre)) -- ....il primo "quadrato" di selezione, definisco se il mouse si trova dentro le coordinate "x min",  "x max", "ymin" e "ymax" della barra di selezione per il volume master
  or 
  ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*1) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1)) -- .... il secondo "quadrato" di selezione, valido per il volume music
  or
  ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*2) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2)) -- .... il terzo "quadrato" di selezione, valido per il volume battle
  or
  ((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante back
  or
  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) -- .... il pulsante close  
end
end

--------------------------------------
-- GESTIONE TOOLTIP ------------------------------------------------------------------------------------------------ IMPLEMENTARE
--------------------------------------
function widget:GetTooltip(x, y) -- questa condizione è vera quando isAbove è vera, modificare aggiungendo  le condizioni dei quadrati
if mostra_soundsetting and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return "Sound Options  (only works in game)"
  else
    return "Sound Options"
  end
end
end

--------------------------------------
-- MOUSE PRESS BUTTONS 1 (SX)
--------------------------------------
function widget:MousePress(x, y, button)
if mostra_soundsetting and not Spring.IsGUIHidden() then
  if (Spring.GetGameSeconds() < 0.1) then
    return false
  end
  if button== 1 then -- aggiunto rev1
  if (widget:IsAbove(x, y)) then
	if ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu) and (y <= posy_menu +margine_barre_giu + altezza_barre))  then --se è sopra  il primo "quadrato" di selezione esegui le modifiche al volume_master
    Calcvolume_master(x)
	Spring.SetConfigInt("snd_volmaster", volume_master * 100)
	volume_master = Spring.GetConfigInt("snd_volmaster", volume_master)
	volume_master = volume_master * 0.01
     return true
	
	elseif ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*1) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1)) then --se è sopra  il secondo "quadrato" di selezione esegui le modifiche al volume_music
    Calcvolume_music(x)
	Spring.SetConfigInt("snd_volmusic", volume_music * 100)
	volume_music = Spring.GetConfigInt("snd_volmusic", volume_music)
	volume_music = volume_music * 0.01
     return true	

	elseif ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*2) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2)) then --se è sopra  il terzp "quadrato" di selezione esegui le modifiche al volume_battle
    Calcvolume_battle(x)
	Spring.SetConfigInt("snd_volbattle", volume_battle * 100)
	volume_battle = Spring.GetConfigInt("snd_volbattle", volume_battle)
	volume_battle = volume_battle * 0.01
     return true		
	
	  elseif  ((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante back
	mostra_soundsetting = false  
--		if ButtonMenu.click then
--			ButtonMenu.click = false
--			PlaySoundFile(TEST_SOUND)		
			-- remove gui shader
		if (WG['guishader_api'] ~= nil) then
			WG['guishader_api'].RemoveRect('WMRTS_snd_option')
		end		
	Spring.SendCommands("close_WMRTS_snd") -- invia il comando per chiudere il snd button sul minimenu
	Spring.SendCommands("open_WMRTS_menu") -- invia comando per aprire menu principale di WMRTS
	 return true        
	
	  elseif  ((x >= posx_menu+posx_menu_button+distance_x_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante close
	Spring.SendCommands("close_WMRTS_snd") -- invia il comando per chiudere il snd button sul minimenu	
	mostra_soundsetting = false  -- chiudo il menu soundsettings
--		if ButtonMenu.click then
--			ButtonMenu.click = false
--			PlaySoundFile(TEST_SOUND)		
			-- remove gui shader
		if (WG['guishader_api'] ~= nil) then
			WG['guishader_api'].RemoveRect('WMRTS_snd_option')
		end		
	
   return true       
	
	
	end
	
  end

  end-- if button == 1 aggiunto rev1
  return false
end
end

--------------------------------------
-- MOUSE IS MOVING
--------------------------------------
function widget:MouseMove(x, y, dx, dy, button)
if mostra_soundsetting and not Spring.IsGUIHidden() then
  if button == 1 then -- se il pulsante sinistro è premuto --aggiunto rev1
  if ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu) and (y <= posy_menu +margine_barre_giu + altezza_barre))  then --se è sopra  il primo "quadrato" di selezione esegui le modifiche al volume_master
  Calcvolume_master(x)
  Spring.SetConfigInt("snd_volmaster", volume_master * 100)
  return
 
  elseif ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*1) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1)) then --se è sopra  il secondo "quadrato" di selezione esegui le modifiche al volume_music
  Calcvolume_music(x)
  Spring.SetConfigInt("snd_volmusic", volume_music * 100)
  return

  elseif ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*2) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2)) then --se è sopra  il terzp "quadrato" di selezione esegui le modifiche al volume_battle  
  Calcvolume_battle(x)
  Spring.SetConfigInt("snd_volbattle", volume_battle * 100)
  return  
  
  
  end -- if del volume music  
  end -- end button 1 premuto -- aggiunto rev1
end
end

--------------------------------------
-- MOUSE BUTTON 1 IS RELEASE
--------------------------------------
function widget:MouseRelease(x, y, button)
if mostra_soundsetting and not Spring.IsGUIHidden() then
  if button == 1 then -- aggiunto rev1
  if ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu) and (y <= posy_menu +margine_barre_giu + altezza_barre))  then --se è sopra  il primo "quadrato" di selezione esegui le modifiche al volume_master
  Calcvolume_master(x)
  Spring.SetConfigInt("snd_volmaster", volume_master * 100)
  PlayTestSound()
  return -1
  
  elseif ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*1) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1)) then --se è sopra  il secondo "quadrato" di selezione esegui le modifiche al volume_music
  Calcvolume_music(x)
  Spring.SetConfigInt("snd_volmusic", volume_music * 100)
  PlayTestSound()
  return -1
  
   elseif ((x >= posx_menu + margine_barre_sx) and (x <= posx_menu + margine_barre_sx +larghezza_barre) and (y >= posy_menu + margine_barre_giu+interasse_righe*2) and (y <= posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2)) then --se è sopra  il terzp "quadrato" di selezione esegui le modifiche al volume_battle    
  Calcvolume_battle(x)
  Spring.SetConfigInt("snd_volbattle", volume_battle * 100)
  PlayTestSound()
  return -1
  
--  elseif  ((x >= posx_menu+posx_menu_button) and (x <= posx_menu+posx_menu_button+larghezza_menu_buttons) and (y >= posy_menu+posy_menu_button) and (y <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante back
--	mostra_soundsetting = false  
--		if (WG['guishader_api'] ~= nil) then
--			WG['guishader_api'].RemoveRect('WMRTS_snd_option')
--		end		
--   return true        ------------------------------------------------------- verificare questa cosa
  end -- if delle posizioni del puntatore
  end -- end button 1 premuto
end
end

--------------------------------------
-- DISEGNO IL SNDMENU
--------------------------------------
function widget:DrawScreen()
	if mostra_soundsetting then
  -- fade before the game starts  ("volume_master" command is not available)
  local alpha = (Spring.GetGameSeconds() < 0.1) and 0.2 or 0.9
--  local xvol = xmin + volume_master * (xmax - xmin) -- sostituito da:
	local xvol = (posx_menu + margine_barre_sx) + (volume_master * ((posx_menu + margine_barre_sx +larghezza_barre) - (posx_menu + margine_barre_sx)))
	local xvol_music = (posx_menu + margine_barre_sx) + (volume_music * ((posx_menu + margine_barre_sx +larghezza_barre) - (posx_menu + margine_barre_sx)))
	local xvol_battle = (posx_menu + margine_barre_sx) + (volume_battle * ((posx_menu + margine_barre_sx +larghezza_barre) - (posx_menu + margine_barre_sx)))	
  -- green/red level indicator
  gl.ShadeModel(GL.FLAT)
  gl.Color(.3, .3, .3)
    -- inserisco lo sfondo
 	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(	posx_menu,posy_menu,posx_menu+larghezza_menu,posy_menu+altezza_menu)	
	gl.Texture(false)	-- fine texture	
--
-- VOLUME MASTER
--
-- disegno il rettangolo di sfondo della linea di selezione volume master
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu },c = { 1, 0, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu + margine_barre_giu } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre } }, --xvol -- alto sx 
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu +margine_barre_giu + altezza_barre } }, -- alto dx
  })
  
	-- disegno la linea che definisce il valore de volume master
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu },c = { 0, 1, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { xvol, posy_menu + margine_barre_giu } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre } }, --xvol -- alto sx 
    { v = { xvol, posy_menu +margine_barre_giu + altezza_barre } }, -- alto dx
  })


--
-- VOLUME MUSIC
--
-- disegno il rettangolo di sfondo della linea di selezione volume MUSIC
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu + interasse_righe*1},c = { 1, 0, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu + margine_barre_giu +interasse_righe*1 } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1 } }, --xvol -- alto sx 
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu +margine_barre_giu + altezza_barre +interasse_righe *1} }, -- alto dx
  })
  
	-- disegno la linea che definisce il valore de  volume MUSIC ############################# finire di qui
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu+interasse_righe*1 },c = { 0, 1, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { xvol_music, posy_menu + margine_barre_giu +interasse_righe*1} }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1 } }, --xvol -- alto sx 
    { v = { xvol_music, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*1 } }, -- alto dx
  })

--
-- VOLUME BATTLE
--
-- disegno il rettangolo di sfondo della linea di selezione volume BATTLE
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu + interasse_righe*2},c = { 1, 0, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu + margine_barre_giu +interasse_righe*2 } }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2 } }, --xvol -- alto sx 
    { v = { posx_menu + margine_barre_sx +larghezza_barre, posy_menu +margine_barre_giu + altezza_barre +interasse_righe *2} }, -- alto dx
  })
  
-- disegno la linea che definisce il valore de  volume BATTLE 
    gl.Shape(GL.QUAD_STRIP, {
    { v = { posx_menu + margine_barre_sx, posy_menu + margine_barre_giu+interasse_righe*2 },c = { 0, 1, 0, alpha } }, -- basso sx = posizione del background + margine
    { v = { xvol_battle, posy_menu + margine_barre_giu +interasse_righe*2} }, -- basso dx =  posizione del background + margine + larghezza della barra
    { v = { posx_menu + margine_barre_sx, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2 } }, --xvol_battle -- alto sx 
    { v = { xvol_battle, posy_menu +margine_barre_giu + altezza_barre+interasse_righe*2 } }, -- alto dx
  })
  
  
  
-- icona menu
	gl.Color(1,1,1,1)
	gl.Texture(icona_menu_sound)	-- add the icon
	gl.TexRect(posx_menu+20,posy_menu+107, posx_menu+20+40,posy_menu+147)	
	gl.Texture(false)	-- fine texture		
	
--titolo menu
	titolo_menu_dim:SetTextColor(titolo_menu_col)
	titolo_menu_dim:Begin()
	titolo_menu_dim:Print("Sound settings:", posx_menu+70,posy_menu+106,14,'ds') 
	titolo_menu_dim:End()
  
--testi di fianco alle barre
	gl.Text(string.format("%i%%", 100 * volume_master), posx_menu + margine_barre_sx+ larghezza_barre + 20, posy_menu + margine_barre_giu +1, 12, "ocn") -- master volume %
	gl.Text(string.format("Master volume:"), posx_menu +140 , posy_menu + margine_barre_giu +1, 12, "orn") -- master volume title

	gl.Text(string.format("%i%%", 100 * volume_music), posx_menu + margine_barre_sx+ larghezza_barre + 20, posy_menu + margine_barre_giu +1+ interasse_righe*1, 12, "ocn") -- music volume %
	gl.Text(string.format("Music volume:"), posx_menu +140 , posy_menu + margine_barre_giu +1+ interasse_righe*1, 12, "orn") -- music volume title
	
	gl.Text(string.format("%i%%", 100 * volume_battle), posx_menu + margine_barre_sx+ larghezza_barre + 20, posy_menu + margine_barre_giu +1+ interasse_righe*2, 12, "ocn") -- battle volume %
	gl.Text(string.format("Battle volume:"), posx_menu +140 , posy_menu + margine_barre_giu +1+ interasse_righe*2, 12, "orn") -- battle volume title
  
  gl.ShadeModel(GL.SMOOTH)
  
-- pulsante back, first button
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_back)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button,posy_menu+posy_menu_button, posx_menu+posx_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)	
	gl.Texture(false)	-- fine texture		
	
-- pulsante close, second button
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_close)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button+distance_x_menu_button,posy_menu+posy_menu_button, posx_menu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)
	gl.Texture(false)	-- fine texture			

-- testi deu PULSANTI
	gl.LoadFont("FreeSansBold.otf",14, 1.9, 40):SetTextColor(0.5,0.5,0.5,0.5)
	gl.Text(string.format("MAIN MENU"), posx_menu+posx_menu_button+ 45, posy_menu+posy_menu_button +9, 9, "ocn") -- BACK BUTTON
	gl.Text(string.format("CLOSE"), posx_menu+posx_menu_button+distance_x_menu_button +45 , posy_menu+posy_menu_button +9, 9, "ocn") -- close button

-- gui shader	
	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect( posx_menu,posy_menu, posx_menu+larghezza_menu, posy_menu+altezza_menu,'WMRTS_snd_option')
	end

 
          

  return
  end -- mostra_soundsetting = true
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
