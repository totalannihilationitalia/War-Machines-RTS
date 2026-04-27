function widget:GetInfo()
  return {
    name      = "WMRTS Mission Marker",
    desc      = "Icone e Auree per Unità e Punti Mappa",
    author    = "Molix",
    layer     = 3,
    enabled   = true,
  }
end
-- todo
-- caricare un immagine per ogni tipologia di marker (esempio attacco, difesa, ecc)

-- Config immagini
local icon_attack = "LuaUI/Images/objectives/target.png"
local aura_attack = "LuaUI/Images/objectives/aura.png"

-- Limite massimo di punti fissi contemporanei (per ottimizzazione)
local MAX_FIXED_POINTS = 10 

--------------------------------------------------------------------------------

local function DrawMarker(x, y, z, type, height, isFixed)
    local time = Spring.GetGameSeconds()
    local bounce = math.sin(time * 3) * 8
    local pulse = 0.5 + math.sin(time * 2) * 0.2

    -- 1. AUREA A TERRA
    gl.DepthMask(false)
    if type == 1 then 
		gl.Color(1, 0, 0, pulse) 	-- Definisco colore rosso per type == 1
    elseif type == 2 then 
		gl.Color(0, 1, 0, pulse) 	-- Definisco colore rosso per type == 2
    else 
		gl.Color(1, 1, 0, pulse) 	-- Definisco colore giallo per type == 3
	end 				
    
    gl.PushMatrix()
    gl.Translate(x, y + 10, z) 		-- coordinate relative all'unità
    gl.Rotate(90, 1, 0, 0)
    gl.Texture(aura_attack)
    gl.TexRect(-45, -45, 45, 45)
    gl.Texture(false)
    gl.PopMatrix()

    -- 2. ICONA (Billboard)
    gl.PushMatrix()
    gl.Translate(x, y + height + 25 + bounce, z)
    gl.Billboard()
    gl.Color(1, 1, 1, 1) -- Colore pieno per l'icona
    gl.Texture(icon_attack)
    gl.TexRect(-20, -20, 20, 20)
    gl.Texture(false)
    gl.PopMatrix()
    
    gl.DepthMask(true)
end

function widget:DrawWorld()
    -- --- PARTE 1: UNITÀ ---
    local visibleUnits = Spring.GetVisibleUnits()
    for i=1, #visibleUnits do
        local uID = visibleUnits[i]
        local objType = Spring.GetUnitRulesParam(uID, "obj_type")
        
        if objType and objType > 0 then
            local x, y, z = Spring.GetUnitPosition(uID)
            local unitDefID = Spring.GetUnitDefID(uID)
            local h = (UnitDefs[unitDefID] and UnitDefs[unitDefID].height or 30)
            DrawMarker(x, y, z, objType, h, false)
        end
    end

    -- --- PARTE 2: PUNTI FISSI ---
    for i=1, MAX_FIXED_POINTS do
        local prefix = "obj_marker_" .. i
		-- se il prefisso è 1 ->
        if (Spring.GetGameRulesParam(prefix .. "_active") or 0) == 1 then
            local px = Spring.GetGameRulesParam(prefix .. "_x") or 0
            local py = Spring.GetGameRulesParam(prefix .. "_y") or 0
            local pz = Spring.GetGameRulesParam(prefix .. "_z") or 0
            local pt = Spring.GetGameRulesParam(prefix .. "_type") or 3
            DrawMarker(px, py, pz, pt, 40, true) -- Altezza fissa 40 per i punti
        end
    end
    
    gl.Color(1,1,1,1)
end