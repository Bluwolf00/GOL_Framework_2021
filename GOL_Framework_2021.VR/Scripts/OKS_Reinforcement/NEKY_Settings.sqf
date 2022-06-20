//	Settings for heli crew and units and also skill setting for heli crew and units.
//
//	Made By NeKo-ArroW


// General Settings
_Rendevouz = False;				// Whether AI units will rendevouz after a paradrop (Kinda edgy, test it if you're gonna use it).
_ChuteHeight = 60;				// The height of where AI will start opening their parachute. If they open it early the wind tends to drag them way off target.
_WPDistance = 150;				// The size of the area to search around when reaching their final SAD waypoint. For units.

_AirbaseRespawnTimer = 120; 	// Timer until allowed to respawn another wave of reinforcements. How its calculated: ThisTime + (random ThisTime) so 300+(randomly between 1-300).
_AirbaseRandomDistanceLZ = 200; // Distance from player the helicopter will choose HLS. Calculated like Timer, 150 meters + (Randomly 1 to 150m) - Max 300, minimum 151 meters.
_AirbaseRefreshRate = 30;		// Refresh timer, checks every X seconds if the player is within the attack zone and if they are detected.
_AirbaseRespawnCount = 10;		// How many waves of reinforcements will be sent from this base if allowed?
_EgressPos = [0,0,0];

_VehicleClassNameArray = ["B_LSV_01_armed_F","rhsusf_m113_usarmy"];
_SkillVariables = ["aimingspeed","aimingaccuracy","aimingshake","spotdistance","spottime","commanding","general"];	//	Add/Remove AI skill types here and add the number to pilot/crew/unit skills below.

// Side specific settings
Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Select AI Unit types \\
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];

		_HeliClass = "B_Heli_Transport_01_F"; // Default Heli class - Ghosthawk Armed
		_PilotClasses = ["B_Pilot_F"]; // Class names for pilots
		_CrewClasses = ["B_Pilot_F"]; // Class names for crew
		//	_UnitTypes = EnemyUnits;
		_UnitTypes = ["B_Soldier_TL_F","B_Soldier_TL_F","B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for unloaded/paradropped units. The first two are team leaders!

		// Set AI skill \\
		_PilotSkill = [0.3, 0.25, 0.3, 0.4, 0.4, 0.6, 0.7]; // [AimSpeed, AimAccuracy, AimShake, SpotDistance, SpotTime, Commanding, General] ( https://community.bistudio.com/wiki/AI_Sub-skills#Sub-Skills )
		_CrewSkill = [0.3, 0.2, 0.2, 0.4, 0.4, 0.6, 0.7];   // Skill ranges from 0 to 1. 0 = retarded. 1 = Super AI.
		_UnitSkill = [0.3, 0.3, 0.3, 0.4, 0.5, 0.8, 0.7];
	};
	case OPFOR:		// OPFOR settings
	{
		_HeliClass = "I_Heli_light_03_unarmed_F"; // Default Heli class - Orca Unarmed
		_PilotClasses = ["O_Pilot_F"]; // Class names for pilots
		_CrewClasses = ["O_Pilot_F"]; // Class names for crew
		//	_UnitTypes = EnemyUnits;
		_UnitTypes = ["O_Soldier_TL_F","O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"]; // Class names for unloaded/paradropped units. The first two are team leaders!

		_PilotSkill = [0.3, 0.25, 0.3, 0.4, 0.4, 0.6, 0.7]; // [AimSpeed, AimAccuracy, AimShake, SpotDistance, SpotTime, Commanding, General] ( https://community.bistudio.com/wiki/AI_Sub-skills#Sub-Skills )
		_CrewSkill = [0.3, 0.2, 0.2, 0.4, 0.4, 0.6, 0.7];   // Skill ranges from 0 to 1. 0 = retarded. 1 = Super AI.
		_UnitSkill = [0.3, 0.3, 0.3, 0.4, 0.5, 0.8, 0.7];
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_HeliClass = "I_Heli_light_03_unarmed_F"; // Default Heli class - Hellcat Unarmed
		_PilotClasses = ["I_Pilot_F"]; // Class names for pilots
		_CrewClasses = ["I_Pilot_F"]; // Class names for crew
		//	_UnitTypes = EnemyUnits;
		_UnitTypes = ["I_Soldier_TL_F","I_Soldier_TL_F","I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"]; // Class names for unloaded/paradropped units. The first two are team leaders!

		_PilotSkill = [0.3, 0.25, 0.3, 0.4, 0.4, 0.6, 0.7]; // [AimSpeed, AimAccuracy, AimShake, SpotDistance, SpotTime, Commanding, General] ( https://community.bistudio.com/wiki/AI_Sub-skills#Sub-Skills )
		_CrewSkill = [0.3, 0.2, 0.2, 0.4, 0.4, 0.6, 0.7];   // Skill ranges from 0 to 1. 0 = retarded. 1 = Super AI.
		_UnitSkill = [0.3, 0.3, 0.3, 0.4, 0.5, 0.8, 0.7];
	};


	default {SystemChat "Incorrect side."};
};