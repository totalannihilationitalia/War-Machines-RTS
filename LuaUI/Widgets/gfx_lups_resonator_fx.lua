function widget:GetInfo()
  return {
    name      = "EUF Resonator FX Dedicated",
    desc      = "Giallo = Collegato, Verde = Attivo",
    author    = "Molix with AI",
    layer     = 10,
    enabled   = true,
  }
end
--[[
15/04/2026 = creato questo widget. Molix
16/04/2026 = realizzata immagine "aurea" 
]]--

local Lups, LupsAddFX
local particleIDs = {} 
local mexUnits = {}    
local initialized = false

local MEX_UNIT_NAME = "cormex"
local SPOTS = {"spot1", "spot2", "spot3", "spot4"}

-- ########## CORE LOGIC ##########

local function ClearMexFX(unitID)
    if particleIDs[unitID] then
        for i=1, #particleIDs[unitID] do Lups.RemoveParticles(particleIDs[unitID][i]) end
        particleIDs[unitID] = nil
    end
end

local function AddMexAdvancedFX(unitID, strength)
    -- Forza 1.0 = Niente effetto
    if strength < 1.1 then return end
    
    if not particleIDs[unitID] then particleIDs[unitID] = {} end
    local pieceMap = Spring.GetUnitPieceMap(unitID)
    local ux, uy, uz = Spring.GetUnitPosition(unitID)

    -- DEFINIZIONE COLORI BASE ALLO STATO
    local colRing, colOrb
    local showExtra = false

    if strength > 2.5 then 
        -- STATO VERDE (ATTIVO)
        colRing = {0.0, 1.0, 0.2, 0.6} -- Verde brillante
        colOrb  = {0.1, 1.0, 0.3, 0.1}
        showExtra = true
    else
        -- STATO GIALLO (COLLEGATO MA OFF)
        colRing = {1.0, 0.9, 0.0, 0.4} -- Giallo
        colOrb  = {1.0, 0.8, 0.0, 0.05}
        showExtra = false
    end

    -- 1. L'AUREA A TERRA (Sempre presente se strength >= 2.0)
    table.insert(particleIDs[unitID], LupsAddFX("GroundFlash", {
        unit = unitID,
        pos = {ux+4, uy+50, uz+4},
        size = 50,
        sizeGrowth = 0,
        life = math.huge,
        colormap = { colRing, {0,0,0,0} },
        texture = ":n:".."LuaUI/Images/units/resonator_aurea.png", --"bitmaps/GPL/Lups/groundringBW.png",
        repeatEffect = true,
    }))

    -- 2. GLI EFFETTI EXTRA (Solo se attivo/Verde)
    if showExtra then
        -- SFRE (Verdi)
        for _, spotName in ipairs(SPOTS) do
            if pieceMap[spotName] then
                table.insert(particleIDs[unitID], LupsAddFX("StaticParticles", {
                    unit = unitID, piece = spotName, partpos = "0,0,0",
                    count = 1, life = math.huge, size = 25,
                    colormap = { colOrb }, texture = 'bitmaps/GPL/smallflare.tga',
                    repeatEffect = true,
                }))
            end
        end
        -- CALORE
        table.insert(particleIDs[unitID], LupsAddFX("ShieldJitter", {
            unit = unitID, pos = {0, 40, 0}, size = 50, precision = 22,
            strength = 0.004, life = math.huge, repeatEffect = true,
        }))
    end
end

-- ########## CALLINS ##########
-- ogni x secondi prelevo lo stato "resonator_status" dal unitparam delle unità 
function widget:GameFrame(n)
    if n % 30 ~= 0 or not initialized then return end
    for unitID, lastS in pairs(mexUnits) do
        local curS = Spring.GetUnitRulesParam(unitID, "resonator_status") or 1.0
        if math.abs(curS - lastS) > 0.1 then
            ClearMexFX(unitID)
            AddMexAdvancedFX(unitID, curS)
            mexUnits[unitID] = curS
        end
    end
end

function widget:UnitFinished(unitID, unitDefID)
    if UnitDefs[unitDefID].name == MEX_UNIT_NAME then mexUnits[unitID] = 0 end
end

function widget:UnitDestroyed(unitID)
    mexUnits[unitID] = nil
    ClearMexFX(unitID)
end

function widget:Update()
    if initialized then return end
    Lups = WG['Lups']
    if Lups then
        LupsAddFX = Lups.AddParticles
        initialized = true
        local allUnits = Spring.GetAllUnits()
        for i=1, #allUnits do
            local ud = UnitDefs[Spring.GetUnitDefID(allUnits[i])]
            if ud and ud.name == MEX_UNIT_NAME then mexUnits[allUnits[i]] = 0 end
        end
    end
end

function widget:Shutdown()
    for uID, _ in pairs(mexUnits) do ClearMexFX(uID) end
end