-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  eufloony= {
--               buildangle = 8345,
               buildcostenergy = 6298,
               buildcostmetal = 702,
               builder = false,
               buildinggrounddecaldecayspeed= 0.01,
               buildinggrounddecalsizex= 6,
               buildinggrounddecalsizey = 6,
               buildinggrounddecaltype = "pavimento_piccolo_euf.png",
               buildpic = "eufloony.png",
               buildtime  = 13525,
               canAttack = true,
--               canstop = 1,
               category = "ALL NOTLAND WEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               corpse = "eufloony_dead",
               damagemodifier = 0.14,
               description = "Pop-up Rocket Battery",
--               firestandorders = 1,
               energyUse = 10,
               explodeas = "MEDIUM_BUILDINGEX",
               footprintx = 3,
               footprintz = 3,
--               mass = 0 --definire massa,
               maxdamage = 1100,
               maxslope = 15,
               maxwaterdepth = 0,
               name = "Lunatic",
               noAutoFire = false,
               objectname = "eufloony.s3o",
               selfdestructas = "MEDIUM_BUILDING",
               sightdistance = 320,
--               soundcategory= "COR_KBOT",
--               standingfireorder = 2,
               TEDClass = "FORT", -- verificare se necessario
               usebuildinggrounddecal = true,
               YardMap= "ooooooooo",
-----------------------------------------------------------
--- Units wreckage and heaps
-----------------------------------------------------------
featuredefs = {
  dead = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               object = "corloony_dead",
               featuredead = "corloony_heap",
               featurereclamate = "smudge01",
               footprintx = 3,
               footprintz = 3,
               height = 23,
               blocking= true,
               hitdensity = 100,
               metal = 562,
               damage = 880,
               reclaimable = true,
               seqnamereclamate = "tree1reclamate",
				collisionvolumeoffsets = "0.0 -1.2425585791 1.2922744751",
				collisionvolumescales = "30.0 14.3981628418 32.5845489502",
				collisionvolumetype = "Box",
               },  -- Close Dead Features
  heap = {
               world = "all",
               description = "Wreckage",
               category = "corecorpses",
               collisionvolumescales = "55.0 4.0 6.0",
               collisionvolumetype = "cylY",
               object = "3x3c",
               footprintx = 3,
               footprintz = 3,
               height = 18,
               blocking = true,
               hitdensity= 100,
               metal = 562,
               damage = 880,
               reclaimable = true,
               featurereclamate = "smudge01",
               seqnamereclamate = "tree1reclamate",
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
                     [1] = "kbcormov",
                    },
               select = {
                     [1] = "kbcorsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
		armrl_missile = {
                     areaofeffect = 48,
                     avoidfeature = true,
                     canattackground = false,
--                     cegTag = "",
--                     craterareaofeffect =  ,
                     craterboost = 0,
                     cratermult = 0,
                     explosiongenerator = "custom:FLASH2",
                     firestarter = 70,
                     flighttime = 1.5,
                     impulseboost = 0.123,
                     impulsefactor = 0.123,
                     metalpershot = 0,
                     model = "missile",
                     name= "Missiles",
                     noselfdamage = true,
                     range = 765,
                     reloadtime = 1.7,
                     smoketrail = true,
                     soundhit = "xplomed2",
 --                   soundhitdry = "",
--                    soundhitwet = "",
--                    soundhitwetvolume = "",
                     soundstart = "rockhvy2",
                     startvelocity = 400,
                     texture2 = "armsmoketrail",
                     tolerance = 10000,
                     tracks = true, 
                     turnrate = 63000,
                     turret  = true, 
                     weaponacceleration = 150,
                     weapontimer = 5,
                     weapontype = "MissileLauncher",
                     weaponvelocity  = 750,
                     damage = {
                         default = 113,
                     }, -- close damage
             }, --close single weapon definitions

}, -- close weapon definition
-----------------------------------------------------------
--- WEAPONS USAGE
-----------------------------------------------------------
weapons = {
                 [1] = {
                 def = "armrl_missile",
                 onlytargetcategory = "VTOL",
                 },
}, -- close weapon usage

}, -- close unit data 
} -- close total
