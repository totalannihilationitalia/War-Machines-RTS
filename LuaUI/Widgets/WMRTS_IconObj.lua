function widget:GetInfo()
  return {
    name      = "WMRTS Mission Marker",
    desc      = "Icone e Auree per Unità e Punti Mappa",
    author    = "Molix",
    layer     = 3,
    enabled   = true,
  }
end

-- 28/04/2026 =	diversificate icone. Molix
-- 				aggiunta diversificazione tra aurea (che sta sotto la unità) e icona (che sta sopra le unità)
--				
-- Lista icone
-- type = 1 -> icone di attacco
-- type = 2 -> icone di difesa
-- type = 3 -> icone di movimento
-- type = 4 -> icona di costruzione (ad esempio per tutorial) -- ######## to do 28/04/2026

-- Config immagini
local icon_attack = "LuaUI/Images/menu/objectives/icon_attack.png"
local aura_attack = "LuaUI/Images/menu/objectives/marker_attack.png"
local icon_defend = "LuaUI/Images/menu/objectives/icon_defend.png"
local aura_defend = "LuaUI/Images/menu/objectives/marker_defend.png"
local icon_move = "LuaUI/Images/menu/objectives/icon_move.png"
local aura_move = "LuaUI/Images/menu/objectives/marker_move.png"

-- Limite massimo di punti fissi contemporanei (per ottimizzazione)
local MAX_FIXED_POINTS = 10 

--------------------------------------------------------------------------------

-- funzione per disegnare l'aurea (che dovrà essere disegnata "dietro" le unità)
local function DrawAura(x, y, z, type)
    local time = Spring.GetGameSeconds()
    local pulse = 0.5 + math.sin(time * 2) * 0.2
	local rotation = time * 60 
    gl.DepthMask(true)  -- Permette al depth buffer di funzionare
    gl.DepthTest(true)
	gl.PushMatrix()    
    if type == 1 then gl.Color(1, 0, 0, pulse) 		-- aurea di attacco
		gl.Color(1, 1, 1, pulse) 	
		gl.Texture(aura_attack)
		gl.Translate(x, y + 5, z) 					-- coordinate relative all'unità
		gl.Rotate(rotation,0 , 1, 0)
		gl.Rotate(90, 1, 0, 0) 
		gl.TexRect(-85, -85, 85, 85)
    elseif type == 2 then 
		gl.Color(1, 1, 1, pulse) 	
		gl.Texture(aura_defend)
		gl.Translate(x, y + 5, z) 					-- coordinate relative all'unità
		gl.Rotate(rotation,0 , 1, 0)
		gl.Rotate(90, 1, 0, 0) 
		gl.TexRect(-85, -85, 85, 85)
	elseif type == 3 then 
		gl.Color(1, 1, 1, pulse) 	
		gl.Texture(aura_move)
		gl.Translate(x, y + 5, z) 					-- coordinate relative all'unità
		gl.Rotate(rotation,0 , 1, 0)
		gl.Rotate(90, 1, 0, 0) 
		gl.TexRect(-85, -85, 85, 85)	
    else 
		Spring.Echo("ATTENZIONE: non esiste questo type!!!!")		-- warning
	end
    
    gl.Texture(false)
    gl.PopMatrix()
end

-- funzione per disegnare l'icona (che verrà disegnata davanti a tutte le unità)
local function DrawIcon(x, y, z, height, type)
    local time = Spring.GetGameSeconds()
    local bounce = math.sin(time * 3) * 8

    gl.DepthMask(false)
    gl.DepthTest(false) -- L'icona si vede anche attraverso le montagne se vuoi
 	gl.PushMatrix()   
    if type == 1 then 				-- type = 1 -> attacco	
		gl.Translate(x, y + height + 25 + bounce, z)
		gl.Billboard()
		gl.Color(1, 1, 1, 1)
		gl.Texture(icon_attack)
		gl.TexRect(-30, -20+40, 30, 20+40+20)
	elseif type == 2 then 			-- type = 2 -> difesa
		gl.Translate(x, y + height + 25 + bounce, z)
		gl.Billboard()
		gl.Color(1, 1, 1, 1)
		gl.Texture(icon_defend)
		gl.TexRect(-30, -20+40, 30, 20+40+20)									
	elseif type == 3 then 			-- type = 3 -> move
		gl.Translate(x, y + height + 25 + bounce, z)
		gl.Billboard()
		gl.Color(1, 1, 1, 1)
		gl.Texture(icon_move)
		gl.TexRect(-30, -20+40, 30, 20+40+20)									-- continuare			############		
	end	
	gl.Texture(false)
	gl.PopMatrix()
end

-- funzione per disegnare le immagini sotto le unità
function widget:DrawWorldPreUnit()
    local visibleUnits = Spring.GetVisibleUnits()
    
    -- Disegna Auree Unità
    for i=1, #visibleUnits do
        local uID = visibleUnits[i]
        local objType = Spring.GetUnitRulesParam(uID, "obj_type")
        if objType and objType > 0 then
            local x, y, z = Spring.GetUnitPosition(uID)
            DrawAura(x, y, z, objType)
        end
    end

    -- Disegna Auree Punti Fissi
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


-- funzione per disegnare le immagini sopra le unità
function widget:DrawWorld()
    local visibleUnits = Spring.GetVisibleUnits()
    
    for i=1, #visibleUnits do
        local uID = visibleUnits[i]
        local objType = Spring.GetUnitRulesParam(uID, "obj_type")
        if objType and objType > 0 then
            local x, y, z = Spring.GetUnitPosition(uID)
            local unitDefID = Spring.GetUnitDefID(uID)
            local h = (UnitDefs[unitDefID] and UnitDefs[unitDefID].height or 30)
            DrawIcon(x, y, z, h, objType)
        end
    end

    -- valuare se inserire le icone ai punti fissi, nel caso farlo qui (magari alcune tipologie necessitano dell'icona, da valutare man mano si fanno le missioni) Molix
end