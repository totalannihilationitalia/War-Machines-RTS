function widget:GetInfo()
	return {
		name    = "Simple menu",
		desc    = "Show a simple menu button",
		author  = "Jools",
		date    = "Oct, 2014",
		license = "Public domain",
		layer   = 0,
		enabled = true
		-- rev 0.wmrts modified by molix: removed and added options for War Machines RTS
		-- rev 1.wmrts add graphics for War Machines RTS game
		-- rev 2.wmrts add guishader
		-- rev 3.open this menu from external command, like "come back button" from other options
		-- rev 4. remover dragging 30/11/2024
		 
		
	}
end

local Echo 							= Spring.Echo
local myFontBig	 					= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local myFont	 					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)
local sizex, sizey					= 400, 200 
local vsx, vsy 						= gl.GetViewSizes()
local posX, posY					= vsx/2, vsy/2
local rowgap						= 27
local rowheight						= 26
local margin						= 20
local myTeamID						= nil
local myAllyTeamID					= nil
local mySpectatorState				= Spring.GetSpectatingState()

local Button						= {}
local ButtonMenu					= {}
ButtonMenu.click					= false
local Panel							= {}
local glColor 						= gl.Color
local glRect						= gl.Rect
local glTexture 					= gl.Texture
local glTexRect 					= gl.TexRect
local PlaySoundFile 				= Spring.PlaySoundFile
local glTexture 					= gl.Texture


-- colors
local cLight						= {0.8, 0.8, 0.2, 0.3}
local cSelect						= {0.8, 0.8, 0.8, 0.5}
local cWhite						= {1, 1, 1, 1}
local cBorder						= {0.2, 0.2, 0.2, 0.5}		
local cBack							= {0, 0, 0, 0.3}
local cTitle						= {0.8, 0.8, 1.0, 1}
local cPanel						= {0.2, 0.2, 0.2, 0.4}
local cShadow						= {0.6, 0.6, 0.6, 0.6}
local cDisabled						= {0.4, 0.4, 0.4, 1.0}
local crelax				    	= {1, 1, 1, 1}
local cover							= {1, 1, 1, 0.8}
local backbutton					= {0.03,0.18,0.3,0.3} -- righe sotto opzioni

--sounds
local button6						= "sounds/button6.wav"
local button8						= "sounds/button8.wav"

--images
local main_butt_relax				= "LuaUI/Images/tweaksettings/menu_button_relax.png"
local main_butt_over				= "LuaUI/Images/tweaksettings/menu_button_over.png"
local main_butt_click				= "LuaUI/Images/tweaksettings/menu_button_click.png"
local main_background				= "LuaUI/Images/tweaksettings/sfondo_mainmenu.png"
local icona_graphics				= "LuaUI/Images/tweaksettings/menu_icon.png" -- icona main menu
local mini_resume				= "LuaUI/Images/tweaksettings/Return to game_mini.png"


local function IsOnButton(x, y, BLcornerX, BLcornerY,TRcornerX,TRcornerY)
	if BLcornerX == nil then return false end
	-- check if the mouse is in a rectangle

	return x >= BLcornerX and x <= TRcornerX
	                      and y >= BLcornerY
	                      and y <= TRcornerY

end

local function InitButtons()
	local L1 = 28	-- rowheight
	local L3 = 20   -- buttonheight
	local L2 = 100  -- button width
	
--	Button[9].disabled 				= mySpectatorState
	
	for i,button in ipairs(Button) do
		button["x1"] 	= posX + margin
		button["x2"]	= posX + sizex - margin
		button["y1"]	= posY + sizey - 2*rowheight - i*rowgap
		button["y2"]	= button.y1 + rowheight
		button["above"] = false
		button["click"] = false
	end
	
	Panel["main"]["x1"]			= posX
	Panel["main"]["x2"]			= posX + sizex
	Panel["main"]["y1"]			= posY
	Panel["main"]["y2"]			= posY + sizey
	
end

function widget:Initialize()
	myTeamID = Spring.GetLocalTeamID()
	myAllyTeamID = select(6,Spring.GetTeamInfo(myTeamID))
	ButtonMenu.x1					= vsx - 65
	ButtonMenu.x2					= vsx - 5
	ButtonMenu.y1					= vsy - 45
	ButtonMenu.y2					= vsy - 5
	
	
	Button[1] 						= {} -- resume
	Button[1]["command"]			= "resume"
	Button[1]["label"]				= "Return to game"
	Button[1]["icon"]				= "LuaUI/Images/tweaksettings/return_opt_mini.png"
	
	Button[2] 						= {} -- graphics options
	Button[2]["command"]			= "graphic_opt"
	Button[2]["label"]				= "Graphics settings"
	Button[2]["icon"]				= "LuaUI/Images/tweaksettings/graphics_opt_mini.png"	
	
	Button[3] 						= {} -- visuals options
	Button[3]["command"]			= "visual_opt"
	Button[3]["label"]				= "Visual settings"
	Button[3]["icon"]				= "LuaUI/Images/tweaksettings/visual_opt_mini.png"	

--	Button[3] 						= {} -- set keys
--	Button[3]["command"]				= "setkeys"
--	Button[3]["label"]				= "Set custom keys"

	Button[4] 						= {} -- sounds options
	Button[4]["command"]			= "sound_opt"
	Button[4]["label"]				= "Sound settings"
	Button[4]["icon"]				= "LuaUI/Images/tweaksettings/sound_opt_mini.png"	
	
--	Button[4] 						= {} -- energyview
--	Button[4]["command"]			= "energy"
--	Button[4]["label"]				= "Energy overview"
	
--	Button[5] 						= {} -- find unit
--	Button[5]["command"]			= "find-unit"
--	Button[5]["label"]				= "Find unit"
	
--	Button[6] 						= {} -- modopt
--	Button[6]["command"]			= "modopt"
--	Button[6]["label"]				= "View mod-options"
	
--	Button[7] 						= {} -- modopt
--	Button[7]["command"]			= "mapopt"
--	Button[7]["label"]				= "View map-options"
		
--	Button[8] 						= {} -- widget
--	Button[8]["command"]			= "widget"
--	Button[8]["label"]				= "Widget selector"
	
--	Button[9] 						= {} -- propose draw
--	Button[9]["command"]			= "offer-draw"
--	Button[9]["label"]				= "Offer draw"
--	Button[9].disabled 				= mySpectatorState
	
--	Button[10] 						= {} -- vote for surrender
--	Button[10]["command"]			= "vote-end"
--	Button[10]["label"]				= "Accept surrender"
--	Button[10].disabled 			= true
	
	Button[5] 						= {} -- quit
	Button[5]["command"]			= "quit"
	Button[5]["label"]				= "Quit game"
	Button[5]["icon"]				= "LuaUI/Images/tweaksettings/quit_opt_mini.png"	
	
	Button["close"] 				= {}
	Panel["main"]					= {}
	InitButtons()
		
end

local function DrawMenu()
	
	--background panel
	gl.Color(1,1,1,1)

--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"])
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo
	gl.TexRect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"])	
	gl.Texture(false)	-- fine texture		

	-- add gui shader	
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"],'Simple menu')
	end
	
	--border
--	gl.Color(cBorder)
--	gl.Rect(Panel["main"]["x1"]-1,Panel["main"]["y1"], Panel["main"]["x1"], Panel["main"]["y2"])
--	gl.Rect(Panel["main"]["x2"],Panel["main"]["y1"], Panel["main"]["x2"]+1, Panel["main"]["y2"])
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y1"]-1, Panel["main"]["x2"], Panel["main"]["y1"])
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y2"], Panel["main"]["x2"], Panel["main"]["y2"]+1)
	
	-- icona menu
	gl.Texture(icona_graphics)	-- add the icon
	gl.TexRect(Panel["main"]["x1"]+20,Panel["main"]["y1"]+167, Panel["main"]["x1"]+60, Panel["main"]["y1"]+207)	
	gl.Texture(false)	-- fine texture		
	
	-- Heading
	myFontBig:SetTextColor(cTitle)
	myFontBig:Begin()
	myFontBig:Print("Game menu", Panel["main"]["x1"]+50 + margin, Panel["main"]["y2"] - 34,14,'ds')
	myFontBig:End()
	
	-- Buttons
	for _,button in ipairs(Button) do
		myFont:Begin()
		if button["disabled"] then
			myFont:SetTextColor(cDisabled)
			gl.Color(cPanel)
		elseif button["above"] then
			myFont:SetTextColor(cWhite)
			gl.Color(cLight)
		else
			myFont:SetTextColor(cWhite)
			gl.Color(cPanel)
		gl.Color(backbutton)					
		end

		gl.Rect(button.x1-19,button.y1,button.x2+19,button.y2)
		myFont:Print(button["label"] or "N/A", button.x1+margin+5, (button.y1+button.y2)/2,12,'vs')
		myFont:End()
		-- add button icon
		gl.Texture(button["icon"])	 								-- type of image (see button configuration - icon)
		gl.TexRect(button.x1-9,button.y1+1,button.x1+15,button.y2-1)	-- dimensions of icons

		
	end
		
	--reset state
	gl.Texture(false)
	gl.Color(1,1,1,1)
end

function widget:TextCommand(command) -- add bay molix 30/11/2024 open menu from external command (like back manu button)

	if command == 'open_WMRTS_menu' then
		ButtonMenu.click = true
	end
end


local function ButtonHandler (cmd)
	if cmd == "resume" then
		ButtonMenu.click = false
		PlaySoundFile(button6)
	elseif cmd == "graphic_opt" then -- apri gui_options.lua
		ButtonMenu.click = false
		Spring.SendCommands("graphics_opt")
		PlaySoundFile(button8)
	elseif cmd == "visual_opt" then -- apri gui_optionsb.lua
		ButtonMenu.click = false
		Spring.SendCommands("visual_opt")
		PlaySoundFile(button8)
	elseif cmd == "sound_opt" then -- apri gui_optionsc.lua
		ButtonMenu.click = false
		Spring.SendCommands("sound_opt")
--		Spring.Echo("Not available at the moment, wait for next update! :) ") removed by molix 30/11/2024
		PlaySoundFile(button8)
--[[		
	elseif cmd == "energy" then
		ButtonMenu.click = false
		Spring.SendCommands("energy-overview")
		PlaySoundFile(button8)
	elseif cmd == "modopt" then
		ButtonMenu.click = false
		Spring.SendCommands("show-modoptions")
		PlaySoundFile(button8)
	elseif cmd == "mapopt" then
		ButtonMenu.click = false
		Spring.SendCommands("show-mapoptions")
		PlaySoundFile(button8)
	elseif cmd == "widget" then
		ButtonMenu.click = false
		Spring.SendCommands("selector")
		PlaySoundFile(button8)

]]--
	elseif cmd == "quit" then
		ButtonMenu.click = false
		Spring.SendCommands("quitmenu")
		PlaySoundFile(button8)
	
--[[		
	elseif cmd == "offer-draw" then
		ButtonMenu.click = false
		Spring.SendCommands("luarules votefordraw")
		PlaySoundFile(button8)
	elseif cmd == "vote-end" then
		ButtonMenu.click = false
		Spring.SendCommands("luarules voteforend")
		PlaySoundFile(button8)
	elseif cmd == "find-unit" then
		ButtonMenu.click = false
		Spring.SendCommands("findunit")
		PlaySoundFile(button8)
]]--		
	else
		Echo("Local command:",cmd)
		ButtonMenu.click = false
	end
end

function widget:DrawScreen()
		
	-- draw menu button
	if ButtonMenu.above then
		glColor(crelax)
		gl.Texture(main_butt_over)	-- over button image		
	elseif ButtonMenu.click then
		glColor(crelax)
		gl.Texture(main_butt_click)	-- clicked button image			
	else
		glColor(crelax)
		gl.Texture(main_butt_relax)	-- relax button image
	end
	


	gl.TexRect(ButtonMenu.x1,ButtonMenu.y1,ButtonMenu.x2,ButtonMenu.y2)	
	gl.Texture(false)	-- end texture	
--	glRect(ButtonMenu.x1,ButtonMenu.y1,ButtonMenu.x2,ButtonMenu.y2) -- old menu button
	
	glColor(cPanel)
	local mg = 10
	-- draw three stripes to symbolise menu drawer
--	glRect(ButtonMenu.x1+mg,ButtonMenu.y2 - 11,ButtonMenu.x2-mg,ButtonMenu.y2 - 13)
--	glRect(ButtonMenu.x1+mg,ButtonMenu.y2 - 16,ButtonMenu.x2-mg,ButtonMenu.y2 - 18)
--	glRect(ButtonMenu.x1+mg,ButtonMenu.y2 - 21,ButtonMenu.x2-mg,ButtonMenu.y2 - 23)
--	glColor(cShadow)
--	glRect(ButtonMenu.x1+mg,ButtonMenu.y2 - 13,ButtonMenu.x2-mg,ButtonMenu.y2 - 14)
--	glRect(ButtonMenu.x1+mg,ButtonMenu.y2 - 18,ButtonMenu.x2-mg,ButtonMenu.y2 - 19)
--	glRect(ButtonMenu.x1+mg,ButtonMenu.y2 - 23,ButtonMenu.x2-mg,ButtonMenu.y2 - 24)
	
	--menu border
--	glColor(cShadow)
--	glRect(ButtonMenu.x1,ButtonMenu.y1,ButtonMenu.x1+1,ButtonMenu.y2)
--	glRect(ButtonMenu.x2-1,ButtonMenu.y1,ButtonMenu.x2,ButtonMenu.y2)
--	glRect(ButtonMenu.x1,ButtonMenu.y1,ButtonMenu.x2,ButtonMenu.y1+1)
--	glRect(ButtonMenu.x1,ButtonMenu.y2-1,ButtonMenu.x2,ButtonMenu.y2)
	
	-- draw menu
	if (not Spring.IsGUIHidden()) and ButtonMenu.click then  -- qui clicca sull icona per aprire il menu

	-- Spring.Echo("helloWorld")	-- per debug

	DrawMenu()
	end
end

function widget:MousePress(mx, my, mButton)
	if not Spring.IsGUIHidden() then
		
		if mButton == 1 then
			if IsOnButton(mx, my, ButtonMenu["x1"],ButtonMenu["y1"],ButtonMenu["x2"],ButtonMenu["y2"]) then
				ButtonMenu.click = true
				PlaySoundFile(button6)
--				Spring.Echo("helloWorld")	-- per debug -- si attiva quando premo sull'icona
				mySpectatorState = Spring.GetSpectatingState()
				local canVoteTeam = Spring.GetGameRulesParam("VotingAllyID")
			
			
--				if not mySpectatorState and canVoteTeam and canVoteTeam == myAllyTeamID then
--					Button[10].disabled 				= false
--				else
--					Button[10].disabled 				= true
--				end			
				
				return true
			end
		end
		
		if ButtonMenu.click then		
			if mButton == 1 then
			
				for _,button in pairs(Button) do
					if IsOnButton(mx, my, button["x1"],button["y1"],button["x2"],button["y2"]) then
						if not button.disabled then
							button["click"] = true
							ButtonHandler(button["command"])
							
										-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('Simple menu')
				end
							
							return true
						end
					end
				end
		
---			elseif mButton == 2 or mButton == 3 then --rev 4 rimosso dragging
---				
---				if IsOnButton(mx, my, Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"]) then
---					--Dragging
---					return true
---				end
			end
		end
	end
	
	return false
 end	

function widget:MouseMove(mx, my, dx, dy, mButton)
      --Dragging
     if mButton == 2 or mButton == 3 then
		 posX = math.max(0, math.min(posX+dx, vsx-sizex))	--prevent moving off screen
		 posY = math.max(0, math.min(posY+dy, vsy-sizey))
		 InitButtons()
     end
 end

function widget:IsAbove(mx,my)
	if not Spring.IsGUIHidden() then
		ButtonMenu.above = IsOnButton(mx, my, ButtonMenu["x1"],ButtonMenu["y1"],ButtonMenu["x2"],ButtonMenu["y2"])
	
		if ButtonMenu.click then
			
			for _,button in pairs(Button) do
				button["above"] = false
			end
			
			for _,button in pairs(Button) do
				if IsOnButton(mx, my, button["x1"],button["y1"],button["x2"],button["y2"]) then
					button["above"] = true
					return true
				end
			end
		end
	end
	
	return false		
		
end	

function widget:KeyPress(key, mods, isRepeat) 
	if key == 0x01B then -- esc
		if ButtonMenu.click then
			ButtonMenu.click = false
			PlaySoundFile(button8)		
			-- remove gui shader
				if (WG['guishader_api'] ~= nil) then
					WG['guishader_api'].RemoveRect('Simple menu')
				end			
			return true
		end
	end
	
	return false
end

function widget:PlayerChanged(playerID)
	mySpectatorState = Spring.GetSpectatingState()
	InitButtons()
end

function widget:GameOver()
	widgetHandler:RemoveWidget()
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

function widget:Shutdown()
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].RemoveRect('Simple menu')
	end
end