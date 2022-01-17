-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  andangel= {
               acceleration = 0,
--               badTargetCategory = MOBILE,
               brakerate  = 0,
--               buildangle = 32700,
               buildcostenergy = 60680,
               buildcostmetal = 4184,
               builder = false,
               buildpic = "corangel.png",
               buildtime  = 85185,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "andangel_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Long Range Plasma Cannon",
--               firestandorders = 0,
               energymake = 0,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 4,
               footprintz = 4,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4200,
               maxslope = 12,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Super Cannon",
               objectname = "ANDANGEL",
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 273,
--               soundcategory= "ARM_BRTHA",
--               standingfireorder = 0,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
               YardMap= "oooooooooooooooo",
      customparams = {
          canareaattack = 1,
      },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Angel Wreckage",
               category = "corpses",
               object = "ANDANGEL_dead",
               featuredead = "andangel_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 40,
               blocking= true,
               hitdensity = 100,
               metal = 2720,
               damage = 2520,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Angel Heap",
               category = "heaps",
               object = "3X3E",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1088,
               damage = 1260,
               reclaimable = true,
               featurereclamate = "SMUDGE01",
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               },  -- Close heap
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:berthaflare",
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
                     [1] = "Servlrg3",
                    },
               select = {
                     [1] = "Servlrg3",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		arm_berthacannon = {
                     accuracy = 300,
                     areaofeffect = 200,
                     avoidfeature = true,
                     cegTag = "andangel_weap",
--                     craterareaofeffect =  ,
		     colorMap = "0.5 0.0 1.0 1.0 0.5 0.0 1.0 1.0",
                     craterboost = 0.25,
                     cratermult = 0.25,
                     energypershot = 3000,
                     explosiongenerator = "custom:FLASHBIGBUILDING",
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     name= "BerthaCannon",
                     noselfdamage = true,
                     range = 6200,
                     reloadtime = 11,
                     stages = 3,
  		     separation = 1.45,
		     alphadecay = 0.3,
		     sizedecay = -0.15,
		     nogap = true,
		     size=6,
                     soundhit = "xplonuk1",
 --                    soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "xplonuk4",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 1100,
--	GroundBounce=1,
--	WaterBounce=1,
--	NumBounce=5,
--	BounceSlip=0.35,
--	BounceRebound=0.5,
                     damage = {
                         default = 1800,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "arm_berthacannon",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
