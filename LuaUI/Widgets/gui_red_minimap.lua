function widget:GetInfo()
	return {
	version   = "2",
	name      = "Red Minimap",
	desc      = "Requires Red UI Framework",
	author    = "Regret",
	date      = "December 7, 2009", --last change December 11,2009
	license   = "GNU GPL, v2 or later",
	layer     = -11,
	enabled   = true, --enabled by default
	handler   = true, --can use widgetHandler:x()
	}
end
-- rev1 = 	13/07/2026	Molix, eliminato autoresize
--						Modificati pulsanti move e scale
--						Aggiunti pulsanti: reset minimap scale e pulsanti on/off camera 1, 2 e 3 (pip widget)


local rescalevalue = 1
local buttonScale = 1
local NeededFrameworkVersion = 8
local CanvasX,CanvasY = 1272/rescalevalue,734/rescalevalue --resolution in which the widget was made (for 1:1 size)
--1272,734 == 1280,768 windowed

local Config = {
	minimap = {
		ancora_x = 2,  			-- 5 pixel da sinistra
		ancora_y = 2,  			-- 5 pixel dal TOP	
		px = 5,py = 5, 			--default start position
		sx = 180, 				--math.min(135*Game.mapX/Game.mapY,270),		--background size
		sy = 180, 				--135, 											--background size
		
		bsx = 23,bsy = 23, 		--button size

		fadetime = 0.10, --fade effect time, in seconds
		fadedistance = 100, --distance from cursor at which console shows up when empty
		
		cresizebackground = {0.9,0.9,0.9,0}, --color {r,g,b,alpha} {0.9,0.9,0.9,0.5}
		cresizecolor = {1,1,1,1},
		
		cmovebackground = {0,1,0,0},
		cmovecolor = {1,1,1,1},
		

--		cbackground = {0,0.67,0.99,0}, -- sfondo -- rimosso
		cborder = {0,0.67,0.99,1}, -- colore del bordo 
--		cbordersize = 2,
		
		dragbutton = {1}, --left mouse button
		tooltip = {
			--todo? kinda useless
		},
	},
}

local sformat = string.format
local sSendCommands = Spring.SendCommands
local sGetMiniMapGeometry = Spring.GetMiniMapGeometry
local sGetCameraState = Spring.GetCameraState
local sceduleMinimapGeometry = false
-- aggiunti con rev 1
local rResetButton
local rcamerabutton_1
local rcamerabutton_2
local rcamerabutton_3
local rResizeButton
local rMoveButton
local camera1IsOpen = false
local camera2IsOpen = false
local camera3IsOpen = false
---------------------

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

local function createminimap(r)
		
	local minimap = {"rectangle",
		px=r.px,py=r.py,
		sx=r.sx,sy=r.sy,
		color={0,0,0,0.1},
		bordersize=3, 
		border=r.cborder,
		obeyscreenedge = true,
		ancora_x = r.ancora_x,
		ancora_y = r.ancora_y,		
	}
--	local minimapbg = {"rectanglerounded",
--		px=r.px-r.cbordersize,py=r.py,
--		sx=r.sx,sy=r.sy,
--		color=r.cbackground,
--		obeyscreenedge = true,
--		bordersize=r.cbordersize
--	}
	
	local resizebutton = {"rectangle",
		px=r.px+r.sx-r.bsx,py=r.py+r.sy-1,
		sx=r.bsx*buttonScale,sy=r.bsy*buttonScale,
		
		color=r.cresizebackground,
		texturecolor=r.cmovecolor,
		texture="luaui/images/redminimap/resize.png",		
		border=r.cborder,
		movable=r.dragbutton,
		overridecursor = true,
		overrideclick = r.dragbutton,
		roundedsize = math.floor(r.bsy*0.15),
		onlyTweakUi = false,
		
		effects = {
			fadein_at_activation = r.fadetime,
			fadeout_at_deactivation = r.fadetime,
		},
	}
	local offsetcorrection = r.bsx - ((r.bsx * buttonScale))
	local movebutton = {"rectangle",
		px=r.px+r.sx-r.bsx*2+1 + offsetcorrection,py=r.py+r.sy-1,
		sx=r.bsx*buttonScale,sy=r.bsy*buttonScale,
		
		color=r.cmovebackground,
		texturecolor=r.cmovecolor,
		texture="luaui/images/redminimap/move.png",
		
		border=r.cborder,
		movable=r.dragbutton,
		obeyscreenedge = true,
		overridecursor = true,
		overrideclick = r.dragbutton,
		roundedsize = math.floor(r.bsy*0.15),
		onlyTweakUi = false,
		
		effects = {
			fadein_at_activation = r.fadetime,
			fadeout_at_deactivation = r.fadetime,
		},
	}
	-- rev1: Bottone Reset (posizionato a sinistra di "move")
	resetbutton = {"rectangle",
		px=r.px+r.sx-r.bsx*3+2 + offsetcorrection,py=r.py+r.sy-1,
		sx=r.bsx*buttonScale,sy=r.bsy*buttonScale,
		
		color={0.8,0.2,0.2,0.6},
		texturecolor={1,1,1,1},
		texture="luaui/images/redminimap/reset.png",
		border=r.cborder,
		obeyscreenedge = true,
		overridecursor = true,
		overrideclick = r.dragbutton,
		roundedsize = math.floor(r.bsy*0.15),
		onlyTweakUi = false,
		
		effects = {
			fadein_at_activation = r.fadetime,
			fadeout_at_deactivation = r.fadetime,
		},
		
		-- Gestione click nativa del framework (tasto 1 = sinistro)
		mouseclick = {
			{1, function(mx, my, self)
				local default_px = Config.minimap.ancora_x or 5
				local default_py = Config.minimap.ancora_y or 5
				local default_sx = Config.minimap.sx or 180
				local default_sy = Config.minimap.sy or 180
				local bsx = Config.minimap.bsx or 15
				
				minimap.px = default_px
				minimap.py = default_py
				minimap.sx = default_sx
				minimap.sy = default_sy
				
				local localOffset = bsx - (bsx * buttonScale)
				
				resizebutton.px = default_px + default_sx - bsx
				resizebutton.py = default_py + default_sy - 1
				
				movebutton.px = default_px + default_sx - bsx*2+1 + localOffset
				movebutton.py = default_py + default_sy - 1
				
				self.px = default_px + default_sx - bsx*3+2 + localOffset
				self.py = default_py + default_sy - 1
				
				camerabutton_1.px = default_px + default_sx - bsx*6+5 + localOffset
				camerabutton_1.py = default_py + default_sy - 1
				
				camerabutton_2.px = default_px + default_sx - bsx*5+4 + localOffset
				camerabutton_2.py = default_py + default_sy - 1

				camerabutton_3.px = default_px + default_sx - bsx*4+3 + localOffset
				camerabutton_3.py = default_py + default_sy - 1				
				
				sceduleMinimapGeometry = true
				Spring.PlaySoundFile("sounds/click.wav", 1.0, 'ui')
			end}
		}
	}
	-- rev1: Bottone Camera 3 
	camerabutton_3 = {"rectangle",
		px=r.px+r.sx-r.bsx*4+3 + offsetcorrection,py=r.py+r.sy-1,
		sx=r.bsx*buttonScale,sy=r.bsy*buttonScale,
		
		color={0.2,0.6,0.8,0.6},
		texturecolor={1,1,1,1},
		texture="luaui/images/redminimap/camera3.png",
		border=r.cborder,
		obeyscreenedge = true,
		overridecursor = true,
		overrideclick = r.dragbutton,
		roundedsize = math.floor(r.bsy*0.15),
		onlyTweakUi = false,
		
		effects = {
			fadein_at_activation = r.fadetime,
			fadeout_at_deactivation = r.fadetime,
		},
		
		-- Gestione click nativa del framework (tasto 1 = sinistro)
		mouseclick = {
			{1, function(mx, my, self)
				if (camera3IsOpen) then
					Spring.SendCommands("close_WMRTS_camera_3")
					camera3IsOpen = false
				else
					Spring.SendCommands("open_WMRTS_camera_3")
					camera3IsOpen = true
				end
				Spring.PlaySoundFile("sounds/click.wav", 1.0, 'ui')
			end}
		}
	}
	
	-- rev1: Bottone Camera 2 
	camerabutton_2 = {"rectangle",
		px=r.px+r.sx-r.bsx*5+4 + offsetcorrection,py=r.py+r.sy-1,
		sx=r.bsx*buttonScale,sy=r.bsy*buttonScale,
		
		color={0.2,0.6,0.8,0.6},
		texturecolor={1,1,1,1},
		texture="luaui/images/redminimap/camera2.png",
		border=r.cborder,
		obeyscreenedge = true,
		overridecursor = true,
		overrideclick = r.dragbutton,
		roundedsize = math.floor(r.bsy*0.15),
		onlyTweakUi = false,
		
		effects = {
			fadein_at_activation = r.fadetime,
			fadeout_at_deactivation = r.fadetime,
		},
		
		-- Gestione click nativa del framework (tasto 1 = sinistro)
		mouseclick = {
			{1, function(mx, my, self)
				if (camera2IsOpen) then
					Spring.SendCommands("close_WMRTS_camera_2")
					camera2IsOpen = false
--					Spring.Echo("WMRTS_Debug:Secondary Camera Closed") -- ####### rimuovere
				else
					Spring.SendCommands("open_WMRTS_camera_2")
					camera2IsOpen = true
--					Spring.Echo("WMRTS_Debug:Secondary Camera Opened") -- ####### rimuovere
				end
				Spring.PlaySoundFile("sounds/click.wav", 1.0, 'ui')
			end}
		}
	}

	-- rev1: Bottone Camera 1 
	camerabutton_1 = {"rectangle",
		px=r.px+r.sx-r.bsx*6+5 + offsetcorrection,py=r.py+r.sy-1,
		sx=r.bsx*buttonScale,sy=r.bsy*buttonScale,
		
		color={0.2,0.6,0.8,0.6},
		texturecolor={1,1,1,1},
		texture="luaui/images/redminimap/camera1.png",
		border=r.cborder,
		obeyscreenedge = true,
		overridecursor = true,
		overrideclick = r.dragbutton,
		roundedsize = math.floor(r.bsy*0.15),
		onlyTweakUi = false,
		
		effects = {
			fadein_at_activation = r.fadetime,
			fadeout_at_deactivation = r.fadetime,
		},
		
		-- Gestione click nativa del framework (tasto 1 = sinistro)
		mouseclick = {
			{1, function(mx, my, self)
				if (camera1IsOpen) then
					Spring.SendCommands("close_WMRTS_camera_1")
					camera1IsOpen = false
					Spring.Echo("WMRTS_Debug:Secondary Camera Closed") -- ####### rimuovere
				else
					Spring.SendCommands("open_WMRTS_camera_1")
					camera1IsOpen = true
					Spring.Echo("WMRTS_Debug:Secondary Camera Opened") -- ####### rimuovere
				end
				Spring.PlaySoundFile("sounds/click.wav", 1.0, 'ui')
			end}
		}
	}	

	
	New(movebutton)
	New(resizebutton)
	New(resetbutton)   -- rev1 resetSizebutton
	New(camerabutton_1)  -- rev1 camera1button
	New(camerabutton_2)  -- rev1 camera1button
	New(camerabutton_3)  -- rev1 camera1button	
	New(minimap)
--	New(minimapbg)

	-- Salvataggio dei riferimenti nelle variabili a livello di file
	rMoveButton = movebutton
	rResizeButton = resizebutton
	rResetButton = resetbutton
	rcamerabutton_1 = camerabutton_1
	rcamerabutton_2 = camerabutton_2
	rcamerabutton_3 = camerabutton_3	

	-- Hover effects per Reset
	resetbutton.mouseover = function(mx,my,self)
		self.active = nil
		if (not self._mouseover) then
			self._color4 = self.color[4]
			self.color[4] = 1
		end
		self._mouseover = true
	end
	resetbutton.mousenotover = function(mx,my,self)
		if (self._mouseover) then
			self.color[4] = self._color4
		end
		self._mouseover = nil
	end

	-- Hover effects per Camera 1
	camerabutton_1.mouseover = function(mx,my,self)
		self.active = nil
		if (not self._mouseover) then
			self._color4 = self.color[4]
			self.color[4] = 1
		end
		self._mouseover = true
	end
	camerabutton_1.mousenotover = function(mx,my,self)
		if (self._mouseover) then
			self.color[4] = self._color4
		end
		self._mouseover = nil
	end
	-- Hover effects per Camera 2
	camerabutton_2.mouseover = function(mx,my,self)
		self.active = nil
		if (not self._mouseover) then
			self._color4 = self.color[4]
			self.color[4] = 1
		end
		self._mouseover = true
	end
	camerabutton_2.mousenotover = function(mx,my,self)
		if (self._mouseover) then
			self.color[4] = self._color4
		end
		self._mouseover = nil
	end	
	-- Hover effects per Camera 3
	camerabutton_3.mouseover = function(mx,my,self)
		self.active = nil
		if (not self._mouseover) then
			self._color4 = self.color[4]
			self.color[4] = 1
		end
		self._mouseover = true
	end
	camerabutton_3.mousenotover = function(mx,my,self)
		if (self._mouseover) then
			self.color[4] = self._color4
		end
		self._mouseover = nil
	end	
	-- Hover effects per Resize	
	resizebutton.mouseover = function(mx,my,self)
		self.active = nil
		movebutton.active = nil
		
		if (not self._mouseover) then
			self._color4 = self.color[4]
			self.color[4] = 4
		end
		
		self._mouseover = true
	end
	resizebutton.mousenotover = function(mx,my,self)
		if ((not minimap._mouseover) and (not movebutton._mouseover)) then
--			self.active = false --deactivate			-- rev 1 rimosso (sparisce se il cursore è fuori dalla mappa, cosi rimane sempre visibile)
		end
		
		if (self._mouseover) then
			self.color[4] = self._color4
		end
		
		self._mouseover = nil
	end
	
	movebutton.mouseover = function(mx,my,self)
		self.active = nil
		resizebutton.active = nil
		
		if (not self._mouseover) then
			self._color4 = self.color[4]
			self.color[4] = 1
		end
		
		self._mouseover = true
	end
	movebutton.mousenotover = function(mx,my,self)
		if ((not minimap._mouseover) and (not resizebutton._mouseover)) then
--			self.active = false --deactivate			-- rev 1 rimosso (sparisce se il cursore è fuori dalla mappa, cosi rimane sempre visibile)
		end
		
		if (self._mouseover) then
			self.color[4] = self._color4
		end
		
		self._mouseover = nil
	end
	
	minimap.onupdate=function(self)
		self.sx = resizebutton.px-self.px+resizebutton.sx
		self.sy = resizebutton.py-self.py+1

--		minimapbg.px = self.px - minimapbg.bordersize
--		minimapbg.py = self.py - minimapbg.bordersize
--		minimapbg.sx = self.sx + minimapbg.bordersize + minimapbg.bordersize
--		minimapbg.sy = self.sy + minimapbg.bordersize + minimapbg.bordersize
	end
	resizebutton.onupdate=function(self)
		if (self._mouseover) then
			self.minpx = minimap.px+r.bsx-1
			self.minpy = minimap.py+r.bsx
		else
			self.minpx = 0
			self.minpy = 0
		end
		self.maxpx = Screen.vsx
		self.maxpy = Screen.vsy
	end
	
	minimap.mousenotover = function(mx,my,self)
		self._mouseover = nil
	end
	
	minimap.mouseover = function(mx,my,self)
		self._mouseover = true
	
		movebutton.active = nil
		resizebutton.active = nil
	end
	
	minimap.movableslaves = {
		movebutton,
	}
	movebutton.movableslaves = {
		minimap,resizebutton, resetbutton, camerabutton_1, camerabutton_2, camerabutton_3,		-- rev1 aggiungo i pulsanti reset e camera_x
	}	
	resizebutton.movableslaves = {
		movebutton, resetbutton, camerabutton_1,  camerabutton_2, camerabutton_3,				-- rev1 aggiungo i pulsanti reset e camera_x
	}
	
	return minimap
end

function widget:Initialize()
	widgetHandler:EnableWidget("Red_UI_Framework")
	widgetHandler:EnableWidget("Red_Drawing")
--	widgetHandler:EnableWidget("RelativeMinimap")
	--oldMinimapGeometry = Spring.GetConfigString("MiniMapGeometry","2 2 200 200") -- store original geometry
	oldMinimapGeometry = sGetMiniMapGeometry()
	
	PassedStartupCheck = RedUIchecks()
	if (not PassedStartupCheck) then return end
	
	rMinimap = createminimap(Config.minimap)
	
	gl.SlaveMiniMap(true)
	
--	AutoResizeObjects() --fix for displacement on crash issue
end

local lastPos = {}


function widget:ViewResize(viewSizeX, viewSizeY)
	sceduleMinimapGeometry = true
end


function widget:Update()
	local _,_,_,_,minimized,maximized = sGetMiniMapGeometry()
	if (maximized) then
		--hack to reset state minimap
		gl.SlaveMiniMap(false) 
		gl.SlaveMiniMap(true)
		----
	end
	
	if (minimized) then
		rMinimap.active = false
		if rResetButton then rResetButton.active = false end
		if rcamerabutton_1 then rcamerabutton_1.active = false end		
		if rcamerabutton_2 then rcamerabutton_2.active = false end		
		if rcamerabutton_3 then rcamerabutton_3.active = false end				
		--hack to reset state minimap
		gl.SlaveMiniMap(false) 
		gl.SlaveMiniMap(true)
		----
	else
		rMinimap.active = nil
		if rResetButton then rResetButton.active = nil end
		if rcamerabutton_1 then rcamerabutton_1.active = nil end		
		if rcamerabutton_2 then rcamerabutton_2.active = nil end	
		if rcamerabutton_3 then rcamerabutton_3.active = nil end			
	end
	
	local st = sGetCameraState()
	if (st.name == "ov") then --overview camera
		rMinimap.active = false
		if rResetButton then rResetButton.active = false end
		if rcamerabutton_1 then rcamerabutton_1.active = false end		
		if rcamerabutton_2 then rcamerabutton_2.active = false end	
		if rcamerabutton_3 then rcamerabutton_3.active = false end			
	else
		if not minimized then
			rMinimap.active = nil
			if rResetButton then rResetButton.active = nil end
			if rcamerabutton_1 then rcamerabutton_1.active = nil end
			if rcamerabutton_2 then rcamerabutton_2.active = nil end
			if rcamerabutton_3 then rcamerabutton_3.active = nil end			
		end
	end

--	AutoResizeObjects()
	if ((lastPos.px ~= rMinimap.px) or (lastPos.py ~= rMinimap.py) or (lastPos.sx ~= rMinimap.sx) or (lastPos.sy ~= rMinimap.sy) or sceduleMinimapGeometry) then
		local borderPadding = 2 -- Distanza in pixel tra la mappa e il bordo esterno
		
		local out_px = math.floor(rMinimap.px + 0.5)  + borderPadding
		local out_py = math.floor(rMinimap.py + 0.5)  + borderPadding
		local out_sx = math.floor(rMinimap.sx + 0.5) - (borderPadding * 2)
		local out_sy = math.floor(rMinimap.sy + 0.5) - (borderPadding * 2)
		
		sSendCommands(sformat("minimap geometry %i %i %i %i",
		out_px,
		out_py,
		out_sx,
		out_sy))
		sceduleMinimapGeometry = false
	end
	lastPos.px = rMinimap.px
	lastPos.py = rMinimap.py
	lastPos.sx = rMinimap.sx
	lastPos.sy = rMinimap.sy
end

function widget:DrawScreen()
	if (rMinimap.active ~= nil) then
		return
	end
	-- this makes jK rage
	gl.ResetState()
	gl.ResetMatrices()
	----
	
    --gl.SlaveMiniMap(true)
    gl.DrawMiniMap()
    --gl.SlaveMiniMap(false)
	
	-- this makes jK rage
	gl.ResetState()
	gl.ResetMatrices()
	----
end

function widget:Shutdown()
	gl.SlaveMiniMap(false)
	Spring.SendCommands("minimap geometry "..oldMinimapGeometry)
end


--save/load stuff
--currently only position
function widget:GetConfigData() --save config
	if (PassedStartupCheck) then
		local vsy = Screen.vsy
		local unscale = CanvasY/vsy --needed due to autoresize, stores unresized variables
		Config.minimap.px = rMinimap.px * unscale
		Config.minimap.py = rMinimap.py * unscale
		return {Config=Config}
	end
end
function widget:SetConfigData(data) --load config
	if (data.Config ~= nil) then
		Config.minimap.px = data.Config.minimap.px
		Config.minimap.py = data.Config.minimap.py
	end
end
