function gadget:GetInfo()
    return {
        name    = "Sparks FX on wreck",
        desc    = "Spawna scintille randomiche sui rottami",
        author  = "Molix",
        date    = "2026",
        license = "GPLv2",
        layer   = 0,
        enabled = true,
    }
end

if not gadgetHandler:IsSyncedCode() then
    return
end

-- Configurazione
local CEG_NAME      = "scifi_pole_sparks" -- Nome del CEG in effects/ ############## determinale scintille in CEG ##############
local SPARK_CHANCE  = 0.35                -- 35% dei pali distrutti farà scintille
local MIN_DELAY     = 15                  -- Minimo frame tra due scariche (30 frame = 1 sec)
local MAX_DELAY     = 110                 -- Massimo frame tra due scariche
local PIECE_PREFIX  = "^wspark"            -- Cerca pezzi chiamati wspark1, wspark2, ecc. NB: inserirli nel modello .s3o dell'unità

-- Nomi (lowercase) dei FeatureDef dei corpse interessati
local TARGET_CORPSES = {
    ["Station_one_tunnel_e_feature_dead"]  = true,
    ["Station_one_tunnel_o_feature_dead"] = true,
    ["Station_one_tunnel_n_feature_dead"] = true,
    ["Station_one_tunnel_s_feature_dead"] = true,	
}

local sparkingFeatures = {}

local function Normalize(x, y, z)
    local len = math.sqrt(x*x + y*y + z*z)
    if len > 0.0001 then
        return x/len, y/len, z/len
    end
    return 0, 1, 0
end

local function TryRegisterFeature(featureID)
    local defID = Spring.GetFeatureDefID(featureID)
    if not defID then return end

    local fDef = FeatureDefs[defID]
    if not fDef or not TARGET_CORPSES[fDef.name] then return end

    -- Scelta randomica: non tutti i pali fanno scintille
    if math.random() > SPARK_CHANCE then return end

    -- Cerca tutti i pezzi che iniziano con "spark" nel modello .s3o
    local pieceMap = Spring.GetFeaturePieceMap(featureID)
    local emitPieces = {}
    if pieceMap then
        for name, pieceID in pairs(pieceMap) do
            if string.match(string.lower(name), PIECE_PREFIX) then
                emitPieces[#emitPieces + 1] = pieceID
            end
        end
    end

    sparkingFeatures[featureID] = {
        pieces    = emitPieces,
        nextFrame = Spring.GetGameFrame() + math.random(5, MAX_DELAY),
    }
end

function gadget:Initialize()
    -- Utile in caso di /luarules reload o corpse già presenti sulla mappa
    for _, featureID in ipairs(Spring.GetAllFeatures()) do
        TryRegisterFeature(featureID)
    end
end

function gadget:FeatureCreated(featureID, allyTeamID)
    TryRegisterFeature(featureID)
end

function gadget:FeatureDestroyed(featureID)
    sparkingFeatures[featureID] = nil
end

function gadget:GameFrame(frame)
    for featureID, data in pairs(sparkingFeatures) do
        if not Spring.ValidFeatureID(featureID) then
            sparkingFeatures[featureID] = nil
        elseif frame >= data.nextFrame then
            local px, py, pz, dx, dy, dz

            if #data.pieces > 0 then
                -- Sceglie a caso uno dei punti "spark*" del modello .s3o
                local pieceID = data.pieces[math.random(#data.pieces)]
                px, py, pz, dx, dy, dz = Spring.GetFeaturePiecePosDir(featureID, pieceID)
                dx, dy, dz = Normalize(dx, dy, dz)
            else
                -- Fallback se il .s3o non ha pezzi "spark*"
                px, py, pz = Spring.GetFeaturePosition(featureID)
                py = py + 15
                dx, dy, dz = 0, 1, 0
            end

            if px then
                Spring.SpawnCEG(CEG_NAME, px, py, pz, dx, dy, dz, 0, 0)
            end

            data.nextFrame = frame + math.random(MIN_DELAY, MAX_DELAY)
        end
    end
end