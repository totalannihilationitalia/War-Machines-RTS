function gadget:GetInfo()
  return {
    name      = "EUF Support resonator",
    desc      = "Area Metal Booster",
    author    = "Molix with AI",
    layer     = 0,
    enabled   = true
  }
end
--[[ 
15/04/2026 realizzato questo widget. Molix
Questo widget imposta un UnitRules agli estrattori di metallo seguendo questa logica:
1.0 (Stato Base): L'estrattore NON è nel raggio di alcun Resonator 																		-->		Effetto: Nessuna grafica (Aurea spenta).
2.0 (Stato "Standby" - GIALLO): L'estrattore È nel raggio, ma il Resonator è SPENTO oppure NON ha abbastanza energia per potenziarlo. 	-->		Effetto: Appare l'anello Giallo (indica che il collegamento c'è, ma non sta producendo extra).
3.0 (Stato "Boost" - VERDE): L'estrattore È nel raggio E il Resonator è ATTIVO E ha energia sufficiente.								-->		Effetto: L'anello diventa Verde + appaiono le sfere + appare l'effetto calore/vapore.
Questo gadget imposta solo gli unitrules, per gli effetti vedere il widget 
]]--


if (not gadgetHandler:IsSyncedCode()) then return end

local RESONATOR_UNIT = "eufresonator" 
local RADIUS          = 600    
local METAL_MULT      = 3.0    
local COST_PER_MEX    = 250    
local TABELLA_MEX     = { 	
	["cormex"] = true,
	["corexp"] = true,
	["cormoho"] = true,		
	["cormexp"] = true,	
	["icumetex"] = true,
	["armamex"] = true,							
	["armmoho"] = true,
	["advmoho"] = true,			
	["eufmetex"] = true,
	["eufametex"] = true,	
	["eufadvmetex"] = true,	
	["andmexun"] = true,	
	["andmex"] = true,	
	["andametex"] = true	
						}

local resonators = {} 

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
    if UnitDefs[unitDefID].name == RESONATOR_UNIT then
        resonators[unitID] = unitTeam
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
    resonators[unitID] = nil
end

function gadget:GameFrame(n)
    if (n % 30 ~= 0) then return end 

    -- Reset grafico globale per i Mex
    for _, mID in ipairs(Spring.GetAllUnits()) do
        local ud = UnitDefs[Spring.GetUnitDefID(mID)]
        if ud and TABELLA_MEX[ud.name] then
            Spring.SetUnitRulesParam(mID, "resonator_status", 1.0)
        end
    end

    for oID, ownerTeam in pairs(resonators) do
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
                        Spring.SetUnitRulesParam(mex.id, "resonator_status", 3.0)
                        Spring.AddTeamResource(ownerTeam, "metal", mex.income * (METAL_MULT - 1))
                    end
                else
                    -- NON ABBIAMO ENERGIA: Spegnimento forzato del Resonator
                    Spring.GiveOrderToUnit(oID, CMD.ONOFF, {0}, {})
                    Spring.SendMessageToTeam(ownerTeam, "\255\255\050\050[EUF] Resonator Tower Emergency Shutdown: Low Energy!")
                end
            end
        else
            -- RESONATOR SPENTO: imposta il luarules = 2.0 
            local ux, uy, uz = Spring.GetUnitPosition(oID)
            local nearbyUnits = Spring.GetUnitsInCylinder(ux, uz, RADIUS)
            for i=1, #nearbyUnits do
                local mID = nearbyUnits[i]
                local mDef = UnitDefs[Spring.GetUnitDefID(mID)]
                if mDef and TABELLA_MEX[mDef.name] then
                    Spring.SetUnitRulesParam(mID, "resonator_status", 2.0)
                end
            end
        end
    end
end