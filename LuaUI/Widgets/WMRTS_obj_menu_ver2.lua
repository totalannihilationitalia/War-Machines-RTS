--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_obj_menu_ver2.lua
--  brief:   War Machines RTS objectives menu
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2025.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


function widget:GetInfo()
	return {
		name    = "WMRTS_objmenu_ver2",
		desc    = "Shows War Machines RTS objectives during missions",
		author  = "Molix",
		date    = "28/05/2024",
		license   = "GNU GPL, v2 or later",
		layer   = 0,
		enabled = true
	}
-- rev 0 by molix -- 23/12/2024 -- New WMRTS obj interface, integrated with WMRTS minimenu
-- rev 1 by molix -- 03/01/2025 -- risolto problema di memoria e relativo crash in Spring 
-- rev 2 by molix -- 28/05/2025 -- from WMRTS_objmenu to WMRTS_objmenu_ver2 
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
local altezza_menu 						 = 140
local larghezza_menu 			 		 = 400
local posx_menu = vsx/2 - larghezza_menu/2 			-- parte da sx
local posy_menu = vsy/2 - altezza_menu/2 			-- parte dal basso
local mostra_objsetting = false 					-- show obj options
local larghezza_menu_buttons 		     = 76		-- like back button, close button
local altezza_menu_buttons				 = 25		-- like back button, close button
local posx_menu_button 					 = 11		-- position x of first menu button (from 0 ,0 of main menu)
local posy_menu_button					 = -10		-- position y of first menu button (from 0 ,0 of main menu)
local distance_x_menu_button 			 = 300		-- x distance between menu buttons
local margine_sx 						 = 30		-- il margine dei testi dal bordo sinistro del background
local margine_superiore					 = 45 		-- il margine dal bordo superiore alla prima riga degli obiettivi
local interasse_righe					 = 20 		-- distanza tra le righe degli obiettivi
local selettore_buttons_visibile 		 = false	-- visibile o no
local posx_selettore_buttons 			 = 0		-- posizione x del selettore dei pulsanti close, back ecc
local posy_selettore_buttons 			 = 0		-- posizione y del selettore dei pulsanti close, back ecc

-- definizione variabili per le missioni -- rev 2
local missionData = {
    obiettiviByKey = {}, -- Tabella che usa chiavi stringa: { obj1 = {data...}, pippo = {data...} }
    orderedKeys = {},    -- Tabella che mantiene l'ordine di inserimento delle chiavi, per il disegno
	
}
local numeroObiettivi					= 0 -- numero di obiettivi. per contare quanti obiettivi sono attivi --->  local numeroObiettivi = #missionData.orderedKeys

-- definizione immagini
local main_background				= "LuaUI/Images/menu/mainmenu/sfondo_sound.png"
local icona_menu_obj				= "LuaUI/Images/menu/mainmenu/menu_obj_icon.png"
local buttons_back					= "LuaUI/Images/menu/mainmenu/menu_back.png"
local buttons_close					= "LuaUI/Images/menu/mainmenu/menu_close.png"
local selettore_button 				= "LuaUI/Images/menu/mainmenu/main_menu_buttonselection.png"

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
-- SEMPRE
--------------------------------------
function widget:Update(dt)
mousex, mousey = Spring.GetMouseState ()  -- verificare se diradare il time di aggiornamento
	if mostra_objsetting and not Spring.IsGUIHidden() then
				-- backbutton
				if 	
				((mousex >= posx_menu+posx_menu_button+distance_x_menu_button) and (mousex <= posx_menu+posx_menu_button+larghezza_menu_buttons+distance_x_menu_button) and (mousey >= posy_menu+posy_menu_button) and (mousey <= posy_menu+posy_menu_button+altezza_menu_buttons)) then -- .... il pulsante close
				selettore_buttons_visibile = true
				posx_selettore_buttons = posx_menu+posx_menu_button+distance_x_menu_button
				posy_selettore_buttons = posy_menu+posy_menu_button
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
-- RICEVO GLI OBIETTIVI DURANTE LA MISSIONE -- aggiornato rev 2
--------------------------------------


-- Funzione "intelligente" per impostare o aggiornare un obiettivo tramite la sua chiave univoca
function widget:SetOrUpdateObjectiveByKey(key, titolo, stato, iconaPath)
    if type(key) ~= "string" or key == "" then
        Spring.Log(widget:GetInfo().name, LOG.WARNING, "SetOrUpdateObjectiveByKey: Chiave non valida: " .. tostring(key))
        return false
    end

    local objectiveExists = (missionData.obiettiviByKey[key] ~= nil)

    if not objectiveExists then
        -- L'obiettivo non esiste, crealo e aggiungi la chiave all'ordine
        missionData.obiettiviByKey[key] = {}
        table.insert(missionData.orderedKeys, key) -- Mantiene l'ordine di aggiunta
		numeroObiettivi = #missionData.orderedKeys -- Aggiorno il numero degli obiettivi da mostrare
    end

    -- Aggiorna o imposta i dati dell'obiettivo
    local obj = missionData.obiettiviByKey[key]
    obj.titolo = titolo or obj.titolo or "Nuovo Obiettivo" -- Se titolo è nil, mantiene il vecchio o default
    obj.stato = stato or obj.stato or "Attivo"
    obj.icona = iconaPath or obj.icona or "LuaUI/Images/icons/default_obj.png"
    obj.key = key -- Memorizza la chiave anche dentro l'oggetto, se utile

    -- Qui dovresti gestire la logica per ricalcolare l'altezza del menu
    -- dato che un obiettivo potrebbe essere stato aggiunto o il suo testo cambiato.
    -- Esempio: widget.needsMenuResize = true

    if not objectiveExists then
        Spring.Log(widget:GetInfo().name, LOG.INFO, "Obiettivo CREATO con chiave: " .. key)
        return "created" -- Indica che è stato creato
    else
        Spring.Log(widget:GetInfo().name, LOG.INFO, "Obiettivo AGGIORNATO con chiave: " .. key)
        return "updated" -- Indica che è stato aggiornato
    end
end

-- Per disegnare, iteri su missionData.orderedKeys per mantenere l'ordine:
-- function widget:DrawScreen()
--   ...
--   myFont:Begin()
--   local yPos = ...
--   for i, key in ipairs(missionData.orderedKeys) do
--       local objData = missionData.obiettiviByKey[key]
--       if objData then
--           myFont:Print(objData.titolo, xPosTitolo, yPos, ...)
--           myFont:Print(objData.stato, xPosStato, yPos, ...)
--           -- Disegna icona
--           yPos = yPos - altezzaRigaObiettivo
--       end
--   end
--   myFont:End()
--   ...
-- end



--[[
-- rimosso dalla rev 2
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
]]-- 



--[[ nel mission runner:

-- All'inizio o quando serve
local objMenuWidget = widgetHandler:GetWidgetForCommand("WMRTS_objmenu")

-- function LaMiaLogicaDiMissione()
    if not objMenuWidget then
        Spring.Log(widget:GetInfo().name, LOG.ERROR, "Widget degli obiettivi non trovato!")
        return
    end

    -- Imposto/Creo l'obiettivo "obj1"
    widgetHandler:CallWidget(objMenuWidget, "SetOrUpdateObjectiveByKey", "obj1", "Distruggi Base", "Attivo", "icon_base.png")
    Spring.Echo("Mission Runner: Inviato comando per obj1")

    -- Imposto/Creo l'obiettivo "pippo"
    widgetHandler:CallWidget(objMenuWidget, "SetOrUpdateObjectiveByKey", "pippo", "Salva Unità X", "Nascosto", "icon_rescue.png")
    Spring.Echo("Mission Runner: Inviato comando per pippo")

    -- Più tardi, aggiorno "obj1" (il titolo nil non lo cambia, stato e icona sì)
    widgetHandler:CallWidget(objMenuWidget, "SetOrUpdateObjectiveByKey", "obj1", nil, "COMPLETATO", "icon_complete.png")
    Spring.Echo("Mission Runner: Inviato comando di aggiornamento per obj1")

    -- Se chiamo con una nuova chiave "obj3", verrà creato
    widgetHandler:CallWidget(objMenuWidget, "SetOrUpdateObjectiveByKey", "obj3", "Raggiungi Checkpoint", "Attivo", "icon_flag.png")
    Spring.Echo("Mission Runner: Inviato comando per obj3")
end



]]--


--------------------------------------
-- DISEGNO L' OBJ MENU
--------------------------------------
function widget:DrawScreen()
	if mostra_objsetting then

--[[ rimosso rev2
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
	titolo_menu_dim:Print("Objectives", posx_menu+70,posy_menu+106,14,'ds') 
	titolo_menu_dim:End()

-- pulsante close, second button
  	gl.Color(1,1,1,1)
	gl.Texture(buttons_close)	-- add the icon
	gl.TexRect(posx_menu+posx_menu_button+distance_x_menu_button,posy_menu+posy_menu_button, posx_menu+posx_menu_button+distance_x_menu_button+larghezza_menu_buttons,posy_menu+posy_menu_button+altezza_menu_buttons)
	gl.Texture(false)	-- fine texture			

-- testi dei PULSANTI
	myFont:Begin()	
	myFont:SetTextColor(1,1,1,1)	
	myFont:Print(("CLOSE"), posx_menu+posx_menu_button+distance_x_menu_button +45 , posy_menu+posy_menu_button +9, 9, "ocn") -- close button
	myFont:End()

-- testi delle missioni
	
-- scrivo nel menu i titoli degli obiettivi (distruggi x, difendi y ecc) impostabili dalla funzione function widget:GameFrame(frame)
	myFont:Begin()	
	myFont:Print(missionData["titoloobj1"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore ,12,'vs')
	myFont:End()
	myFont:Begin()		
	myFont:Print(missionData["titoloobj2"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 1,12,'vs')
	myFont:End()
	myFont:Begin()		
	myFont:Print(missionData["titoloobj3"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 2,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["titoloobj4"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 3,12,'vs')
	myFont:End()
	myFont:Begin()		
	myFont:Print(missionData["titoloobj5"] or "-", posx_menu+margine_sx, posy_menu + altezza_menu - margine_superiore - interasse_righe * 4,12,'vs')
	myFont:End()
--	myFont:SetTextColor(cWhite) ------------------------------------------------------------------------------------------------------------------ cancellare

-- ricevo lo stato degli obiettivi (in progess, complete, failed ecc) impostabili dalla funzione function widget:GameFrame(frame)
	myFont:Begin()	
	myFont:Print(missionData["Objective 1"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore ,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 2"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 1,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 3"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 2,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 4"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 3,12,'vs')
	myFont:End()	
	myFont:Begin()		
	myFont:Print(missionData["Objective 5"] or "-", posx_menu+margine_sx+100, posy_menu + altezza_menu - margine_superiore - interasse_righe * 4,12,'vs')
	myFont:End()	
			
	--reset state
--	gl.Texture(false)
--	gl.Color(1,1,1,1)

-- riquadri di selezione dei menubuttons (close o back)
  	if selettore_buttons_visibile then
		gl.Color(1,1,1,1)
		gl.Texture(selettore_button)	-- add the selector
		gl.TexRect(posx_selettore_buttons,posy_selettore_buttons, posx_selettore_buttons+larghezza_menu_buttons,posy_selettore_buttons+altezza_menu_buttons)	
		gl.Texture(false)	-- fine texture			
	end

	-- gui shader	
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect( posx_menu,posy_menu, posx_menu+larghezza_menu, posy_menu+altezza_menu,'WMRTS_obj_option')
	end

  return
  end -- mostra_objsetting = true
end


--[[  todo
function widget:DrawScreen()
    if not mostra_objsetting then return end -- Se il menu non è visibile, non fare nulla

    -- 1. Disegna il background principale del menu e il titolo (come fai già)
    -- gl.Texture(main_background)
    -- gl.TexRect(posx_menu, posy_menu, posx_menu + larghezza_menu, posy_menu + altezza_menu_calcolata)
    -- gl.Texture(false)
    -- ... titolo del menu "Objectives" ...

    -- 2. Imposta la posizione Y di partenza per la prima riga di obiettivo
    --    Questa Y è la parte SUPERIORE della prima riga di obiettivo.
    --    Spring disegna da basso a sinistra, quindi per posizionare dall'alto del menu:
    --    posy_menu è il fondo del tuo menu principale.
    --    altezza_menu_calcolata è l'altezza totale del tuo menu.
    --    margine_superiore_della_lista è lo spazio tra la cima del menu e la prima riga di obiettivi.
    local margine_superiore_della_lista = 45 -- Esempio, come avevi prima
    local current_row_y_top = posy_menu + altezza_menu_calcolata - margine_superiore_della_lista

    -- 3. Inizia il loop per disegnare ogni obiettivo
    myFont:Begin() -- Inizia il blocco di disegno del testo una sola volta se possibile

    for i, key in ipairs(missionData.orderedKeys) do
        local objData = missionData.obiettiviByKey[key]

        if objData then -- Sicurezza: controlla che i dati per la chiave esistano

            -- Calcola la Y del fondo della riga corrente (per gl.TexRect)
            -- Ricorda: Spring UI (0,0) è in basso a sinistra.
            -- current_row_y_top è la coordinata Y del bordo superiore del background della riga.
            -- Il fondo del background della riga sarà current_row_y_top - altezza_riga_obiettivo_background
            local row_background_y_bottom = current_row_y_top - altezza_riga_obiettivo_background

            -- A. DISEGNA IL BACKGROUND DELLA RIGA (alto 10px)
            gl.Color(1, 1, 1, 1) -- Colore bianco per la texture, se non ha trasparenza propria
            gl.Texture(img_background_riga_obiettivo)
            gl.TexRect(
                posx_menu + margine_sx_riga_dal_menu, -- X inizio (es. posx_menu + 5)
                row_background_y_bottom,             -- Y fondo
                posx_menu + margine_sx_riga_dal_menu + larghezza_riga_obiettivo, -- X fine
                current_row_y_top                    -- Y cima
            )
            gl.Texture(false)

            -- B. DISEGNA IL TESTO (Titolo, Stato) E L'ICONA SOPRA IL BACKGROUND DELLA RIGA
            -- La Y per il testo. myFont:Print usa la Y della baseline del testo.
            -- Se current_row_y_top è la cima del background di 10px, e il testo è alto 12px,
            -- dovrai posizionare la baseline del testo leggermente sotto current_row_y_top.
            -- Una buona approssimazione è current_row_y_top - (altezza_testo_obiettivo / fattore_circa_2)
            -- o più semplicemente, current_row_y_top - un piccolo offset.
            -- O, se il tuo background_riga è solo decorativo e il testo può "fluttuare" sopra/sotto:
            -- la Y per myFont:Print è la baseline. Se la riga è alta 10px, il testo alto 12px sporgerà.
            -- Dovrai decidere l'allineamento verticale.
            -- Supponiamo che la Y per il testo sia riferita alla cima della riga e scenda.
            local text_y_baseline = current_row_y_top - (altezza_riga_obiettivo_background / 2) - (altezza_testo_obiettivo / 2) + 2 -- Prova ad aggiustare questo offset
                                   -- Oppure, più semplicemente, se il testo deve stare DENTRO i 10px:
                                   -- text_y_baseline = row_background_y_bottom + offset_dal_basso_per_testo
                                   -- O se la tua `interasse_righe` è ciò che conta per la Y del testo:
                                   -- text_y_baseline = current_row_y_top - (spaziatura_verticale_tra_righe - altezza_testo_obiettivo) / 2 - un_po_di_offset

            -- Più semplice per iniziare: usiamo la Y della cima della riga e l'opzione 'vs' di Print (vertical shadow/top)
            local text_y_for_print = current_row_y_top - 2 -- Piccolo offset dall'alto della riga background

            -- Titolo
            myFont:SetTextColor(1, 1, 1, 1) -- Imposta colore testo (bianco)
            myFont:Print(
                objData.titolo or "-",
                posx_menu + margine_sx_riga_dal_menu + margine_sx_testo_in_riga, -- X del titolo
                text_y_for_print,
                altezza_testo_obiettivo,
                "vs" -- allinea in alto ('v') con ombra ('s')
            )

            -- Stato (più a destra del titolo)
            local x_stato = posx_menu + margine_sx_riga_dal_menu + margine_sx_testo_in_riga + 150 -- Esempio X per lo stato
            -- Potresti voler cambiare colore per lo stato (es. verde per "Completato", rosso per "Fallito")
            if objData.stato == "COMPLETATO!" then
                myFont:SetTextColor(0.5, 1, 0.5, 1) -- Verde chiaro
            elseif objData.stato == "FALLITO" then
                myFont:SetTextColor(1, 0.5, 0.5, 1) -- Rosso chiaro
            else
                myFont:SetTextColor(0.8, 0.8, 0.8, 1) -- Grigio chiaro per "Attivo" o altro
            end
            myFont:Print(
                objData.stato or "-",
                x_stato,
                text_y_for_print,
                altezza_testo_obiettivo,
                "vs"
            )

            -- Icona (se presente)
            if objData.icona and objData.icona ~= "" then
                gl.Color(1,1,1,1)
                gl.Texture(objData.icona)
                local icon_size = altezza_riga_obiettivo_background -- Facciamo l'icona alta come la riga
                local x_icona = posx_menu + margine_sx_riga_dal_menu + larghezza_riga_obiettivo - icon_size - 5 -- Allineata a destra nella riga
                gl.TexRect(
                    x_icona,
                    row_background_y_bottom,
                    x_icona + icon_size,
                    current_row_y_top
                )
                gl.Texture(false)
            end

            -- C. AGGIORNA LA POSIZIONE Y PER LA PROSSIMA RIGA
            -- Sposta la Y verso il basso per la prossima iterazione
            current_row_y_top = current_row_y_top - spaziatura_verticale_tra_righe
                                 -- spaziatura_verticale_tra_righe deve essere abbastanza grande
                                 -- da contenere l'altezza_riga_obiettivo_background e dare un po' di spazio.

            -- D. (Opzionale) Interrompi se hai disegnato troppe righe e non hai scrolling
            if i >= max_obiettivi_visualizzabili then -- es. max_obiettivi_visualizzabili = 5
                -- Potresti disegnare un "..." o un indicatore che ci sono altri obiettivi
                break
            end
        end
    end
    myFont:End() -- Fine blocco testo

    -- 4. Disegna il pulsante CLOSE e altri elementi del menu (come fai già)
    -- gl.Texture(buttons_close) ...

    gl.Color(1,1,1,1) -- Ripristina colore di default per sicurezza
end

]]--