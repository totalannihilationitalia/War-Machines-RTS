function gadget:GetInfo()
  return {
    name      = "Dynamic collision volume & Hitsphere Scaledown",
    desc      = "Adjusts collision volume for pop-up style units & Reduces the diameter of default sphere collision volume for 3DO models",
    author    = "Deadnight Warrior",
    date      = "Oct 9, 2011 (Updated 2025)", -- Data aggiornata per riflettere le modifiche
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end
-- update gadget for spring v. 100 by molix	07/10/2025

-- Pop-up style unit and per piece collision volume definitions
local popupUnits = {}		--list of pop-up style units
local unitCollisionVolume, pieceCollisionVolume = include("LuaRules/Configs/CollisionVolumes.lua")

-- Localization and speedups for Spring API calls
local spGetPieceCollisionData = Spring.GetUnitPieceCollisionVolumeData
local spSetPieceCollisionData = Spring.SetUnitPieceCollisionVolumeData
local spGetUnitCollisionData = Spring.GetUnitCollisionVolumeData
local spSetUnitCollisionData = Spring.SetUnitCollisionVolumeData
local spGetFeatureCollisionData = Spring.GetFeatureCollisionVolumeData
local spSetFeatureCollisionData = Spring.SetFeatureCollisionVolumeData
local spArmor = Spring.GetUnitArmored
local spActive = Spring.GetUnitIsActive
local airScalX, airScalY, airScalZ
local pairs = pairs	

function gadget:Initialize()
	-- Spring 0.83 doesn't scale collision volumes of aircraft by additional 0.5 like Spring 0.82 does
	-- Questo controllo garantisce compatibilità con versioni più vecchie
	if spGetFeatureCollisionData then
		airScalX, airScalY, airScalZ = 0.375, 0.225, 0.45
	else
		airScalX, airScalY, airScalZ = 0.75, 0.45, 0.9
	end
end

	
if (gadgetHandler:IsSyncedCode()) then

	-- Gestisce le collisioni alla creazione di un'unità
	function gadget:UnitCreated(unitID, unitDefID, unitTeam)
		-- Caso 1: L'unità ha una collisione "per pezzo" definita in CollisionVolumes.lua
		if (pieceCollisionVolume[UnitDefs[unitDefID].name]) then
			for pieceIndex, p in pairs(pieceCollisionVolume[UnitDefs[unitDefID].name]) do
				if (p[1]==true) then
					-- Firma corretta: (unitID, pieceIndex, enable, scaleX, scaleY, scaleZ, offsetX, offsetY, offsetZ, vType, Axis)
					spSetPieceCollisionData(unitID, pieceIndex, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9])
				else
					spSetPieceCollisionData(unitID, pieceIndex, false, 1, 1, 1, 0, 0, 0, 1, 1)
				end
			end
		else
			-- Caso 2: L'unità è un modello 3DO generico, ridimensioniamo la sua sfera di collisione di default
			if UnitDefs[unitDefID].model.type=="3do" then
				local xs, ys, zs, xo, yo, zo, vtype, htype, axis, _ = spGetUnitCollisionData(unitID)
				if (vtype==4 and xs==ys and ys==zs) then -- Controlla se è una sfera di default
					if (xs>47 and not UnitDefs[unitDefID].canFly) then
						spSetUnitCollisionData(unitID, xs*0.68, ys*0.68, zs*0.68,  xo, yo, zo,  vtype, htype, axis)
					elseif (not UnitDefs[unitDefID].canFly) then
						spSetUnitCollisionData(unitID, xs*0.75, ys*0.75, zs*0.75,  xo, yo, zo,  vtype, htype, axis)
					else -- Caso specifico per le unità volanti
						spSetUnitCollisionData(unitID, xs*airScalX, ys*airScalY, zs*airScalZ,  xo, yo, zo,  vtype, htype, axis)
					end
				end
			end
		end
	end

	-- Gestisce le collisioni alla creazione di una "feature" (es. relitti)
	-- Questa è l'unica, corretta implementazione per Spring 100
	function gadget:FeatureCreated(featureID, allyTeam)
        local featureModel = FeatureDefs[Spring.GetFeatureDefID(featureID)].modelname:lower()
        if featureModel:find(".3do") then
            local rs, hs
            -- Otteniamo i dati della collisione usando una funzione valida
            local xs, ys, zs, xo, yo, zo, vtype, htype, axis, _ = spGetFeatureCollisionData(featureID)

            -- Eseguiamo il codice solo se la feature ha un volume sferico (vtype 3 o 4)
            if (vtype < 3 or xs ~= ys or ys ~= zs) then
                return
            end

            -- Usiamo 'xs' (la dimensione della sfera) al posto della vecchia funzione 'spGetFeatureRadius'
			if (xs > 47) then
                rs, hs = 0.68, 0.60
            else
                rs, hs = 0.75, 0.67
            end
            
            -- Applichiamo la nuova collisione
            spSetFeatureCollisionData(featureID, xs*rs, ys*hs, zs*rs,  xo, yo-ys*0.09, zo,  vtype, htype, axis)
        end
    end

	-- Registra un'unità "pop-up" quando viene completata la costruzione
	function gadget:UnitFinished(unitID, unitDefID, unitTeam)
		local un = UnitDefs[unitDefID].name
		if unitCollisionVolume[un] then
			popupUnits[unitID]={name=un, state=-1}
		end
	end

	-- Rimuove un'unità "pop-up" dalla lista di controllo quando viene distrutta
	function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
		if popupUnits[unitID] then
			popupUnits[unitID] = nil
		end
	end
	
	-- Ciclo principale che aggiorna dinamicamente le hitbox delle unità "pop-up"
	function gadget:GameFrame(n)
		if (n%15 ~= 0) then -- Esegui due volte al secondo (per un gioco a 30 FPS)
			return
		end
		
		local p
		for unitID,defs in pairs(popupUnits) do
			-- Controlla lo stato "ARMORED" per decidere se l'unità è attiva o nascosta
			if spArmor(unitID) then -- Nascosta / Chiusa
				if (defs.state ~= 0) then
					p = unitCollisionVolume[defs.name].off
					spSetUnitCollisionData(unitID, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9])
					popupUnits[unitID].state = 0
				end
			else -- Attiva / Aperta
				if (defs.state ~= 1) then
					p = unitCollisionVolume[defs.name].on
					spSetUnitCollisionData(unitID, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9])
					popupUnits[unitID].state = 1
				end
			end			
		end
	end
end