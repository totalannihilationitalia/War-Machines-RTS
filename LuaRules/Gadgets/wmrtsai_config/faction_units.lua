-- === 1. DEFINIZIONE FAZIONI E UNITÀ PER TIER ===
  -- !! IMPORTANTE: Compila con NOMI ESATTI, moveType e role corretti !!
 local factionUnits = {
    ICU = {
        commander = { name = "icucom", moveType = "LAND", role = "Commander_T0", viewradius = 500 }, -- *** MODIFICATO: reso tabella per coerenza e per ID ***
        T1 = {
            -- Chiavi usate da GetUnitDataByRole per richieste "standard" (es. "T1_Extractor")
            extractor =   { name = "icumetex", moveType="BUILDING", role="Building_Extractor_T1"}, -- Ruolo interno descrittivo
            powerPlant =  { name = "armsolar", moveType="BUILDING", role="Building_Power_T1"},   -- Ruolo interno descrittivo (era "solar_T1")
            factory =     { name = "armlab",   moveType="BUILDING", role="Building_Factory_Kbot_T1"}, -- Ruolo interno descrittivo (era "Kbot_Land_T1")
            constructor = { name = "icuck",    moveType="LAND",     role="Unit_Constructor_T1" },    -- Ruolo interno descrittivo (era "Constructor_T1")

            -- Lista di attaccanti, ognuno con il suo ruolo specifico e univoco
            attackers = {
                          { name = "icupatroller", moveType = "LAND", role="Unit_Infantry_Light_T1", viewradius = 429 },  -- Era "fantry_T1"
                          { name = "armrock",      moveType = "LAND", role="Unit_Infantry_Rocket_T1", viewradius = 475 }, -- Era "rock_T1"
                          { name = "icuinv",       moveType = "LAND", role="Unit_Infantry_Plasma_T1", viewradius = 380 }, -- Era "plasma_T1"
                          { name = "armwar",       moveType = "LAND", role="Unit_Infantry_Laser_T1", viewradius = 330 }, -- Era "laser_T1"
                          { name = "armjeth",      moveType = "LAND", role="Unit_Infantry_AntiAir_T1", viewradius = 330 }  -- Era "antiair_T1"
                        },
            defenses = {
                          { name = "iculighlturr", moveType = "BUILDING", role="Building_Defense_Light_T1" } -- Era "Light_T1"
                       }
        },
          T2 = {
              extractor =   { name = "armamex", moveType="BUILDING", role="Extractor_T2"},
              powerPlant =  { name = "armfus", moveType="BUILDING", role="Power_T2"},
              factory =     { name = "armalab", moveType = "BUILDING", role="Factory_Land_T2" },
              constructor = { name = "armack", moveType = "LAND", role="Constructor_T2" },
              attackers = { { name = "armfboy", moveType = "LAND", role="Heavy_T2" }, },
              defenses = { { name = "armhlt", moveType = "BUILDING", role="Heavy_T2" } }
          },
          T3 = {
              factory =     { name = "armshltx", moveType = "BUILDING", role="Factory_Land_T3" },
              -- constructor = { ... },
              attackers = { { name = "armshock", moveType = "LAND", role="Experimental_T3" }, },
              defenses = { { name = "armanni", moveType = "BUILDING", role="Experimental_T3" } }
          },
          _unitDefIDs = {}
      },
      NFA = { -- !! COMPILA !!
          commander = "nfacom",
          T1 = { extractor = { name = "nfa_mex_t1", moveType="BUILDING", role="Extractor_T1" }, powerPlant = { name="nfa_pow_t1", moveType="BUILDING", role="Power_T1" }, factory = {name="nfa_factory_t1", moveType="BUILDING", role="Factory_Land_T1"}, constructor = {name="nfa_con_t1", moveType="LAND", role="Constructor_T1"}, attackers = {{name="nfa_attacker_t1", moveType="LAND", role="Basic_T1"}}, defenses = {{name="nfa_defense_t1", moveType="BUILDING", role="Light_T1"}} },
          T2 = { extractor = { name = "nfa_mex_t2", moveType="BUILDING", role="Extractor_T2" }, powerPlant = { name="nfa_pow_t2", moveType="BUILDING", role="Power_T2" }, factory = {name="nfa_factory_t2", moveType="BUILDING", role="Factory_Land_T2"}, constructor = {name="nfa_con_t2", moveType="LAND", role="Constructor_T2"}, attackers = {{name="nfa_attacker_t2", moveType="LAND", role="Heavy_T2"}}, defenses = {{name="nfa_defense_t2", moveType="BUILDING", role="Heavy_T2"}} },
          T3 = { factory = {name="nfa_factory_t3", moveType="BUILDING", role="Factory_Land_T3"}, constructor = {name="nfa_con_t3", moveType="LAND", role="Constructor_T3"}, attackers = {{name="nfa_attacker_t3", moveType="LAND", role="Experimental_T3"}}, defenses = {{name="nfa_defense_t3", moveType="BUILDING", role="Experimental_T3"}} },
          _unitDefIDs = {}
      },
       AND = { -- !! COMPILA !!
          commander = "andcom",
          T1 = { extractor = { name = "and_mex_t1", moveType="BUILDING", role="Extractor_T1" }, powerPlant = { name="and_pow_t1", moveType="BUILDING", role="Power_T1" }, factory = {name="and_factory_t1", moveType="BUILDING", role="Factory_Land_T1"}, constructor = {name="and_con_t1", moveType="LAND", role="Constructor_T1"}, attackers = {{name="and_attacker_t1", moveType="LAND", role="Basic_T1"}}, defenses = {{name="and_defense_t1", moveType="BUILDING", role="Light_T1"}} },
          T2 = { extractor = { name = "and_mex_t2", moveType="BUILDING", role="Extractor_T2" }, powerPlant = { name="and_pow_t2", moveType="BUILDING", role="Power_T2" }, factory = {name="and_factory_t2", moveType="BUILDING", role="Factory_Land_T2"}, constructor = {name="and_con_t2", moveType="LAND", role="Constructor_T2"}, attackers = {{name="and_attacker_t2", moveType="LAND", role="Heavy_T2"}}, defenses = {{name="and_defense_t2", moveType="BUILDING", role="Heavy_T2"}} },
          T3 = { factory = {name="and_factory_t3", moveType="BUILDING", role="Factory_Land_T3"}, constructor = {name="and_con_t3", moveType="LAND", role="Constructor_T3"}, attackers = {{name="and_attacker_t3", moveType="LAND", role="Experimental_T3"}}, defenses = {{name="and_defense_t3", moveType="BUILDING", role="Experimental_T3"}} },
          _unitDefIDs = {}
      },
      EUF = { -- !! COMPILA !!
          commander = "eufcd",
          T1 = { extractor = { name = "euf_mex_t1", moveType="BUILDING", role="Extractor_T1" }, powerPlant = { name="euf_pow_t1", moveType="BUILDING", role="Power_T1" }, factory = {name="euf_factory_t1", moveType="BUILDING", role="Factory_Land_T1"}, constructor = {name="euf_con_t1", moveType="LAND", role="Constructor_T1"}, attackers = {{name="euf_attacker_t1", moveType="LAND", role="Basic_T1"}}, defenses = {{name="euf_defense_t1", moveType="BUILDING", role="Light_T1"}} },
          T2 = { extractor = { name = "euf_mex_t2", moveType="BUILDING", role="Extractor_T2" }, powerPlant = { name="euf_pow_t2", moveType="BUILDING", role="Power_T2" }, factory = {name="euf_factory_t2", moveType="BUILDING", role="Factory_Land_T2"}, constructor = {name="euf_con_t2", moveType="LAND", role="Constructor_T2"}, attackers = {{name="euf_attacker_t2", moveType="LAND", role="Heavy_T2"}}, defenses = {{name="euf_defense_t2", moveType="BUILDING", role="Heavy_T2"}} },
          T3 = { factory = {name="euf_factory_t3", moveType="BUILDING", role="Factory_Land_T3"}, constructor = {name="euf_con_t3", moveType="LAND", role="Constructor_T3"}, attackers = {{name="euf_attacker_t3", moveType="LAND", role="Experimental_T3"}}, defenses = {{name="euf_defense_t3", moveType="BUILDING", role="Experimental_T3"}} },
          _unitDefIDs = {}
      }
      -- Non serve sezione common se tutto è per fazione/tier
  }
  return factionUnits