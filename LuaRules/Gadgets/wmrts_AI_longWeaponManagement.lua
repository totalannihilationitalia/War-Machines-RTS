function gadget:GetInfo()
	return {
		name      = "WMRTS Long Range Weapon Management",
		desc      = "Gestore Artiglierie e Silos Nucleari V17 - War Machines RTS",
		author    = "molix & AI",
		date      = "2026",
		license   = "GPL",
		layer     = 110,
		enabled   = true
	}
end
-- 23/02/2026 V17	- introdotta la tabella esterna "WMRTS_AI_mission_db.lua" Questo gadget utilizza le unità di type = "strategicshield" e la relativa opzione "shieldRange" 
-- 23/02/2026		- l'artiglieria "LRA" non colpisce bersagli vicini alle unità di tipo "strategicshield" entro un certo raggio "shieldRange"

if (not gadgetHandler:IsSyncedCode()) then return end

--------------------------------------------------------------------------------
-- CONFIGURAZIONE
--------------------------------------------------------------------------------

local dbPath = "LuaRules/Configs/WMRTS_AI_mission_db.lua"
local UNIT_DB = VFS.Include(dbPath)

local TARGET_AI_NAME = "WarMachinesRTSmissionAI" -- Filtro per attivare l'IA
local aiTeamIDs = {}
local lastNukeFrame = {} 
local artilleryTargets = {} -- Memorizza: [unitID_Cannone] = targetID_Nemico -- Quando l'IA trova un bersaglio (es. ID 500) alle coordinate (100, 0, 200), l'ID 500 viene salvato. Nel ciclo successivo, il gadget controlla se l'ID 500 è ancora vivo. Se l'unità muore, invia un CMD.STOP al cannone. Questo svuota la coda comandi e permette al blocco if #updatedCmdQueue == 0 di attivarsi e cercare un nuovo bersaglio al ciclo successivo.

--------------------------------------------------------------------------------
-- FUNZIONI DI SUPPORTO
--------------------------------------------------------------------------------
-- Funzione per trovare tutti gli scudi nemici sulla mappa
local function GetEnemyShields(myTeamID)
    local shields = {}
    local allUnits = Spring.GetAllUnits()
    for i = 1, #allUnits do
        local uID = allUnits[i]
        local uTeam = Spring.GetUnitTeam(uID)
        if not Spring.AreTeamsAllied(myTeamID, uTeam) then
            local uDefID = Spring.GetUnitDefID(uID)
            local uName = UnitDefs[uDefID].name
            local dbEntry = UNIT_DB[uName]
            if dbEntry and dbEntry.type == "strategicshield" then
                local sx, sy, sz = Spring.GetUnitPosition(uID)
                table.insert(shields, {x = sx, z = sz, range = dbEntry.shieldRange or 300})
            end
        end
    end
    return shields
end

-- funzione per localizzare il target
local function GetTargetInRange(myTeamID, cx, cz, maxRange, minPriority, enemyShields) -- Nella funzione GetTargetInRange ho aggiunto il parametro enemyShields. Prima di confermare che un'unità è il "miglior bersaglio", il codice calcola la distanza tra quell'unità e tutti gli scudi nemici identificati. Se la distanza è inferiore a shieldRange, l'unità viene scartata.
	local allUnits = Spring.GetAllUnits()
	local gaiaTeamID = Spring.GetGaiaTeamID()
	
	local bestTarget = nil
	local highestPriorityFound = -1

	for i = 1, #allUnits do
		local uID = allUnits[i]
		local uTeam = Spring.GetUnitTeam(uID)
		
		if uTeam ~= gaiaTeamID and not Spring.AreTeamsAllied(myTeamID, uTeam) then
			local uDefID = Spring.GetUnitDefID(uID)
			local uName = UnitDefs[uDefID].name
			local dbEntry = UNIT_DB[uName]
			
			if dbEntry and not dbEntry.ignore then
				local priority = 0
				local enemyCat = dbEntry.type or "unknown"
				if enemyCat == "strategicbuilding" then priority = 10				
				elseif enemyCat == "strategicdefence" then priority = 9
				elseif enemyCat == "building" then priority = 7
				elseif enemyCat == "defence" then priority = 5
				elseif enemyCat == "ground" then priority = 1 
				end

				if priority >= minPriority then
					local tx, ty, tz = Spring.GetUnitPosition(uID)
					if tx then
						local dx = cx - tx
						local dz = cz - tz
						local dist = math.sqrt(dx*dx + dz*dz)
						
						if dist <= maxRange then
                            -- CONTROLLO SCUDI: Verifica se il target è protetto
                            local protectedByShield = false
                            for _, shield in ipairs(enemyShields) do
                                local sdx = tx - shield.x
                                local sdz = tz - shield.z
                                local distToShield = math.sqrt(sdx*sdx + sdz*sdz)
                                if distToShield <= shield.range then
                                    protectedByShield = true
                                    break
                                end
                            end

                            if not protectedByShield and priority > highestPriorityFound then
								highestPriorityFound = priority
								-- Restituiamo una tabella con tutti i dati necessari
								bestTarget = {x=tx, y=ty, z=tz, id=uID, prio=priority}
							end
						end
					end
				end
			end
		end
	end
	return bestTarget
end

--------------------------------------------------------------------------------
-- CORE LOGIC
--------------------------------------------------------------------------------

function gadget:GameFrame(n)
    if n < 300 then return end 
    if n % 150 ~= 0 then return end -- Esecuzione ogni 5 secondi
    -- 1. IDENTIFICAZIONE TEAM (Solo quelli controllati dalla tua IA)
    local teamList = Spring.GetTeamList()
    for _, teamID in ipairs(teamList) do
        local aiName = Spring.GetTeamLuaAI(teamID)
        if aiName and string.find(string.lower(aiName), string.lower(TARGET_AI_NAME)) then
            aiTeamIDs[teamID] = true
        end
    end

    for teamID, _ in pairs(aiTeamIDs) do
        -- Prepariamo la lista scudi nemici per questo team
        local currentEnemyShields = GetEnemyShields(teamID)
        local teamUnits = Spring.GetTeamUnits(teamID)
        
        for _, uID in ipairs(teamUnits) do
            local uDefID = Spring.GetUnitDefID(uID)
            local uName = UnitDefs[uDefID].name
            local dbEntry = UNIT_DB[uName]
            
            if dbEntry then
				-- Controllo se l'unità è completata
                local _, _, _, _, buildProgress = Spring.GetUnitHealth(uID)
                if buildProgress and buildProgress >= 1.0 then
                    local ux, uy, uz = Spring.GetUnitPosition(uID)

                    --------------------------------------------------------------------
                    -- 1) ARTIGLIERIA (isLRA)
                    --------------------------------------------------------------------
                    if dbEntry.isLRA then
                        local cmdQueue = Spring.GetCommandQueue(uID, 1)
                        local currentTargetID = artilleryTargets[uID]

                        -- Se il cannone sta sparando, controlliamo se il bersaglio esiste ancora
                        if #cmdQueue > 0 and currentTargetID then
                            if not Spring.ValidUnitID(currentTargetID) or Spring.GetUnitIsDead(currentTargetID) then
                                -- Il bersaglio è morto o sparito: STOP
                                Spring.GiveOrderToUnit(uID, CMD.STOP, {}, {})
                                artilleryTargets[uID] = nil
                            end
                        end

                        -- Se il cannone è libero, cerca un nuovo bersaglio
                        local updatedCmdQueue = Spring.GetCommandQueue(uID, 1)
                        if #updatedCmdQueue == 0 then
                            local weaponRange = dbEntry.range or 6000  -- Usiamo il range dal DB (obbligatorio per evitare errori)
                            local target = GetTargetInRange(teamID, ux, uz, weaponRange, 1, currentEnemyShields) -- priorità dei target da 1 in su ( che vuol dire in ordine da 10 a 1, definiti nella funzione GetTargetInRange)
                            
                            if target then
                                Spring.GiveOrderToUnit(uID, CMD.ATTACK, {target.x, target.y, target.z}, {}) 	-- Ordine alle coordinate, in questo modo l'AI colpisce anche senza radar ########## verificare se creare una tabella con le unità spottate (almeno una volta) e colpire solo quelle, anche fuori dai radar per rendere l'AI più "umana"
                                artilleryTargets[uID] = target.id -- Memorizziamo chi stiamo colpendo
                            end
                        end
                    end           

					--------------------------------------------------------------------
					-- 2) GESTIONE ANTI-NUKE (isAMD) - Invariato
					--------------------------------------------------------------------
					if dbEntry.isAMD then
						local numStockpiled, numScheduled = Spring.GetUnitStockpile(uID)
						if numStockpiled then
							if (numStockpiled + numScheduled) < 3 then
								Spring.GiveOrderToUnit(uID, CMD.STOCKPILE, {}, {}) 
							end
						end
					end		-- fine isAMD

					--------------------------------------------------------------------
					-- 3) GESTIONE SILOS NUCLEARI (isSILO) - Invariato
					--------------------------------------------------------------------
					if dbEntry.isSILO then
						local numStockpiled, numScheduled = Spring.GetUnitStockpile(uID)
						if numStockpiled then
							-- A) Produzione
							if (numStockpiled + numScheduled) < 2 then
								Spring.GiveOrderToUnit(uID, CMD.STOCKPILE, {}, {})
							end
							-- B) Lancio
							if numStockpiled > 0 then
								local lastLaunch = lastNukeFrame[uID] or 0
								if (n - lastLaunch) > 1200 then 
									local nukeRange = dbEntry.range or 50000
                                    -- ######## Per le atomiche ignoriamo il filtro scudi (opzionale, ma solitamente le atomiche devono colpire gli scudi per abbatterli)
									local target = GetTargetInRange(teamID, ux, uz, nukeRange, 8, {}) -- priorità dei target da 8 in su ( che vuol dire in ordine da 10 a 8, definiti nella funzione GetTargetInRange)
									if target then
										Spring.GiveOrderToUnit(uID, CMD.ATTACK, {target.x, target.y, target.z}, {}) -- Ordine alle coordinate, in questo modo l'AI colpisce anche senza radar ########## verificare se creare una tabella con le unità spottate (almeno una volta) e colpire solo quelle, anche fuori dai radar per rendere l'AI più "umana"
										lastNukeFrame[uID] = n
									end
								end
							end
						end
					end		-- fine isSILO
				end 	-- fine del buildprogress >= 1.0
			end	-- fine if dbEntry
		end	-- fine loop teamUnits
	end	-- fine loop aiTeamIDs
end	-- fine funzione GameFrame

-- Pulizia memoria quando un cannone viene distrutto
function gadget:UnitDestroyed(uID, unitDefID, teamID)
    artilleryTargets[uID] = nil
    lastNukeFrame[uID] = nil
end