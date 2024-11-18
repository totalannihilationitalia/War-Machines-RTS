function widget:GetInfo()
	return {
		name    = "WMRTS Mission obj GUI",
		desc    = "Shows War Machines RTS objectives during missions",
		author  = "Molix",
		date    = "Gen, 2022",
		license = "Public domain",
		layer   = 0,
		enabled = true
	}
--rev1: 18/11/2024 aggiunta condizione per farlo apparire (ismission = 1) 

end

local Echo 					     	= Spring.Echo
local myFontBig	 					= gl.LoadFont("FreeSansBold.otf",14, 1.9, 40)
local myFont	 					= gl.LoadFont("FreeSansBold.otf",12, 1.9, 40)
local sizex, sizey					= 400, 160
local vsx, vsy 						= gl.GetViewSizes()
local posX, posY					= vsx/2, vsy/2
local rowgap						= 27
local rowheight						= 26
local margin						= 20
local myTeamID						= nil
local myAllyTeamID					= nil
local mySpectatorState				= Spring.GetSpectatingState()
--local attivo						 -- rev1

local Button						= {}
local ObjMenu						= {}
ObjMenu.click						= false

local Panel							= {}
local glColor 						= gl.Color
local glRect						= gl.Rect
local glTexture 					= gl.Texture
local glTexRect 					= gl.TexRect
local PlaySoundFile 				= Spring.PlaySoundFile

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
local cTex							= {1, 1, 1, 0.75}

--sounds
local button6						= "sounds/button6.wav"
local button8						= "sounds/button8.wav"


local missionData						= {}
-- images
local imgMission						= "luaui/images/menu/button_obj.png" -- rev1
local main_background				= "LuaUI/Images/menu/sfondo_obj.png"
local icona_graphics				= "LuaUI/Images/menu/menu_obj_icon.png" -- icona main menu

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
	
	
	Panel["main"]["x1"]			= posX
	Panel["main"]["x2"]			= posX + sizex
	Panel["main"]["y1"]			= posY
	Panel["main"]["y2"]			= posY + sizey
	
	Button["close"]["x1"]		= posX
	Button["close"]["x2"]		= posX + sizex
	Button["close"]["y1"]		= posY
	Button["close"]["y2"]		= posY + sizey
	Button["close"]["above"] 	= false
	
end

-- mettere una condizione per attivare questo widget (al posto di quella sotto dopo --), del tipo dalle missioni, se ismission==1 ok altrimenti chiudi
function widget:Initialize()
--	attivo = Spring.GetModOptions().mo_comgate
--		Spring.Echo("variabile MO_gate = "..attivo)
--		if (attivo == 0) then 
		if Spring.GetModOptions().ismission=="0" then
--		Spring.Echo("WMRTS button mission off")
		widgetHandler:RemoveWidget()
		end
--	if not(Spring.GetGameRulesParam('IsMission') == 1 or Spring.GetGameRulesParam('IsMission') == '1') then  -- rev1 ******************** mettere la variabile ismission nel client --##dafare##############
		
	

	myTeamID = Spring.GetLocalTeamID()
	myAllyTeamID = select(6,Spring.GetTeamInfo(myTeamID))
	ObjMenu.x1					= vsx - 228  -- larghezza del bottone in alto a destra per aprire la lista degli obiettivi
	ObjMenu.x2					= vsx - 186
	ObjMenu.y1					= vsy - 45
	ObjMenu.y2					= vsy - 5

	Button["close"] 				= {}
	Panel["main"]					= {}
	InitButtons()
		
end

function widget:Shutdown()
	widgetHandler:DeregisterGlobal('ChickenEvent')
end

local function DrawMissionStats()
	
	--background panel
	gl.Color(1,1,1,1)
	gl.Texture(main_background)	-- aggiungo l'immagine di sfondo --rev1
	gl.TexRect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"])	
	gl.Texture(false)	-- fine texture	
	-- icona menu
	gl.Texture(icona_graphics)	-- aggiungo l'icona --rev1
	gl.TexRect(Panel["main"]["x1"]+20,Panel["main"]["y1"]+127, Panel["main"]["x1"]+60, Panel["main"]["y1"]+167)	
	gl.Texture(false)	-- fine texture	
	
	--border
--	gl.Color(cBorder)
--	gl.Rect(Panel["main"]["x1"]-1,Panel["main"]["y1"], Panel["main"]["x1"], Panel["main"]["y2"])
--	gl.Rect(Panel["main"]["x2"],Panel["main"]["y1"], Panel["main"]["x2"]+1, Panel["main"]["y2"])
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y1"]-1, Panel["main"]["x2"], Panel["main"]["y1"])
--	gl.Rect(Panel["main"]["x1"],Panel["main"]["y2"], Panel["main"]["x2"], Panel["main"]["y2"]+1)
	
	-- Heading
	myFontBig:SetTextColor(cTitle)
	myFontBig:Begin()
	myFontBig:Print("Mission objectives:", Panel["main"]["x1"]+50 + margin, Panel["main"]["y2"] - 34,14,'ds') 
	myFontBig:End()
	
	-- add gui shader	
	if (WG['guishader_api'] ~= nil) then
	WG['guishader_api'].InsertRect(Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"],'Simple menu')
	end	
	
	-- Info
	
	local y0 = Panel["main"]["y2"] - 40
	
	myFont:Begin()		
	myFont:SetTextColor(1,1,1,1)
	-- fare in modo che in funzione delle missioni scrivo n righe. --##dafare############## 
	
	
	-- scrivo nel menu i titoli degli obiettivi (distruggi x, difendi y ecc) impostabili dalla funzione function widget:GameFrame(frame)
	myFont:Print(missionData["titoloobj1"] or "-", Panel["main"]["x1"]+margin, y0 -20 ,12,'vs')
	myFont:Print(missionData["titoloobj2"] or "-", Panel["main"]["x1"]+margin, y0 - 40,12,'vs')
	myFont:Print(missionData["titoloobj3"] or "-", Panel["main"]["x1"]+margin, y0 - 60,12,'vs')
	myFont:Print(missionData["titoloobj4"] or "-", Panel["main"]["x1"]+margin, y0 - 80,12,'vs')
	myFont:Print(missionData["titoloobj5"] or "-", Panel["main"]["x1"]+margin, y0 - 100,12,'vs')
	myFont:SetTextColor(cWhite)
	-- ricevo lo stato degli obiettivi (in progess, complete, failed ecc) impostabili dalla funzione function widget:GameFrame(frame)
	myFont:Print(missionData["Objective 1"] or "-", Panel["main"]["x2"]-margin, y0 -20 ,12,'rvs')
	myFont:Print(missionData["Objective 2"] or "-", Panel["main"]["x2"]-margin, y0 - 40,12,'rvs')
	myFont:Print(missionData["Objective 3"] or "-", Panel["main"]["x2"]-margin, y0 - 60,12,'rvs')
	myFont:Print(missionData["Objective 4"] or "-", Panel["main"]["x2"]-margin, y0 - 80,12,'rvs')
	myFont:Print(missionData["Objective 5"] or "-", Panel["main"]["x2"]-margin, y0 - 100,12,'rvs')
	myFont:End()
		
	--reset state
	gl.Texture(false)
	gl.Color(1,1,1,1)
end


function widget:GameFrame(frame)
	if frame%30 == 0 then
		-- ricevo il numero degli obiettivi attivi per la missione
		missionData["numero_obiettivi_attivi"] 	= Spring.GetGameRulesParam("noobjactive")
		
	    -- ricevo lo stato della missione 1
		missionData["Objective 1"] 	= Spring.GetGameRulesParam("uploadobj1")
		-- ricevo lo stato della missione 2
		missionData["Objective 2"] 	= Spring.GetGameRulesParam("uploadobj2")
		-- ricevo lo stato della missione 3
		missionData["Objective 3"] 	= Spring.GetGameRulesParam("uploadobj3")
		-- ricevo lo stato della missione 4
		missionData["Objective 4"] 	= Spring.GetGameRulesParam("uploadobj4")
	    -- ricevo lo stato della missione 5
		missionData["Objective 5"] 	= Spring.GetGameRulesParam("uploadobj5")
		
		-- ricevo il titolo della missione 1
		missionData["titoloobj1"] 	= Spring.GetGameRulesParam("settitolo1")
		-- ricevo il titolo della missione 2
		missionData["titoloobj2"] 	= Spring.GetGameRulesParam("settitolo2")
		-- ricevo il titolo della missione 3
		missionData["titoloobj3"] 	= Spring.GetGameRulesParam("settitolo3")
		-- ricevo il titolo della missione 4
		missionData["titoloobj4"] 	= Spring.GetGameRulesParam("settitolo4")
		-- ricevo il titolo della missione 5
		missionData["titoloobj5"] 	= Spring.GetGameRulesParam("settitolo5")

	end
end

function widget:DrawScreen()
		
	-- draw menu button
	if ObjMenu.above then
		glColor(cLight)
	elseif ObjMenu.click then
		glColor(cSelect)
	else
		glColor(cBack)
	end
--	glRect(ObjMenu.x1,ObjMenu.y1,ObjMenu.x2,ObjMenu.y2)
--	local mg = 2
	
	gl.Color(cTex)
	glTexture(imgMission)
--	glTexRect(ObjMenu.x1+mg,ObjMenu.y1+mg,ObjMenu.x2-mg,ObjMenu.y2-mg)
	glTexRect(ObjMenu.x1,ObjMenu.y1,ObjMenu.x2,ObjMenu.y2)	
	
	glTexture(false)
--	glColor(cPanel)
			
	--menu border
--	glColor(cShadow)
--	glRect(ObjMenu.x1,ObjMenu.y1,ObjMenu.x1+1,ObjMenu.y2)
--	glRect(ObjMenu.x2-1,ObjMenu.y1,ObjMenu.x2,ObjMenu.y2)
--	glRect(ObjMenu.x1,ObjMenu.y1,ObjMenu.x2,ObjMenu.y1+1)
--	glRect(ObjMenu.x1,ObjMenu.y2-1,ObjMenu.x2,ObjMenu.y2)
	
	-- draw flea window
	if (not Spring.IsGUIHidden()) and ObjMenu.click then
		DrawMissionStats()
	end
end

function widget:MousePress(mx, my, mButton)
	if not Spring.IsGUIHidden() then
		
		if mButton == 1 then
			if IsOnButton(mx, my, ObjMenu["x1"],ObjMenu["y1"],ObjMenu["x2"],ObjMenu["y2"]) then
				ObjMenu.click = not ObjMenu.click
				PlaySoundFile(button6)				
				return true
			end
		end
		
		if ObjMenu.click then		
			if mButton == 1 then
				-- add close button
			elseif mButton == 2 or mButton == 3 then
				
				if IsOnButton(mx, my, Panel["main"]["x1"],Panel["main"]["y1"], Panel["main"]["x2"], Panel["main"]["y2"]) then
					--Dragging
					return true
				end
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
		ObjMenu.above = IsOnButton(mx, my, ObjMenu["x1"],ObjMenu["y1"],ObjMenu["x2"],ObjMenu["y2"])
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