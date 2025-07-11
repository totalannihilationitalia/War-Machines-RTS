return {
  pala003_feature =
  {
    description = "A building",
    blocking = true,
    damage = 1000,
    energy = 0,
    flammable = false,
    featureDead ="pala003d_feature",
    noselect = false,
    metal = 250,
    footprintx = 4,
    footprintz = 4,
    object = "pala003.s3o",
    reclaimable = false,
    upright = true,
    crushResistance = 10000,
    crushResistance = 10000,
    collisionvolumeoffsets = "0 50 0",
    collisionvolumescales = "70 100 70",
    collisionvolumetype = "Box",
  },

  pala003d_feature =
  {
    description = "A destroyed building",
    blocking = true,
    damage = 500,
    energy = 0,
    flammable = false,
--    featureDead ="Pala003_d",
    noselect = false,
    metal = 100,
    footprintx = 4,
    footprintz = 4,
    object = "pala003_d.s3o",
    reclaimable = true,
    upright = true,
    crushResistance = 10000,
    collisionvolumeoffsets = "0 35 0",
    collisionvolumescales = "70 70 70",
    collisionvolumetype = "Box",
  },
}