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

if (not gadgetHandler:IsSyncedCode()) then
  return
end
-------------------
-- Variabili
-------------------

-- tabella / feature -> effetto esplosione, qui associo ad ogni feature la relativa esplosione
local config = {
  pala001_feature   = "FLASH224", 
  pala002_feature   = "FLASH224",
  pala003_feature   = "FLASH224",
  pala004_feature   = "FLASH224",
  pala005_feature   = "FLASH224",
  pala006_feature   = "FLASH224",
  pala007_feature   = "FLASH224",
  pala008_feature   = "FLASH224",
  pala009_feature   = "FLASH224",
  pala010_feature   = "FLASH224",
  pala011_feature   = "FLASH224",
  
  Station_one_antenna_feature = "FLASH224",
  -- ########## continuare la lista #########################################
  
}

-- tabella utilizzata per ID feature sulla mappa -> relativa CeG (ossia all'inizio il gadget esegue un ciclo for di tutte le featuresMap per prelevarne l'ID, se essa è presente nella tabella config, le scrive nella tabella featureNamesToCEG con la relativa esplosione da creare quando la feature muore)
local featureNamesToCEG = {} 

-- all'inizio (quando il gadget viene caricato)
function gadget:Initialize()
  for fName, cegName in pairs(config) do 												-- ciclo for per la compilazione della suddetta tabella
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