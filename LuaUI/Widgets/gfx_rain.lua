function widget:GetInfo()
  return {
    name      = "Rain (Smooth Transition)",
    desc      = "Pioggia con transizione fluida. Comandi: /rain, /weatheroff",
    author    = "Molix (Modificato)",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = -24,
    enabled   = true
  }
end

-- 01/01/2026 created this widget
-- 03/01/2026 added "startrain" and "stoprain" commands for mission (fade in-fade out rain)

--------------------------------------------------------------------------------
-- CONFIGURAZIONE
--------------------------------------------------------------------------------

local fadeDuration = 10.0 -- Durata del fade in secondi

local splashTex = LUAUI_DIRNAME.."Images/weather/rain_splash.png"
local rainKeywords = {'rain', 'tropical', 'swamp', 'wet', 'jungle', 'water', 'river', 'delta', 'marsh', 'island', 'lake'}

local intensityMin     = 0.3
local intensityMax     = 1.0
local cycleSpeed       = 0.0005

local particleMultiplier = 0.04 
local rainLineLength     = 35.0
local rainLineWidth      = 1.0
local rainColor          = {0.7, 0.7, 0.9, 0.35}

local showSplashes      = true
local splashSize        = 15.0   
local splashOpacity     = 0.45   
local splashDensity     = 0.1    
local splashMaxDistance = 3500.0 

--------------------------------------------------------------------------------
-- VARIABILI INTERNE
--------------------------------------------------------------------------------

local particleSteps = 15
local particleLists = {}; local splashLists = {}
local particleStep = 1

local enabled = false
local isFadingIn = false
local isFadingOut = false
local fadeStartTime = 0
local currentFadeProgress = 0.0

local currentIntensity = 0.5
local shader; local splashShader
local startTimer = Spring.GetTimer()
local currentMapname = Game.mapName:lower()

local uRainTime, uRainCam, uRainScale, uRainWind, uRainLen
local uSplashTime, uSplashTarget, uSplashScale, uSplashSize, uSplashGroundY

--------------------------------------------------------------------------------
-- SHADERS
--------------------------------------------------------------------------------

local vertexRain = [[
	uniform float time; uniform float scale; uniform float lineLength; uniform vec3 wind; uniform vec3 camPos;
	void main(void) {
		vec3 basePos = gl_Vertex.xyz * scale;
		basePos.y -= time * 700.0;
		vec3 wrappedPos = mod(basePos - camPos, scale) - (scale * 0.5) + camPos;
		vec3 finalPos = wrappedPos;
		if (gl_Vertex.w > 0.5) { finalPos.y += lineLength; finalPos.xz -= wind.xz * 0.0; }
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
		finalPos.x += offset.x; finalPos.z += offset.y; finalPos.y = groundY + 3.0; 
		gl_TexCoord[0] = gl_MultiTexCoord0;
		gl_FrontColor = vec4(gl_Color.rgb, gl_Color.a * (1.0 - phase));
		gl_Position = gl_ModelViewProjectionMatrix * vec4(finalPos, 1.0);
	}
]]

--------------------------------------------------------------------------------
-- CORE
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
	if not shader or not splashShader then return end

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
				for i = 1, math.floor(count * splashDensity) do
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
-- UPDATE (Logica Fade)
--------------------------------------------------------------------------------

function widget:Update()
	if not enabled then return end
    
    local now = Spring.GetTimer()
	local frame = Spring.GetGameFrame()
    
    if isFadingIn then
        local elapsed = Spring.DiffTimers(now, fadeStartTime)
        currentFadeProgress = math.min(1.0, elapsed / fadeDuration)
        if currentFadeProgress >= 1.0 then isFadingIn = false end
    elseif isFadingOut then
        local elapsed = Spring.DiffTimers(now, fadeStartTime)
        currentFadeProgress = math.max(0.0, 1.0 - (elapsed / fadeDuration))
        if currentFadeProgress <= 0.0 then 
            isFadingOut = false
            enabled = false
            removeRain()
            return
        end
    else
        currentFadeProgress = 1.0
    end

	local timeFactor = (math.sin(frame * cycleSpeed) + 1) / 2
	currentIntensity = (intensityMin + (intensityMax - intensityMin) * timeFactor) * currentFadeProgress
	particleStep = math.max(1, math.min(particleSteps, math.floor(particleSteps * currentIntensity)))
end

--------------------------------------------------------------------------------
-- DRAW
--------------------------------------------------------------------------------

function widget:DrawWorld()
	if not enabled or not shader or not particleLists[particleStep] then return end
    if currentFadeProgress < 0.01 then return end
	
	local vsx, vsy = gl.GetViewSizes()
	local camX, camY, camZ = Spring.GetCameraPosition()
	local _, pos = Spring.TraceScreenRay(vsx / 2, vsy / 2, true)
	local tx, ty, tz = (pos and pos[1]) or camX, (pos and pos[2]) or 0, (pos and pos[3]) or camZ

	local dx, dy, dz = camX - tx, camY - ty, camZ - tz
	local distance = math.sqrt(dx*dx + dy*dy + dz*dz)
	local groundY = Spring.GetGroundHeight(tx, tz) or 0
	local diffTime = Spring.DiffTimers(Spring.GetTimer(), startTimer)
	local windX, windY, windZ = Spring.GetWind()

	gl.DepthTest(true); gl.Blending(GL.SRC_ALPHA, GL.ONE)
	
	-- Pioggia
	gl.UseShader(shader); gl.LineWidth(rainLineWidth)
	gl.Uniform(uRainTime, diffTime); gl.Uniform(uRainCam, camX, camY, camZ)
	gl.Uniform(uRainScale, 4500.0); gl.Uniform(uRainWind, windX, windY, windZ); gl.Uniform(uRainLen, rainLineLength)
	gl.Color(rainColor[1], rainColor[2], rainColor[3], rainColor[4] * currentFadeProgress)
	gl.CallList(particleLists[particleStep]); gl.UseShader(0)
	
	-- Splash
	if showSplashes and distance < splashMaxDistance then
		local distanceAlpha = math.max(0, 1.0 - (distance / splashMaxDistance))
		gl.Texture(splashTex); gl.UseShader(splashShader)
		gl.Uniform(uSplashTime, diffTime); gl.Uniform(uSplashTarget, tx, ty, tz)
		gl.Uniform(uSplashScale, 2800.0); gl.Uniform(uSplashSize, splashSize); gl.Uniform(uSplashGroundY, groundY)
		gl.Color(rainColor[1], rainColor[2], rainColor[3], splashOpacity * distanceAlpha * currentFadeProgress)
		gl.CallList(splashLists[particleStep]); gl.Texture(false); gl.UseShader(0)
	end
	gl.ResetState()
end

--------------------------------------------------------------------------------
-- COMANDI
--------------------------------------------------------------------------------

function widget:Initialize()
	local found = false
	for _, keyword in pairs(rainKeywords) do
		if string.find(currentMapname, keyword) then found = true; break end
	end
	if found then 
        enabled = true; isFadingIn = true; fadeStartTime = Spring.GetTimer(); currentFadeProgress = 0.0; init() 
    end
end

function widget:Shutdown() removeRain() end

function widget:TextCommand(command)
    -- Gestione /stoprain (Spegne con fade-out se acceso)
    if (command:find("stoprain") == 1) then
        if enabled and not isFadingOut then
            isFadingIn = false
            isFadingOut = true
            fadeStartTime = Spring.GetTimer()
        end
        return false -- false permette ad altri widget (Rainstorm) di leggere lo stesso comando
    end

    -- Gestione /startrain (Toggle con fade)
    if (command:find("startrain") == 1) then 
		if not enabled then
            enabled = true; isFadingIn = true; isFadingOut = false
            fadeStartTime = Spring.GetTimer(); currentFadeProgress = 0.0; init()
        else
            isFadingIn = false; isFadingOut = true; fadeStartTime = Spring.GetTimer()
        end
        return true
	end
    return false
end