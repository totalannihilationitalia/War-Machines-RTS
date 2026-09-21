function gadget:GetInfo()
  return {
    name      = "mo_greenfields",
    desc      = "mo_greenfields",
    author    = "TheFatController",
    date      = "19 Jan 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end
--[[
Qual è lo scopo di gioco di "Green Fields"?
In questa modalità, se abilitata, nessun estrattore di metallo (Mex) può produrre risorse dalla mappa:
I giacimenti di metallo sul terreno diventano completamente inutili.
I giocatori sono costretti a produrre metallo solo tramite convertitori di energia (Metal Makers) o riciclando relitti/alberi (Reclaim).
È una modalità alternativa pensata per cambiare radicalmente la strategia economica della partita.
]]--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (not gadgetHandler:IsSyncedCode()) then
  return
end

local enabled = tonumber(Spring.GetModOptions().mo_greenfields) or 0

if (enabled == 0) then 
  return false
end

local SetUnitMetalExtraction = Spring.SetUnitMetalExtraction

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
 SetUnitMetalExtraction(unitID, 0, 0)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------