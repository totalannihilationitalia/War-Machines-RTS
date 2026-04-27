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
25/04/2026 = creo custom size per adattare meglio l' "aurea" alla dimensione dell'estrattore. Molix
]]--

local Lups, LupsAddFX
local particleIDs = {} 
local mexUnits = {}    
local initialized = false

-- local MEX_UNIT_NAME = "cormex" trasformo in tabella
--[[local VALID_UNITS = { 	
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
]]--

local VALID_UNITS = { 	

    ["cormex"]       = { size = 45, texture = "resonator_aurea.png" },
    ["corexp"]       = { size = 60, texture = "resonator_aurea.png" },
    ["cormoho"]      = { size = 70, texture = "resonator_aurea_large.png" }, -- esempio texture diversa
    ["cormexp"]      = { size = 50 }, -- userà la texture di default
    ["icumetex"]     = { size = 38 },
    ["armamex"]      = { size = 45 },
    ["armmoho"]      = { size = 70 },
    ["advmoho"]      = { size = 85 },
    ["eufmetex"]     = { size = 55 },
    ["eufametex"]    = { size = 55 },
    ["eufadvmetex"]  = { size = 90 },
    ["andmexun"]     = { size = 50 },
    ["andmex"]       = { size = 50 },
    ["andametex"]    = { size = 60 }
}

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

    -- Recuperiamo il nome dell'unità per pescare i dati dalla tabella VALID_UNITS
    local unitDefID = Spring.GetUnitDefID(unitID)
    local uName = UnitDefs[unitDefID].name
    local config = VALID_UNITS[uName] or {} -- se non trova l'unità (strano), usa tabella vuota

    -- PARAMETRI MANUALI (con valori di fallback se mancano nella tabella)
    local customSize = config.size or 50
    local customTexture = config.texture or "resonator_aurea.png"
    
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

-- ############ utilizzare questa porzione di codice taggato per creare un icona 3D in testa alle unità. Usare poi per le missioni ######################## molix
--[[ 
 table.insert(particleIDs[unitID], LupsAddFX("SimpleParticles", {	-- modifico da GroundFlash per gestire anche l'altezza
        unit = unitID,
        pos = {0, 20, 0},
        direction = {0, 1, 0},      -- IMPORTANTE: Forza la particella a guardare in alto (diventa piatta)
        emitVector = {0, 1, 0},     -- Aiuta a mantenere l'orientamento orizzontale		
        size = customSize, --50,  		-- sostituisco con il customsize per adattare meglio la larghezza dell'immagine alla dimensione dell'estrattore
        sizeGrowth = 0,
        life = math.huge,
        colormap = { colRing, {0,0,0,0} },
        texture = ":n:LuaUI/Images/units/" .. customTexture,  -- :n:".."LuaUI/Images/units/resonator_aurea.png", --"bitmaps/GPL/Lups/groundringBW.png", -- anche qui imposto texture custom per evitare troppi stretch (valutare poi se mantenere le stesse dimensioni per tutti e variare solo l'immagine. Molix ############# )
        repeatEffect = true,
        alignToPath = false,        -- Evita che ruoti se l'unità si muove		
    }))
]]--


    -- 1. L'AUREA A TERRA (Sempre presente se strength >= 2.0)
    table.insert(particleIDs[unitID], LupsAddFX("GroundFlash", {
        unit = unitID,
        pos = {ux+3, uy, uz+4},
        size = customSize, --50,  		-- sostituisco con il customsize per adattare meglio la larghezza dell'immagine alla dimensione dell'estrattore
        sizeGrowth = 0,
        life = math.huge,
        colormap = { colRing, {0,0,0,0} },
        texture = ":n:LuaUI/Images/units/" .. customTexture,  -- :n:".."LuaUI/Images/units/resonator_aurea.png", --"bitmaps/GPL/Lups/groundringBW.png", -- anche qui imposto texture custom per evitare troppi stretch (valutare poi se mantenere le stesse dimensioni per tutti e variare solo l'immagine. Molix ############# )
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
 --       table.insert(particleIDs[unitID], LupsAddFX("ShieldJitter", {
--            unit = unitID, pos = {0, 40, 0}, size = 50, precision = 22,
 --           strength = 0.004, life = math.huge, repeatEffect = true,
--        }))
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
--    if UnitDefs[unitDefID].name == MEX_UNIT_NAME then mexUnits[unitID] = 0 end -- sostituisco con controllo tabella
    local name = UnitDefs[unitDefID].name
    if VALID_UNITS[name] then 
        mexUnits[unitID] = 0 
    end
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
            local uID = allUnits[i]
            local ud = UnitDefs[Spring.GetUnitDefID(uID)]
            if ud and VALID_UNITS[ud.name] then 
                mexUnits[uID] = 0 
            end
        end
    end
end

function widget:Shutdown()
    for uID, _ in pairs(mexUnits) do ClearMexFX(uID) end
end