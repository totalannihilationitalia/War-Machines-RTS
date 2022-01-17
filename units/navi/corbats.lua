-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corbats= {
               acceleration = 0.03,
--               badTargetCategory = VTOL,
               brakerate  = 0.025,
--               buildangle = 16384,
               buildcostenergy = 21941,
               buildcostmetal = 5404,
               builder = false,
               buildpic = "nfabats.png",
               buildtime  = 60640,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL NOTLAND MOBILE WEAPON SHIP NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corbats_dead",
--               defaultmissiontype = Standby,
               description = "Battleship",
--               firestandorders = 1,
               energymake = 46,
               energystorage = 0,
               energyUse = 44,
               explodeas = "BIG_UNITEX",
               footprintx = 7,
               footprintz = 7,
               icontype = "sea",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
--               mass = 0 --definire massa,
               maxdamage = 16685,
               maxvelocity = 2.64,
               metalStorage = 0,
               minWaterDepth= 15,
--               mobilestandorders= 1,
               movementclass = "DBOAT6",
               name = "Warlord",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfa_nave001.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 455,
--               soundcategory= "CORE_SHIP",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "SHIP", -- verificare se necessario
               turnrate = 306,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Warlord Wreckage",
               category = "corpses",
               object = "CORBATS_DEAD",
               featuredead = "corbats_heap",
               footprintx = 6,
               footprintz = 6,
               height = 4,
               blocking= false,
               hitdensity = 100,
               metal = 3513,
               damage = 6831,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Warlord Heap",
               category = "heaps",
               object = "6X6C",
               footprintx = 2,
               footprintz = 2,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1066,
               damage = 2016,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:POPUPFLAREFAST",
               }, -- close effects list
}, -- close section sfxtypes
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
                     [1] = "shcormov",
                    },
               select = {
                     [1] = "shcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		cor_bats = {
                     accuracy = 400,
                     areaofeffect = 96,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "BattleshipCannon",
                     noselfdamage = true,
                     range = 1320,
                     reloadtime = 0.5,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy1",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 400,
                     damage = {
                         default = 450,
                     }, -- close damage
             }, --close single weapon definitions

		core_batslaser = {
                     areaofeffect = 8,
                     avoidfeature = true,
                     beamtime = 0.2,
--                     beamweapon = true,
--                     cegTag = "",
                     corethickness = 0.2,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 125,
                    explosiongenerator = "custom:SMALL_ARANCIO_BURN",  --LARGE_YELLOW_LASER_BURN",
                     firestarter = 90,
                     impactonly = true,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "HighEnergyLaser",
                     noselfdamage = true,
                     laserflaresize = 15,
                     range = 950,
                     reloadtime = 1.1,
                     rgbcolor = "1 1 0",
                     soundhit = "lasrhit1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Lasrmas2",
                     targetmoveerror = 0.2,
                     thickness = 3,
                     tolerance = 10000,
                     turret  = true, 
                     weapontype = "BeamLaser",
                     weaponvelocity  = 700,
                     damage = {
                         default = 300,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "cor_bats",
                 onlytargetcategory = "SURFACE",
                 },
                 [2] = {
                 badtargetcategory = "ANTILASER",
                 def = "core_batslaser",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 330,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
