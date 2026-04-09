function widget:GetInfo()
	return {
	name      = "Red Resource Bars",
	desc      = "Requires Red UI Framework",
	author    = "Regret",
	date      = "29 may 2015",
	license   = "GNU GPL, v2 or later",
	layer     = 0,
	enabled   = true, --enabled by default
	handler   = true, --can use widgetHandler:x()
	}
end

-- 08/04/2026 -- modificato da molix, eliminato il fattore "scaling" per rendere più nitide le immagini. Utilizzati background images. 

local barTexture = LUAUI_DIRNAME.."Images/resbar.dds"

local NeededFrameworkVersion = 8
local CanvasX,CanvasY = 1280,734 --resolution in which the widget was made (for 1:1 size)
--1272,734 == 1280,768 windowed

local Config = {
	metal = {
		px = 370,py = -0.5, --default start position
		sx = 260,sy = 29, --background size
		ancora_x = 7,  
		ancora_y = 165,   
		barsy = 5, --width of the actual bar
		fontsize = 11,
		
		margin = 5, --distance from background border
		
--		padding = 3, -- for border effect --rimosso vedi codice seguente
--		color2 = {0,0,0,0.5}, -- riquadro interno --rimosso vedi codice seguente
		
		expensefadetime = 0.5, --fade effect time, in seconds
		background_texture = ":n:"..LUAUI_DIRNAME.."images/menu/resourcesmenu/metal_bkgnd.png",
		cbackground = {0,0,0,0}, --{0.03,0.18,0.3,0.5}, --color {r,g,b,alpha} riquadro esterno metallo
		cborder =  {0,0,0,0}, --{0,0.67,0.99,1}, -- bordo barra  metallo
		cbarbackground = {1,1,1,1}, -- boh
		cbar = {1,0.8,0,1}, -- colore barra metallo
		cindicator = {1,0,0,1}, -- cursore rosso metallo
		
		cincome = {0,1,0,1},
		cpull = {1,0,0,1},
		cexpense = {1,0,0,1},
		ccurrent = {1,1,1,1},
		cstorage = {1,1,1,1},
-- aggiungo icona
		cicona = ":n:"..LUAUI_DIRNAME.."Images/menu/resourcesmenu/metal_icon.png",
		dragbutton = {2}, --middle mouse button
		tooltip = {
			background ="In CTRL+F11 mode: Hold \255\255\255\1middle mouse button\255\255\255\255 to drag the resource bar.\n\n"..
			"\255\255\255\1Leftclick\255\255\255\255 on the bar to set team share.",
			income = "Your Livrium income.",
			pull = "Your Livrium pull.",
			expense = "Your Livrium expense, same as pull if not shown.",
			storage = "Your maximum Livrium storage.",
			current = "Your current Livrium storage.",
		},
	},
	
	energy = {
		px = 636,py = -0.5,
		sx = 260,sy = 29, --background size
		ancora_x = 7,  
		ancora_y = 131,   
		barsy = 5, --width of the actual bar
		fontsize = 11,
		
		margin = 5,
		
--		padding = 2, -- for border effect  --rimosso vedi codice seguente
--		color2 = {0,0,0,0.5}, -- riquadro interno --rimosso vedi codice seguente
		
		expensefadetime = 0.25,
		background_texture = ":n:"..LUAUI_DIRNAME.."images/menu/resourcesmenu/energy_bkgnd.png",
		cbackground = {0,0,0,0},	-- {0.03,0.18,0.3,0.5}, --riquadro esteno
		cborder =  {0,0,0,0}, 		-- {0,0.67,0.99,1},
		cbarbackground = {0,0,0,1},
		cbar = {0.33,0.45,0.81,1}, 	--0,0.7,1,1
		cindicator = {1,0,0,0.8},
		
		cincome = {0,1,0,1},
		cpull = {1,0,0,1},
		cexpense = {1,0,0,1},
		ccurrent = {1,1,1,1},
		cstorage = {1,1,1,1},

		cicona = ":n:"..LUAUI_DIRNAME.."Images/menu/resourcesmenu/energy_icon.png",	
		dragbutton = {2}, --middle mouse button
		tooltip = {
			background ="In CTRL+F11 mode: Hold \255\255\255\1middle mouse button\255\255\255\255 to drag the resource bar.\n\n"..
			"\255\255\255\1Leftclick\255\255\255\255 on the bar to set team share.",
			income = "Your energy income.",
			pull = "Your energy pull.",
			expense = "Your energy expense, same as pull if not shown.",
			storage = "Your maximum energy storage.",
			current = "Your current energy storage.",
		},
	},
}

local sGetMyTeamID = Spring.GetMyTeamID
local sGetTeamResources = Spring.GetTeamResources
local sSetShareLevel = Spring.SetShareLevel
local sformat = string.format

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

		-- 1. Identifica gli slave
		local isSlave = {}
		for i=1,#objects do
			local o = objects[i]
			if (o.movableslaves) then
				for j=1,#o.movableslaves do isSlave[o.movableslaves[j]] = true end
			end
		end

		-- 2. Riposiziona i Master
		for i=1,#objects do
			local o = objects[i]
			if not isSlave[o] then
				local oldPx, oldPy = o.px, o.py
				
				-- Applica ancore (Arrotondate per nitidezza)
				if (o.ancora_x) then 
					o.px = math.floor(o.ancora_x + 0.5) 
				end
				
				if (o.ancora_y) then 
					-- Se vuoi ancorare dal TOP:
					o.py = math.floor(vsy - o.ancora_y + 0.5)
					
				end

				-- 3. Muovi i figli mantenendo le distanze originali (Delta)
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

local function short(n,f)
	if (f == nil) then
		f = 0
	end
	if (n > 9999999) then
		return sformat("%."..f.."fm",n/1000000)
	elseif (n > 9999) then
		return sformat("%."..f.."fk",n/1000)
	else
		return sformat("%."..f.."f",n)
	end
end

local function createbar(r)
-- rimuovo riquadro interno
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
		movable=r.dragbutton,
		obeyscreenedge = true,
		ancora_x = r.ancora_x,				-- aggiungo ancora, molix
		ancora_y = r.ancora_y,				-- aggiungo ancora, molix
		padding=r.padding,
        texture = r.background_texture,		-- aggiungo texture, molix
        texturecolor = {1,1,1,1}, 			-- aggiungo texture, molix	
		--overridecursor = true,
		overrideclick = {1},
		onupdate=function(self)
-- rimosso rettangolo iterno
--			background2.px = self.px + self.padding
--			background2.py = self.py + self.padding
--			background2.sx = self.sx - self.padding - self.padding
--			background2.sy = self.sy - self.padding - self.padding
		end,
	}






	New(background)

--	New(icona)

--	New(background2)
	
	local number = {"text",
		px=0,py=background.py+r.margin,fontsize=r.fontsize,
		caption="+99999.9m",
		options="n", --disable colorcodes
	}
	
	local income = New(number)
	income.color = r.cincome

	
	local barbackground = {"rectangle",
		px=background.px+income.getwidth()-r.margin,py=income.py,
		sx=background.sx-income.getwidth(),sy=r.barsy,
--		color=r.cbarbackground,
		texture = barTexture,
		texturecolor = {0.15,0.15,0.15,1},
	}

----- test inserisco l'icona energia 
	local icona = 	{"rectangle",
	--[[	px=r.px-5,py=r.py+4,
		sx=r.sx-240,sy=r.sy-8,
	]]--
		px = math.floor(r.px - 5 + 0.5),
		py = math.floor(r.py + 3 + 0.5),
		sx = math.floor(r.sx - 240 + 0.5),
		sy = math.floor(r.sy - 8 + 0.5),	

		color={0,0,0,0},
		border={0,0,0,0},
		texture = r.cicona, 
		texturecolor = {1,1,1,1},	
	}

	local barborder = Copy(barbackground)
	barborder.color = nil
	barborder.border = r.cborder
	barborder.texture = nil
	barborder.texturecolor = nil
	local bar = Copy(barbackground)
	bar.color = r.cbar
	bar.texture = barTexture
	bar.texturecolor = r.cbar
	bar.cicona = r.cicona -- inserisco

	local shareindicator = Copy(barbackground)
	shareindicator.color = r.cindicator
	shareindicator.py = shareindicator.py -2
	shareindicator.sx = barbackground.sy
	shareindicator.sy = shareindicator.sy +4
	shareindicator.border = r.cborder
	shareindicator.texture = barTexture
	shareindicator.texturecolor = r.cindicator

	New(barbackground)
	New(bar)
	New(barborder)
	New(shareindicator)
-- aggiungo le icone
	New(icona)
	
	bar.overridecursor = true
	
	local pull = New(number)
	pull.color = r.cpull
	--pull.py = pull.py+pull.fontsize
	pull.py = barbackground.py+barbackground.sy+r.margin
	if ((barbackground.sy+r.margin)<r.fontsize) then
		pull.py = barbackground.py+r.fontsize
	end
	
	local expense = New(pull)
	expense.color = r.cexpense
	expense.px = barbackground.px
	
	local current = New(pull)
	current.color = r.ccurrent
	
	local storage = New(pull)
	storage.color = r.cstorage
	
	expense.effects = {
		fadein_at_activation = r.expensefadetime,
		fadeout_at_deactivation = r.expensefadetime,
	}
	
	background.movableslaves = {
		barbackground,
		barborder,
		bar,
		shareindicator,
		income,
		pull,
		expense,
		current,
		storage,
		icona,
	}
	
	-- smaller fontsize for fontsize of income and pull
	income.fontsize = r.fontsize*0.93
	pull.fontsize = r.fontsize*0.93
	storage.fontsize = r.fontsize*0.88
	
	--tooltip
	background.mouseover = function(mx,my,self) SetTooltip(r.tooltip.background) end
	income.mouseover = function(mx,my,self) SetTooltip(r.tooltip.income) end
	pull.mouseover = function(mx,my,self) SetTooltip(r.tooltip.pull) end
	expense.mouseover = function(mx,my,self) SetTooltip(r.tooltip.expense) end
	storage.mouseover = function(mx,my,self) SetTooltip(r.tooltip.storage) end
	current.mouseover = function(mx,my,self) SetTooltip(r.tooltip.current) end
	
	return {
		["background"] = background,
--		["background2"] = background2,
		["barbackground"] = barbackground,
		["bar"] = bar,
		["barborder"] = barborder,
		["shareindicator"] = shareindicator,
		["income"] = income,
		["pull"] = pull,
		["expense"] = expense,
		["current"] = current,
		["storage"] = storage,
		["cicona"] = cicona,
	
		margin = r.margin
	}
end

local function updatebar(b,res)
	local r = {sGetTeamResources(sGetMyTeamID(),res)} -- 1 = cur 2 = cap 3 = pull 4 = income 5 = expense 6 = share
	local barbackpx = b.barbackground.px
	local barbacksx = b.barbackground.sx
--New(icona)	
	b.bar.sx = r[1]/r[2]*barbacksx
	if (b.bar.sx > barbacksx) then --happens on gamestart and storage destruction
		b.bar.sx = barbacksx
	end
	
	b.income.caption = "+ "..short(r[4],(r[4] < 10 and 1 or 0))
	b.pull.caption = "- "..short(r[3],(r[3] < 10 and 1 or 0))
	b.current.caption = short(r[1])
	b.storage.caption = short(r[2])
	
	--align numbers
	b.income.px = barbackpx - b.income.getwidth() -b.margin*2.2
	b.pull.px = barbackpx - b.pull.getwidth() -b.margin*2.2
	b.current.px = barbackpx + barbacksx/2 - b.current.getwidth()/2
	b.storage.px = barbackpx + barbacksx - b.storage.getwidth()
	
	if (r[3]~=r[5]) then
		b.expense.active = nil --activate
		b.expense.caption = "  - "..short(r[5],(r[5] < 10 and 1 or 0))
	else
		b.expense.active = false
	end
	
	b.shareindicator.px = barbackpx+r[6]*barbacksx-b.shareindicator.sx/2
end

function widget:Initialize()
	widgetHandler:EnableWidget("Red_UI_Framework")
	widgetHandler:EnableWidget("Red_Drawing")
	PassedStartupCheck = RedUIchecks()
	if (not PassedStartupCheck) then return end
	
	metal = createbar(Config.metal)
	energy = createbar(Config.energy)
	
	metal.barbackground.mouseheld = {
		{1,function(mx,my,self)
			sSetShareLevel("metal",(mx-self.px)/self.sx)
			updatebar(metal,"metal")
		end},
	}
	energy.barbackground.mouseheld = {
		{1,function(mx,my,self)
			sSetShareLevel("energy",(mx-self.px)/self.sx)
			updatebar(energy,"energy")
		end},
	}
	
	Spring.SendCommands("resbar 0")
	AutoResizeObjects()
end

function widget:Shutdown()
	Spring.SendCommands("resbar 1")
end

local gameFrame = 0
local lastFrame = -1
function widget:GameFrame(n)
	gameFrame = n
end

function widget:Update()
	AutoResizeObjects()
	if (gameFrame ~= lastFrame) then
		updatebar(energy,"energy")
		updatebar(metal,"metal")
		lastFrame = gameFrame
	end
end

--save/load stuff
--currently only position
function widget:GetConfigData() --save config
--[[	if (PassedStartupCheck) then
		local vsy = Screen.vsy
		local unscale = CanvasY/vsy --needed due to autoresize, stores unresized variables
		Config.metal.px = metal.background.px * unscale
		Config.metal.py = metal.background.py * unscale
		Config.energy.px = energy.background.px * unscale
		Config.energy.py = energy.background.py * unscale
		return {Config=Config}
	end
]]--	
end
function widget:SetConfigData(data) --load config
	if (data.Config ~= nil) then
		Config.metal.px = data.Config.metal.px
		Config.metal.py = data.Config.metal.py
		Config.energy.px = data.Config.energy.px
		Config.energy.py = data.Config.energy.py
	end
end
