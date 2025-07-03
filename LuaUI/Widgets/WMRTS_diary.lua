--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_diary.lua
--  brief:   Diary / Briefing for War Machines RTS missions
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2025.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_diary",
    desc      = "WMRTS diary menu",
    author    = "molixx81",
    date      = "30 Giugno, 2025",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

--------------------------------------------------------------------------------
--[[

to do list 
-- all :D
1) Global Map info
2) Story of War
3) Hints
4) Character
5) Units

Pulsante close
Pulsante avanti e dietro (per leggere le storie della categoria
tra i due pulsanti la pagina 1/xx
Al momento ogni scheda sarà un immagine con nomeimmagine_ing.png (cosi da diversificare quando un domani ci sarà il multilingua).

]]--

local Pos_x_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local Pos_y_mainmenu					= 20  								-- NON EDITARE posizione in basso a sinistra del menu (valore gestito poi autonomamente dallo script)
local larghezza_mainmenu				= 800 								-- larghezza
local altezza_mainmenu					= 400								-- altezza
local autopopup							= 1									-- attiva l'apertura del diario quando si riceve il comando
local diarymenu_attivo					= false 							-- Indica se questo menu è aperto o meno

-- Variabili n° massimo di item per categoria
local val_maps			-- n° news attive inerenti alle mappe
local val_story			-- n° news attive inerenti alla storia
local val_hints			-- n° news attive inerenti ai suggerimenti
local val_character		-- n° news attive inerenti ai personaggi
local val_units			-- n° news attive inerenti alle unità

-- variabili per "blinking" nuove news -- alla ricezione della rispettiva news la categoria lampeggia per indicare una nuova news
local new_maps
local new_story
local new_hints
local new_character
local new_units



-- definizioni immagini bottoni e background
local backgroundmainmenu 			= "LuaUI/Images/menu/mainmenu/diary_menu_bkgnd.png"
local button_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"

-- definizione delle news (le news sono le schede con il contenuto interamente in formato immagine)




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
	if command == 'diary_WMRTS_maps' then -- se ricevo una news inerente alla mappa globale
		new_maps = 1
		if autopopup == 1 then diarymenu_attivo = true end -- se l'opzione autopopup è abilitata, apri automaticamente il diario
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_story' then -- se ricevo una news inerente alla storia
		new_story = 1
		if autopopup == 1 then diarymenu_attivo = true end 
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_hints' then -- se ricevo una news inerente ai suggerimenti
		new_hints = 1	
		if autopopup == 1 then diarymenu_attivo = true end
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_character' then -- se ricevo una news inerente ai personaggi
		new_character = 1		
		if autopopup == 1 then diarymenu_attivo = true end
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_units' then -- se ricevo una news inerente alle unità
		new_units = 1			
		if autopopup == 1 then diarymenu_attivo = true end		
--		Inserire invio comando per "blinking" dell'icona diario nel minimenu		####################################
	elseif command == 'diary_WMRTS_open' then -- se ricevo il comando di aprire il diario (dal minimenu)
		diarymenu_attivo = true
	elseif command == 'diary_WMRTS_close' then -- se ricevo il comando di chiudere il diario (dal minimenu)
		diarymenu_attivo = false		
	end
end


--------------------------------------
-- ALLA PRESSIONE DEI TASTI 
--------------------------------------
function widget:KeyPress(key, mods, isRepeat) 
	if diarymenu_attivo and not Spring.IsGUIHidden() then
		if key == 27 then -- TASTO esc  0x01B
			diarymenu_attivo = false 							-- chiudo il diario
			Spring.SendCommands("diary_WMRTS_close")			-- spengo il minipulsante menu del minimenu 
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
--[[
############## inserire le opzioni corrette (tipo autopopup ed eventuali numerazioni)
-- all'inizio verifico anche il valore delle configurazioni
  valore_mapshading = Spring.GetConfigInt("AdvMapShading", 1)			-- booleano di default è true
  valore_unitshading = Spring.GetConfigInt("AdvModelShading", 1)			-- booleano di default è true
  valore_grass = Spring.GetConfigInt("GrassDetail", 1)   				-- booleano di default è true
  valore_hardwarecur = Spring.GetConfigInt("HardwareCursor", 0) 		-- booleano di default è falso
  valore_LUPS = Spring.GetConfigInt("LupsActive", 0) 					-- booleano di default è falso -> disattivo successivamente anche il Widget				## widget
  valore_bloom_shader = Spring.GetConfigInt("BloomshaderActive", 0)		-- booleano di default è falso -> disattivo successivamente anche il Widget			## widget
  valore_show_projeclight = Spring.GetConfigInt("ShowProjectile", 0)	-- booleano di default è falso  -> disattivo successivamente anche il Widget	## widget
  valore_xray = Spring.GetConfigInt("XrayActive", 0)					-- booleano di default è falso  -> disattivo successivamente anche il Widget			## widget
  valore_fullscreen = Spring.GetConfigInt("Fullscreen", 1) 				-- booleano di default è true
  valore_blinking = Spring.GetConfigInt("teamhighlight", 1)   			-- booleano di default è true
  valore_shadows = Spring.GetConfigInt("Shadows", 2) 					-- -1:=forceoff, 0:=off, 1:=full, 2:=fast (skip terrain)
  valore_showenvironmental = Spring.GetConfigInt("EnviroActive", 0)		-- booleano di default è falso ->  -> disattivo successivamente anche il Widget			## widget
  valore_antialiasing = Spring.GetConfigInt("MSAALevel", 0) 			-- valori da 0 a 32 MAX
  valore_watertype = Spring.GetConfigInt("Water", 1) 					-- Defines the type of water rendering. Can be set in game. Options are: 0 = Basic water, 1 = Reflective water, 2 = Reflective and Refractive water, 3 = Dynamic water, 4 = Bumpmapped water
  valore_vsynk = Spring.GetConfigInt("VSync", 0)   						-- valori 1 o 0 (default) abilita o disabilita standard VSynk
  valore_mapborders = Spring.GetConfigInt("MapBorder", 1)   			-- valori 1 (default) o 0 abilita o disabilita bordi della mappa
]]--
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
-- DISEGNO IL DIARY
-------------------------------------- 
 function widget:DrawScreen()
if diarymenu_attivo then -- se il main menu è attivo, allora disegnalo



end -- if diarymenu_attivo	
end --drawscreen