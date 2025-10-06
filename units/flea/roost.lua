-- made by DaRyL - www.warmachinesrts.com
return {

-----------------------------------------------------------
--- UNITS FEATURES
-----------------------------------------------------------
  roost= {
               acceleration = 0,
               activatewhenbuilt = true,
               brakerate  = 0,
--               buildangle = 4096,
               buildcostenergy = 1337.0,
               buildcostmetal = 500,
               buildpic = "roost.DDS",
               buildtime  = 3315,
               category = "ALL PLANT NOTLAND NOWEAPON NOTSUB NOTSHIP NOTAIR SURFACE",
               --collisionvolumeoffsets = "",
               --collisionvolumescales = "",
               --collisionvolumetype = "",
               description = "Gates God-Like Forces",
               explodeas = "ATOMIC_SMALLNANO",
               footprintx = 5,
               footprintz = 5,
               icontype = "building",
               idleautoheal = 4,
               idletime = 1800,
               isTargetingUpgrade = true,
               mass = 165.75,
               maxdamage = 1800,
               maxvelocity = 0,
               mincloakdistance = 0,
               name = "Unidentified Unit",
               noAutoFire = false,
               objectname = "flea_teleport.s3o",
               seismicsignature = 0,
               selfdestructas = "ATOMIC_SMALLNANO",
               sightdistance = 273,
               TEDClass = "ENERGY", -- verificare se necessario
               turnrate = 0,
               upright = false,
               waterline = 0,
               workertime = 0,
               YardMap= "ooooo ooooo ooooo ooooo ooooo",
-----------------------------------------------------------
--- EFFECTS
-----------------------------------------------------------
sfxtypes = {
  explosiongenerators = {
               [1]="custom:fleanuklearmini",  -- NUCKLEARMINIFLEA scia che lascia l'oggetto mentre cade
			   [2]="custom:fleareactorbigsequence", -- luce centrale che rimane permanente
               [3]="custom:flealongnano", -- esplosione nano
               [4]="custom:fleafireLanding", -- esplosione durante l'impatto
               [5]="custom:fleaesplosionipostatterraggio", -- esplosioni nucleari post atterraggio
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
                     [1] = "kbarmmov",
                    },
               select = {
                     [1] = "kbarmsel",
                        },
               underattack = "warning1",
}, --close sound section
-----------------------------------------------------------
--- WEAPONS DEFINITION
-----------------------------------------------------------
weapondefs = {
}, -- close weapon definition

}, -- close unit data 
} -- close total
