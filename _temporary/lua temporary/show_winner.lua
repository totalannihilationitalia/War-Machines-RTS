-- file: show_winners.lua

function gadget:GetInfo()
    return {
        name      = "Show Winners",
        desc      = "Mostra i nomi dei giocatori vincenti a fine partita.",
        author    = "molix",
        date      = "10/10/2025",
        license   = "GNU GPL, v2 or later",
        layer     = 0, -- Un layer basso per essere eseguito prima di altri gadget di gameover
        enabled   = true
    }
end
----
-- SYNC
---- 

if (gadgetHandler:IsSyncedCode()) then

    -- Funzione per estrarre i nomi come definita sopra
    local function GetWinningPlayerNames()
        if (not GG) or (not GG.gamewinners) then return nil end
        if #GG.gamewinners == 0 then return {"Pareggio"} end

        local winningPlayerNames = {}
        for _, allyTeamID in ipairs(GG.gamewinners) do
            for _, teamID in ipairs(Spring.GetTeamList(allyTeamID)) do
                for _, playerID in ipairs(Spring.GetPlayerList(teamID, true)) do
                    local playerName = select(1, Spring.GetPlayerInfo(playerID))
                    if playerName then table.insert(winningPlayerNames, playerName) end
                end
            end
        end
        return winningPlayerNames
    end

    -- Questo call-in viene eseguito quando la partita finisce
    function gadget:GameOver(winningAllyTeams)
        local winners = GetWinningPlayerNames()
        
        if winners then
            if winners[1] == "Pareggio" then
                Spring.Echo(">> PARTITA TERMINATA: Pareggio!")
            else
			
--[[
---------------
-- aggiungo righe seguenti per mandare la variabile al lato unsync
---------------
    vala=3 -- invio la variabile a convo_message_list.lua per far apparire la scritta "....destroy all the enemies"
    SendToUnsynced("ParlatoGateEvent", vala)
	gadgetHandler:RemoveGadget()


]]--			
			
			
			
			
				-- invio ad UnSync
			--	local valo = 1
				
                -- Concatena i nomi per una bella visualizzazione
                local winnerString = table.concat(winners, ", ")
				SendToUnsynced("VictoryListEvent", winnerString) -- invio a UnSync la variabile winners
					Spring.Echo("test49")
                Spring.Echo(">> VINCITORI: " .. winnerString)
                
                -- Qui potresti anche inviare i dati a un'interfaccia UI (nella parte Unsynced)
                -- per mostrare una schermata di vittoria personalizzata.
            end
        end
        
        -- È importante restituire false per non bloccare il call-in GameOver per altri gadget
        return false 
    end

else
----
-- UNSYNC
---- 

-- funzione HandleVictoryListEvent
local function HandleVictoryListEvent(cmd, winnerString)
	if Script.LuaUI('VictoryListEvent') then
	Spring.Echo("test68")
		Script.LuaUI.VictoryListEvent(winnerString)
	end
end

-- all'inizio associo l'evento VictoryListEvent alla funzione HandleVictoryListEvent
function gadget:Initialize()
	Spring.Echo("test75")
 gadgetHandler:AddSyncAction("VictoryListEvent", HandleVictoryListEvent)
end



--[[  ### esempio
function gadget:Initialize()
  gadgetHandler:AddSyncAction("ParlatoGateEvent",WrapToLuaUI)
  gadgetHandler:AddSyncAction("gatesound", GateSound)
end

------ aggiungo la funzione per il parlato
function WrapToLuaUI(_,vala)
    if Script.LuaUI('ParlatoGateEvent') then
       Script.LuaUI.ParlatoGateEvent(vala)
    end
end
]]--

end