-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corsilo= {
               acceleration = 0,
--               badTargetCategory = MOBILE,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 77536,
               buildcostmetal = 7187,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 7,
               buildinggrounddecalsizey = 7,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfasilo.png",
               buildtime  = 181243,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corsilo_dead",
               description = "Nuclear ICBM Launcher",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 7,
               footprintz = 7,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 5560,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Silencer",
               noAutoFire = false,
               objectname = "nfasilo.s3o",
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
               description = "Silencer Wreckage",
               category = "corpses",
               object = "CORSILO_DEAD",
               featuredead = "corsilo_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 4672,
               damage = 3336,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Silencer Heap",
               category = "heaps",
               object = "3X3A",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1869,
               damage = 1668,
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
		crblmssl = {
                     areaofeffect = 1920,
                     avoidfeature = true,
                     cegTag = "NUCKLEARMINI", --aggiungo il fumo emesso dal proiettile
                     collidefriendly = false,
                     commandfire = true,
--                     craterareaofeffect =  ,
                     craterboost = 6,
                     cratermult = 3,
                     edgeeffectiveness = 0.3,
                     energypershot = 187500,
                     explosiongenerator = "custom:FLASHNUKE1920",
                     firestarter = 0,
                     flighttime = 400,
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     metalpershot = 1500,
                     model = "crblmssl",
                     name= "CoreNuclearMissile",
                     range = 72000,
                     reloadtime = 2,
                     smoketrail = true,
                     soundhit = "xplomed4",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "misicbm1",
                     stockpile = true,
                     stockpiletime = 180,
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
                 def = "crblmssl",
--               onlytargetcategory = " ",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
