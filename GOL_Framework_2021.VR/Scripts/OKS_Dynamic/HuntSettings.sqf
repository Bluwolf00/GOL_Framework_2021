//	[] Call OKS_Hunt_Settings;
//
//	Settings for OKS Dynamic.
//
//	Returns: [Settings]

/* Respawn Time in seconds */
_InfantryRespawnTime = 1200;
_WheeledRespawnTime = 1200;
_APCRespawnTime = 1200;
_TankRespawnTime = 1200;
_HelicopterRespawnTime = 1200;

/* Number of Waves */
_InfantryWaves = 5;
_WheeledWaves = 5;
_APCWaves = 5;
_TankWaves = 5;
_HelicopterWaves = 5;

/* Global Refresh Rate */
_RefreshRate = 30;

_Waves = [_InfantryWaves,_WheeledWaves,_APCWaves,_TankWaves,_HelicopterWaves];
_Respawn = [_InfantryRespawnTime,_WheeledRespawnTime,_APCRespawnTime,_TankRespawnTime,_HelicopterRespawnTime];

// DO NOT EDIT ANYTHING BELOW \\
[_Respawn,_Waves,_RefreshRate];