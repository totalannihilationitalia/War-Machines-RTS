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
-- 29/01/2026 Modificato minDist da 64 a 150
-- todo: implementare pannello amministrazione per gli strumenti "WMRTS_Maker"
-- todo: verificare se stampare il report su un file, o meglio integrare questa ricerca nel gadget

local function ExportMetalPositions()
    -- PARAMETRI CONFIGURABILI
    local minDist = 150 -- Distanza minima tra giacimenti (150 è ideale per evitare duplicati, prima era 64 e creava duplicati 29/01/2026)
    
    local resX = math.floor(Game.mapSizeX / 16)
    local resZ = math.floor(Game.mapSizeZ / 16)
    local clusters = {}

    Spring.Echo("Inizio scansione accurata giacimenti...")

    -- 1. Scansione e raggruppamento
    for z = 0, resZ - 1 do
        for x = 0, resX - 1 do
            local metal = Spring.GetMetalAmount(x, z)
            if metal and metal > 0 then
                local worldX = x * 16 + 8
                local worldZ = z * 16 + 8
                
                local foundCluster = false
                for i=1, #clusters do
                    -- Calcoliamo la distanza dal centro attuale del cluster
                    local dx = (clusters[i].sumX / clusters[i].count) - worldX
                    local dz = (clusters[i].sumZ / clusters[i].count) - worldZ
                    local distSq = dx*dx + dz*dz
                    
                    if distSq < (minDist * minDist) then
                        -- Aggiungiamo il pixel al cluster esistente
                        clusters[i].sumX = clusters[i].sumX + worldX
                        clusters[i].sumZ = clusters[i].sumZ + worldZ
                        clusters[i].count = clusters[i].count + 1
                        foundCluster = true
                        break
                    end
                end
                
                if not foundCluster then
                    -- Creiamo un nuovo cluster
                    table.insert(clusters, {sumX = worldX, sumZ = worldZ, count = 1})
                end
            end
        end
    end

    -- 2. Calcolo dei centri finali e formattazione
    local finalSpots = {}
    for i=1, #clusters do
        table.insert(finalSpots, {
            x = math.floor(clusters[i].sumX / clusters[i].count),
            z = math.floor(clusters[i].sumZ / clusters[i].count)
        })
    end

    local mapName = Game.mapName or "UnknownMap"
    local output = '    ["' .. mapName .. '"] = { '
    
    for i, spot in ipairs(finalSpots) do
        output = output .. '{x = ' .. spot.x .. ', z = ' .. spot.z .. '}'
        if i < #finalSpots then
            output = output .. ', '
        end
    end
    
    output = output .. ' },'

    -- 3. Stampa finale
    Spring.Echo("--- RISULTATO EXPORT (Trovati " .. #finalSpots .. " giacimenti) ---")
    Spring.Echo(output)
    Spring.Echo("-------------------------------------------------------------")
    Spring.SendMessage("Trovati " .. #finalSpots .. " giacimenti. Copia da F11 o infolog.txt")
end

function widget:TextCommand(command)
    if (command == 'exportmetal') then
        ExportMetalPositions()
        return true
    end
    return false
end