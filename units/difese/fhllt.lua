-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  fhllt= {
               acceleration = 0,
--               badTargetCategory = VTOL,
               brakerate  = 0,
--               buildangle = 32768,
               buildcostenergy = 1467,
               buildcostmetal = 185,
               builder = false,
--               buildinggrounddecaldecayspeed= 0.01,
--               buildinggrounddecalsizex= 3,
--               buildinggrounddecalsizey = 3,
--               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "fhllt.png",
               buildtime  = 5448,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "fhllt_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Anti-Swarm Double LLT",
--               firestandorders = 1,
               energystorage = 100,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 2,
               footprintz = 2,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 1500,
               maxslope = 10,
               maxvelocity = 0,
               metalStorage = 0,
               minWaterDepth= 10,
               name = "fhllt",
               noAutoFire = false,
               objectname = "nfafhllt.s3o",
               seismicsignature = 0,
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 455,
--               soundcategory= "LLT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
--               usebuildinggrounddecal = true,
               waterline = 4,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "wwww",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "fhllt Wreckage",
               category = "corpses",
               object = "fhllt_DEAD",
               featuredead = "fhllt_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 6.5,
               blocking= true,
               hitdensity = 100,
               metal = 120,
               damage = 900,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "fhllt Heap",
               category = "heaps",
               object = "4X4D",
               footprintx = 3,
               footprintz = 3,
               height = 1,
               blocking = false,
               hitdensity= 100,
               metal = 48,
               damage = 450,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "85.0 14.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- NO EFFECTS
-----------------------------------------------------------
-----------------------------------------------------------
--- UNITS SOUND
-----------------------------------------------------------
sounds = {
               cloak = "kloak1",
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
                     [1] = "servmed2",
                    },
               select = {
                     [1] = "servmed2",
                        },
               uncloak = "kloak1un",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		fhllt_bottom = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

		fhllt_top = {
                     areaofeffect = 12,
                     avoidfeature = true,
                     beamtime = 0.12,
--                     cegTag = "",
                     corethickness = 0.175,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 20,
                     explosiongenerator = "custom:SMALL_ARANCIO_BURN",
                     firestarter = 100,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightLaser",
                     noselfdamage = true,
                     laserflaresize = 10,
                     range = 435,
                     reloadtime = 0.48,
                     rgbcolor = "1 0.2 0",
                     soundhit = "lasrhit2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "lasrfir3",
                     soundtrigger = "1",
                     targetmoveerror = 0.1,
                     thickness = 2.5,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 2250,
                     damage = {
                         default = 75,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
--                 badtargetcategory = "VTOL",
                 def = "fhllt_bottom",
                 onlytargetcategory = "SURFACE VTOL",
                 },
                 [2] = {
                 def = "fhllt_top",
                 onlytargetcategory = "SURFACE VTOL", -- weapon 2
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
