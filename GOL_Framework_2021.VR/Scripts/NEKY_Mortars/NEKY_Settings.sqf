//	Settings for NEKY_Mortars
//
//	(https://community.bistudio.com/wiki/Arma_3_CfgMagazines#8Rnd_82mm_Mo_shells)   Mortar class names
//
//	Made by NeKo-ArroW


// General Settings
_TravelTime = 20;											// Time it takes for round to travel to its position. (Will always take a minimum of 2sec for sound effects sake).	Number (Seconds)
_Avoid = true;												// Avoid firing near friendlies, if friendlies are within "inaccuracy" area, it will hold fire and rescan.			Boolean
_AvoidMultiplier = 2;										// if a unit is within inaccuracy zone times(*) this multiplier then it counts as "too close".						Number (Multiplier)
_Danger = True;												// Dismount static weapon if an enemy unit is close.																Boolean
_DangerClose = 50;											// Range from which the unit will react to enemy forces and dismount static weapon.									Number (Meters)
_Lock = True;												// Lock the mortar if the gunner dies or leaves it (To avoid other AI to take it and operate it as they see fit). 	Boolean
_ScanVehicles = False;										// When scanning for targets, count manned vehicles as targets. True/False											Boolean
_Ammo = 100;												// Total ammo the mortar can spend. Once empty, unit will dismount.													Number (Mortars)

//	Firing Mode settings
_PreciseSize = [2,3,5];									// Randomly select number of mortars per "Precise" rotation.														Array of numbers (Mortars)
_PreciseReloadTime = 110;									// The time it takes for the mortar to prepare for another strike after performing a Precise strike.				Number (Seconds)
_BarrageSize = [8,10,12];									// Randomly selected number of mortars per barrage.																	Array of numbers (Mortars)
_BarrageReloadTime = 170;									// The time it takes for the mortar to prepare for another strike after performing a Barrage.						Number (Seconds)
_BarrageInaccuracyMultiplier = 1.75;						// How much more inaccurate the barrage will be compared to a precise strike.										Number (Multiplier)
_SporadicSize = [10,12,14];									// Randomly selected number of mortars per "Sporadic" rotation.														Array of numbers (Mortars)
_SporadicReloadTime = 90;									// The time it takes for the mortar to prepare for another strike after performing a Sporadic strike.				Number (Seconds)
_SporadicInaccuracyMultiplier = 4;							// How much more inaccurate the barrage will be compared to a precise strike.										Number (Multiplier)
_GuidedSize = [9,11,13];									// Randomly selected number of mortars per "Guided" rotation.														Array of numbers (Mortars)
_GuidedReloadTime = 150;									// The time it takes for the mortar to prepare for another strike after performing a Guided strike.					Number (Seconds)
_GuidedInaccuracyMultiplier = 3;							// How much more inaccurate the Guided strike will be to begin with													Number (Multiplier)
_ScreenSize = [6,8,10];										// Randomly select number of mortars per "Screen" rotation.															Array of numbers (Mortars)
_ScreenReloadTime = 150;									// The time it takes for the mortar to prepare for another strike after performing a Screen strike.					Number (Seconds)

// Class Names
_Light = "Sh_82mm_AMOS";									// Class name of light mortar round.																				String
_Medium = "Sh_120mm_HE";									// Class name of medium mortar round.																				String
_Heavy = "Sh_155mm_AMOS";									// Class name of heavy mortar round.																				String
_Smoke = "Smoke_120mm_AMOS_White";							// Class name of smoke round.																						String
_Flare = "F_40mm_White";									// Class name of flare round.																						String


// Day/Night time
_Sunrise = 4.00;											// The time it gets bright enough for smokes to be used instead of flares.											Number (0.00 - 23.59)
_Sunset = 22.00;											// The time it gets dark enough to start using flares.																Number (0.00 - 23.59)

// Crew
_BLUFORGunner = ["B_Soldier_F"];							// BLUFOR Gunner for the Mortar
_OPFORGunner = ["O_Soldier_F"];								// OPFOR Gunner for the Mortar
_INDEPGunner = ["I_Soldier_F"];								// INDEPENDENT Gunner for the Mortar

// _OPFORGunner = EnemyUnits;								// BLUFOR Gunner for the Mortar

//	Marking and Sound effects
_Marking = [false,true,true,false,false];					// If marking should be used on firing modes. [Sporadic,Precise,Barrage,Guided,Screen] True / False					Array of Booleans
_SoundOn = [true,false,false,false,true];					// If sound effect should be applied to mortar round when incoming. [Light,Medium,Heavy,Smoke,Flare] True / False	Array of Booleans
_SoundTypes = ["mortar1","","",""];							// The sound effects used by using Say3d. [Light,Medium,Heavy,Smoke]												Array of Strings
_MarkSmoke = "SmokeShellRed";								// Class name of smoke that marks target area.																		String
_MarkFlare = "F_40mm_Red";									// Class name of flare that marks target area.																		String

//	Random Parameter. These are the firing modes that will be randomly selected if firing mode is "Random".
_RandomFiringMode = ["Sporadic", "Precise", "Barrage", "Guided"]; // Randomly selected firing mode. Default: ["Sporadic", "Precise", "Barrage", "Guided"]						Array of Strings




