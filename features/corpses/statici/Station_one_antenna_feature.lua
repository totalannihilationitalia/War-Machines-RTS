return {
  Station_one_antenna_feature =
  {
    description = "A big antenna",
    blocking = true,
    damage = 30000,
    energy = 60000,
    flammable = false,
    featureDead ="Station_one_antenna_feature_dead",
    noselect = false,
    metal = 10000,
    footprintx = 1,
    footprintz = 1,
    object = "Station_one_antenna.s3o",
    reclaimable = true,
    upright = true,
--    collisionvolumeoffsets = "0 0 0",
--    collisionvolumescales = "5 50 5",
--    collisionvolumetype = "Box",
  },
  Station_one_antenna_feature_dead =
  {
    description = "wreckage of a big antenna",
    blocking = true,
    damage = 15000,
    energy = 30000,
    flammable = false,
--    featureDead ="",
    noselect = false,
    metal = 5000,
    footprintx = 1,
    footprintz = 1,
    object = "Station_one_antenna_rottami.s3o",
    reclaimable = true,
    upright = true,
--    collisionvolumeoffsets = "0 0 0",
--    collisionvolumescales = "5 50 5",
--    collisionvolumetype = "Box",
  },
}