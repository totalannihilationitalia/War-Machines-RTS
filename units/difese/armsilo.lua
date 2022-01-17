-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armsilo= {
               acceleration = 0,
--               badTargetCategory = MOBILE,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 84268,
               buildcostmetal = 7625,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 8,
               buildinggrounddecalsizey = 8,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "icusilo.png",
               buildtime  = 178453,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armsilo_dead",
               description = "Nuclear ICBM Launcher",
--               firestandorders = 1,
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 7,
               footprintz = 7,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 5300,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Retaliator",
               noAutoFire = false,
               objectname = "icusilo.s3o",
               radardistance = 50,
               seismicsignature = 0,
               selfdestructas = "NUCLEAR_MISSILE",
               sightdistance = 455,
--               soundcategory= "NUC",
--               standingfireorder = 0,
               TEDClass = "SPECIAL", -- verificare se necessario
               turnrate = 0,
	       usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
               YardMap= "ooooooooooooooooooooooooooooooooooooooooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Retaliator Wreckage",
               category = "corpses",
               object = "ARMSILO_DEAD",
               featuredead = "armsilo_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 4956,
               damage = 3180,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Retaliator Heap",
               category = "heaps",
               object = "3X3F",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1982,
               damage = 1590,
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
                     [1] = "servroc1",
                    },
               select = {
                     [1] = "servroc1",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		nuclear_missile = {
                     areaofeffect = 1280,
                     avoidfeature = true,
                     cegTag = "NUCKLEARMINI", -- fumo emesso dal proiettile
                     collidefriendly = false,
                     commandfire = true,
--                     craterareaofeffect =  ,
                     craterboost = 6,
                     cratermult = 3,
                     edgeeffectiveness = 0.3,
                     energypershot = 125000,
                     explosiongenerator = "custom:FLASHNUKE1280",
                     firestarter = 0,
                     flighttime = 400,
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     metalpershot = 1000,
                     model = "ballmiss",
                     name= "NuclearMissile",
                     range = 72000,
                     reloadtime = 2,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "misicbm1",
                     stockpile = true,
                     stockpiletime = 120,
		     targetable = 1,
                     tolerance = 4000,
                     turnrate = 32768,
                     weaponacceleration = 100,
                     weapontimer = 8,
                     weapontype = "StarburstLauncher",
                     weaponvelocity  = 1600,
                     damage = {
                         default = 9500,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "MOBILE",
                 def = "nuclear_missile",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
