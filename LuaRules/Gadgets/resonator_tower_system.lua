function gadget:GetInfo()
  return {
    name      = "Resonator tower system",
    desc      = "More extraxtion point to extractors inside the Resonator radius",
    author    = "Molix",
    date      = "2024",
    license   = "GNU GPL",
    layer     = 0,
    enabled   = true
  }
end

if (not gadgetHandler:IsSyncedCode()) then return end

local OVERDRIVER_UNIT = "euf_overdriver" 
local RADIUS          = 600    
local METAL_MULT      = 3.0    
local COST_PER_MEX    = 250    

local overdrivers = {} 

local function IsMex(unitID)
    local ud = UnitDefs[Spring.GetUnitDefID(unitID)]
    return ud and ud.extractsMetal > 0
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if UnitDefs[unitDefID].name == OVERDRIVER_UNIT then
        overdrivers[unitID] = unitTeam
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    overdrivers[unitID] = nil
end

function gadget:GameFrame(n)
    if (n % 30 ~= 0) then return end 

    -- Reset visivo (tutti i mex a 1.0)
    local allUnits = Spring.GetAllUnits()
    for i=1, #allUnits do
        local uID = allUnits[i]
        if IsMex(uID) then
            Spring.SetUnitRulesParam(uID, "overdrive", 1.0)
        end
    end

    -- Ciclo Overdriver
    for oID, ownerTeam in pairs(overdrivers) do
        local states = Spring.GetUnitStates(oID)
        
        -- controllare tutti gli estrattori in stato di ON
        if states and states.active then
            local ux, uy, uz = Spring.GetUnitPosition(oID)
            local nearbyUnits = Spring.GetUnitsInCylinder(ux, uz, RADIUS)
            
            local activeMexesInRange = {}
            
            for i=1, #nearbyUnits do
                local mID = nearbyUnits[i]
                local mTeam = Spring.GetUnitTeam(mID)
                
                -- controlla se è un estrattore è un estrattore, se è alleato e se è finito di costruire. l'overdrive si applica a questi
                if IsMex(mID) and Spring.AreTeamsAllied(ownerTeam, mTeam) then
                    local _, isBuilding = Spring.GetUnitIsBuilding(mID)
                    local _, metalMake = Spring.GetUnitResources(mID)
                    
                    -- AGGIUNTO: Il Mex deve essere completato e produrre metallo (> 0)
                    if not isBuilding and metalMake and metalMake > 0 then
                        table.insert(activeMexesInRange, {id = mID, income = metalMake, team = mTeam})
                    end
                end
            end

            -- Calcolo costi solo sui Mex che stanno effettivamente lavorando
            local totalEnergyCost = #activeMexesInRange * COST_PER_MEX
            local _, energyStored = Spring.GetTeamResources(ownerTeam, "energy")

            if #activeMexesInRange > 0 then
                if energyStored >= totalEnergyCost then
                    -- Pagamento
                    Spring.UseTeamResource(ownerTeam, "energy", totalEnergyCost)
                    
                    -- Bonus
                    for _, mexData in ipairs(activeMexesInRange) do
                        -- Grafica LUPS
                        Spring.SetUnitRulesParam(mexData.id, "overdrive", METAL_MULT)
                        
                        -- Bonus Metallo (3x totale = produzione base + bonus di 2x)
                        local bonus = mexData.income * (METAL_MULT - 1)
                        Spring.AddTeamResource(mexData.team, "metal", bonus)
                    end
                else
                    -- Spegnimento se l'energia non basta per tutti i mex attivi
                    Spring.GiveOrderToUnit(oID, CMD.ONOFF, {0}, {})
                    Spring.SendMessageToTeam(ownerTeam, "Overdriver EUF: Energia insufficiente!") --- DEBUG: ########### farlo diventare un message warning!!!!!!!!!!!!!!!!!!!! ############# molix
                end
            end
        end
    end
end