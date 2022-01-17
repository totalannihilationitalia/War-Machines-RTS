function widget:GetInfo()
   return {
      name         = "Warning messages",
      desc         = "WMRTS warning messages",
      author       = "Molix",
      date         = "01/01/2022",
      license      = "freeeee", -- should be compatible with Spring
      layer        = 0,
      enabled      = true
   }
end

local toggle
local vala = 0 -- all'inizio attribuisco = 0 la variabile (nessun parlato)

-- questo widget aspetta la variabile vala che si sincronizza con  i gadget (mo_comgate) per avviare il parlato durante il gioco

function Parlatoingame(vala) -- ogni volta che si richiama questa funzione
	if (vala == 1) then     -- se uguale 1 il comandante inizia il gate  in skirmish mode
		WG.AddConvo('>>> Initializing Commander Gate <<<', nil, "LuaUI/Images/parlato_gate.png", nil, 50)

		end
	if (vala == 2) then	-- se uguale 2 il comandante ha completato il gate in skirmish mode
		WG.AddConvo('>>> Commander Gate Successful <<<', nil, "LuaUI/Images/parlato_gate.png", nil, 50)
		Spring.Echo("testwidget2")

		end	
	if (vala == 3) then	-- se uguale 3 faccio apparire la terza frase in skirmish mode
		WG.AddConvo('Ok commander, start to collect resources on the map, build your empire and destroy all the enemy units!', nil, "LuaUI/Images/Radar.jpg", nil, 190)
	--	WG.AddConvo('Good luck!', nil, "LuaUI/Images/Radar.jpg", nil, 150)
		 Spring.Echo("testwidget")

		end	
	if (vala == 4) then	-- se uguale 4 faccio apparire la quarta frase in skirmish mode
		WG.AddConvo('Warning: A team has been destroyed', nil, "LuaUI/Images/parlato_defeat.png", nil, 105)
		  Spring.Echo("testdestroy")

		end
	if (vala == 5) then	-- se uguale 5 faccio apparire la quarta frase in skirmish mode
	WG.AddConvo('Warning: Sensors reactivated', nil, "LuaUI/Images/parlato_radar_on.png", nil, 52)
	--Spring.Echo("sens reactived")
		end
	if (vala == 6) then	-- se uguale 6 faccio apparire la quarta frase in skirmish mode
	WG.AddConvo('Warning: Sensors deactivated due insufficient power', nil, "LuaUI/Images/parlato_radar_off.png", nil, 52)
	--Spring.Echo("sens disattivi")
		end
end


-- commander gate
function widget:Initialize() -- ogni volta che si verifica l'evento ParlatoGateEvent nel gadget mo_comgate.lua (le variabili sono nate inizialmente per questo evento e poi sono state mantenute anche in altri gadget), esegui la funzione Parlatoingame in questo widget. è importante che ogni volta che si richiama questo script, la variabile vala assuma il valore del parlato che si vuole avere (vedi sopra)
widgetHandler:RegisterGlobal('ParlatoGateEvent',Parlatoingame)
end






