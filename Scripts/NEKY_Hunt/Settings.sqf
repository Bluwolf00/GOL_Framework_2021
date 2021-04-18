//	[] Call NEKY_Hunt_Settings;
//
//	Settings for NEKY_Hunt.
//
//	Returns: [Settings]
//
//	Made by NeKo-ArroW

// General Settings
_MinDistance = 100;	// Minimum distance in meters the AI spawn location has to be from all players.
_ForceRespawnMultiplier = 100; // _MinDistance * Multiplier = if distance to hunting target is greater than this, change target or respawn hunting group closer to players.
_UpdateFreq = 60; // Frequency in seconds that the hunting AI group will be updated with prey's position.
_MaxCargoSeats = 8; // Max amount of Cargo seats regardless of amount available to vehicle.

// Skill Settings
_SkillVariables = ["aimingspeed","aimingaccuracy","aimingshake","spotdistance","spottime","commanding","general"];	//	Add/Remove AI skill types here and add the number to unit skills below. ( https://community.bistudio.com/wiki/AI_Sub-skills#Sub-Skills )
_Skill = [0.4, 0.35, 0.35, 0.5, 0.6, 0.8, 0.7];	// Higher is better (0 - 1)

// Side specific settings
Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_TL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = ["B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for infantry units.
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = ["O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_TL_F","I_Soldier_TL_F"];
		_Units = ["I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_SkillVariables = "";
		_Skill = "";
		_Leaders = "";
		_Units = "";
	};
};

// DO NOT EDIT ANYTHING BELOW \\
[_MinDistance, _UpdateFreq, _SkillVariables, _Skill, _Leaders, _Units,_MaxCargoSeats];