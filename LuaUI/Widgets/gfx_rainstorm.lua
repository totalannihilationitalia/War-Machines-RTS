function widget:GetInfo()
  return {
    name      = "RainStorm",
    desc      = "Rain and thunder",
    author    = "Molix",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = -24,
    enabled   = true
  }
end

-- 01/01/2026 created this widget
-- 02/01/2026 add fade in and fadeout, command /stopstorm (fadeout) and /startstorm (start with fadein) -- for missions

-- to do --
-- 1) linkare le variabili a gamnerules cosi da modificarle da mission editor

--------------------------------------------------------------------------------
-- CONFIGURAZIONE
--------------------------------------------------------------------------------

local targetMaps = { 
	'Throne', 
	'Throne_v2',
	'Small_Divide_V2' -- ad esempio
}

local fadeDuration = 12.0  -- Secondi per le transizioni (in e out)

local thunderSounds = {
	LUAUI_DIRNAME.."Sounds/thunder1.wav",
	LUAUI_DIRNAME.."Sounds/thunder2.wav",
	LUAUI_DIRNAME.."Sounds/thunder3.wav",
}

-- Searchlights (Fari unità)
local useSearchlights        = true
local searchlightStrength     = 0.05
local searchlightBeamColor    = {1, 1, 0.8, 0.02} 
local searchlightHeightOffset  = 1.2
local searchlightVertexCount   = 16
local searchlightGroundLead    = 1.2
local RADIANS_PER_COBANGLE     = math.pi / 32768

-- Splash (Cerchi a terra)
local showSplashes           = true
local splashTex             = LUAUI_DIRNAME.."Images/weather/rain_splash.png"
local splashSize             = 15.0
local splashMaxDistance      = 3500.0 

-- Ciclo Meteo e Oscuramento
local darknessAtMinRain = 1.50   
local darknessAtMaxRain = 0.82  
local intensityMin      = 0.2    
local intensityMax      = 1.0
local cycleSpeed        = 0.0005 
local stormColor        = {0.4, 0.4, 0.5}

-- Fulmini
local lightningChance  = 0.0005  
local lightningFlash   = 0      
local flashFadeSpeed   = 0.12   

-- Aspetto Pioggia
local particleMultiplier = 0.045 
local rainLineLength     = 35.0
local rainLineWidth      = 1.0
local rainColor          = {0.7, 0.7, 0.9, 0.3}

--------------------------------------------------------------------------------
-- VARIABILI INTERNE
--------------------------------------------------------------------------------

local searchlightVertexIncrement = (math.pi * 2) / searchlightVertexCount
local shader, splashShader
local particleSteps = 15
local particleLists = {}; local splashLists = {}
local particleStep = 1

local active = false 
local isFadingIn = false
local isFadingOut = false
local fadeStartTime = 0
local currentFadeProgress = 0.0

local currentIntensity = 0.0
local dynamicDarkness  = 1.0
local startTimer = Spring.GetTimer()

local uRainTime, uRainCam, uRainScale, uRainWind, uRainLen
local uSplashTime, uSplashTarget, uSplashScale, uSplashSize, uSplashGroundY

--------------------------------------------------------------------------------
-- GEOMETRIA FARI
--------------------------------------------------------------------------------

local function BaseVertices(baseX, baseZ, radius, ecc, heading)
	local theta = heading
	while theta < heading + 2 * math.pi do
		local denom = (1 - ecc * math.cos(theta - heading))
		local vx = baseX + radius * math.cos(theta) / denom
		local vz = baseZ + radius * math.sin(theta) / denom
		local vy = (Spring.GetGroundHeight(vx, vz) or 0) + 2.0
		gl.Vertex(vx, vy, vz)
		theta = theta + searchlightVertexIncrement * denom 
	end
	gl.Vertex(baseX + radius * math.cos(heading) / (1 - ecc), (Spring.GetGroundHeight(baseX, baseZ) or 0) + 2.0, baseZ + radius * math.sin(heading) / (1 - ecc))
end

local function BeamVertices(baseX, baseZ, radius, ecc, heading, px, py, pz)
	gl.Vertex(px, py, pz)
	BaseVertices(baseX, baseZ, radius, ecc, heading)
end

--------------------------------------------------------------------------------
-- SHADERS
--------------------------------------------------------------------------------

local vertexRain = [[
	uniform float time; uniform float scale; uniform float lineLength; uniform vec3 wind; uniform vec3 camPos;
	void main(void) {
		vec3 basePos = gl_Vertex.xyz * scale;
		basePos.y -= time * 750.0;
		vec3 wrappedPos = mod(basePos - camPos, scale) - (scale * 0.5) + camPos;
		vec3 finalPos = wrappedPos;
		if (gl_Vertex.w > 0.5) { finalPos.y += lineLength; finalPos.xz -= wind.xz * 0.2; }
		gl_FrontColor = gl_Color;
		gl_Position = gl_ModelViewProjectionMatrix * vec4(finalPos, 1.0);
	}
]]

local vertexSplash = [[
	uniform float time; uniform float scale; uniform float sSize; uniform float groundY; uniform vec3 targetPos;
	void main(void) {
		float phase = mod(time * 2.5 + (gl_Vertex.x * 20.0), 1.0);
		float currentSize = phase * sSize;
		vec3 basePos = gl_Vertex.xyz * scale;
		vec3 wrappedPos = mod(basePos - targetPos, scale) - (scale * 0.5) + targetPos;
		vec2 offset = (gl_MultiTexCoord0.xy - 0.5) * currentSize;
		vec3 finalPos = wrappedPos;
		finalPos.x += offset.x; finalPos.z += offset.y; finalPos.y = groundY + 2.0;
		gl_TexCoord[0] = gl_MultiTexCoord0;
		gl_FrontColor = vec4(gl_Color.rgb, gl_Color.a * (1.0 - phase));
		gl_Position = gl_ModelViewProjectionMatrix * vec4(finalPos, 1.0);
	}
]]

--------------------------------------------------------------------------------
-- CORE FUNCTIONS
--------------------------------------------------------------------------------

function removeRain()
	if shader then gl.DeleteShader(shader) end
	if splashShader then gl.DeleteShader(splashShader) end
	for i=1, #particleLists do gl.DeleteList(particleLists[i]) end
	for i=1, #splashLists do gl.DeleteList(splashLists[i]) end
	particleLists = {}; splashLists = {}
    shader = nil; splashShader = nil
end

function init()
    if shader then return end
	if not gl.CreateShader then return end
    shader = gl.CreateShader({ vertex = vertexRain })
	splashShader = gl.CreateShader({ vertex = vertexSplash })
	uRainTime = gl.GetUniformLocation(shader, 'time'); uRainCam = gl.GetUniformLocation(shader, 'camPos')
	uRainScale = gl.GetUniformLocation(shader, 'scale'); uRainWind = gl.GetUniformLocation(shader, 'wind')
	uRainLen = gl.GetUniformLocation(shader, 'lineLength')
	uSplashTime = gl.GetUniformLocation(splashShader, 'time'); uSplashTarget = gl.GetUniformLocation(splashShader, 'targetPos')
	uSplashScale = gl.GetUniformLocation(splashShader, 'scale'); uSplashSize = gl.GetUniformLocation(splashShader, 'sSize')
	uSplashGroundY = gl.GetUniformLocation(splashShader, 'groundY')
	local vsx, vsy = gl.GetViewSizes()
	local countMax = math.floor((vsx * vsy) * particleMultiplier)
	for step=1, particleSteps do
		local count = math.floor((countMax / particleSteps) * step)
		particleLists[step] = gl.CreateList(function()
			gl.BeginEnd(GL.LINES, function()
				for i = 1, count do
					local x, y, z = math.random(), math.random(), math.random()
					gl.Vertex(x, y, z, 0); gl.Vertex(x, y, z, 1)
				end
			end)
		end)
		splashLists[step] = gl.CreateList(function()
			gl.BeginEnd(GL.QUADS, function()
				for i = 1, math.floor(count * 0.3) do
					local x, z, s = math.random(), math.random(), math.random()
					gl.TexCoord(0,0); gl.Vertex(s, 0, z, 0)
					gl.TexCoord(1,0); gl.Vertex(s, 0, z, 0)
					gl.TexCoord(1,1); gl.Vertex(s, 0, z, 0)
					gl.TexCoord(0,1); gl.Vertex(s, 0, z, 0)
				end
			end)
		end)
	end
end

--------------------------------------------------------------------------------
-- UPDATE (LOGICA FADE IN / OUT)
--------------------------------------------------------------------------------

function widget:Update()
	if not active then return end
    local now = Spring.GetTimer()
	local frame = Spring.GetGameFrame()
    
    -- 1. Gestione Fade Progressivo
    if isFadingIn then
        local elapsed = Spring.DiffTimers(now, fadeStartTime)
        currentFadeProgress = math.min(1.0, elapsed / fadeDuration)
        if currentFadeProgress >= 1.0 then isFadingIn = false end
    elseif isFadingOut then
        local elapsed = Spring.DiffTimers(now, fadeStartTime)
        currentFadeProgress = math.max(0.0, 1.0 - (elapsed / fadeDuration))
        if currentFadeProgress <= 0.0 then 
            isFadingOut = false
            active = false
            removeRain()
            return
        end
    else
        currentFadeProgress = 1.0
    end

    -- 2. Intensità Pioggia
	local timeFactor = (math.sin(frame * cycleSpeed) + 1) / 2
	local targetInt = intensityMin + (intensityMax - intensityMin) * timeFactor
	currentIntensity = targetInt * currentFadeProgress
	particleStep = math.max(1, math.min(particleSteps, math.floor(particleSteps * currentIntensity)))
	
    -- 3. Oscuramento
	dynamicDarkness = darknessAtMinRain + (darknessAtMaxRain - darknessAtMinRain) * ((targetInt - intensityMin) / (intensityMax - intensityMin))

	-- 4. Fulmini (disabilitati se stiamo svanendo oltre metà)
	if lightningFlash > 0 then 
        lightningFlash = lightningFlash - flashFadeSpeed
	elseif currentFadeProgress > 0.8 and not isFadingOut then
		if math.random() < (lightningChance * currentIntensity) then
			lightningFlash = 1.3 
			if #thunderSounds > 0 then Spring.PlaySoundFile(thunderSounds[math.random(#thunderSounds)], 1.0) end
		end
	end
end

--------------------------------------------------------------------------------
-- DISEGNO
--------------------------------------------------------------------------------

local function DrawSearchlights(r, g, b)
    if currentFadeProgress < 0.2 then return end

	local currColorInverse = { (1 / r - 1) * searchlightStrength, (1 / g - 1) * searchlightStrength, (1 / b - 1) * searchlightStrength, 1.0 }
	local visibleUnits = Spring.GetVisibleUnits(-1, 30, false)
	for _, unitID in pairs(visibleUnits) do
		local px, py, pz = Spring.GetUnitPosition(unitID)
		if py then
			local ud = UnitDefs[Spring.GetUnitDefID(unitID)]
			if ud and ud.speed > 0 then
				local radius = Spring.GetUnitRadius(unitID)
				local heading = -1 * (Spring.GetUnitHeading(unitID) or 0) * RADIANS_PER_COBANGLE + math.pi / 2
				local leadDistance = searchlightGroundLead * ud.speed * 0.4 + (radius * 1.5)
				local absHeight = py - (Spring.GetGroundHeight(px, pz) or 0)
				local baseX = px + leadDistance * math.cos(heading)
				local baseZ = pz + leadDistance * math.sin(heading)
				local ecc = math.min(1 - 2 / (leadDistance / (absHeight + 1) + 2), 0.75)
				gl.DepthTest(true)
                gl.Blending(GL.SRC_ALPHA, GL.ONE)
                gl.Color(searchlightBeamColor[1], searchlightBeamColor[2], searchlightBeamColor[3], searchlightBeamColor[4] * currentFadeProgress)
				gl.BeginEnd(GL.TRIANGLE_FAN, BeamVertices, baseX, baseZ, radius * 1.2, ecc, heading, px, py + (radius * searchlightHeightOffset), pz)
				gl.Blending(GL.DST_COLOR, GL.ONE); gl.Color(currColorInverse)
				gl.BeginEnd(GL.TRIANGLE_FAN, BaseVertices, baseX, baseZ, radius * 1.6, ecc, heading)
			end
		end
	end
end

local function DrawDarkness()
    if currentFadeProgress < 0.001 and lightningFlash <= 0 then return {1,1,1} end
    local targetR = stormColor[1] * dynamicDarkness
    local targetG = stormColor[2] * dynamicDarkness
    local targetB = stormColor[3] * dynamicDarkness
    local r = 1.0 + (targetR - 1.0) * currentFadeProgress + lightningFlash
    local g = 1.0 + (targetG - 1.0) * currentFadeProgress + lightningFlash
    local b = 1.0 + (targetB - 1.0) * currentFadeProgress + lightningFlash
    r = math.max(0, math.min(1.0, r)); g = math.max(0, math.min(1.0, g)); b = math.max(0, math.min(1.0, b))
	gl.Blending(GL.ZERO, GL.SRC_COLOR)
	gl.MatrixMode(GL.PROJECTION); gl.PushMatrix(); gl.LoadIdentity()
	gl.MatrixMode(GL.MODELVIEW); gl.PushMatrix(); gl.LoadIdentity()
	gl.Color(r, g, b, 1); gl.Rect(-1, 1, 1, -1)
	gl.MatrixMode(GL.PROJECTION); gl.PopMatrix(); gl.MatrixMode(GL.MODELVIEW); gl.PopMatrix()
	gl.Color(1, 1, 1, 1); gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    return {r, g, b}
end

function widget:DrawWorld()
	if not active or not shader or not particleLists[particleStep] then return end
    local vsx, vsy = gl.GetViewSizes(); local camX, camY, camZ = Spring.GetCameraPosition()
	local _, pos = Spring.TraceScreenRay(vsx / 2, vsy / 2, true)
	local tx, ty, tz = (pos and pos[1]) or camX, (pos and pos[2]) or 0, (pos and pos[3]) or camZ
	local dx, dy, dz = camX - tx, camY - ty, camZ - tz; local distance = math.sqrt(dx*dx + dy*dy + dz*dz)
	local splashAlpha = math.max(0, 1.0 - (distance / splashMaxDistance)); local windX, windY, windZ = Spring.GetWind()
	gl.DepthTest(true); gl.Blending(GL.SRC_ALPHA, GL.ONE); gl.UseShader(shader); gl.LineWidth(rainLineWidth)
	gl.Uniform(uRainTime, Spring.DiffTimers(Spring.GetTimer(), startTimer)); gl.Uniform(uRainCam, camX, camY, camZ)
	gl.Uniform(uRainScale, 4500.0); gl.Uniform(uRainWind, windX, windY, windZ); gl.Uniform(uRainLen, rainLineLength)
	gl.Color(rainColor[1], rainColor[2], rainColor[3], rainColor[4] * currentFadeProgress) 
    gl.CallList(particleLists[particleStep]); gl.UseShader(0)
	if showSplashes and splashAlpha > 0.1 then
		gl.Texture(splashTex); gl.UseShader(splashShader); gl.Uniform(uSplashTime, Spring.DiffTimers(Spring.GetTimer(), startTimer))
		gl.Uniform(uSplashTarget, tx, ty, tz); gl.Uniform(uSplashScale, 2800.0); gl.Uniform(uSplashSize, splashSize); gl.Uniform(uSplashGroundY, Spring.GetGroundHeight(tx, tz) or 0)
		gl.Color(rainColor[1], rainColor[2], rainColor[3], 0.4 * splashAlpha * currentFadeProgress)
		gl.CallList(splashLists[particleStep]); gl.Texture(false); gl.UseShader(0)
	end
	gl.ResetState()
	local currentAmbient = DrawDarkness()
	if useSearchlights then DrawSearchlights(currentAmbient[1], currentAmbient[2], currentAmbient[3]) end
end

--------------------------------------------------------------------------------
-- GESTIONE COMANDI
--------------------------------------------------------------------------------

function widget:Initialize()
    local currentMap = Game.mapName
    for _, mapName in pairs(targetMaps) do
        if currentMap == mapName then
            active = true; isFadingIn = true; fadeStartTime = Spring.GetTimer(); currentFadeProgress = 0.0; init(); break
        end
    end
end

function widget:Shutdown() removeRain() end

function widget:TextCommand(command)
    -- Comando /stopstorm (Sempre Fade-out)
    if (command:find("stopstorm") == 1) then
        if active and not isFadingOut then
            isFadingIn = false
            isFadingOut = true
            fadeStartTime = Spring.GetTimer()
            Spring.Echo("Rainstorm Pro: Inizio Fade-out (Spegnimento)...")
        end
        return true
    end

    -- Comando /startstorm (Toggle con Fade)
    if (command:find("startstorm") == 1) then 
		if not active then
            active = true
            isFadingIn = true
            isFadingOut = false
            fadeStartTime = Spring.GetTimer()
            currentFadeProgress = 0.0
            init()
            Spring.Echo("Rainstorm Pro: ON (Fade-in)")
        else
            isFadingIn = false
            isFadingOut = true
            fadeStartTime = Spring.GetTimer()
            Spring.Echo("Rainstorm Pro: OFF (Fade-out)")
        end
        return true
	end
    return false
end