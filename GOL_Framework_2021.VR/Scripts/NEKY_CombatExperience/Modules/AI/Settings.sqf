//	#include "Settings.sqf"
//
//	Settings for the AI Module
//
//	Made by NeKo-ArroW
//	Version 1.02

// Laser
_Laser = False;				// This makes AI react to laser being pointed at them.
_IdentifySpeed = 0.08;		// This decides how quickly they will identify the origin of the laser. Initial knowledge will be 1(25%). 0 = disables increasing knowledge. Anything above 0 is the % rate per second (1 = 100%). This updates every second.

// AI Surrender
_Surrender = False;			// This will make it possible for AI to surrender if conditions below are met.
_FriendliesNear = 1;		// How many friendlies are allowed to be near to the AI for it to surrender.
_Distances = [75,25];		// [DistanceToPlayer, DistanceToFriendly]. 1.How close atleast one player needs to be. 2. How far away a friendly (to the AI) unit needs to be.
_Chance = 0.02;				// How big of a chance there is for the AI to surrender if conditions above are met. 0 = 0%, 1 = 100%.

// AI Share Info
_ShareInfo = TRUE;			// This will make AI share info about enemy forces with other friendlies within range.
_ShareTo = ["MAN","LANDVEHICLE","AIR"];										// What kinds of groups information will be shared to. "MAN" = Infantry, "LANDVEHICLE" = Cars, IFV's, tanks etc. "AIR" = Aerial vehicles. These can be combined, ["MAN","LANDVEHICLE","AIR"].
NEKY_AI_ShareRange = 1000;	// All friendly AI within this range will be informed of the enemies.
NEKY_AI_ShareQuality = [0.2,0.4]	// This array sets the minimum and maximum quality of the information sent to friendly groups. 0 = 0%, 1 = 100%. [0.1, 0.8], 0.1 (10%) to 0.8 (80%) quality of original information will be transmitted from reporter to friendly reciever, the quality drops based upon distance to friendly, further away, less quality, closer, higher quality.