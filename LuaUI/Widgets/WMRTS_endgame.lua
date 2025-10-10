--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    WMRTS_endgame.lua
--  brief:   War Machines RTS endgame info management
--  author:  Dario Molinaroli ( Molixx81 )
--
--  Copyright (C) 2025.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "WMRTS_endgame",
    desc      = "WMRTS endgame management",
    author    = "molixx81",
    date      = "10 Ottobre, 2025",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true 
  }
end

--------------------------------------------------------------------------------
--[[
to do list 
-- creare una lista di winningplayer in txt cosi da creare un sistema più robusto per il client (lettura stile ini)
-- creare un interfaccia finale per la vincita o la perdita
]]--
--------------------------------------------------------------------------------
-- rev 0 by molix -- 10/10/2025 -- designing WMRTS endgame management

-- Lista delle variabili
local nomeFile = "WMRST_winninglist.wmr"  		-- definisco il file che voglio scrivere

-- funzione scrittura lista player vincenti
function listavincenti(winnerString) -- ogni volta che si richiama questa funzione
--	local listaplayerwin = winnerString -- importa la stringa "winnerString" che ricevo dal gadget e salvala nella variabile listaplayerwin (guarda se puoi usare direttamente winnerstring) ###############
	local file = io.open(nomeFile, "w")	-- "w" significa "write mode" (modalità di scrittura). -- Usiamo io.open() per aprire il file.-- Se il file non esiste, lo crea. Se esiste già, CANCELLA tutto il suo contenuto.
		if file then -- se il file è aperto correttamente
			file:write("[winninglist_skirmish]\n") 								-- scrivo l'intestazione del file
			for nomegiocatore in string.gmatch(winnerString, "([^,]+)") do    	-- Rimuove eventuali spazi bianchi prima o dopo il nome del giocatore. Ricordo che già da registrazione php non accetta spazi bianchi/vuoti. nel ciclo for...do la variabile (in questo caso nomegiocatore) viene dichiarata in automatico
				local trimmedName = nomegiocatore:match("^%s*(.-)%s*$") 		-- definisco la variabile del giocatore priva di spazi bianchi
				file:write(trimmedName .. " = won\n") -- scrivi su file il nome del giocatore seguito da " = won". Il simbolo "\n" è FONDAMENTALE: -- significa "newline" (vai a capo). Senza di esso, tutto verrebbe scritto sulla stessa linea.
			end -- fine ciclo for...end
			file:close()		--         -- 3. CHIUDI IL FILE -- Questo salva le modifiche e "libera" il file. Se non lo fai, il file potrebbe rimanere vuoto!		
--		    file:write("ciao\n")     -- Scriviamo la prima riga. 
--			file:write("sono dario")     -- Scriviamo la seconda riga.
--			file:close()		--         -- 3. CHIUDI IL FILE -- Questo salva le modifiche e "libera" il file. Se non lo fai, il file potrebbe rimanere vuoto!
--		    print("File scritto con successo!")
		else 
				Spring.Echo("Errore: impossibile aprire il file " .. nomeFile)  -- Se c'è stato un problema ad aprire il file (es. permessi mancanti)
			end -- end ciclo for do
end

-- inizializzo il widget
function widget:Initialize() -- ogni volta che si verifica l'evento VictoryListEvent nel gadget show_winner.lua (o in altri gadget), esegui la funzione listavincenti in questo widget. è importante che ogni volta che si richiama questo script, la variabile winnerString assuma il valore del parlato che si vuole avere (vedi sopra)
	widgetHandler:RegisterGlobal('VictoryListEvent',listavincenti) -- test aggiunto di recente
end