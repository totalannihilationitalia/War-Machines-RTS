function gadget:GetInfo()
  return {
    name      = "EUF Support Overdrive (Balanced)",
    desc      = "Consumo totale energia e spegnimento automatico",
    author    = "AI & Molix",
    layer     = 0,
    enabled   = true
  }
end

if (not gadgetHandler:IsSyncedCode()) then return end

local OVERDRIVER_UNIT = "eufresonator" 
local RADIUS          = 600    
local METAL_MULT      = 3.0    
local COST_PER_MEX    = 250    
local TABELLA_MEX     = { ["cormex"] = true }

local overdrivers = {} 

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

    -- Reset grafico globale per i Mex
    for _, mID in ipairs(Spring.GetAllUnits()) do
        local ud = UnitDefs[Spring.GetUnitDefID(mID)]
        if ud and TABELLA_MEX[ud.name] then
            Spring.SetUnitRulesParam(mID, "overdrive", 1.0)
        end
    end

    for oID, ownerTeam in pairs(overdrivers) do
        local states = Spring.GetUnitStates(oID)
        local isActive = states and (states.active == true or states.active == 1)
        
        if isActive then
            local ux, uy, uz = Spring.GetUnitPosition(oID)
            local nearbyUnits = Spring.GetUnitsInCylinder(ux, uz, RADIUS)
            local validMexes = {}

            -- 1. Identifichiamo i Mex pronti per il boost
            for i=1, #nearbyUnits do
                local mID = nearbyUnits[i]
                local mDef = UnitDefs[Spring.GetUnitDefID(mID)]
                if mDef and TABELLA_MEX[mDef.name] and Spring.AreTeamsAllied(ownerTeam, Spring.GetUnitTeam(mID)) then
                    local metalMake = Spring.GetUnitResources(mID)
                    local _, isBuilding = Spring.GetUnitIsBuilding(mID)
                    if not isBuilding and metalMake and metalMake > 0 then
                        table.insert(validMexes, {id = mID, income = metalMake})
                    end
                end
            end

            -- 2. Calcoliamo il costo TOTALE
            local totalCost = #validMexes * COST_PER_MEX
            local _, energyStored = Spring.GetTeamResources(ownerTeam, "energy")

            if #validMexes > 0 then
                if energyStored >= totalCost then
                    -- ABBIAMO ENERGIA PER TUTTI: Applichiamo boost e consumiamo
                    Spring.UseTeamResource(ownerTeam, "energy", totalCost)
                    for _, mex in ipairs(validMexes) do
                        Spring.SetUnitRulesParam(mex.id, "overdrive", 3.0)
                        Spring.AddTeamResource(ownerTeam, "metal", mex.income * (METAL_MULT - 1))
                    end
                else
                    -- NON ABBIAMO ENERGIA: Spegnimento forzato del Resonator
                    Spring.GiveOrderToUnit(oID, CMD.ONOFF, {0}, {})
                    Spring.SendMessageToTeam(ownerTeam, "\255\255\050\050[EUF] Resonator Tower Emergency Shutdown: Low Energy!")
                end
            end
        else
            -- RESONATOR SPENTO: Mostra solo l'anello giallo (2.0)
            local ux, uy, uz = Spring.GetUnitPosition(oID)
            local nearbyUnits = Spring.GetUnitsInCylinder(ux, uz, RADIUS)
            for i=1, #nearbyUnits do
                local mID = nearbyUnits[i]
                local mDef = UnitDefs[Spring.GetUnitDefID(mID)]
                if mDef and TABELLA_MEX[mDef.name] then
                    Spring.SetUnitRulesParam(mID, "overdrive", 2.0)
                end
            end
        end
    end
end