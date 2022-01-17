-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corint= {
               acceleration = 0,
--               badTargetCategory = MOBILE,
               brakerate  = 0,
--               buildangle = 32700,
               buildcostenergy = 62520,
               buildcostmetal = 4328,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 6,
               buildinggrounddecalsizey = 6,
               buildinggrounddecaltype = "Pavimentazione_nfa_ap.png",
               buildpic = "nfaint.png",
               buildtime  = 93237,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corint_dead",
--               defaultmissiontype = GUARD_NOMOVE,
               description = "Long Range Plasma Cannon",
--               firestandorders = 2,
               energystorage = 0,
               energyUse = 0,
               explodeas = "ATOMIC_BLAST",
               footprintx = 5,
               footprintz = 5,
               icontype = "building",
               idleautoheal = 5,
               idletime = 1800,
--               mass = 0 --definire massa,
               maxdamage = 4600,
               maxslope = 13,
               maxvelocity = 0,
               maxwaterdepth = 0,
               metalStorage = 0,
               name = "Intimidator",
               objectname = "nfa_long_plasma_cannon.s3o",
               seismicsignature = 0,
               selfdestructas = "ATOMIC_BLAST",
               sightdistance = 273,
--               soundcategory= "COR_INT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               turnrate = 0,
               usebuildinggrounddecal = true,
               workertime = 0,
               wpri_badtargetcategory = "MOBILE",
               YardMap= "ooooooooooooooooooooooooo",
      customparams = {
          canareaattack = 1,
      },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "All Worlds",
               description = "Intimidator Wreckage",
               category = "corpses",
               object = "CORINT_DEAD",
               featuredead = "corint_heap",
               featurereclamate = "SMUDGE01",
               footprintx = 3,
               footprintz = 3,
               height = 20,
               blocking= true,
               hitdensity = 100,
               metal = 2813,
               damage = 2760,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "All Worlds",
               description = "Intimidator Heap",
               category = "heaps",
               object = "3X3C",
               footprintx = 3,
               footprintz = 3,
               height = 4,
               blocking = false,
               hitdensity= 100,
               metal = 1125,
               damage = 1380,
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
                     [1] = "Servlrg4",
                    },
               select = {
                     [1] = "Servlrg4",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		core_intimidator = {
                     accuracy = 335,
                     areaofeffect = 224,
                     avoidfeature = true,
                     cegTag = "vulcanfx",
--                     craterareaofeffect =  ,
                     craterboost = 0.25,
                     cratermult = 0.25,
                     energypershot = 3000,
                     explosiongenerator = "custom:FLASHBIGBUILDING",
                     impulseboost = 0.5,
                     impulsefactor = 0.5,
                     name= "IntimidatorCannon",
                     noselfdamage = true,
                     range = 6600,
                     reloadtime = 13.5,
                     stages = 20,
  		     separation = 1.45,
		     alphadecay = 0.3,
		     sizedecay = -0.15,
		     nogap = true,
		     size=5,
                     soundhit = "xplonuk1",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "xplonuk3",
                     tolerance = 500,
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 1150,
                     damage = {
                         default = 2000,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "core_intimidator",
                 onlytargetcategory = "SURFACE",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
