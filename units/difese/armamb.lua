-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  armamb= {
               acceleration = 0,
               activatewhenbuilt = true,
--               badTargetCategory = VTOL,
               brakerate  = 0,
--               buildangle = 8192,
               buildcostenergy = 16821,
               buildcostmetal = 2342,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 4,
               buildinggrounddecalsizey = 4,
               buildinggrounddecaltype = "Pavimentazione3.png",
               buildpic = "ICUAMB.PNG",
               buildtime  = 27072,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               cloakcost = 40,
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "armamb_dead",
               damagemodifier = 0.25,
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Cloakable Heavy Plasma Cannon",
--               firestandorders = 1,
               energystorage = 0,
               energyUse = 0,
               explodeas = "LARGE_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
               highTrajectory = 2,	
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 3600,
               maxslope = 10,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               mincloakdistance = 70,
               name = "Ambusher",
               noAutoFire = false,
               nochasecategory = "MOBILE",
               objectname = "ICUAMB.s3o",
               seismicsignature = 0,
               selfdestructas = "LARGE_BUILDING",
               sightdistance = 442,
--               soundcategory= "GUARD",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
	       usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "VTOL",
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Ambusher Wreckage",
               category = "corpses",
               object = "ARMAMB_DEAD1",
               featuredead = "armamb_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 1522,
               damage = 2160,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Ambusher Wreckage",
               category = "corpses",
               object = "ARMAMB_DEAD2",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking = true,
               hitdensity= 100,
               metal = 609,
               damage = 1080,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:MEDIUMFLARE",
               }, -- close effects list
}, -- close section sfxtypes
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
                     [1] = "twrturn3",
                    },
               select = {
                     [1] = "twrturn3",
                        },
               uncloak = "kloak1un",
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armamb_gun = {
                     accuracy = 400,
                     areaofeffect = 152,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     edgeeffectiveness = 0.25,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "PopupCannon",
                     noselfdamage = true,
                     range = 1320,
                     reloadtime = 1.8,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 450,
                     damage = {
                         default = 345,
                     }, -- close damage
             }, --close single weapon definitions

		armamb_gun_high = {
                     accuracy = 400,
                     areaofeffect = 224,
                     avoidfeature = true,
--                     cegTag = ""
--                     craterareaofeffect =  ,
                     craterboost = 0.123,
                     cratermult = 0.123,
                     edgeeffectiveness = 0.5,
                     explosiongenerator = "custom:FLASH96",
                     impulseboost = 0.123,
                     impulsefactor = 2,
                     name= "PopupCannon",
                     noselfdamage = true,
                     proximitypriority = -2,
                     range = 1320,
                     reloadtime = 7,
                     soundhit = "xplomed2",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy5",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 440,
                     damage = {
                         default = 865,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "armamb_gun",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 230,
                 maindir = "0 1 0",
                 },
                 [2] = {
                 badtargetcategory = "VTOL",
                 def = "armamb_gun_high",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
