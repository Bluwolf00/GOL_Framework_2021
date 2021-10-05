//	[Side] Call OKS_Task_Setting;
//
//	Settings for OKS Task.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_Leaders","_Units"];

/*
	Exfil marker used for Repair Task Exfil
*/
_ExfilMarker = "exfil_marker";

Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_SL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = [
			"B_Soldier_A_F",
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F",
			"B_Soldier_F",
			"B_Soldier_LAT_F"
		]; // Class names for infantry units.
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_SL_F","O_Soldier_TL_F"];
		_Units = [
			"O_Soldier_A_F",
			"O_Soldier_AR_F",
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_medic_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_LAT_F"
		];
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_SL_F","I_Soldier_TL_F"];
		_Units = [
			"I_Soldier_A_F",
			"I_Soldier_AR_F",
			"I_Soldier_AR_F",
			"I_medic_F",
			"I_medic_F",
			"I_Soldier_GL_F",
			"I_soldier_M_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_LAT_F"
		];

	};

	case civilian:
	{
		_Leaders = ["C_man_1"];
		_Units = [
			"C_man_polo_1_F",
			"C_man_polo_2_F",
			"C_man_polo_3_F",
			"C_man_polo_4_F",
			"C_man_polo_5_F",
			"C_man_polo_6_F",
			"C_man_1_1_F",
			"C_man_1_2_F",
			"C_man_1_3_F"
		];
	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_Leaders = "";
		_Units = "";
	};
};

// DO NOT EDIT ANYTHING BELOW \\
[_Leaders,_Units,_ExfilMarker]
