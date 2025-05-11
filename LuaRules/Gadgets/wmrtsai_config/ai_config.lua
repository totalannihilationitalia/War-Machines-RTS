-- LuaUI/Gadgets/wmrtsai_config/ai_config.lua

local aiConfig = {
    [0] = { -- Tech Level 0 (Comandante)
        economyTargets = {
            { role = "T1_Extractor", min = 1, max = 2 },  -- Richiede un T1_Extractor
            { role = "T1_PowerPlant", min = 1, max = 2 }  -- Richiede una T1_PowerPlant
        },
  --      factoryTargets = { minTotal = 1, maxTotal = 1, targetTier = 1 }, -- Richiede una T1_Factory
        productionList = {
            -- Di solito vuota, il comandante costruisce edifici.
            -- Se il comandante potesse fare costruttori T1, sarebbe qui.
        },
        attackGroup = { min = 1, max = 1, target = "GUARD_BASE" } -- Il solo comandante
    },
    [1] = { -- Tech Level 1
        economyTargets = {
            { role = "T1_Extractor", min = 3, max = 5 },  -- Obiettivo per estrattori T1
            { role = "T1_PowerPlant", min = 3, max = 5 }  -- Obiettivo per centrali T1
        },
        factoryTargets = { minTotal = 1, maxTotal = 2, targetTier = 1 }, -- Obiettivo per fabbriche T1 (es. 1-2 armlab)
        productionList = {
            -- I ruoli qui DEVONO corrispondere ai valori del campo 'role' in faction_units.lua
            -- per le unità che vuoi costruire.
            { role = "Unit_Constructor_T1",      priority = 100, max = 2 }, -- Per icuck

            { role = "Unit_Infantry_Light_T1",   priority = 90,  max = 6 }, -- Per icupatroller
            { role = "Unit_Infantry_Rocket_T1",  priority = 85,  max = 4 }, -- Per armrock
            { role = "Unit_Infantry_Plasma_T1",  priority = 80,  max = 3 }, -- Per icuinv (se questo è il suo ruolo)
            { role = "Unit_Infantry_Laser_T1",   priority = 75,  max = 3 }, -- Per armwar (se questo è il suo ruolo)
            { role = "Unit_Infantry_AntiAir_T1", priority = 70,  max = 2 }  -- Per armjeth (se questo è il suo ruolo)
        },
        attackGroup = { min = 6, max = 10, target = "ATTACK_ENEMY_EXPANSION" }
    },
    [2] = { -- Tech Level 2
        economyTargets = {
            { role = "T1_Extractor", min = 5, max = 7 },     -- Mantenere una buona economia T1
            { role = "T1_PowerPlant", min = 5, max = 7 },
            { role = "T2_Extractor", min = 2, max = 4 },     -- Iniziare economia T2
            { role = "T2_PowerPlant", min = 2, max = 4 }
        },
        factoryTargets = {
            -- Qui potresti volere una struttura più dettagliata se vuoi specificare
            -- obiettivi per fabbriche T1 E T2 contemporaneamente.
            -- Per ora, con la struttura semplice, punta a fabbriche T2.
            minTotal = 2, maxTotal = 3, targetTier = 2 -- Punta ad avere fabbriche T2
                                                       -- (e presume che manterrai quelle T1 se servono unità T1)
        },
        productionList = {
            { role = "Unit_Constructor_T2",      priority = 100, max = 2 }, -- Assumendo che il costruttore T2 abbia questo ruolo

            { role = "Unit_Heavy_Armor_T2",      priority = 90,  max = 8 }, -- Esempio per un tank T2 (es. armfboy), adatta il ruolo
            -- Potresti ancora volere alcune unità T1 se le fabbriche T1 sono attive
            -- e se la logica di ManageProduction (unitTier == factoryTier) è implementata
            { role = "Unit_Infantry_Rocket_T1",  priority = 70,  max = 2 }  -- Esempio: continua a fare qualche unità T1 specifica
        },
        attackGroup = { min = 10, max = 15, target = "ATTACK_ENEMY_BASE" }
    },
    [3] = { -- Tech Level 3
        economyTargets = {
            { role = "T2_Extractor", min = 5, max = 8 },
            { role = "T2_PowerPlant", min = 6, max = 10 },
            -- Aggiungi T3_Extractor e T3_PowerPlant se li hai
        },
        factoryTargets = { minTotal= 2, maxTotal = 4, targetTier = 3 }, -- Punta a fabbriche T3
        productionList = {
            -- { role = "Unit_Constructor_T3", priority = 100, max = 1 },
            { role = "Unit_Experimental_T3",     priority = 90,  max = 3 }, -- Esempio per armshock
            { role = "Unit_Heavy_Armor_T2",      priority = 70,  max = 5 }  -- Continua a fare unità T2 di supporto
        },
        attackGroup = { min = 12, max = 20, target = "ATTACK_ENEMY_BASE_PRIORITY" }
    }
}

return aiConfig