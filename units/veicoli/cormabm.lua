-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  cormabm= {
               acceleration = 0.0198,
--               badTargetCategory = VTOL,
               brakerate  = 0.0374,
               buildcostenergy = 92321,
               buildcostmetal = 1508,
               builder = false,
               buildpic = "nfamabm.png",
               buildtime  = 96450,
	       canattack = false,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK MOBILE WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "cormabm_dead",
               damagemodifier = 0.5,
--               defaultmissiontype = Standby,
               description = "Mobile Anti-missile Defense",
--               firestandorders = 1,
               energymake = 200,
               energystorage = 1000,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 640,
               mass = 3000,
               maxdamage = 780,
               maxslope = 10,
               maxvelocity = 1.771,
               maxwaterdepth = 0,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK3",
               name = "Hedgehog",
               nochasecategory = "ALL",
               objectname = "nfa_antinuke_vehycle.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 450,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 520.3,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               leaveTracks = true,
               trackOffset = 6,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 34,
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Hedgehog Wreckage",
               category = "corpses",
               object = "CORMABM_DEAD",
               featuredead = "cormabm_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 980,
               damage = 468,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Hedgehog Heap",
               category = "heaps",
               object = "3X3D",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 392,
               damage = 234,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
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
                     [1] = "tcormove",
                    },
               select = {
                     [1] = "tcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		cormabm_weapon = {
                     areaofeffect = 420,
                     avoidfeature = true,
--                     cegTag = "",
                     collidefriendly = false,
                     coverage = 2000,
                     interceptor = 1, --specificare ID missili che verranno intercettati
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 7500,
                     explosiongenerator = "custom:FLASH4",
                     firestarter = 100,
                     flighttime = 120,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 150,
                     model = "fmdmisl",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 72000,
                     reloadtime = 2,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     stockpile = true,
                     stockpiletime = 90, 
                     tolerance = 4000,
                     tracks = true, 
                     turnrate = 99000,
                     weaponacceleration = 75,
                     weapontimer = 5,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 3000,
                     damage = {
                         default = 500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "cormabm_weapon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
