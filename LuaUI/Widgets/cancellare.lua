function widget:GetInfo()
  return {
    name      = "cancellare_porcodio",
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
local glevel
local gstore
local gpull
local gincome
local gexpanse
local tteam = 1

function widget:Initialize()
   Spring.Echo(helloWorld)
end

function widget:Update()
   if (toggle == true) then
	  glevel,gstore, gpull = GetTeamResources(tteam, "metal")
	  Spring.Echo("storage: "..tostring(gstore))
	  Spring.Echo("current level: "..tostring(glevel))
	  Spring.Echo("pull: "..tostring(pull))	  
--	  ai_number, ai_name= Spring.GetAIInfo ( tteam )
--	  Spring.Echo("hai "..tostring(ai_number).." name: "..ai_name)
--	  
--	  nuteamid = Spring.GetTeamInfo ( tteam )
--	  Spring.Echo("number team id "..tostring(nuteamid))
      toggle = false
   else
      Spring.Echo("test_stopped")
      toggle = true
   end
end