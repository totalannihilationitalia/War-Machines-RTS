local versionName = "v1.01"
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:GetInfo()
  return {
    name      = "Vertical Line on Radar Dots",
    desc      = versionName .. " help you identify enemy units by adding vertical line on radar dots",
    author    = "msafwan",
    date      = "March 14, 2012",
    license   = "GNU GPL, v2 or later",
    layer     = 20,
    enabled   = true  --  loaded by default?
  }
end

local osClock = os.clock
local mathCeil = math.ceil
local mathMax = math.max
local spGetUnitPosition = Spring.GetUnitPosition
local spGetGroundHeight = Spring.GetGroundHeight
local spGetMyAllyTeamID = Spring.GetMyAllyTeamID 

local glVertex          = gl.Vertex 
local glPushAttrib  = gl.PushAttrib 
local glLineStipple = gl.LineStipple 
local glDepthTest   = gl.DepthTest 
local glLineWidth   = gl.LineWidth 
local glColor       = gl.Color 
local glBeginEnd    = gl.BeginEnd 
local glPopAttrib   = gl.PopAttrib 
local glCreateList  = gl.CreateList 
--local glCallList    = gl.CallList 
local glDeleteList  = gl.DeleteList 
local GL_LINES      = GL.LINES 

local dots_gbl = {}
local framePoll_gbl = {frame = 0, lastUpdate = 0} --// 1st number represent number of frame soo far, 2nd number represent the time of last update
local updateAtFrame_gbl = 0
local desiredDisplayInterval_gbl = 0.03
local myAllyTeamID = -1
-----------------------------------------
function widget:Initialize()
	framePoll_gbl.frame = 0
	framePoll_gbl.lastUpdate = osClock()
	myAllyTeamID = spGetMyAllyTeamID()
end

function widget:UnitEnteredRadar(unitID, allyTeam)
	if myAllyTeamID ~= allyTeam then
		if ( dots_gbl[unitID] == nil ) then --//a check to prevent crash in case 1: where enemy suddenly appear in LOS + Radar but LOS registered it first
			dots_gbl[unitID] = {position={0,0,0}, surface=0, isBelow = false, frame= 0, inLOS=false, wasInLOS = false}
		end
	end
end

function widget:UnitLeftRadar(unitID, allyTeam)
	if myAllyTeamID ~= allyTeam then 
		dots_gbl[unitID] = nil
	end
end

function widget:UnitEnteredLos(unitID, allyTeam )
	if myAllyTeamID ~= allyTeam then
		if ( dots_gbl[unitID] ~= nil ) then --//a check to prevent crash in case 2: where enemy appear in LOS but ally has no radar
			dots_gbl[unitID].inLOS= true
			dots_gbl[unitID].wasInLOS = true
		else  --//a check to prevent crash in case 1: where enemy suddenly appear in LOS + Radar but LOS registered it first
			dots_gbl[unitID] = {position={0,0,0}, surface=0, isBelow = false, frame= 0, inLOS=true , wasInLOS = true}
		end
	end
end

function widget:UnitLeftLos(unitID, allyTeam)
	if myAllyTeamID ~= allyTeam then --//a check to prevent crash in case 3: where enemy died in LOS + Radar but Radar registered the death first.
		if ( dots_gbl[unitID] ~= nil ) then
			dots_gbl[unitID].inLOS= false	
		end
	end
end
------------------------------------------------------
local function UpdateDotsContent (unitID, content) --//retrieve unit information.
	local x, y, z = spGetUnitPosition(unitID)
	if x == nil then return nil end
	local groundY = spGetGroundHeight(x,z)
	local surfaceY = mathMax (groundY, 0) --//select surface of water, or select ground height depending on which is higher. 
	if surfaceY > y then  --//mark unit as submerged if it below surface
		content.isBelow = true
	else 
		content.isBelow = false
	end
	content.surface = surfaceY
	content.position = {x,y,z}
	
	return content
end

local function GetAppropriateUpdateInterval (framePoll, updateAtFrame) --//poll 60 frame to check how long is 1 frame took
	local desiredDisplayInterval = desiredDisplayInterval_gbl
	---- localized global variable
	
	local currentTime = osClock()
	local secondPerFrame = (currentTime - framePoll.lastUpdate)/framePoll.frame
	framePoll.lastUpdate = currentTime
	local numberOfFrameForDesiredDisplayInterval = desiredDisplayInterval/secondPerFrame
	updateAtFrame = mathCeil(numberOfFrameForDesiredDisplayInterval) --//either using the number of frame needed to satisfy the desired interval, or update every 1 frame (in case the frame number is fractional, eg: <1). Prevent high FPS from updating dot position too much
	
	return framePoll, updateAtFrame
end

function widget:DrawWorld()
	local framePoll = framePoll_gbl
	local updateAtFrame = updateAtFrame_gbl
	local dots = dots_gbl

	framePoll.frame = framePoll.frame +1
	if framePoll.frame >= 60 then --//calculate the appropriate update interval by polling delay after 60 frame
		framePoll, updateAtFrame = GetAppropriateUpdateInterval (framePoll, updateAtFrame)
		framePoll.frame = 0
	end

	glPushAttrib(GL.LINE_BITS)	--//reference: "unit_target_on_the_move.lua" (by Google Frog), ZK gadget
	glDepthTest(false)
	glLineWidth(1.4)
	glColor(1, 0.75, 0, 1)
	for unitID, content in pairs(dots) do --//iterate over all dots and draw them
		if content ~= nil then
			if content.inLOS ==false then
				content.frame = content.frame +1
				if content.frame >= updateAtFrame then --//retrieve dots info at every interval. Prevent updating more than necessary
					content.frame = 0
					content = UpdateDotsContent (unitID, content)
				end
				if content ~= nil then
					if content.isBelow then --//use stipple when unit is below surface. Indicate moving away from map's plane/away from user
						glLineStipple(true) --1, 2047)
					elseif content.wasInLOS then --//add occlusion to the vertical line (when enemy was identified) for asthetic purposes 
					 	glDepthTest(true)
					end
					local x,y,z = content.position[1],content.position[2],content.position[3]
					local surfaceY = content.surface
					glBeginEnd(GL_LINES, function() glVertex(x,surfaceY,z) glVertex(x,y,z) end)
					--glCallList(drawList)
					glLineStipple(false)
					glDepthTest(false)
				end
				dots[unitID] = content --//commit any changes to dots.
			end
		end
	end
	glColor(1,1,1,1)	
	glPopAttrib() 	
	
	---- update global variable
	framePoll_gbl = framePoll
	updateAtFrame_gbl = updateAtFrame
	dots_gbl = dots
end
----------------------
--//reference1: "unit_ghostRadar.lua" (by very_bad_soldier), http://widgets.springrts.de/
--//reference2: "unit_target_on_the_move.lua" (by Google Frog), ZK gadget