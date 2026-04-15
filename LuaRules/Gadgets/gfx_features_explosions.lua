function gadget:GetInfo()
  return {
    name      = "Feature Explosion Spawner",
    desc      = "Crea esplosioni CEG quando specifiche feature vengono distrutte",
    author    = "molix",
    date      = "2026",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  -- Carica il gadget all'avvio
  }
end
--
-- 25/03/2026 realizzato questo gadget. Molix
-- TODO
-- abbinare anche il suono alla feature (ogni feature avrà la sua esplosione visiva e sonora)
-- 15/04/2026 appunto ################################ molix
-- semplificare questo gadget, utilizzare una unità "fantoccio" alla quale è abbinata l'esplosione. In questo modo aggiungiamo anche i detriti dell'esplosione
-- a questo punto config diventa "nome_feature" = "nome_unitàDaCreare_edEsplodere"
-- pertanto i CEG saranno abbinati all'unità


if (not gadgetHandler:IsSyncedCode()) then
  return
end
-------------------
-- Variabili
-------------------

-- tabella / feature -> effetto esplosione, qui associo ad ogni feature la relativa esplosione
local config = {
--[[
  pala001_feature   = "building_destruction_heavy", 
  pala002_feature   = "building_destruction_heavy",
  pala003_feature   = "building_destruction_heavy",
  pala004_feature   = "building_destruction_heavy",
  pala005_feature   = "building_destruction_heavy",
  pala006_feature   = "building_destruction_heavy",
  pala007_feature   = "building_destruction_heavy",
  pala008_feature   = "building_destruction_heavy",
  pala009_feature   = "building_destruction_heavy",
  pala010_feature   = "building_destruction_heavy",
  pala011_feature   = "building_destruction_heavy",
  pala001_feature   = "fleaesplosionipostatterraggio", 
]]-- 
  pala002_feature   = "building_effects",
  pala003_feature   = "building_effects",
  pala004_feature   = "building_effects",
  pala005_feature   = "building_effects",
  pala006_feature   = "building_effects",
  pala007_feature   = "building_effects",
  pala008_feature   = "building_effects",
  pala009_feature   = "building_effects",
  pala010_feature   = "building_effects",
  pala011_feature   = "building_effects",  
  Station_one_antenna_feature = "FLASH224",
  -- ########## continuare la lista #########################################
  
}

-- tabella utilizzata per ID feature sulla mappa -> relativa CeG (ossia all'inizio il gadget esegue un ciclo for di tutte le featuresMap per prelevarne l'ID, se essa è presente nella tabella config, le scrive nella tabella featureNamesToCEG con la relativa esplosione da creare quando la feature muore)
local featureNamesToCEG = {} 

-- all'inizio (quando il gadget viene caricato)
function gadget:Initialize()
  for fName, cegName in pairs(config) do 												-- ciclo for per la compilazione della tabella "featureNamesToCEG"
    local fDef = FeatureDefNames[fName]
    if fDef then
      featureNamesToCEG[fDef.id] = cegName
    else
      Spring.Log(gadget:GetInfo().name, LOG.WARNING, "Feature non trovata: " .. fName)	-- caso in cui la mappa non possiede la features sopra elencata ###### DEBUG rimuovere dopo test, non tutte le mappe hanno le features elencate ####################
    end
  end
end

-- se una features viene distrutta
function gadget:FeatureDestroyed(featureID, allyTeamID)
  local fDefID = Spring.GetFeatureDefID(featureID)
  local cegName = featureNamesToCEG[fDefID]

  if cegName then
    local x, y, z = Spring.GetFeaturePosition(featureID)
  

    Spring.SpawnCEG(cegName, x, y, z, 0, 1, 0)
    Spring.PlaySoundFile("sounds/bertha6.wav", 1.0, x, y, z)
  end
end