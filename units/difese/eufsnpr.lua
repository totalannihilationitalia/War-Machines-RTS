-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufsnpr= {
--               badTargetCategory = VTOL,
               buildcostenergy = 5098,
               buildcostmetal = 1092,
               builder = false,
               buildpic = "eufsnpr.png",
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 6,
               buildinggrounddecalsizey = 6,
               buildinggrounddecaltype = "pavimento_piccolo_euf.png",
               buildtime  = 11005,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufsnpr_dead",
               description = "Sniper Tower",
--               firestandorders = 1,
               energystorage = 100,
               energyUse = 0,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 1000,
               maxslope = 10,
               maxwaterdepth = 0,
               name = "Sniper Tower",
               noAutoFire = false,
               objectname = "eufsnpr.s3o",
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 550,
--               soundcategory= "LLT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               usebuildinggrounddecal = true,
               wpri_badtargetcategory = "VTOL",
               YardMap= "oooooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "corsnpr_dead",
               featuredead = "corsnpr_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 27,
               blocking= true,
               hitdensity = 100,
               metal = 634,
               damage = 1600,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Wreckage",
               category = "heaps",
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               object = "3x3c",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 317,
               damage = 800,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS  --************************************************************************sistemare colore effetto
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:azzurroflare",
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
		eufsnpr_laser = {
                     areaofeffect = 8,
                     avoidfeature = true,
--                     beamweapon = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     duration = 0.5,
                     energypershot = 350,
                     explosiongenerator = "custom:azzurrolaser",
                     firestarter = 10,
                     name= "Energy Sniper Beam",
                     range = 1000,
                     rgbcolor = "0 0.35 0.35",
                     reloadtime = 6.5,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "CORSNIPE_laser",
                     turret  = true, 
                     weapontype = "LaserCannon",
                     weaponvelocity  = 1000,
                     damage = {
                         default = 450,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
--                 badtargetcategory = "VTOL",
                 def = "eufsnpr_laser",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
