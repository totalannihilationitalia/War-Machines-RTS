-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armamd= {
               acceleration = 0,
--               badTargetCategory = NOTAIR,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 59439,
               buildcostmetal = 1437,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icuamd.png",
               buildtime  = 95678,
	       canattack = false,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armamd_dead",
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
               maxdamage = 3300,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Protector",
               objectname = "icuamd.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 201,
--               soundcategory= "ARM_AMD",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
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
               description = "Protector Wreckage",
               category = "corpses",
               object = "ARMAMD_DEAD",
               featuredead = "armamd_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 5,
               footprintz = 6,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 934,
               damage = 1980,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Protector Heap",
               category = "heaps",
               object = "5X5B",
               footprintx = 5,
               footprintz = 5,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 374,
               damage = 990,
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
                     [1] = "loadwtr2",
                    },
               select = {
                     [1] = "loadwtr2",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		amd_rocket = {
                     areaofeffect = 420,
                     avoidfeature = true,
--                     cegTag = ""
                     collidefriendly = false,
                     coverage = 2000, -- range di copertura
                     interceptor = 1, --specificare ID missili che verranno intercettati. I lanciamissili "armsilo" dovranno avere il targetable = 1 (ossia con il numero corrispondente all'interceptor). Entrambi i valori di default sono 0                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     energypershot = 7500,
                     explosiongenerator = "custom:FLASH4",
                     firestarter = 100,
                     flighttime = 120,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 150,
                     model = "amdrocket",
                     name= "Rocket",
                     noselfdamage = true,
                     range = 72000,
                     reloadtime = 2,
                     smoketrail = true,
                     soundhit = "xplomed4",
--                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "Rockhvy1",
                     stockpile = true,
                     stockpiletime = 90,
                     tolerance = 4000,
                     tracks = true, 
                     turnrate = 130000,
                     weaponacceleration = 75,
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
                 def = "amd_rocket",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
