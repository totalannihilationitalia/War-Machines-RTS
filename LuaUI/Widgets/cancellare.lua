function widget:GetInfo()
  return {
    name      = "cancellare_WMRTStest",
    desc      = "Camera shakes",
    author    = "trepan",
    date      = "Jun 15, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

local helloWorld = "quante risorse hai, coglione!"
local toggle
local GetTeamResources = Spring.GetTeamResources -- questo funziona solo se il teamID è un giocatore, non funziona con le AI
local glevel = 1
local gstore = 1
local gpull = 1
local gincome = 1
local gexpanse  = 1
local wrteam = 0

local teamList   = {}

function widget:Initialize()
   Spring.Echo(helloWorld)
end

function widget:Update()

		 energy, energyStorage,_, energyIncome = GetTeamResources(wrteam, "energy")
		 metal, metalStorage,_, metalIncome = GetTeamResources(wrteam, "metal")
--		 energy = math.floor(energy)
--		metal = math.floor(metal)
--		if energy < 0 then energy = 0 end
--		if metal < 0 then metal = 0 end

--   	  glevel,gstore, gpull = GetTeamResources(1, "metal")
	  Spring.Echo(energy)
	  Spring.Echo(metal)	  
--	  Spring.Echo("current level: "..tostring(eCur))
--	  Spring.Echo("max: "..tostring(eMax))	  
--	  local ai_number, ai_name= Spring.GetAIInfo ( tteam )
--	  Spring.Echo("hai "..tostring(ai_number).." name: "..ai_name)
--	  
--	  nuteamid = Spring.GetTeamInfo ( tteam )
--	  Spring.Echo("number team id "..tostring(nuteamid))
   
   
end