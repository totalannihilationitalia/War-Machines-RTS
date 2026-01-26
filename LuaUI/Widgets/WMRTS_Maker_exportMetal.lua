function widget:GetInfo()
  return {
    name      = "Metal Spot Exporter V2",
    desc      = "Esporta coordinate giacimenti. Comando: /exportmetal",
    author    = "Molix",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end
-- 26/01/2026 Creato questo widget
-- todo: implementare pannello amministrazione per gli strumenti "WMRTS_Maker"


local function ExportMetalPositions()
    -- Parametri di scansione
    local threshold = 1 
    local minDist = 64 -- Distanza minima tra i centri dei giacimenti
    
    -- Calcolo risoluzione metal map (16 pixel world = 1 pixel metal map)
    local resX = math.floor(Game.mapSizeX / 16)
    local resZ = math.floor(Game.mapSizeZ / 16)
    
    local spots = {}

    Spring.Echo("Analisi giacimenti su mappa: " .. Game.mapName)
    Spring.Echo("Dimensioni: " .. resX .. "x" .. resZ)

    -- 1. Scansione della metal map
    for z = 0, resZ - 1 do
        for x = 0, resX - 1 do
            local metal = Spring.GetMetalAmount(x, z)
            if metal and metal > 0 then
                local worldX = x * 16 + 8
                local worldZ = z * 16 + 8
                
                local foundNear = false
                for i=1, #spots do
                    local dx = spots[i].x - worldX
                    local dz = spots[i].z - worldZ
                    local distSq = dx*dx + dz*dz
                    
                    if distSq < (minDist * minDist) then
                        -- Se è vicino a un punto già trovato, facciamo una media
                        spots[i].x = (spots[i].x + worldX) / 2
                        spots[i].z = (spots[i].z + worldZ) / 2
                        foundNear = true
                        break
                    end
                end
                
                if not foundNear then
                    table.insert(spots, {x = worldX, z = worldZ})
                end
            end
        end
    end

    -- 2. Formattazione stringa richiesta
    local mapName = Game.mapName or "UnknownMap"
    local output = '    ["' .. mapName .. '"] = { '
    
    for i, spot in ipairs(spots) do
        output = output .. '{x = ' .. math.floor(spot.x) .. ', z = ' .. math.floor(spot.z) .. '}'
        if i < #spots then
            output = output .. ', '
        end
    end
    
    output = output .. ' },'

    -- 3. Output in console e log
    Spring.Echo("--- COPIA LA RIGA QUI SOTTO ---")
    Spring.Echo(output)
    Spring.Echo("-------------------------------")
    Spring.SendMessage("Export completato. Apri F11 o infolog.txt per copiare i dati.")
end

function widget:TextCommand(command)
    if (command == 'exportmetal') then
        ExportMetalPositions()
        return true
    end
    return false
end