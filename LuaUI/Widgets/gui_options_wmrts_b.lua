function widget:GetInfo()
   return {
      name      = "Options_visuals",
      desc      = "Provide a GUI for some options",
      author    = "Jools modified by molix",
      date      = "jan, 2014",
      license   = "GNU GPL, v2 or later",
      layer 	= 5,
      enabled   = true,  --  loaded by default?
	}
end
-- ***********************
-- original was for XTA, modified by molix 14/01/2022 -> restyling + inserted visual option (widget and option) used in War Machhines RTS
-- modified by molix 15/01/2022 rev1.WMRTS -> add images and restyling graphics ( WMRTS style)
-- modified by molix 25/01/2022 rev2.WMRTS -> add guishader effect
-- ***********************
-- VISUAL OPTIONS
-- ***********************

local posX, posY					  	= 600, 400
local buttonsize					  	= 16
local width, height					  	= 400, 457  -- larghezza e alteza dello sfondo menù opzioni
local iWidth							= 400
local iRowHeight						= 14
local rows								= 0
local height0							= 160
local iHeight
local rowgap						  	= 26 -- distanza fra le righe
local leftmargin						= 20 -- margine da sinistra (per le scritte del menù)
local buttontab							= 360 -- distanza dei bottoni dal testo
local vsx, vsy 						  	= gl.GetViewSizes()
local Echo								= Spring.Echo
local PlaySoundFile						= Spring.PlaySoundFile
local showModOptions					= false 
local showMapOptions					= false
local showSettings						= false
local textSize							= 10
local myFont							= gl.LoadFont("FreeSansBold.otf",textSize, 1.9, 40)
local myFontBig							= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local myFontBigger						= gl.LoadFont("FreeSansBold.otf",18, 1.9, 40)
-- images
local optContrast						= "LuaUI/Images/tweaksettings/contrast.png"
local optCheckBoxOn						= "LuaUI/Images/tweaksettings/chkBoxOn.png"
local optCheckBoxOff					= "LuaUI/Images/tweaksettings/chkBoxOff.png"
local imgArrows							= "LuaUI/Images/tweaksettings/arrows.png"
local imgQuit							= "LuaUI/Images/tweaksettings/quit_menu.png"
local imgQuit2							= "LuaUI/Images/tweaksettings/quit_menu_over.png" 
local sfondomenu						= "LuaUI/Images/tweaksettings/sfondo_menub.png" -- menub background
local icona_graphics					= "LuaUI/Images/tweaksettings/menu_visual_icon.png" -- icona menu visual

--sounds
local sndButtonOn 						= 'sounds/button8.wav'
local sndButtonOff 						= 'sounds/button6.wav'

-- other
local Button				  			= {}
local ButtonClose		 				= {}
local Panel					  			= {}

-- variables

local waterType = 0
local modOptions 						= Spring.GetModOptions()
local Options							= {}
Options["general"]						= {}
Options["other"]						= {}
Options["multipliers"]					= {}
Options["koth"]							= {}
Options["experimental"]					= {}
Options["map"]							= {}
Options["fleabowl"]						= {}

local mapOptions 						= Spring.GetMapOptions()

local OptionCount						= {}
local MapOptionCount					= 0

--colors
local cLight 							= {1,1,1,1}
local cWhite 							= {1,1,1,1}
local cButton							= {0.8,0.8,0.8,1}
local cBack 							= {0,0,1,0.2} -- {0,0,0,0.8}
local cGreen							= {0.2, 0.8, 0.2, 1}
local cRed								= {0.8, 0.2, 0.2, 1}
local cGrey								= {1, 1, 1, 1} -- {0.8, 0.8, 0.8, 0.2}
local cYellow							= {0.8, 0.8, 0.2, 1}
local cRow								= {0.2,0.6,0.9,0.1}
local cBorder							= {0,0,0,1} 
local cAbove							= {1,1,1,0.5}
local notOver							= {1,1,1,0.75} -- per testi pulsante "not over"
local backbutton						= {0.03,0.18,0.3,0.3} -- righe sotto opzioni

--------------------------------------------------------------------------------			 
-- Local functions
--------------------------------------------------------------------------------

local function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function firstToUpper(str)
		return (str:gsub("^%l", string.upper))
	end

local function formatLabel(value,type,name)
	local label 

	if type == "bool" then
		if value == 1 or value == "1" then
			label = "Yes"
			myFont:SetTextColor(cGreen) -- green
		elseif value == 0 or value == "0" then
			label = "No"
			myFont:SetTextColor(cRed) -- red
		else
			label = "N/A"
			myFont:SetTextColor(cGrey) -- grey
		end
	else
		label = firstToUpper(tostring(value))
		if name == "Game mode:" then
			if label == "Killall" or label == "None" then
				myFont:SetTextColor(cRed) -- red
			elseif label ~= "N/A" then
				myFont:SetTextColor(cGreen) -- green
			else
				myFont:SetTextColor(cGrey) -- grey
			end
		else
			myFont:SetTextColor(cButton)
		end
		if label == "N/A" then
			myFont:SetTextColor(cGrey) -- grey
		end
	end
	return label
end

local function IsOnButton(x, y, BLcornerX, BLcornerY,TRcornerX,TRcornerY)
	if BLcornerX == nil then return false end
	-- check if the mouse is in a rectangle

	return x >= BLcornerX and x <= TRcornerX
	                      and y >= BLcornerY
	                      and y <= TRcornerY

end
      
-----------	  
-- INIT  --
-----------	  
function widget:Initialize()

-- proprietà grafiche --------------------------------------------------------------------------------------------------------------------
--	Button[1] 						= {} -- mapshading
--	Button[2]						= {} -- unitshading
--	Button[3]						= {} -- shadows
--	Button[4]						= {} -- hardwarecursor
--	Button[5]						= {} -- showfps
--	Button[6]						= {} -- show time
--	Button[7]						= {} -- show speed
--	Button[8]						= {} -- FSAA da portare a MSAA
--	Button[9]						= {} -- Spring shaders ON/OFF--
--	Button[10]						= {} -- Bloom shader
--	Button[11]						= {} -- water render
--	Button[12]						= {} -- camera mode
--	Button[13]						= {} -- projectilelight
--	Button[14]						= {} -- LUPS
--	Button[15]						= {} -- x-Ray
--	Button[16]						= {} -- Fullscreen
--	Button[17]						= {} -- TeamHighlight	
--	Button[18]						= {} -- grassdetail
--	Button[19]						= {} -- eliminare ####################################
-- proprietà visive --------------------------------------------------------------------------------------------------------------------
	Button[1]						= {} -- camera mode
	Button[2]						= {} -- units aura	(spot)
	Button[3]						= {} -- unitshealtbar
	Button[4]						= {} -- etabar
	Button[5]						= {} -- unitsrank
	Button[6]						= {} -- camerashake On/OFF da trasformare in camera shake level (con parametri da impostare)
	Button[7]						= {} -- showingamemessage on/off
	Button[8]						= {} -- showlos on/off		
	Button[9]						= {} -- showvline on/off
	Button[10]						= {} -- Show initial point spawn
	Button[11]						= {} -- Show aura on teammates selected units:
	Button[12]						= {} -- Show teammates cursor
	Button[13]						= {} -- Edge camera move (require restart):
	Button[14]						= {} -- scale commander name
	
	Panel["main"]					= {}
--	Panel["main2"]					= {} -- test secondo menù	
	Panel["info"]					= {} -- info screen with mod options
	InitButtons()
	
	
	if modOptions then
		--general
		Options["general"] = {
			{
			name	= "Start metal:",
			type	= "value",
			value	= modOptions["startmetal"] or "N/A",
			},
			
			{	
			name	= "Start energy:",
			type	= "value",
			value	= modOptions["startenergy"] or "N/A",
			},
			
			{
			name	= "Min. speed:",
			type	= "value",
			value	= modOptions["minspeed"] or "N/A",
			},
			
			{	
			name	= "Max. speed:",
			type	= "value",
			value	= modOptions["maxspeed"] or "N/A",
			},
			
			{
			name	= "Max. units:",
			type	= "value",
			value	= modOptions["maxunits"] or "N/A",
			},
			
			{
			name	= "Commander type:",
			type	= "value",
			value	= modOptions["commander"] or "N/A",
			},
			
			{
			name	= "Game mode:",
			type	= "value",
			value	= modOptions["mode"] or "N/A",
			},
					
			{
			name	= "Reclaim method is lump sum:",
			type	= "bool",
			value	= modOptions["reclaim_method"] or "N/A",
			},
			
			{
			name	= "Ghosted buildings:",
			type	= "bool",
			value	= modOptions["ghostedbuildings"] or "N/A",
			},
			
			{
			name	= "Sounds mode:",
			type	= "value",
			value	= modOptions["sounds"] or "N/A",
			},
			
			{
			name 	= "Enable units to slow down on slopes",
			type 	= bool,
			value 	= modOptions["enableslopemods"] or "N/A",
			},
		}
		
		-- other options
		Options["other"] = {
			{
			name		= "Aircraft do not collide:",
			type		= "bool",
			value		= modOptions["airnocollide"] or "N/A",
			},
			
			{
			name		= "Disable friendly unit projectile collisions:",
			type		= "bool",
			value		= modOptions["nocollide"] or "N/A",
			},
			
			{
			name		= "Limit D-Gun:",
			type		= "bool",
			value		= modOptions["limitdgun"] or "N/A",
			},
			
			{
			name		= "Intercept nukes:",
			type		= "bool",
			value		= modOptions["nuke"] or "N/A",
			},
			
			{
			name		= "Disable map damage:",
			type		= "bool",
			value		= modOptions["disablemapdamage"] or "N/A",
			},
			
			{
			name		= "Allow transport of enemies:",
			type		= "value",
			value		= modOptions["mo_transportenemy"] or "N/A",
			},
			
			{
			name		= "Allow transport of hovercraft:",
			type		= "bool",
			value		= modOptions["mo_transporthover"] or "N/A",
			},
			
			{
			name		= "No wrecks:",
			type		= "bool",
			value		= modOptions["mo_nowrecks"] or "N/A",
			},
			{
			name	= "Critters:",
			type	= "bool",
			value	= modOptions["critters"] or "N/A",
			},					
			{
			name	= "Dynamic lights:",
			type	= "bool",
			value	= modOptions["dynamiclights"] or "N/A",
			},
			
		}
		-- unit packs
		Options["unitpacks"] = {
			
			{
			name		= "XTAIDS unit pack:",
			type		= "bool",
			value		= modOptions["xtaidunits"] or "N/A",
			},
			
			{
			name		= "Spider & Tortoise unit pack:",
			type		= "bool",
			value		= modOptions["spidertortoise"] or "N/A",
			},
			
			{
			name		= "The Lost Legacy faction:",
			type		= "bool",
			value		= modOptions["tllunits"] or "N/A",
			},
			
			{
			name		= "The Guardians of Kadesh faction:",
			type		= "bool",
			value		= modOptions["gokunits"] or "N/A",
			},
			
			{
			name		= "Disable all new units after XTA version 8.1:",
			type		= "bool",
			value		= modOptions["newunits"] or "N/A",
			},	
		}
		
		
		-- multiplier options
		Options["multiplier"] = {
			{
			name		= "Metal:",
			type		= "value",
			value		= modOptions["metalmult"] or "N/A",
			},
			
			{
			name		= "Energy:",
			type		= "value",
			value		= modOptions["energymult"] or "N/A",
			},
			
			{
			name		= "Worker:",
			type		= "value",
			value		= modOptions["workermult"] or "N/A",
			},
		
			{
			name		= "Velocity:",
			type		= "value",
			value		= modOptions["velocitymult"] or "N/A",
			},
			
			{
			name		= "Hits:",
			type		= "value",
			value		= modOptions["hitmult"] or "N/A",
			},
		}
		
		-- KOTH options
		Options["koth"] = {
			{
			name		= "Enable KOTH mode:",
			type		= "bool",
			value		= modOptions["koth"] or "N/A",
			},
			
			{
			name		= "Hill time (min):",
			type		= "value",
			value		= modOptions["hilltime"] or "N/A",
			},
			
			{
			name		= "Grace time (min):",
			type		= "value",
			value		= modOptions["gracetime"] or "N/A",
			},
		}
		-- Fleabowl options
		Options["fleabowl"] = {
			
			{
			name		= "Spawn bosses",
			type		= "bool",
			value		= modOptions["bosses"] or "N/A",
			},
			
			{
			name		= "Fleagoth time (min):",
			type		= "value",
			value		= modOptions["mo_gothtime"] or "N/A",
			},
			
			{
			name		= "Max fleas:",
			type		= "value",
			value		= modOptions["mo_maxfleas"] or "N/A",
			},
			
			{
			name		= "Max flea dens:",
			type		= "value",
			value		= modOptions["mo_maxburrows"] or "N/A",
			},
		}
			
		-- Experimental options
		Options["experimental"] = {
			{
			name		= "Cannon velocity:",
			type		= "value",
			value		= modOptions["gravity"] or "N/A",
			},
			
			{
			name		= "Enable zombies:",
			type		= "bool",
			value		= modOptions["zombies"] or "N/A",
			},
			
			{
			name		= "Enable QT pathfinding system:",
			type		= "bool",
			value		= modOptions["qtpfs"] or "N/A",
			},
			
			{
			name		= "Enable additional rocket type for some units:",
			type		= "bool",
			value		= modOptions["rockettoggle"] or "N/A",
			},
			
			{
			name		= "Enable variable production rate gadget:",
			type		= "bool",
			value		= modOptions["buildspeed"] or "N/A",
			},
		}
	end

	for optionName, data in pairs(Options) do
		OptionCount[optionName] = 0
		for _, value in pairs(data) do
			if value.value and value.value ~= "N/A" then
				OptionCount[optionName] = OptionCount[optionName] + 1
			end
		end
	end
	
	for optionName, value in pairs(mapOptions) do
		
		MapOptionCount = MapOptionCount + 1
		Options["map"][optionName] = {
			name	= optionName,
			type	= "value",
			value	= value or "N/A",
		}
	end
end

function updateHeights()
	iHeight	 					= height0  + rows * (iRowHeight+4)
	Panel["info"]["y2"]			= posY + iHeight
end

function InitButtons()

	-- special buttons
--	Button[8]["divided"] 		= true -- action depens on which side of button is clicked
--	Button[8]["wide"] 		    = true	
--	Button[11]["wide"]			= true -- Water double width as normal
--	Button[11]["divided"] 		= true -- Water
	Button[1]["wide"]			= true -- Camera double width as normal
	Button[1]["divided"] 		= true -- Camera
	
	-- automate positions
	for i,button in ipairs(Button) do
		if button["wide"] then   											-- pulsante doppio con frecce laterali
			button["x1"] 	= posX + buttontab - 1 * buttonsize --1
			button["x2"]	= button["x1"] + 2 * buttonsize --3
			button["y1"]	= posY + height - 20 - i*rowgap - buttonsize --20
			button["y2"]	= button["y1"] + 1 * buttonsize --1.5
			button["above"] = false
		elseif button["divided"] then										-- pulsante normale diviso
			button["x1"] 	= posX + buttontab - 0.05 * buttonsize --0.25
			button["x2"]	= button["x1"] + 1 * buttonsize --1.5
			button["y1"]	= posY + height - 20 - i*rowgap - buttonsize
			button["y2"]	= button["y1"] + 1 * buttonsize --1.5
			button["above"] = false
		else																-- pulsante normale tipo check
			button["x1"] 	= posX + buttontab
			button["x2"]	= button["x1"] + buttonsize
			button["y1"]	= posY + height - 20 - i*rowgap - buttonsize
			button["y2"]	= button["y1"] + buttonsize
			button["above"] = false
		end
	end	

----------------
-- CAMERA SETTING 
----------------	
	Button[1]["click"]			= false
	Button[1]["img"]			= imgArrows
	Button[1]["less"]			= "cameraPrev"
	Button[1]["more"]			= "cameraNext"
	if not Button[1]["value"] then
		Button[1]["value"]   		= tonumber(Spring.GetConfigInt("CamMode",1)) or 0
	end
	if Button[1]["value"] == 0 then
		cameraType = "FPS"
		Spring.SendCommands('viewfps')
	elseif Button[1]["value"] == 1 then
		cameraType = "Overhead"
		Spring.SendCommands('viewta')
	elseif Button[1]["value"] == 2 then
		cameraType = "Spring"
		Spring.SendCommands('viewspring')
	elseif Button[1]["value"] == 3 then
		cameraType = "RotOverhead"
		Spring.SendCommands('viewrot')
	elseif Button[1]["value"] == 4 then
		cameraType = "Free"
	elseif Button[11]["value"] == 5 then
		cameraType = "Overview"	
		Spring.SendCommands('viewfree')		
	end

	Button[1]["label"]			= table.concat{"Camera type: "," (", tonumber(Button[1]["value"])," - ",cameraType ,")"}	
---------------	
---------------

	
	Button[2]["click"]			= tonumber(Spring.GetConfigInt("unitsaura",1) or 1) == 1									
	Button[2]["command"]		= "showunitaura"
	Button[2]["label"]			= "Show units aura:"

	Button[3]["click"]			= tonumber(Spring.GetConfigInt("unitshealtbar",1) or 1) == 1									
	Button[3]["command"]		= "showunithbar"
	Button[3]["label"]			= "Show units healt/weapon bars:"	
	
	Button[4]["click"]			= tonumber(Spring.GetConfigInt("unitsetabar",1) or 1) == 1									
	Button[4]["command"]		= "showunitetabar"
	Button[4]["label"]			= "Show units ETA bars:"	

	Button[5]["click"]			= tonumber(Spring.GetConfigInt("unitsrank",1) or 1) == 1									
	Button[5]["command"]		= "showunitrank"
	Button[5]["label"]			= "Show units rank:"	
	
	Button[6]["click"]			= tonumber(Spring.GetConfigInt("camerashake",1) or 1) == 1									
	Button[6]["command"]		= "shakecamera"
	Button[6]["label"]			= "Camera shake during explosions:"	
	
	Button[7]["click"]			= tonumber(Spring.GetConfigInt("showingamemessage",1) or 1) == 1									
	Button[7]["command"]		= "ingamemessage"
	Button[7]["label"]			= "Show ingame alerts:"	
	
	Button[8]["click"]			= tonumber(Spring.GetConfigInt("showlos",1) or 1) == 1									
	Button[8]["command"]		= "loseff"
	Button[8]["label"]			= "Show LOS fog:"		
	
	Button[9]["click"]			= tonumber(Spring.GetConfigInt("showvline",1) or 1) == 1									
	Button[9]["command"]		= "vlineopt"
	Button[9]["label"]			= "Show vertical line on radar dots:"	
	
	Button[10]["click"]			= tonumber(Spring.GetConfigInt("showipsawn",1) or 1) == 1									
	Button[10]["command"]		= "ipsawnopt"
	Button[10]["label"]			= "Show initial point spawn:"	
	
	Button[11]["click"]			= tonumber(Spring.GetConfigInt("showteamaura",1) or 1) == 1									
	Button[11]["command"]		= "teamauraopt"
	Button[11]["label"]			= "Show aura on teammates selected units:"		

	Button[12]["click"]			= tonumber(Spring.GetConfigInt("showteamcurs",1) or 1) == 1									
	Button[12]["command"]		= "teamcursopt"
	Button[12]["label"]			= "Show teammates cursor:"		

	Button[13]["click"]			= tonumber(Spring.GetConfigInt("FullscreenEdgeMove",1) or 1) == 1		
	Button[13]["command"]		= "setedgecamera"
	Button[13]["label"]			= "Edge camera move (require restart):"

	Button[14]["click"]			= WG.nameScaling or false
	Button[14]["command"]		= "scale-names"
	Button[14]["label"]			= "Scale commander names to zoom-level:"

	Panel["main"]["x1"]			= posX
	Panel["main"]["x2"]			= posX + width
	Panel["main"]["y1"]			= posY
	Panel["main"]["y2"]			= posY + height
	
	iHeight						= height0  + rows * (iRowHeight+4)
	
	Panel["info"]["x1"]			= posX
	Panel["info"]["x2"]			= posX + iWidth
	Panel["info"]["y1"]			= posY
	Panel["info"]["y2"]			= posY + iHeight
	
	ButtonClose["x1"] 			= posX + width/2 - 30
	ButtonClose["y1"] 			= posY + 20
	ButtonClose["x2"] 			= ButtonClose["x1"] + 60
	ButtonClose["y2"] 			= posY + 50
	
end

function ButtonHandler (cmd)

---------------------------
-- CAMERA		
---------------------------
    if cmd == "cameraPrev" then
		if Button[1]["value"] ~= math.max(Button[1]["value"] - 1,0) then
			Button[1]["value"] = math.max(Button[1]["value"] - 1,0)
--			Spring.SendCommands("CamMode" .. tonumber(Button[12]["value"]))
			Spring.SetConfigInt("CamMode",(Button[1]["value"]))
		end

--		InitButtons() tolto #####################
	elseif cmd == "cameraNext" then	
		if Button[1]["value"] ~= math.min(Button[1]["value"] + 1,5) then
			Button[1]["value"] = math.min(Button[1]["value"] + 1,5)
--			Spring.SendCommands("CamMode" .. tonumber(Button[12]["value"]))
			Spring.SetConfigInt("CamMode",(Button[1]["value"]))
		end
---------------------------
-- UNITS SPOT
---------------------------	
	elseif cmd == "showunitaura" then			
		if Button[2]["click"] then
			Spring.SetConfigInt("unitsaura",0)
			Spring.SendCommands({"luaui disablewidget Spotter"}) 			
		else
			Spring.SetConfigInt("unitsaura",1)
			Spring.SendCommands({"luaui enablewidget Spotter"}) 			
		end	
---------------------------
-- HEALTBAR
---------------------------	
	elseif cmd == "showunithbar" then				
		if Button[3]["click"] then
			Spring.SetConfigInt("unitshealtbar",0)
			Spring.SendCommands({"luaui disablewidget HealthBars"}) 			
		else
			Spring.SetConfigInt("unitshealtbar",1)
			Spring.SendCommands({"luaui enablewidget HealthBars"}) 			
		end
---------------------------
-- ETA
---------------------------	
	elseif cmd == "showunitetabar" then				
			if Button[4]["click"] then
			Spring.SetConfigInt("unitsetabar",0)
			Spring.SendCommands({"luaui disablewidget BuildETA"}) 			
		else
			Spring.SetConfigInt("unitsetabar",1)
			Spring.SendCommands({"luaui enablewidget BuildETA"}) 			
		end
---------------------------
-- RANK
---------------------------	
	elseif cmd == "showunitrank" then				
			if Button[5]["click"] then
			Spring.SetConfigInt("unitsrank",0)
			Spring.SendCommands({"luaui disablewidget Rank Icons"}) 			
		else
			Spring.SetConfigInt("unitsrank",1)
			Spring.SendCommands({"luaui enablewidget Rank Icons"}) 			
		end
---------------------------
-- CAMERA SHAKE
---------------------------	
	elseif cmd == "shakecamera" then				
			if Button[6]["click"] then
			Spring.SetConfigInt("camerashake",0)
			Spring.SendCommands({"luaui disablewidget CameraShake"}) 			
		else
			Spring.SetConfigInt("camerashake",1)
			Spring.SendCommands({"luaui enablewidget CameraShake"}) 			
		end
---------------------------
-- IN GAME MESSAGES ################################# TO BE IMPROOOOOVEEE
---------------------------		
	elseif cmd == "ingamemessage" then			
			if Button[7]["click"] then
			Spring.SetConfigInt("showingamemessage",0)
			Spring.Echo("to be improove")
			Spring.SendCommands({"luaui disablewidget Warning messages"}) 			
		else
			Spring.SetConfigInt("showingamemessage",1)
			Spring.SendCommands({"luaui enablewidget Warning messages"}) 			
			Spring.Echo("to be improove")
		end
---------------------------
-- LOS
---------------------------		
	elseif cmd == "loseff" then			
			if Button[8]["click"] then
			Spring.SetConfigInt("showlos",0)
			Spring.SendCommands({"luaui disablewidget LOS View"}) 			
		else
			Spring.SetConfigInt("showlos",1)
			Spring.SendCommands({"luaui enablewidget LOS View"}) 			
		end
---------------------------
-- VERTICAL LINE
---------------------------		
	elseif cmd == "vlineopt" then			
			if Button[9]["click"] then
			Spring.SetConfigInt("showvline",0)
			Spring.SendCommands({"luaui disablewidget Vertical Line on Radar Dots"}) 			
		else
			Spring.SetConfigInt("showvline",1)
			Spring.SendCommands({"luaui enablewidget Vertical Line on Radar Dots"}) 			
		end
---------------------------
-- INITIAL POINT TO SPAWN
---------------------------	
	elseif cmd == "ipsawnopt" then				
			if Button[10]["click"] then
			Spring.SetConfigInt("showipsawn",0)
			Spring.SendCommands({"luaui disablewidget Start Point Adder"}) 			
		else
			Spring.SetConfigInt("showipsawn",1)
			Spring.SendCommands({"luaui enablewidget Start Point Adder"}) 			
		end
---------------------------
-- TEAM SELECTED UNITS
---------------------------			
	elseif cmd == "teamauraopt" then		
			if Button[11]["click"] then
			Spring.SetConfigInt("showteamaura",0)
			Spring.SendCommands({"luaui disablewidget Ally Selected Units"}) 			
		else
			Spring.SetConfigInt("showteamaura",1)
			Spring.SendCommands({"luaui enablewidget Ally Selected Units"}) 			
		end
---------------------------
-- TEAM CURSOR
---------------------------					
	elseif cmd == "teamcursopt" then
			if Button[12]["click"] then
			Spring.SetConfigInt("showteamcurs",0)
			Spring.SendCommands({"luaui disablewidget AllyCursors"}) 			
		else
			Spring.SetConfigInt("showteamcurs",1)
			Spring.SendCommands({"luaui enablewidget AllyCursors"}) 			
		end		
---------------------------
-- MUOVI LA CAMERA CON IL CURSORE AI BORDI (SIA FULLSCREEN CHE WINDOWED MODE)
---------------------------					
	elseif cmd == "setedgecamera" then
			if Button[13]["click"] then
			Spring.SetConfigInt("FullscreenEdgeMove",0)
			Spring.SendCommands("FullscreenEdgeMove 0")		
			Spring.SendCommands("WindowedEdgeMove 0")		
		else
			Spring.SetConfigInt("FullscreenEdgeMove",1)
			Spring.SendCommands("FullscreenEdgeMove 1")		
			Spring.SendCommands("WindowedEdgeMove 1")				
		end				
---------------------------
-- SCALE COMMANDER NAME
---------------------------			
	elseif cmd == "scale-names" then
		Spring.SendCommands("comnamescale")
	else
		Echo("Local command:",cmd)
	end
end

--------------------------------------------------------------------------------			 
-- Callins
--------------------------------------------------------------------------------

local function drawRow(optData,i,lastY)
	local name = optData["name"]
	local type = optData["type"]
	local value = optData["value"]
	
	local yi = lastY - 14
	lastY = lastY - 14
	
	local label = formatLabel(value,type,name)
	
	if label ~= "N/A" and type then
		myFont:Print(label, Panel["info"]["x2"] - leftmargin, yi,textSize,'rdo')
		myFont:SetTextColor(cButton)
		myFont:Print(name, Panel["info"]["x1"] + leftmargin, yi,textSize,'do')
		i = i + 1
		rows = rows + 1
	else
		lastY = lastY + 14
	end
	myFont:SetTextColor(cButton)
	
	if i%2 ~= 0 and type and label ~= "N/A" then
		gl.Color(cRow)
		gl.Rect(Panel["info"]["x1"]+ leftmargin, yi, Panel["info"]["x2"]-leftmargin,yi + 14)
		gl.Color(cWhite)
	end
	return i,lastY
end

local function drawModOptions() -- valido per il mod optionz

	--background panel
	gl.Color(cBack)
	gl.Rect(Panel["info"]["x1"],Panel["info"]["y1"], Panel["info"]["x2"], Panel["info"]["y2"])
	
	--border
	gl.Color(cBorder)
	gl.Rect(Panel["info"]["x1"]-1,Panel["info"]["y1"], Panel["info"]["x1"], Panel["info"]["y2"])
	gl.Rect(Panel["info"]["x2"],Panel["info"]["y1"], Panel["info"]["x2"]+1, Panel["info"]["y2"])
	gl.Rect(Panel["info"]["x1"],Panel["info"]["y1"]-1, Panel["info"]["x2"], Panel["info"]["y1"])
	gl.Rect(Panel["info"]["x1"],Panel["info"]["y2"], Panel["info"]["x2"], Panel["info"]["y2"]+1)
	
	-- Heading
	myFontBigger:Begin()
	myFontBigger:SetTextColor(cWhite)
	myFontBigger:Print("XTA Mod options", (Panel["info"]["x1"] + Panel["info"]["x2"])/2 , Panel["info"]["y2"] - 20,18,'cds')
	myFontBigger:End()
	-- content
	local lastY = Panel["info"]["y2"] - 20
	rows = 0
	
	--General options heading
	do
		myFontBig:Begin()
		if Options["general"] and OptionCount["general"] > 0 then
			myFontBig:SetTextColor(cYellow) -- yellow
			myFontBig:Print("General:", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
			lastY = lastY - 40
		end
		myFontBig:End()
		
		--General options
		myFont:Begin()
		local i = 0
		
		for _,opt in pairs(Options["general"]) do
			i,lastY = drawRow(opt,i,lastY)
		end
		myFont:End()
	end
	--Other options heading 
	do
		if Options["other"] and OptionCount["other"] > 0 then
			myFontBig:Begin()
			myFontBig:SetTextColor(cYellow) -- yellow
			myFontBig:Print("More options:", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
			lastY = lastY - 40
			myFontBig:End()
		end
		
		--Other options
		myFont:Begin()
		local i = 0
		for _,opt in pairs(Options["other"]) do
			i,lastY = drawRow(opt,i,lastY)
		end
		myFont:End()
	end
	-- unit packs heading
	do
		if Options["unitpacks"] and OptionCount["unitpacks"] > 0 then
			myFontBig:Begin()
			myFontBig:SetTextColor(cYellow) -- yellow
			myFontBig:Print("Unit packs:", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
			lastY = lastY - 40
			myFontBig:End()
		end
		
		-- unit packs
		myFont:Begin()
		local i = 0
		for _,opt in pairs(Options["unitpacks"]) do
			i,lastY = drawRow(opt,i,lastY)
		end
		myFont:End()
	end
	--multiplier options heading
	do
		if Options["multiplier"] and OptionCount["multiplier"] > 0 then
			myFontBig:Begin()
			myFontBig:SetTextColor(cYellow) -- yellow
			myFontBig:Print("Multiplier settings:", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
			lastY = lastY - 40
			myFontBig:End()
		end
		
		--multiplier options
		myFont:Begin()
		local i = 0
		for _,opt in pairs(Options["multiplier"]) do
			i,lastY = drawRow(opt,i,lastY)
		end
		myFont:End()
	end
	--KOTH options heading
	do
		if Options["koth"] and (Options["koth"][1]["value"] == 1 or Options["koth"][1]["value"] == "1") then
			if Options["koth"] then
				myFontBig:Begin()
				myFontBig:SetTextColor(cYellow) -- yellow
				myFontBig:Print("King of the hill options", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
				lastY = lastY - 40
				myFontBig:End()
			end
			
			--KOTH options
			myFont:Begin()
			local i = 0
			for _,opt in pairs(Options["koth"]) do
				i,lastY = drawRow(opt,i,lastY)
			end
			myFont:End()
		end
	end
	
	--Fleabowl options heading
	do
		
		if (Spring.GetGameRulesParam('Fleabowl') == 1 or Spring.GetGameRulesParam('Fleabowl') == '1') then
			if Options["fleabowl"] then
				myFontBig:Begin()
				myFontBig:SetTextColor(cYellow) -- yellow
				myFontBig:Print("Fleabowl options", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
				lastY = lastY - 40
				myFontBig:End()
			end
			
			--FB options
			myFont:Begin()
			local i = 0
			for _,opt in pairs(Options["fleabowl"]) do
				i,lastY = drawRow(opt,i,lastY)
			end
			myFont:End()
		end
	end
	
	
	--Experimental options heading
	do
		if Options["experimental"] and OptionCount["experimental"] > 0 then
			myFontBig:Begin()
			myFontBig:SetTextColor(cYellow) -- yellow
			myFontBig:Print("Experimental options:", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
			lastY = lastY - 40
			myFontBig:End()
		end
		
		--Experimental options
		myFont:Begin()
		local i = 0
		for _,opt in pairs(Options["experimental"]) do
			i,lastY = drawRow(opt,i,lastY)
		end
		myFont:End()
	end
	-- update height and position of window
	updateHeights()
	
	-- exitbutton
	if ButtonClose.above then
		gl.Color(cAbove)
	else
		gl.Color(cGrey)
	end
	gl.TexRect(ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"])
	myFontBig:Begin()
	myFontBig:SetTextColor(cWhite)
	myFontBig:Print("Close", (ButtonClose["x1"]+ButtonClose["x2"])/2, (ButtonClose["y1"]+ButtonClose["y2"])/2,14,'vcs')
	myFontBig:End()
		
	--reset state
	gl.Texture(false)
	gl.Color(cWhite)
end

local function drawMapOptions() -- valido per map option
	
	--background panel
	gl.Color(cBack)
	gl.Rect(Panel["info"]["x1"],Panel["info"]["y1"], Panel["info"]["x2"], Panel["info"]["y2"])
	
	--border
	gl.Color(cBorder)
	gl.Rect(Panel["info"]["x1"]-1,Panel["info"]["y1"], Panel["info"]["x1"], Panel["info"]["y2"])
	gl.Rect(Panel["info"]["x2"],Panel["info"]["y1"], Panel["info"]["x2"]+1, Panel["info"]["y2"])
	gl.Rect(Panel["info"]["x1"],Panel["info"]["y1"]-1, Panel["info"]["x2"], Panel["info"]["y1"])
	gl.Rect(Panel["info"]["x1"],Panel["info"]["y2"], Panel["info"]["x2"], Panel["info"]["y2"]+1)
	--testare aggiungendo le linee
--	gl.Color( 1, 1, 0, 0 )--glColor( 1, 1, 0, 0.33) --imposta colore linea
--	gl.Vertex(50,50) -- imposta linee
--	gl.Vertex(50,100) -- imposta linee 
--  eccetera
	
	-- Heading
	myFontBigger:Begin()
	myFontBigger:SetTextColor(cWhite)
	myFontBigger:Print(Game.mapName, (Panel["info"]["x1"] + Panel["info"]["x2"])/2 , Panel["info"]["y2"] - 20,18,'cds')
	myFontBigger:End()
	-- content
	local lastY = Panel["info"]["y2"] - 20
	rows = 0
	
	--Map options
	do
		myFontBig:Begin()
		if Options["general"] and OptionCount["general"] > 0 then
			myFontBig:SetTextColor(cYellow) -- yellow
			myFontBig:Print("Map options:", Panel["info"]["x1"] + leftmargin, lastY - 40,14,'do')
			lastY = lastY - 40
		end
		myFontBig:End()
		
		--General options
		myFont:Begin()
		local i = 0
		
		for _,opt in pairs(Options["map"]) do
			i,lastY = drawRow(opt,i,lastY)
		end
		myFont:End()
	end
	
	-- update height and position of window
	updateHeights()
	
	-- exitbutton
	if ButtonClose.above then
		gl.Color(cAbove)
	else
		gl.Color(cGrey)
	end
	gl.TexRect(ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"])
	myFontBig:Begin()
	myFontBig:SetTextColor(cWhite)
	myFontBig:Print("Close", (ButtonClose["x1"]+ButtonClose["x2"])/2, (ButtonClose["y1"]+ButtonClose["y2"])/2,14,'vcs')
	myFontBig:End()
		
	--reset state
	gl.Texture(false)
	gl.Color(cWhite)
end

local function drawSettings() -- valido per opzioni menu
	--test
--	gl.Color( 1, 1, 0, 0 )--glColor( 1, 1, 0, 0.33) --imposta colore linea
--	gl.Vertex(50,50) -- imposta linee
--	gl.Vertex(50,100) -- imposta linee 
--  eccetera



	
	
	--background panel 
	gl.Color(cWhite)

	gl.Texture(sfondomenu)	-- aggiungo l'immagine al background
	gl.TexRect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"])	
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"])
	gl.Texture(false)	-- fine texture	
	
	--border
--	gl.Color(cBorder)
--	gl.Rect(Panel["main"]["x1"]-1,Panel["main"]["y1"], Panel["main"]["x1"], Panel["main"]["y2"])
--	gl.Rect(Panel["main"]["x2"],Panel["main"]["y1"], Panel["main"]["x2"]+1, Panel["main"]["y2"])
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y1"]-1, Panel["main"]["x2"], Panel["main"]["y1"])
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y2"], Panel["main"]["x2"], Panel["main"]["y2"]+1)
	
	-- icona menu
	
	gl.Texture(icona_graphics)	-- aggiungo l'icona
	gl.TexRect(Panel["main"]["x1"]+20,Panel["main"]["y1"]+424, Panel["main"]["x1"]+60, Panel["main"]["y1"]+464)	
	gl.Texture(false)	-- fine texture		
	
	-- Heading
	myFontBig:Begin()
	myFontBig:SetTextColor(cWhite)
	myFontBig:Print("Visuals settings", Panel["main"]["x1"]+50 + leftmargin, Panel["main"]["y2"] - 34,14,'ds')
	myFontBig:End()


	-- exit
	
	myFontBig:Begin()
	if ButtonClose.above then
	gl.Texture(imgQuit2)	-- aggiungo l'immagine al pulsante close menù	
	gl.TexRect(ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"])
	gl.Texture(false)	-- fine texture		
	myFontBig:SetTextColor(cWhite)
	else
	gl.Texture(imgQuit)	-- aggiungo l'immagine al pulsante close menù
	gl.TexRect(ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"])
	gl.Texture(false)	-- fine texture
	myFontBig:SetTextColor(notOver)
	end
	myFontBig:Print("Close", (ButtonClose["x1"]+ButtonClose["x2"])/2, (ButtonClose["y1"]+ButtonClose["y2"])/2,14,'vcs')
	myFontBig:End()	
	-- Buttons	


	
	-- other
	for _,button in ipairs(Button) do

		gl.Color(backbutton)																	-- disegno i riquadri di ogni opzione
		gl.Rect(Panel["main"]["x1"]+1,button["y1"]-2, Panel["main"]["x2"]-1, button["y1"]+18) 	-- disegno i riquadri di ogni opzione
		
		myFont:Begin()
		if button["mouse"] then
			myFont:SetTextColor(cLight)
		else
			myFont:SetTextColor(cButton)
		end
		
		myFont:Print(button["label"] or "N/A", posX+leftmargin, button["y1"],12,'do')
		myFont:End()

		gl.Color(cWhite)
		if button["divided"] then
			if button["img"] then
				gl.Texture(button["img"])
			else
				gl.Texture(optContrast)
			end
		else
			if button["click"] then
				gl.Texture(optCheckBoxOn)
			else
				gl.Texture(optCheckBoxOff)
			end
		end
		
		gl.TexRect(button["x1"],button["y1"],button["x2"],button["y2"])
		gl.Texture(false)
	end
		
	--reset state
	gl.Texture(false)
	gl.Color(cWhite)
	
		-- add gui shader	
	
		if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].InsertRect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"],'gui_options_b')
	end
end

local function drawIsAbove(x,y)
	
	if not x or not y then return false end
	
	for _,button in pairs(Button) do
		button["mouse"] = false
	end
	ButtonClose.above = false
	
	for _,button in pairs(Button) do
		if IsOnButton(x, y, button["x1"],button["y1"],button["x2"],button["y2"]) then
			button["mouse"] = true
			return true
		end
	end
	
	if IsOnButton(x, y, ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"]) then
		ButtonClose.above = true
	end
	
	return false
end

function widget:DrawScreen()
	if (not Spring.IsGUIHidden()) then
		if showModOptions then
			drawModOptions()
		elseif showSettings then
			drawSettings()
		elseif showMapOptions then
			drawMapOptions()
		end
	end
end

function widget:IsAbove(x,y)
	if (not Spring.IsGUIHidden()) then
		if showModOptions or showSettings or showMapOptions then
			drawIsAbove(x,y)
		end
	end
	--this callin must be present, otherwise function widget:TweakIsAbove(x,y) isn't called. Maybe a bug in widgethandler.
end

function widget:TextCommand(command)

------------ rimuovere tutto il codice inerente a draw, voting ecc vedi sotto ######################################################################################	
--	if command == 'draw' or command == 'votefordraw' then
--		Spring.SendCommands("luarules votefordraw")
--	elseif command == 'voting' or command == 'voteforend'then
--		Spring.SendCommands("luarules voteforend")
--	elseif command == 'show-modoptions' then
--		showModOptions = true
--	elseif command == 'show-mapoptions' then
--		showMapOptions = true
	if command == 'visual_opt' then
		showSettings = true
	end
end

function widget:MouseMove(mx, my, dx, dy, mButton)
	
      --Dragging
     if mButton == 2 or mButton == 3 then
		 posX = math.max(0, math.min(posX+dx, vsx-width))	--prevent moving off screen
		 posY = math.max(0, math.min(posY+dy, vsy-height))
		 InitButtons()
     end
 end 
 
function widget:MousePress(x, y, button)
	 if button == 1 and (showSettings or showModOptions or showMapOptions) then
		
		for _,button in ipairs(Button) do
			if IsOnButton(x, y, button["x1"],button["y1"],button["x2"],button["y2"]) then
				if not button["click"] then
					PlaySoundFile(sndButtonOn,1.0,0,0,0,0,0,0,'userinterface')
				else
					PlaySoundFile(sndButtonOff,1.0,0,0,0,0,0,0,'userinterface')
				end
				if button["divided"] then
					if button["wide"] then
						if x < button["x1"] + 3*buttonsize/2 then
							ButtonHandler(button["less"])
						else
							ButtonHandler(button["more"])
						end
					else
						if x < button["x1"] + 1.5*buttonsize/2 then
							ButtonHandler(button["less"])
						else
							ButtonHandler(button["more"])
						end
					end
					InitButtons()
				else 
					ButtonHandler(button["command"])
					button["click"] = not button["click"]
				end
				return true
			end	
		end
		if IsOnButton(x, y, ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"]) then -- exit from menu
			PlaySoundFile(sndButtonOff,1.0,0,0,0,0,0,0,'userinterface')
			showSettings = false
			showModOptions = false
			showMapOptions = false
		-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('gui_options_b')
				end			

			
		end
		
	elseif button == 2 or button == 3 then
		if (showModOptions or showMapOptions) and IsOnButton(x, y, Panel["info"]["x1"],Panel["info"]["y1"], Panel["info"]["x2"], Panel["info"]["y2"]) then			
			--Dragging
			return true			
		elseif showSettings and IsOnButton(x, y, Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"]) then
			--Dragging
			return true
		end
	end
	return false
 end
 
function widget:KeyPress(key, mods, isRepeat) 
	if (key == 0x069) and mods["ctrl"] and (not isRepeat) then 				-- i-key
		showModOptions = not showModOptions
		return true
	elseif key == 0x01B then -- ESC
		showModOptions = false
		showMapOptions = false
		showSettings = false
		return false
	elseif key == 0x124 and mods.ctrl then -- CTRL-F11
		showSettings = true
		return false
	end
	return false
end

--------------------------------------------------------------------------------			 
-- Tweak-mode
--------------------------------------------------------------------------------

function widget:TweakDrawScreen()
	if showSettings then
		drawSettings()
	end
end

function widget:TweakIsAbove(x,y)
	--Echo("Tweak Is Above callin:",x,y) -- This callin isn't working in spring 96. It may be fixed in the future.
	drawIsAbove(x,y)
 end
 
function widget:TweakMousePress(x, y, button)
	
	if button == 1 then
		for _,button in ipairs(Button) do
			if IsOnButton(x, y, button["x1"],button["y1"],button["x2"],button["y2"]) then
				if not button["click"] then
					PlaySoundFile(sndButtonOn,1.0,0,0,0,0,0,0,'userinterface')
				else
					PlaySoundFile(sndButtonOff,1.0,0,0,0,0,0,0,'userinterface')
				end
				if button["divided"] then
					if button["wide"] then
						if x < button["x1"] + 3*buttonsize/2 then
							ButtonHandler(button["less"])
						else
							ButtonHandler(button["more"])
						end
					else
						if x < button["x1"] + 1.5*buttonsize/2 then
							ButtonHandler(button["less"])
						else
							ButtonHandler(button["more"])
						end
					end
					InitButtons()
				else 
					ButtonHandler(button["command"])
					button["click"] = not button["click"]
				end
				return true
			end	
		end
		
		if IsOnButton(x, y, ButtonClose["x1"],ButtonClose["y1"],ButtonClose["x2"],ButtonClose["y2"]) then
			PlaySoundFile(sndButtonOff,1.0,0,0,0,0,0,0,'userinterface')
			showSettings = false
			showModOptions = false
			showMapOptions = false
		end
		
	 elseif (button == 2 or button == 3) then
		 if IsOnButton(x, y, Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"]) then
			  --Dragging
			 return true
		 end		
	 end
	 return false
 end

function widget:TweakMouseMove(mx, my, dx, dy, mButton)
	
      --Dragging
     if mButton == 2 or mButton == 3 then
		 posX = math.max(0, math.min(posX+dx, vsx-width))	--prevent moving off screen
		 posY = math.max(0, math.min(posY+dy, vsy-height))
		 InitButtons()
     end
 end
 
 function widget:Shutdown()
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].RemoveRect('gui_options_b')
	end
end
 
function widget:GetConfigData(data)      -- save
	local vsx, vsy = gl.GetViewSizes()
	return {
			posX         		= posX,
			posY         		= posY,
		}
	end

function widget:SetConfigData(data)      -- load
	posX         			= data.posX or posX
	posY         			= data.posY or posY
end
 