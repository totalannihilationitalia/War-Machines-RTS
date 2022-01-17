-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  corwolv= {
               acceleration = 0.011,
--               badTargetCategory = VTOL OGGETTISTATICI,
               brakerate  = 0.0099,
               buildcostenergy = 2219,
               buildcostmetal = 159,
               builder = false,
               buildpic = "nfawolv.png",
               buildtime  = 3254,
               canAttack = true,
               canGuard = true,
               canmove = true,
               canPatrol = true,
--               canstop = 1,
               category = "ALL TANK WEAPON NOTSUB NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "corwolv_dead",
--               defaultmissiontype = Standby,
               description = "Light Mobile Artillery",
--               firestandorders = 1,
               energymake = 0.5,
               energystorage = 0,
               energyUse = 0.5,
               explodeas = "BIG_UNITEX",
               footprintx = 2,
               footprintz = 2,
               highTrajectory = 1,
	       icontype = "veicoli",
               idleautoheal = 5,
               idletime = 1800,
--               maneuverleashlength  = 650,
               mass = 200,
               maxdamage = 550,
               maxslope = 10,
               maxvelocity = 1.87,
               maxwaterdepth = 8,
               metalStorage = 0,
--               mobilestandorders= 1,
               movementclass = "TANK2",
               name = "Wolverine",
               noAutoFire = false,
               nochasecategory = "VTOL",
               objectname = "nfawolv.s3o",
               seismicsignature = 0,
               selfdestructas = "BIG_UNIT",
               sightdistance = 299,
--               soundcategory= "CORE_TANK",
--               standingfireorder = 2,
--               steeringmode= 1,
--               standingmoveorder = 1,
               TEDClass = "TANK", -- verificare se necessario
               turnrate = 466,
               workertime = 0,
               wpri_badtargetcategory = "VTOL OGGETTISTATICI",
               highTrajectory = 1,
               leaveTracks = true,
               trackOffset = 6,
               trackStrength = 5,
               trackStretch = 1,
               trackType = "StdTank",
               trackWidth = 30,
      customparams = {
          canareaattack = 1,
      },
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wolverine Wreckage",
               category = "corpses",
               object = "CORWOLV_DEAD",
               featurereclamate = "SMUDGE01",
               footprintx = 2,
               footprintz = 2,
               height = 0,
               blocking= true,
               hitdensity = 100,
               metal = 103,
               damage = 330,
               reclaimable = true,
               seqnamereclamate = "TREE1RECLAMATE",
               energy = 0,
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
},  --  Wreckage and heaps
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:plasmaflare",
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
		corwolv_gun = {
                     accuracy = 275,
                     areaofeffect = 88,
                     avoidfeature = true,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH4",
                     hightrajectory = 1,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     name= "LightArtillery",
                     noselfdamage = true,
                     range = 710,
                     reloadtime = 3.5,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "cannhvy3",
                     turret  = true, 
                     weapontype = "Cannon",
                     weaponvelocity  = 365,
                     damage = {
                         default = 150,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 badtargetcategory = "VTOL",
                 def = "corwolv_gun",
                 onlytargetcategory = "SURFACE",
                 maxAngleDif = 180,
                 maindir = "0 0 1",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
