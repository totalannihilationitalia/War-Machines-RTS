function gadget:GetInfo()
    return {
        name    = "Sparks FX on wreck",
        desc    = "Spawna scintille randomiche sui pezzi wspark* dei rottami .s3o",
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
local DEBUG         = false              -- Debug
local CEG_NAME      = "wreck_sparks"
local CEG_RADIUS    = 50
local CEG_DAMAGE    = 100
local SPARK_CHANCE  = 1                  -- 1 = 100%, 0.35 = 35%
local MIN_DELAY     = 15
local MAX_DELAY     = 110
local PIECE_PREFIX  = "^wspark"

-- Nomi (lowercase) dei FeatureDef interessati
local TARGET_CORPSES = {
    ["station_one_tunnel_e_feature_dead"]           = true,
    ["station_one_tunnel_o_feature_dead"]           = true,
    ["station_one_tunnel_n_feature_dead"]           = true,
    ["station_one_tunnel_s_feature_dead"]           = true,
    ["station_one_antenna_small_se_feature_dead"]   = true,
    ["station_one_antenna_small_so_feature_dead"]   = true,
    ["station_one_antenna_small_ne_feature_dead"]   = true,
    ["station_one_antenna_small_no_feature_dead"]   = true,
    ["station_one_scudi_n_feature_dead"]            = true,
    ["station_one_scudi_s_feature_dead"]            = true,
    ["station_one_scudi_o_feature_dead"]            = true,
    ["station_one_scudi_e_feature_dead"]            = true,
    ["station_one_antenna_feature_dead"]            = true,
}

local sparkingList   = {} -- Array sequenziale per iterazione deterministica (sync-safe)
local sparkingIndex  = {} -- Mappa: featureID -> indice in sparkingList
local s3oSparksCache = {} -- Cache per FeatureDefID: evita di rileggere il .s3o ogni volta

--------------------------------------------------------------------------------
-- Parser binario .s3o (compatibile Lua 5.1 / Spring 100+)
--------------------------------------------------------------------------------
local function ReadUInt32LE(data, off0)
    local b1, b2, b3, b4 = string.byte(data, off0 + 1, off0 + 4)
    if not b4 then return 0 end
    return b1 + b2 * 256 + b3 * 65536 + b4 * 16777216
end

local function ReadFloat32LE(data, off0)
    local b1, b2, b3, b4 = string.byte(data, off0 + 1, off0 + 4)
    if not b4 then return 0 end
    local sign = 1
    if b4 >= 128 then
        sign = -1
        b4 = b4 - 128
    end
    local exp = b4 * 2 + math.floor(b3 / 128)
    local mant = (b3 % 128) * 65536 + b2 * 256 + b1
    if exp == 0 then
        if mant == 0 then return 0 end
        return sign * (mant / 8388608) * (2 ^ -126)
    elseif exp == 255 then
        return 0
    end
    return sign * (1 + mant / 8388608) * (2 ^ (exp - 127))
end

local function ReadCString(data, off0)
    if off0 <= 0 or off0 >= #data then return "" end
    local nulPos = string.find(data, "\0", off0 + 1, true)
    if not nulPos then return "" end
    return string.sub(data, off0 + 1, nulPos - 1)
end

local function LoadS3OData(fDef)
    local candidates = {}
    local function addCandidate(p)
        if type(p) == "string" and p ~= "" then
            candidates[#candidates + 1] = p
            if not string.find(string.lower(p), "^objects3d/") then
                candidates[#candidates + 1] = "objects3d/" .. p
            end
            if not string.find(string.lower(p), "%.s3o$") then
                candidates[#candidates + 1] = p .. ".s3o"
                if not string.find(string.lower(p), "^objects3d/") then
                    candidates[#candidates + 1] = "objects3d/" .. p .. ".s3o"
                end
            end
        end
    end

    addCandidate(fDef.modelpath)
    if fDef.model then addCandidate(fDef.model.path) end
    addCandidate(fDef.modelname)

    for _, path in ipairs(candidates) do
        -- VFS.ZIP esclude eventuali file sciolti locali (VFS.RAW) evitando desync
        if VFS.FileExists(path, VFS.ZIP) then
            local raw = VFS.LoadFile(path, VFS.ZIP)
            if raw and #raw >= 52 and string.sub(raw, 1, 11) == "Spring unit" then
                return raw, path
            end
        end
    end
    return nil, nil
end

local function ExtractS3OSparkPoints(defID, fDef)
    if s3oSparksCache[defID] ~= nil then
        return s3oSparksCache[defID]
    end

    local points = {}
    local data, loadedPath = LoadS3OData(fDef)

    if data then
        local function WalkPiece(pieceOff, px, py, pz, depth)
            if depth > 64 or pieceOff <= 0 or pieceOff + 52 > #data then return end

            local nameOff       = ReadUInt32LE(data, pieceOff + 0)
            local numChildren   = ReadUInt32LE(data, pieceOff + 4)
            local childTableOff = ReadUInt32LE(data, pieceOff + 8)
            local numVertices   = ReadUInt32LE(data, pieceOff + 12)
            local vertTableOff  = ReadUInt32LE(data, pieceOff + 16)

            local ox = ReadFloat32LE(data, pieceOff + 40)
            local oy = ReadFloat32LE(data, pieceOff + 44)
            local oz = ReadFloat32LE(data, pieceOff + 48)

            local wx, wy, wz = px + ox, py + oy, pz + oz
            local pieceName = ReadCString(data, nameOff)

            if string.match(string.lower(pieceName), PIECE_PREFIX) then
                local vx, vy, vz = 0, 0, 0
                if numVertices > 0 and vertTableOff > 0 and vertTableOff + 12 <= #data then
                    -- Usa il primo vertice del pezzo (come fa GetPiecePosDir in Spring)
                    vx = ReadFloat32LE(data, vertTableOff + 0)
                    vy = ReadFloat32LE(data, vertTableOff + 4)
                    vz = ReadFloat32LE(data, vertTableOff + 8)
                end
                points[#points + 1] = {
                    name = pieceName,
                    x = wx + vx,
                    y = wy + vy,
                    z = wz + vz,
                }
            end

            if numChildren > 0 and childTableOff > 0 then
                for i = 0, numChildren - 1 do
                    local entryOff = childTableOff + i * 4
                    if entryOff + 4 <= #data then
                        local childOff = ReadUInt32LE(data, entryOff)
                        WalkPiece(childOff, wx, wy, wz, depth + 1)
                    end
                end
            end
        end

        local rootOff = ReadUInt32LE(data, 36)
        WalkPiece(rootOff, 0, 0, 0, 0)
    end

    if DEBUG then
        Spring.Echo("[SparksFX] S3O:", tostring(loadedPath), "punti wspark trovati:", #points)
        for _, pt in ipairs(points) do
            Spring.Echo(string.format("   -> %s: (%.2f, %.2f, %.2f)", pt.name, pt.x, pt.y, pt.z))
        end
    end

    s3oSparksCache[defID] = points
    return points
end

--------------------------------------------------------------------------------
-- Logica Gadget
--------------------------------------------------------------------------------
local function LocalToWorld(bx, by, bz, fx, fz, lx, ly, lz)
    local len = math.sqrt(fx * fx + fz * fz)
    if len > 0.0001 then
        fx, fz = fx / len, fz / len
    else
        fx, fz = 0, 1
    end
    local rx, rz = fz, -fx
    return bx + lx * rx + lz * fx, by + ly, bz + lx * rz + lz * fz
end

local function RemoveSparkingByIndex(i)
    local lastIdx = #sparkingList
    local removedID = sparkingList[i].id
    if i ~= lastIdx then
        local lastEntry = sparkingList[lastIdx]
        sparkingList[i] = lastEntry
        sparkingIndex[lastEntry.id] = i
    end
    sparkingList[lastIdx] = nil
    sparkingIndex[removedID] = nil
end

local function TryRegisterFeature(featureID)
    if sparkingIndex[featureID] then return end

    local defID = Spring.GetFeatureDefID(featureID)
    if not defID then return end

    local fDef = FeatureDefs[defID]
    if not fDef or not fDef.name then return end

    local fName = string.lower(fDef.name)
    if not TARGET_CORPSES[fName] then return end
    if SPARK_CHANCE < 1 and math.random() > SPARK_CHANCE then return end

    local points = ExtractS3OSparkPoints(defID, fDef)
    local idx = #sparkingList + 1
    sparkingList[idx] = {
        id        = featureID,
        points    = points,
        height    = Spring.GetFeatureHeight(featureID) or 30,
        nextFrame = Spring.GetGameFrame() + math.random(5, MAX_DELAY),
    }
    sparkingIndex[featureID] = idx
end

function gadget:Initialize()
    for _, featureID in ipairs(Spring.GetAllFeatures()) do
        TryRegisterFeature(featureID)
    end
end

function gadget:FeatureCreated(featureID, allyTeamID)
    TryRegisterFeature(featureID)
end

function gadget:FeatureDestroyed(featureID)
    local idx = sparkingIndex[featureID]
    if idx then
        RemoveSparkingByIndex(idx)
    end
end

function gadget:GameFrame(frame)
    for i = #sparkingList, 1, -1 do
        local data = sparkingList[i]
        local featureID = data.id

        if not Spring.ValidFeatureID(featureID) then
            RemoveSparkingByIndex(i)
        elseif frame >= data.nextFrame then
            local bx, by, bz = Spring.GetFeaturePosition(featureID)
            if bx then
                local px, py, pz
                local pts = data.points

                if pts and #pts > 0 then
                    local pt = pts[math.random(#pts)]
                    local fx, _, fz = Spring.GetFeatureDirection(featureID)
                    px, py, pz = LocalToWorld(bx, by, bz, fx or 0, fz or 1, pt.x, pt.y, pt.z)
                else
                    -- Fallback se nel .s3o non ci sono pezzi wspark*
                    px, py, pz = bx, by + data.height * 0.5, bz
                end

                local dx = (math.random() * 2 - 1) * 0.4
                local dy = 0.8 + math.random() * 0.2
                local dz = (math.random() * 2 - 1) * 0.4

                Spring.SpawnCEG(CEG_NAME, px, py, pz, dx, dy, dz, CEG_RADIUS, CEG_DAMAGE)
            end

            data.nextFrame = frame + math.random(MIN_DELAY, MAX_DELAY)
        end
    end
end