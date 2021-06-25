//
//  [_Position,_Side,_InfantryNumber,_Range] spawn OKS_Populate_Bunkers;
//  execVM "Scripts\OKS_Dynamic\OKS_Populate_Bunkers.sqf"
//

if(HasInterface && !isServer) exitWith {};


Params["_Position","_Side","_InfantryNumber","_Range"];
private ["_Units"];

	Switch (_Side) do
	{
		case BLUFOR:	// BLUFOR settings
		{
			_Units = ["B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for infantry units.
		};
		case OPFOR:		// OPFOR settings
		{
			_Units = ["O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
		};
		case INDEPENDENT:	// INDEPENDENT Settings
		{
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

	_Group = CreateGroup _Side;
	for "_i" from 1 to (_InfantryNumber - 1) do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_Position select 0,_Position select 1,0], [], 10, "NONE"];
			_Unit setRank "SERGEANT";
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_Position select 0,_Position select 1,0], [], 10, "NONE"];
			_Unit setRank "PRIVATE";
		};
	};
	[[_Position select 0,_Position select 1,0], nil, units _Group, _Range, 0, true, true] remoteExec ["ace_ai_fnc_garrison",0];