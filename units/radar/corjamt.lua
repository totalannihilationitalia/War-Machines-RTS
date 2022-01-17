-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corjamt= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 9821,
               buildcostenergy = 4791,
               buildcostmetal = 109,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 3,
               buildinggrounddecalsizey = 3,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfajamt.png",
               buildtime  = 4577,
               canAttack = false,
               category = "ALL NOTSUB JAM NOWEAPON SPECIAL NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corjamt_dead",
               description = "Short-Range Jamming Device",
               energymake = 0,
               energystorage = 0,
               energyUse = 25,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "radar",
               idleautoheal = 5,
               idletime = 1800,
               losemitheight = 250, -- verificare se necessario l'unità è jammer
--               mass = 0 --definire massa,
               maxdamage = 960,
               maxslope = 32,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Castro",
               noAutoFire = false,
               objectname = "nfajammer.s3o",
               onoffable = true,
               radarDistanceJam = 360,
               radaremitheight = 250, -- verificare se necessario l'unità è jammer
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 104,
--               soundcategory= "CORE_JAM",
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               YardMap= "oooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Castro Wreckage",
               category = "corpses",
               object = "CORJAMT_DEAD",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 3,
               blocking= true,
               hitdensity = 100,
               metal = 71,
               damage = 576,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
},  --  Close Features
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
               sounds = {
               count = {
                     [1] =  "count6",
                     [2] =  "count5",
                     [3] =  "count4",
                     [4] =  "count3",
                     [5] =  "count2",
                     [6] =  "count1",
                       },
               canceldestruct = "cancel2",
               cant = {
                     [1] = "cantdo4",
                      },
               ok = {
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "radjam2",
                        },
               underattack = "warning1",
               },
                 maxAngleDif = 1,
               }, 
               }
