function widget:GetInfo()
  return {
    name      = "WMRTS Mission Marker",
    desc      = "Icone, Auree e Testo per Unità e Punti Mappa",
    author    = "Molix",
    layer     = 3,
    enabled   = true,
  }
end

-- 28/04/2026 =	diversificate icone. Molix
-- 				aggiunta diversificazione tra aurea (che sta sotto la unità) e icona (che sta sopra le unità)
-- 29/04/2026 = ottimizzato il codice e aggiunto il testo ai marker		
-- 06/04/2026 = aggiunte icone "build" e "select"		
-- Lista icone
-- type = 1 -> icone di attacco
-- type = 2 -> icone di difesa
-- type = 3 -> icone di movimento
-- type = 4 -> icona di costruzione ( factory -> unità)
-- type = 5 -> icona di selezione unità
-- type = 6 -> icona di costruzione ( unità -> building)
-- type = 7 -> icona di "DANGER", pericolo

-- Config immagini
local icon_attack = "LuaUI/Images/menu/objectives/icon_attack.png"
local aura_attack = "LuaUI/Images/menu/objectives/marker_attack.png"
local icon_defend = "LuaUI/Images/menu/objectives/icon_defend.png"
local aura_defend = "LuaUI/Images/menu/objectives/marker_defend.png"
local icon_move   = "LuaUI/Images/menu/objectives/icon_move.png"
local aura_move   = "LuaUI/Images/menu/objectives/marker_move.png"
local icon_build   = "LuaUI/Images/menu/objectives/icon_build.png" 			--	rev 06/05/2026 aggiunto
local aura_build   = "LuaUI/Images/menu/objectives/marker_build.png"		--	rev 06/05/2026 aggiunto
local icon_select   = "LuaUI/Images/menu/objectives/icon_select.png"		--	rev 06/05/2026 aggiunto
local aura_select   = "LuaUI/Images/menu/objectives/marker_select.png"		--	rev 06/05/2026 aggiunto
local icon_construct   = "LuaUI/Images/menu/objectives/icon_select.png"		--	rev 06/05/2026 aggiunto
local aura_construct   = "LuaUI/Images/menu/objectives/marker_select.png"	--	rev 06/05/2026 aggiunto
local icon_danger   = "LuaUI/Images/menu/objectives/icon_danger.png"		--	rev 06/05/2026 aggiunto
local aura_danger   = "LuaUI/Images/menu/objectives/marker_danger.png"		--	rev 06/05/2026 aggiunto

-- Tabella per i testi automatici delle unità basata sul tipo
local typeToText = {
    [1] = "DESTROY",
    [2] = "DEFEND",
    [3] = "MOVE",
    [4] = "BUILD",
    [5] = "SELECT",	
    [6] = "BUILD",			-- ########## sarebbe costruire edificio,
    [7] = "DANGER",		
}

-- Limite massimo di punti fissi
local MAX_FIXED_POINTS = 10 

--------------------------------------------------------------------------------

-- Funzione per disegnare il testo
local function DrawLabel(x, y, z, height, text)
    if not text or text == "" then return end
    
    gl.PushMatrix()
    -- Lo posizioniamo più in alto dell'icona (height + offset icona + offset testo)
    gl.Translate(x, y + height + 100, z) 
    gl.Billboard()
    gl.DepthTest(false) -- Visibile sopra tutto
    
    -- gl.Text(testo, x, y, dimensione, opzioni)
    -- "c" = centra orizzontalmente, "o" = contorno nero (outline)
    gl.Text(text, -9, 20, 16, "co")
    
    gl.DepthTest(true)
    gl.PopMatrix()
end

-- Funzione per disegnare l'aurea (sotto l'unità)
local function DrawAura(x, y, z, type)
    local time = Spring.GetGameSeconds()
    local pulse = 0.5 + math.sin(time * 2) * 0.2
    local rotation = time * 60 
    
    gl.DepthMask(false) -- disabilito la scrittura della profondità
    gl.DepthTest(true)
    gl.PushMatrix()    
    
    local tex = aura_move
    if type == 1 then tex = aura_attack
    elseif type == 2 then tex = aura_defend
    elseif type == 3 then tex = aura_move 
    elseif type == 4 then tex = aura_build 		--	rev 06/05/2026 aggiunto
    elseif type == 5 then tex = aura_select 	--	rev 06/05/2026 aggiunto
    elseif type == 6 then tex = aura_build 		--	rev 06/05/2026 aggiunto
    elseif type == 7 then tex = aura_danger 	--	rev 06/05/2026 aggiunto	
	end
    
    gl.Color(1, 1, 1, pulse) 	
    gl.Texture(tex)
    gl.Translate(x, y + 5, z)
    gl.Rotate(rotation, 0, 1, 0)
    gl.Rotate(90, 1, 0, 0) 
    gl.TexRect(-85, -85, 85, 85)
    gl.DepthMask(true)	-- riattivo la scrittura di profondità    
    gl.Texture(false)
    gl.PopMatrix()
end

-- Funzione per disegnare l'icona (sopra l'unità)
local function DrawIcon(x, y, z, height, type)
    local time = Spring.GetGameSeconds()
    local bounce = math.sin(time * 3) * 8

    gl.DepthMask(false)
    gl.DepthTest(false) 
    gl.PushMatrix()   
    
    local tex = icon_move
    if type == 1 then tex = icon_attack
    elseif type == 2 then tex = icon_defend
    elseif type == 3 then tex = icon_move 
    elseif type == 4 then tex = icon_build 	
    elseif type == 5 then tex = icon_select 		
    elseif type == 6 then tex = icon_build				-- ####### sistemare e mettere icona di costruzione unità->building 	
    elseif type == 7 then tex = icon_danger 			--	rev 06/05/2026 aggiunto	
	end

    gl.Translate(x, y + height + 25 + bounce, z)
    gl.Billboard()
    gl.Color(1, 1, 1, 1)
    gl.Texture(tex)
    -- Disegna l'icona leggermente alzata rispetto al centro del billboard
    gl.TexRect(-30, 20, 30, 80) 
    
    gl.Texture(false)
    gl.PopMatrix()
end

-- Disegna le auree (Sotto le unità)
function widget:DrawWorldPreUnit()
    -- Auree Unità
    local visibleUnits = Spring.GetVisibleUnits()
    for i=1, #visibleUnits do
        local uID = visibleUnits[i]
        local objType = Spring.GetUnitRulesParam(uID, "obj_type")
        if objType and objType > 0 then
            local x, y, z = Spring.GetUnitPosition(uID)
            DrawAura(x, y, z, objType)
        end
    end

    -- Auree Punti Fissi
    for i=1, MAX_FIXED_POINTS do
        local prefix = "obj_marker_" .. i
        if (Spring.GetGameRulesParam(prefix .. "_active") or 0) == 1 then
            local px = Spring.GetGameRulesParam(prefix .. "_x") or 0
            local py = Spring.GetGameRulesParam(prefix .. "_y") or 0
            local pz = Spring.GetGameRulesParam(prefix .. "_z") or 0
            local pt = Spring.GetGameRulesParam(prefix .. "_type") or 3
            DrawAura(px, py, pz, pt)
        end
    end
end

-- Disegna Icone e Testi (Sopra le unità)
function widget:DrawWorld()
    local visibleUnits = Spring.GetVisibleUnits()
    
    -- 1. Gestione UNITA'
    for i=1, #visibleUnits do
        local uID = visibleUnits[i]
        local objType = Spring.GetUnitRulesParam(uID, "obj_type")
        if objType and objType > 0 then
            local x, y, z = Spring.GetUnitPosition(uID)
            local unitDefID = Spring.GetUnitDefID(uID)
            local h = (UnitDefs[unitDefID] and UnitDefs[unitDefID].height or 30)
            
            -- Disegna Icona
            DrawIcon(x, y, z, h, objType)
            -- Disegna Testo automatico (ATTACK, DEFEND, ecc)
            DrawLabel(x, y, z, h, typeToText[objType])
        end
    end

    -- 2. Gestione PUNTI FISSI (Marker)
    for i=1, MAX_FIXED_POINTS do
        local prefix = "obj_marker_" .. i
        if (Spring.GetGameRulesParam(prefix .. "_active") or 0) == 1 then
            local px = Spring.GetGameRulesParam(prefix .. "_x") or 0
            local py = Spring.GetGameRulesParam(prefix .. "_y") or 0
            local pz = Spring.GetGameRulesParam(prefix .. "_z") or 0
            local pt = Spring.GetGameRulesParam(prefix .. "_type") or 3
            -- Legge il testo personalizzato dal GameRulesParam
            local pText = Spring.GetGameRulesParam(prefix .. "_text")
            
            -- Disegna Icona anche per i punti fissi
            DrawIcon(px, py, pz, 0, pt)
            -- Disegna il testo se presente
            if pText then
                DrawLabel(px, py, pz, 0, pText)
            end
        end
    end
end