function widget:GetInfo()
	return {
		name      = "LOS Colors Customizer",
		desc      = "LOS Custom Color",
		author    = "molix",
		date      = "2026",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true
	}
end

local function ApplyCustomColors()
    -- I valori dei colori RGB sono espressi in decimali da 0.0 a 1.0
    Spring.SetLosViewColors({
        always = { 0.05, 0.05, 0.05 },  	-- Nebbia di guerra (più è basso, più è scuro il non esplorato)
        LOS    = { 1.0, 1.0, 1.0 },      	-- Area visibile sotto il LOS delle unità (bianco neutro)
        radar  = { 0.0, 1.0, 0.0 },      	-- Colore del bordo esterno del radar (es. verde)
        jammer = { 1.0, 0.0, 0.0 },      	-- Area coperta da Radar Jammer (es. rosso)
        radar2 = { 0.0, 0.25, 0.0 }      	-- Interno dell'area di copertura radar
    })
end

function widget:Initialize()
    ApplyCustomColors()
end