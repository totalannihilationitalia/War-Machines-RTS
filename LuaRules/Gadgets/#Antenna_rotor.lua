function gadget:GetInfo()
    return {
        name      = "Rotating Antenna Feature",
        desc      = "Fa ruotare il rotore dell'antenna e lo elimina se la base viene distrutta",
        author    = "Molixx",
        date      = "2026",
        license   = "GPL v2+",
        layer     = 0,
        enabled   = true,
    }
end

-- ############################################## SPOSTARE IN GADGET MAPPA!!!!!!!!!!!!!!!!!!!!!!!!!! #############################################################

if not gadgetHandler:IsSyncedCode() then
    return
end

local BASE_DEF_NAME  = "Station_one_antenna_featdyn_base"
local ROTOR_DEF_NAME = "Station_one_antenna_featdyn_rot"

local ROTATION_SPEED = 0.02     -- radianti per gameframe (30 frame = 1 sec)
local LINK_RADIUS_SQ = 32 * 32  -- raggio massimo (32 elmo) per associare base e rotore

local TWO_PI = math.pi * 2

local baseDefID  = nil
local rotorDefID = nil

local basePositions    = {} -- [baseFeatureID] = { x = number, z = number }
local rotatingFeatures = {} -- [rotorFeatureID] = { angle = number, speed = number }

local spGetAllFeatures      = Spring.GetAllFeatures
local spGetFeatureDefID     = Spring.GetFeatureDefID
local spGetFeaturePosition  = Spring.GetFeaturePosition
local spGetFeatureDirection = Spring.GetFeatureDirection
local spSetFeatureDirection = Spring.SetFeatureDirection
local spDestroyFeature      = Spring.DestroyFeature
local spValidFeatureID      = Spring.ValidFeatureID
local sin, cos, atan2       = math.sin, math.cos, math.atan2

local function ResolveFeatureDefID(name)
    local fDef = FeatureDefNames[name] or FeatureDefNames[string.lower(name)]
    return fDef and fDef.id or nil
end

local function RegisterFeature(featureID)
    local defID = spGetFeatureDefID(featureID)
    if not defID then
        return
    end

    if defID == rotorDefID then
        local dx, _, dz = spGetFeatureDirection(featureID)
        local startAngle = (dx and dz) and atan2(dx, dz) or 0
        rotatingFeatures[featureID] = {
            angle = startAngle,
            speed = ROTATION_SPEED,
        }
    elseif defID == baseDefID then
        local x, _, z = spGetFeaturePosition(featureID)
        if x and z then
            basePositions[featureID] = { x = x, z = z }
        end
    end
end

function gadget:Initialize()
    baseDefID  = ResolveFeatureDefID(BASE_DEF_NAME)
    rotorDefID = ResolveFeatureDefID(ROTOR_DEF_NAME)

    if not baseDefID or not rotorDefID then
        Spring.Echo("[Rotating Antenna] Errore: FeatureDef non trovata ->", BASE_DEF_NAME, baseDefID, ROTOR_DEF_NAME, rotorDefID)
        return
    end

    for _, featureID in ipairs(spGetAllFeatures()) do
        RegisterFeature(featureID)
    end
end

function gadget:FeatureCreated(featureID)
    RegisterFeature(featureID)
end

function gadget:FeatureDestroyed(featureID)
    -- Se è stato distrutto un rotore, lo rimuoviamo dalla lista di rotazione
    rotatingFeatures[featureID] = nil

    -- Se è stata distrutta una base, cerchiamo ed eliminiamo il rotore sopra di essa
    local pos = basePositions[featureID]
    if pos then
        basePositions[featureID] = nil

        local toDestroy = {}
        for rotorID in pairs(rotatingFeatures) do
            if spValidFeatureID(rotorID) then
                local rx, _, rz = spGetFeaturePosition(rotorID)
                if rx and rz then
                    local dx = rx - pos.x
                    local dz = rz - pos.z
                    if (dx * dx + dz * dz) <= LINK_RADIUS_SQ then
                        toDestroy[#toDestroy + 1] = rotorID
                    end
                end
            end
        end

        for i = 1, #toDestroy do
            spDestroyFeature(toDestroy[i])
        end
    end
end

function gadget:GameFrame()
    for featureID, data in pairs(rotatingFeatures) do
        if spValidFeatureID(featureID) then
            data.angle = (data.angle + data.speed) % TWO_PI
            spSetFeatureDirection(featureID, sin(data.angle), 0, cos(data.angle))
        else
            rotatingFeatures[featureID] = nil
        end
    end
end