function widget:GetInfo()
	return {
	name      = "Red Tooltip",
	desc      = "Toggle unitcounter with /unitcounter   (Requires Red UI Framework)",
	author    = "Regret",
	date      = "29 may 2015",
	license   = "GNU GPL, v2 or later",
	layer     = -100,
	enabled   = true, --enabled by default
	handler   = true, --can use widgetHandler:x()
	}
end
local NeededFrameworkVersion = 8
local CanvasX,CanvasY = 1280,734 --resolution in which the widget was made (for 1:1 size)
--1272,734 == 1280,768 windowed


--todo: sy adjustment

local Config = {
	tooltip = {
		px = -0.5,py = CanvasY-82, --default start position
		sx = 260,sy = 95, 	--background size
		ancora_x = 7,		-- posizione da sinistra
		ancora_y = 97,		-- posizione dal basso
		fontsize = 10,
		
--		padding = 3, --distanza del riquadro interno rispetto quello esterno
--		color2 = {0,0,0,0.5}, -- riquadro interno eliminato
		
		margin = 11, --distance from background border
		
		cbackground = {0,0,0,0}, --{0.03,0.18,0.3,0.5}, --color {r,g,b,alpha} riquadro esterno
		cborder = {0,0,0,0}, --{0,0.67,0.99,1},
		background_texture = ":n:"..LUAUI_DIRNAME.."images/menu/tooltip/tool_bkgnd.png",
		dragbutton = {2}, --middle mouse button
		tooltip = {
			background = "In CTRL+F11 mode: Hold \255\255\255\1middle mouse button\255\255\255\255 to drag this element.",
		},
		unitCounterEnabled = false,
	},
}

local totalUnits = 0

local spGetTeamUnitCount		= Spring.GetTeamUnitCount
local sGetCurrentTooltip 		= Spring.GetCurrentTooltip
local sGetSelectedUnitsCount 	= Spring.GetSelectedUnitsCount
local OrangeStr  				= "\255\255\190\128"
local GreyStr    				= "\255\210\210\210"
local WhiteStr   				= "\255\255\255\255"

local function IncludeRedUIFrameworkFunctions()
	New = WG.Red.New(widget)
	Copy = WG.Red.Copytable
	SetTooltip = WG.Red.SetTooltip
	GetSetTooltip = WG.Red.GetSetTooltip
	Screen = WG.Red.Screen
	GetWidgetObjects = WG.Red.GetWidgetObjects
end

local function RedUIchecks()
	local color = "\255\255\255\1"
	local passed = true
	if (type(WG.Red)~="table") then
		Spring.Echo(color..widget:GetInfo().name.." requires Red UI Framework.")
		passed = false
	elseif (type(WG.Red.Screen)~="table") then
		Spring.Echo(color..widget:GetInfo().name..">> strange error.")
		passed = false
	elseif (WG.Red.Version < NeededFrameworkVersion) then
		Spring.Echo(color..widget:GetInfo().name..">> update your Red UI Framework.")
		passed = false
	end
	if (not passed) then
		widgetHandler:ToggleWidget(widget:GetInfo().name)
		return false
	end
	IncludeRedUIFrameworkFunctions()
	return true
end

--[[
local function AutoResizeObjects() --autoresize v2
	if (LastAutoResizeX==nil) then
		LastAutoResizeX = CanvasX
		LastAutoResizeY = CanvasY
	end
	local lx,ly = LastAutoResizeX,LastAutoResizeY
	local vsx,vsy = Screen.vsx,Screen.vsy
	if ((lx ~= vsx) or (ly ~= vsy)) then
		local objects = GetWidgetObjects(widget)
		local scale = vsy/ly
		local skippedobjects = {}
		for i=1,#objects do
			local o = objects[i]
			local adjust = 0
			if ((o.movableslaves) and (#o.movableslaves > 0)) then
				adjust = (o.px*scale+o.sx*scale)-vsx
				if (((o.px+o.sx)-lx) == 0) then
					o._moveduetoresize = true
				end
			end
			if (o.px) then o.px = o.px * scale end
			if (o.py) then o.py = o.py * scale end
			if (o.sx) then o.sx = o.sx * scale end
			if (o.sy) then o.sy = o.sy * scale end
			if (o.fontsize) then o.fontsize = o.fontsize * scale end
			if (adjust > 0) then
				o._moveduetoresize = true
				o.px = o.px - adjust
				for j=1,#o.movableslaves do
					local s = o.movableslaves[j]
					s.px = s.px - adjust/scale
				end
			elseif ((adjust < 0) and o._moveduetoresize) then
				o._moveduetoresize = nil
				o.px = o.px - adjust
				for j=1,#o.movableslaves do
					local s = o.movableslaves[j]
					s.px = s.px - adjust/scale
				end
			end
		end
		LastAutoResizeX,LastAutoResizeY = vsx,vsy
	end
end
]]--

local function AutoResizeObjects()
	if (LastAutoResizeX==nil) then
		LastAutoResizeX = CanvasX
		LastAutoResizeY = CanvasY
	end
	local vsx,vsy = Screen.vsx,Screen.vsy
	
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
				
				if (o.ancora_x) then 
					o.px = math.floor(o.ancora_x + 0.5) 
				end
				if (o.ancora_y) then 
					o.py = math.floor(vsy - o.ancora_y + 0.5)
				end

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

local function getEditedCurrentTooltip() 
	local text = sGetCurrentTooltip() 
	--extract the exp value with regexp 
	local expPattern = "Experience (%d+%.%d%d)" 
	local currentExp = tonumber(text:match(expPattern)) 
	--replace with limexp: exp/(1+exp) since all spring exp effects are linear in limexp, multiply by 10 because people like big numbers instead of [0,1] 
	return currentExp and text:gsub(expPattern,string.format("XP ".. OrangeStr .. "%.2f" .. WhiteStr, currentExp)  ) or text 
end 

local function createtooltip(r)
	local text = {"text",
		px=r.px+r.margin,py=r.py+(r.margin/1.5),
		fontsize=r.fontsize,
		color={1,1,1,0.3},
		caption="",
		options="o",
		
				-- add gui shader	

		
		
		onupdate=function(self)
			local unitcount = sGetSelectedUnitsCount()
			if (unitcount ~= 0) then
				self.caption = "Selected units: "..unitcount.."\n"
			else
				self.caption = "\n"
			end
		
			if (self._mouseoverself) then
				self.caption = self.caption..r.tooltip.background
			else
				self.caption = self.caption..(getEditedCurrentTooltip() or sGetCurrentTooltip()) 
			end
		end
	}
	
	
	local unitcounter = {"text",
		px=r.sx-(r.margin/2),py=r.py+(r.margin/2),
		fontsize=r.fontsize/1.3,
		color={1,1,1,0.2},
		caption="",
		options="r",
		
		onupdate=function(self)
			if Config.tooltip.unitCounterEnabled then
				-- get total unit count
				if Spring.GetGameFrame() % 60 == 0 then
					totalUnits = 0
					local allyTeamList = Spring.GetAllyTeamList()
					local numberOfAllyTeams = #allyTeamList
					for allyTeamListIndex = 1, numberOfAllyTeams do
						local allyID = allyTeamList[allyTeamListIndex]
						local teamList = Spring.GetTeamList(allyID)
						for _,teamID in pairs(teamList) do
							totalUnits = totalUnits + spGetTeamUnitCount(teamID)
						end
					end
					local alpha = (totalUnits/6600)
					if alpha > 0.66 then alpha = 0.66 end
					if alpha < 0.2 then alpha = 0.2 end
					self.color={1,1,1,alpha}
				end
				self.caption = totalUnits
				vsx,vsy = gl.GetViewSizes()
				
			else
				self.caption = ""
			end
		end
	}
--	local background2 = {"rectanglerounded",
--		px=r.px+r.padding,py=r.py+r.padding,
--		sx=r.sx-r.padding-r.padding,sy=r.sy-r.padding-r.padding,
--		color=r.color2,
--	}
	local background = {"rectangle",
		px=r.px,py=r.py,
		sx=r.sx,sy=r.sy,
		color=r.cbackground,
		border=r.cborder,
		texture = r.background_texture,
		texturecolor = {1,1,1,1},
		ancora_x = r.ancora_x,
		ancora_y = r.ancora_y,		
		padding=r.padding,
		
		movable=r.dragbutton,
--		movableslaves={text,unitcounter,background2}, rimuovo
		
		obeyscreenedge = true,
		--overridecursor = true,
		--overrideclick = {2},
		
		onupdate=function(self)
			if (self.px < (Screen.vsx/2)) then --left side of screen
				if ((self.sx-r.margin*2) <= text.getwidth()) then
					self.sx = math.floor(text.getwidth()+r.margin*2) -- self.sx = (text.getwidth()+r.margin*2) -1
				else
					self.sx = math.floor(r.sx + 0.5) --self.sx = r.sx * Screen.vsy/CanvasY
				end
				text.px = math.floor(self.px + r.margin + 0.5) --text.px = self.px + r.margin
			else --right side of screen
				if ((self.sx-r.margin*2 -1) <= text.getwidth()) then
					self.px = math.floor(self.px - ((text.getwidth() + r.margin*2) - self.sx) + 0.5) -- self.px = self.px - ((text.getwidth() + r.margin*2) - self.sx)
					self.sx = math.floor(text.getwidth() + r.margin*2 + 0.5) --self.sx = (text.getwidth() + r.margin*2)
				else
					self.px = math.floor(self.px - (r.sx - self.sx) + 0.5) --self.px = self.px - ((r.sx * Screen.vsy/CanvasY) - self.sx)
					self.sx = math.floor(r.sx + 0.5) --self.sx = r.sx * Screen.vsy/CanvasY
				end
				text.px = math.floor(self.px + r.margin + 0.5) --text.px = self.px + r.margin
			end
			unitcounter.px = math.floor(self.px + self.sx - (r.margin/2) + 0.5) --unitcounter.px = self.sx - ((r.margin/2)* Screen.vsy/CanvasY)
-- rimuovo background2
--			background2.px = self.px + self.padding
--			background2.py = self.py + self.padding
--			background2.sx = self.sx - self.padding - self.padding
--			background2.sy = self.sy - self.padding - self.padding
		end,
		
		mouseover=function(mx,my,self)
			text._mouseoverself = true
		end,
		mousenotover=function(mx,my,self)
			text._mouseoverself = nil
		end,
	}
	
	background.movableslaves = {text, unitcounter}
	
	New(background)
--	New(background2)
	New(text)
	New(unitcounter)
	
	return {
		["background"] = background,
--		["background2"] = background2,
		["text"] = text,
		["unitcounter"] = unitcounter,
		
		margin = r.margin,
	}
end

function widget:Initialize()
	widgetHandler:EnableWidget("Red_UI_Framework")
	widgetHandler:EnableWidget("Red_Drawing")
	PassedStartupCheck = RedUIchecks()
	if (not PassedStartupCheck) then return end
	
	tooltip = createtooltip(Config.tooltip)
		
	Spring.SetDrawSelectionInfo(false) --disables springs default display of selected units count
	Spring.SendCommands("tooltip 0")
	AutoResizeObjects()
	

end

function widget:Shutdown()
	Spring.SendCommands("tooltip 1")
end

function widget:Update()
	AutoResizeObjects()
end

function widget:GameFrame(n)

	-- get total unit count
	if n % 120 == 0 then
		totalUnits = 0
		local allyTeamList = Spring.GetAllyTeamList()
		local numberOfAllyTeams = #allyTeamList
		for allyTeamListIndex = 1, numberOfAllyTeams do
			local allyID = allyTeamList[allyTeamListIndex]
			local teamList = Spring.GetTeamList(allyID)
			for _,teamID in pairs(teamList) do
				totalUnits = totalUnits + spGetTeamUnitCount(teamID)
			end
		end
	end
end

--save/load stuff
--currently only position
function widget:GetConfigData() --save config
	if (PassedStartupCheck) then
		local vsy = Screen.vsy
		local unscale = CanvasY/vsy --needed due to autoresize, stores unresized variables
		Config.tooltip.px = tooltip.background.px * unscale
		Config.tooltip.py = tooltip.background.py * unscale
		Config.tooltip.unitCounterEnabled = Config.tooltip.unitCounterEnabled
		return {Config=Config}
	end
end
function widget:SetConfigData(data) --load config
	if (data.Config ~= nil) then
		Config.tooltip.px = data.Config.tooltip.px
		Config.tooltip.py = data.Config.tooltip.py
		Config.tooltip.unitCounterEnabled = data.Config.tooltip.unitCounterEnabled
	end
end

function widget:TextCommand(command)
	if (string.find(command, "unitcount") == 1  and  string.len(command) == 11) then 
		Config.tooltip.unitCounterEnabled = not Config.tooltip.unitCounterEnabled
		if Config.tooltip.unitCounterEnabled then
			Spring.Echo("Total units counter:  enabled")
		else
			Spring.Echo("Total units counter:  disabled")
		end
	end
end
