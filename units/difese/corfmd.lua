-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corfmd= {
               acceleration = 0,
--               badTargetCategory = NOTAIR,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 64321,
               buildcostmetal = 1508,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 5,
               buildinggrounddecalsizey = 5,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfafmd.png",
               buildtime  = 96450,
	       canattack = false,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corfmd_dead",
               damagemodifier = 0.5,
               description = "Anti-Nuke System",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3280,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Fortitude",
               objectname = "nfafmd.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 195,
--               soundcategory= "COR_FMD",
--               standingfireorder = 2,
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "NOTAIR",
               YardMap= "oooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Fortitude Wreckage",
               category = "corpses",
               object = "CORFMD_DEAD",
               featuredead = "corfmd_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 5,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 980,
               damage = 1968,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Fortitude Heap",
               category = "heaps",
               object = "5X5D",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 392,
               damage = 984,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
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
                     [1] = "loadwtr1",
                    },
               select = {
                     [1] = "loadwtr1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		fmd_rocket = {
                     areaofeffect = 420,
                     avoidfeature = true,
--                     cegTag = "",
                     collidefriendly = false,
                     coverage = 2000,
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 7500,
                     explosiongenerator = "custom:FLASH4",
                     firestarter = 100,
                     flighttime = 120,
                     interceptor = 1,
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
                     turnrate = 130000,
                     weaponacceleration = 150,
                     weapontimer = 2,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 3000,
                     damage = {
                         default = 1500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "NOTAIR",
                 def = "fmd_rocket",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
