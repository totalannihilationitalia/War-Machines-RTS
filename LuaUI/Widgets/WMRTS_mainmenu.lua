--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_mainmenu.lua
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
    name      = "WMRTS_main menu",
    desc      = "WMRTS main menu options",
    author    = "molixx81",
    date      = "04 Dicember, 2024",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true -- false at the moment, under test 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
- pulsanti piccoli / grossi
- le immagini dei comandanti di fianco al menu
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix
-- designing WMRTS main-menù

-- definizione variabili di posizione e lunghezza
local mainmenu_attivo					= false
local vsx, vsy 						  	= widgetHandler:GetViewSizes()
local larghezza_mainmenu				= 400
local altezza_mainmenu					= 200
local Pos_x_mainmenu					-- posizione in bassi a sinistra del menu
local Pos_y_mainmenu					-- posizione in bassi a sinistra del menu
local margine_sx_scritte				= 10 -- margine sinistro da cui partono le scritte del menu
local distanza_icone_testi				= 20 -- distanza tra le icone ed il testo della medesima opzione
local larghezza_icona_opzioni			= 20 -- larghezza icona opzioni
local altezza_icona_opzioni				= 20 -- altezza icona opzioni
local Posy_exit							= 20  -- posizione y della rispettiva riga (dal fondo del background)
local Posy_snd  						= 30  -- posizione y della rispettiva riga (dal fondo del background)
local Posy_graphics 					= 40  -- posizione y della rispettiva riga (dal fondo del background)
local Posy_visuals  					= 50  -- posizione y della rispettiva riga (dal fondo del background)
local Posy_menuset  					= 60  -- posizione y della rispettiva riga (dal fondo del background)
local Posy_exitgame						= 10  -- posizione y della rispettiva riga (dal fondo del background) 

-- definizioni immagini bottoni e background
local backgroundmainmenu = "LuaUI/Images/menu/mainmenu/main_menu_bkgnd.png"
local icona_exit = ""
local icona_snd = ""
local icona_graphics = ""
local icona_visuals = ""
local icona_menuset = ""

-- impostazione dei fonts
local font_intestazione				= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local font_generale					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)

--------------------------------------
-- AGGIORNAMENTO DELLA GEOMETRIA
--------------------------------------
-- funzione aggiorno la posizione del minimenu button in alto a destra
local function UpdateGeometry() -- aggiorno geometria
  Pos_x_mainmenu = vsx/2 - Pos_x_mainmenu/2
  Pos_y_mainmenu = vsy/2 - Pos_y_mainmenu/2
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
-- all'inizio imposto la posizione del mini menu
  Pos_x_mainmenu = vsx/2 - Pos_x_mainmenu/2
  Pos_y_mainmenu = vsy/2 - Pos_y_mainmenu/2
end

--------------------------------------
-- DISEGNO IL MINIMENU
--------------------------------------
function widget:DrawScreen()
if mainmenu_attivo then -- se il main menu è attivo, allora disegnalo
-- inserisco il background del mainmenu
	gl.Color(1,1,1,1)
	gl.Texture(backgroundmainmenu)	
	gl.TexRect(	Pos_x_mainmenu,Pos_y_mainmenu,Pos_x_mainmenu+larghezza_mainmenu,Pos_y_mainmenu+altezza_mainmenu)	
	gl.Texture(false)	-- fine texture	

-- Intestazione del menu
	-- testo
	font_intestazione:SetTextColor(1, 1, 1, 1)
	font_intestazione:Begin()
	font_intestazione:Print("Game menu", Pos_x_mainmenu+50, Pos_y_mainmenu - 34,14,'ds')
	font_intestazione:End()	
	
-- voce exit to windows del menu
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Exit to Windows", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_exitgame,14,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_exit)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanza_icone_testi,Pos_y_mainmenu +Posy_exit,Pos_x_mainmenu + margine_sx_scritte-distanza_icone_testi,Pos_y_mainmenu +Posy_exit+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce sound option del menu ----------------------------------------------
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Sound settings", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_snd ,14,'ds')
	font_generale:End()
	-- icona	
	gl.Color(1,1,1,1)
	gl.Texture(icona_snd)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanza_icone_testi,Pos_y_mainmenu +Posy_snd,Pos_x_mainmenu + margine_sx_scritte-distanza_icone_testi,Pos_y_mainmenu +Posy_snd+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce visual option del menu ----------------------------------------------
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Visual settings", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_visuals ,14,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_visuals)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanza_icone_testi,Pos_y_mainmenu +Posy_visuals,Pos_x_mainmenu + margine_sx_scritte-distanza_icone_testi,Pos_y_mainmenu +Posy_visuals+altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
-- voce graphics option del menu ----------------------------------------------
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Graphics settings", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_graphics ,14,'ds')
	font_generale:End()	
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_graphics)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanza_icone_testi,Pos_y_mainmenu +Posy_graphics,Pos_x_mainmenu + margine_sx_scritte-distanza_icone_testi,Pos_y_mainmenu + Posy_graphics +altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture			
	
-- voce menu option del menu ----------------------------------------------
	-- testo
	font_generale:SetTextColor(1, 1, 1, 1)
	font_generale:Begin()
	font_generale:Print("Menu settings", Pos_x_mainmenu + margine_sx_scritte, Pos_y_mainmenu + Posy_menuset ,14,'ds')
	font_generale:End()		
	-- icona
	gl.Color(1,1,1,1)
	gl.Texture(icona_menuset)	
	gl.TexRect(	Pos_x_mainmenu + margine_sx_scritte-larghezza_icona_opzioni-distanza_icone_testi,Pos_y_mainmenu +Posy_menuset,Pos_x_mainmenu + margine_sx_scritte-distanza_icone_testi,Pos_y_mainmenu + Posy_menuset +altezza_icona_opzioni)	
	gl.Texture(false)	-- fine texture		
	
end -- if mainmenu_attivo	
end --drawscreen

