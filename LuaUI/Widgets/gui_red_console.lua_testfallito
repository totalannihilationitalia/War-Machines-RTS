function widget:GetInfo()
	return {
	name      = "Red Console",
	desc      = "Requires Red UI Framework (Optimized for Spring 100)",
	author    = "Regret",
	date      = "2024 - War Machines RTS Edit",
	license   = "GNU GPL, v2 or later",
	layer     = 0,
	enabled   = true,
	handler   = true,
	}
end

local NeededFrameworkVersion = 8
local CanvasX,CanvasY = 1280,734 
local SoundIncomingChat  = 'sounds/beep4.wav'
local SoundIncomingChatVolume = 1.0

local gameOver = false
local isChatting = false -- Stato per Spring 100

local clock = os.clock
local slen = string.len
local ssub = string.sub
local sfind = string.find
local sformat = string.format
local schar = string.char
local sreverse = string.reverse
local glGetTextWidth = gl.GetTextWidth
local sGetPlayerRoster = Spring.GetPlayerRoster
local sGetTeamColor = Spring.GetTeamColor
local sGetMyAllyTeamID = Spring.GetMyAllyTeamID
local sGetModKeyState = Spring.GetModKeyState
local spPlaySoundFile = Spring.PlaySoundFile

local Config = {
	console = {
		px = 10, py = 25,
		sx = 516,
		ancora_x = 10,
		ancora_y = 450,
		fontsize = 10,
		minlines = 1,
		maxlines = 5,
		maxlinesScrollmode = 15,
		maxage = 10,
		margin = 6,
		fadetime = 0.5,
		fadedistance = 100,
		filterduplicates = true,
		cothertext = {1,1,1,1},
		callytext = {0,1,0,1},
		cspectext = {1,1,0,1},
		cotherallytext = {1,0.5,0.5,1},
		cmisctext = {0.78,0.78,0.78,1},
		cgametext = {0.4,1,1,1},
		cbackground = {0.03,0.18,0.3,0.5},
		cborder = {0,0.67,0.99,1},
		dragbutton = {2},
		-- Input bar config
		input_sx = 500,
		input_sy = 25,
		input_offset_y = 5,
		cinput_back = {0.03,0.18,0.3,0.8},
		cinput_border = {0,0.67,0.99,1},
		tooltip = {
			background ="In CTRL+F11 mode:  Hold middle mouse to drag.\n- CTRL + wheel to scroll history.",
		},
	},
}

local function IncludeRedUIFrameworkFunctions()
	New = WG.Red.New(widget)
	Copy = WG.Red.Copytable
	SetTooltip = WG.Red.SetTooltip
	GetSetTooltip = WG.Red.GetSetTooltip
	Screen = WG.Red.Screen
	GetWidgetObjects = WG.Red.GetWidgetObjects
end

local function RedUIchecks()
	if (type(WG.Red)~="table") or (WG.Red.Version < NeededFrameworkVersion) then
		widgetHandler:ToggleWidget(widget:GetInfo().name)
		return false
	end
	IncludeRedUIFrameworkFunctions()
	return true
end

-- FUNZIONE DI RESIZE FISSO (War Machines RTS Version)
local function AutoResizeObjects()
	if (LastAutoResizeX==nil) then
		LastAutoResizeX = CanvasX
		LastAutoResizeY = CanvasY
	end
	local vsx,vsy = widgetHandler:GetViewSizes()
	
	if ((LastAutoResizeX ~= vsx) or (LastAutoResizeY ~= vsy)) then
		local objects = GetWidgetObjects(widget)
		local isSlave = {}
		for i=1,#objects do
			local o = objects[i]
			if (o.movableslaves) then
				for j=1,#o.movableslaves do isSlave[o.movableslaves[j]] = true end
			end
		end

		for i=1,#objects do
			local o = objects[i]
			if not isSlave[o] then
				local oldPx, oldPy = o.px, o.py
				if (o.ancora_x) then o.px = math.floor(o.ancora_x + 0.5) end
				if (o.ancora_y) then o.py = math.floor(vsy - o.ancora_y + 0.5) end

				if (o.movableslaves) then
					local dx = o.px - oldPx
					local dy = o.py - oldPy
					for j=1,#o.movableslaves do
						local s = o.movableslaves[j]
						if (s.px) then s.px = math.floor(s.px + dx + 0.5) end
						if (s.py) then s.py = math.floor(s.py + dy + 0.5) end
					end
				end
			end
		end
		LastAutoResizeX,LastAutoResizeY = vsx,vsy
	end
end

local function createconsole(r)
	local vars = {}
	
	local lines = {"text",
		px=r.px+r.margin,py=r.py+r.margin,
		fontsize=r.fontsize,
		caption="",
		options="o",
	}
	
	local activationarea = {"area",
		px=r.px-r.fadedistance,py=r.py-r.fadedistance,
		sx=r.sx+r.fadedistance*2,sy=0,
		mousewheel=function(up,mx,my,self)
			if (vars.browsinghistory) then
				local shift = Spring.GetModKeyState()
				local step = shift and 5 or 1
				if (vars.historyoffset == nil) then vars.historyoffset = 0 end
				vars.historyoffset = up and (vars.historyoffset + step) or (vars.historyoffset - step)
				if (vars.historyoffset > (#vars.consolehistory - r.maxlines)) then vars.historyoffset = #vars.consolehistory - r.maxlines end
				if (vars.historyoffset < 0) then vars.historyoffset = 0 end
				vars._forceupdate = true
			end
		end,
	}

	-- INPUT BG
	local input_bg = {"rectangle",
		px = r.px, py = r.py,
		sx = r.input_sx, sy = r.input_sy,
		color = r.cinput_back,
		border = r.cinput_border,
		active = false,
	}

	-- BACKGROUND PRINCIPALE
	local background = {"rectangle",
		px=r.px,py=r.py,
		sx=r.sx,sy=r.maxlines*r.fontsize+r.margin*2,
		color=r.cbackground,
		border=r.cborder,
		movable=r.dragbutton,
		obeyscreenedge = true,
		ancora_x = r.ancora_x,
		ancora_y = r.ancora_y,		
		movableslaves={lines, activationarea, input_bg},
		
onupdate = function(self)
			if isChatting then
				input_bg.active = nil 
				input_bg.px = self.px
				input_bg.py = math.floor(self.py + self.sy + r.input_offset_y + 0.5)
				
				local vsx, vsy = widgetHandler:GetViewSizes()
				
				-- PARAMETRI CALCOLATI
				local posX = (input_bg.px + 10) / vsx  -- Prova a mettere +50 per vedere se si sposta
				local posY = (vsy - input_bg.py - input_bg.sy + (r.input_sy * 0.35)) / vsy
				local fontSize = (r.input_sy * 0.60) / vsy
				
				-- ASPECT RATIO (Fondamentale per Spring 100)
				-- Calcola quanto è larga la casella rispetto a quanto è alto il testo
				local aspect = (r.input_sx * 0.9) / (r.input_sy * 0.60)
				
				-- Invia il comando
				Spring.SendCommands(string.format('inputtextgeo %.4f %.4f %.4f %.4f', 
					posX, posY, fontSize, aspect))
			else
				input_bg.active = false
				-- Non inviare comandi continuamente se la chat è chiusa
			end
		end,
	}

	activationarea.onupdate=function(self)
		local fadedistance = (self.sx-background.sx)/2
		self.sy = background.sy+fadedistance*2
		self.px = background.px-fadedistance
		self.py = background.py-fadedistance
		if (not self._mousenotover) then
			background.active = nil
			local _,ctrl = Spring.GetModKeyState()
			if (ctrl and not vars.browsinghistory) then
				vars._forceupdate = true
				vars.nextupdate = -1
				vars.browsinghistory = true
				vars.historyoffset = 0
				self.overridewheel = true
				vars._skipagecheck = true
				vars._usecounters = false
			end
		else
			if (vars._skipagecheck ~= nil) then
				vars._forceupdate = true
				vars.browsinghistory = nil
				self.overridewheel = nil
				vars._skipagecheck = nil
				vars._usecounters = nil
			end
		end
		self._mousenotover = nil
	end
	activationarea.mousenotover=function(mx,my,self) self._mousenotover = true end

	New(activationarea)
	New(background)
	New(lines)
	New(input_bg)
	
	local counters = {}
	for i=1,r.maxlines do
		local b = New(lines)
		b.onupdate = function(self) self.px = background.px - self.getwidth() - (lines.px-background.px) end
		b.active = false
		b.py = b.py+(i-1)*r.fontsize
		counters[#counters+1] = b
		table.insert(background.movableslaves,b)
	end
	
	background.mouseover = function(mx,my,self) SetTooltip(r.tooltip.background) end
	background.active = nil
	
	return { ["background"] = background, ["lines"] = lines, ["counters"] = counters, ["vars"] = vars }
end

-- [FUNZIONI DI LOGICA CHAT ORIGINALI MANTENUTE]
local function lineColour(prevline)
	local prevlineReverse = sreverse(prevline)
	local newlinecolour = ""
	local colourCodePosReverse = sfind(prevlineReverse, "\255")
	if colourCodePosReverse then
		local colourCodePos = slen(prevline) - colourCodePosReverse + 1 	
		if slen(ssub(prevline, colourCodePos)) >= 4 then newlinecolour = ssub(prevline, colourCodePos, colourCodePos+3) end
	end	
	return newlinecolour
end

local function clipLine(line,fontsize,maxwidth)
	local clipped = {}
	local firstclip = line:len()
	local firstpass = true
	while (1) do
		local linelen = slen(line)
		local i=1
		while (1) do
			if (glGetTextWidth(ssub(line,1,i+1))*fontsize > maxwidth) then
				local newlinecolour = firstpass==nil and lineColour(clipped[#clipped]) or ""
				clipped[#clipped+1] = newlinecolour .. ssub(line,1,i)
				line = ssub(line,i+1)
				if (firstpass) then firstclip = i; firstpass = nil end
				break
			end
			i=i+1
			if (i > linelen) then break end
		end
		if (glGetTextWidth(line)*fontsize <= maxwidth) then break end
	end
	local newlinecolour = #clipped > 0 and lineColour(clipped[#clipped]) or ""
	clipped[#clipped+1] = newlinecolour .. line
	return clipped,firstclip
end

local function clipHistory(g,oneline)
	local history = g.vars.consolehistory
	local maxsize = g.background.sx - (g.lines.px-g.background.px)
	local fontsize = g.lines.fontsize
	if (oneline) then
		local line = history[#history]
		local lines,firstclip = clipLine(line[1],fontsize,maxsize)	
		line[1] = ssub(line[1],1,firstclip)
		for i=2,#lines do history[#history+1] = {line[4]..lines[i],line[2],line[3],line[4],line[5]} end
	else
		local clippedhistory = {}
		for i=1,#history do
			local line = history[i]
			local lines,firstclip = clipLine(line[1],fontsize,maxsize)
			for j=1,#lines do
				clippedhistory[#clippedhistory+1] = { (j>1 and line[4] or "")..lines[j], line[2], line[3], line[4], line[5] }
			end
		end
		g.vars.consolehistory = clippedhistory
	end
end

local function processLine(line,g,cfg,newlinecolor)
	if (g.vars.browsinghistory) then g.vars.historyoffset = (g.vars.historyoffset or 0) + 1 end
	g.vars.nextupdate = 0
	local roster = sGetPlayerRoster()
	local names = {}
	for i=1,#roster do names[roster[i][1]] = {roster[i][4],roster[i][5],roster[i][3]} end
	local name, text, linetype = "", "", 0
	if (not newlinecolor) then
		if (names[ssub(line,2,(sfind(line,"> ") or 1)-1)]) then
			linetype, name = 1, ssub(line,2,sfind(line,"> ")-1)
			text = ssub(line,slen(name)+4)
		elseif (ssub(line,1,1) == ">") then linetype, text = 4, ssub(line,3) end
	end
	local MyAllyTeamID = Spring.GetMyAllyTeamID()
	local textcolor = convertColor(1,1,1)
	if linetype==1 then
		local c = cfg.cothertext
		textcolor = convertColor(c[1],c[2],c[3])
		line = convertColor(1,1,1)..name..": "..textcolor..text
	end
	if (g.vars.consolehistory == nil) then g.vars.consolehistory = {} end
	g.vars.consolehistory[#g.vars.consolehistory+1] = {line,clock(),#g.vars.consolehistory+1,textcolor,linetype}
	return g.vars.consolehistory[#g.vars.consolehistory]
end

function convertColor(r,g,b) return schar(255, (r*255), (g*255), (b*255)) end

local function updateconsole(g,cfg)
	if (g.vars.nextupdate and g.vars.nextupdate > 0 and clock() < g.vars.nextupdate and not g.vars._forceupdate) then return end
	g.vars._forceupdate = nil
	local maxlines = g.vars.browsinghistory and cfg.maxlinesScrollmode or cfg.maxlines
	local history = g.vars.consolehistory or {}
	local display, count = "", 0
	local historyoffset = g.vars.historyoffset or 0
	for i=0, maxlines-1 do
		local line = history[#history-i-historyoffset]
		if line and (g.vars._skipagecheck or (clock()-line[2] < cfg.maxage)) then
			display = line[1] .. (display=="" and "" or "\n") .. display
			count = count + 1
		end
	end
	if count == 0 then
		g.background.active, g.lines.active = false, false
	else
		g.background.active, g.lines.active = nil, nil
		g.background.sy = math.floor(count*cfg.fontsize + cfg.margin*2 + 0.5)
		g.lines.caption = display
	end
end

-- GESTIONE TASTI SPRING 100
function widget:KeyPress(key)
	if key == 13 then -- Tasto INVIO
		isChatting = not isChatting
		if isChatting then
			-- Quando apriamo la chat, forziamo l'aggiornamento immediato
			local r = Config.console
			local vsx, vsy = widgetHandler:GetViewSizes()
			-- Usiamo i valori dal Config per il primo posizionamento
			local x = (r.ancora_x + 10) / vsx
			local y = (vsy - (vsy - r.ancora_y + (r.maxlines * r.fontsize) + r.input_offset_y) - r.input_sy + (r.input_sy * 0.35)) / vsy
			local h = (r.input_sy * 0.2) / vsy
			local aspect = (r.input_sx * 0.9) / (r.input_sy * 0.6)
			
			Spring.SendCommands(string.format('inputtextgeo %.4f %.4f %.4f %.4f', x, y, h, aspect))
		else
			-- Quando chiudiamo, nascondiamo il testo
			Spring.SendCommands('inputtextgeo 0 -1 0 0')
		end
	elseif key == 27 then -- Tasto ESC
		isChatting = false
		Spring.SendCommands('inputtextgeo 0 -1 0 0')
	end
end

function widget:AddConsoleLine(lines,priority)
	isChatting = false -- Chiude il rettangolo quando si invia
	lines = lines:match('^\[f=[0-9]+\] (.*)$') or lines
	local textcolor
	for line in lines:gmatch("[^\n]+") do textcolor = processLine(line, console, Config.console, textcolor)[4] end
	clipHistory(console,true)
end

function widget:Initialize()
	if not RedUIchecks() then return end
	console = createconsole(Config.console)
	Spring.SendCommands("console 0")
	Spring.SendCommands('inputtextgeo 0 -1 0 0')
	AutoResizeObjects()
end

function widget:Update()
	updateconsole(console,Config.console)
	AutoResizeObjects()
end

function widget:GetConfigData()
	local vsy = Screen.vsy
	return {Config=Config}
end

function widget:SetConfigData(data)
	if (data and data.Config) then Config = data.Config end
end