/* Sentry Spawner

	Params:
	1 - Location - Array Position
	2 - Enemy Side - Side
	3 - Amount of Units per Spawn - Integer Number
	4 - Delay per Spawn - Integer Seconds
	5 - Near Player Distance to Disable - Integer Meters
	6 - Max units limit - Integer Number

	Example: [spawner_1,east,1,20,40,20] execVM "Scripts\OKS_Ambience\OKS_SentrySpawner.sqf";
 */

Params ["_Location","_EnemySide","_UnitsPerSpawn","_DelayPerSpawn","_PlayerDistanceDisable","_MaxUnits"];
Private ["_CurrentUnits","_Units","_Spawned"];
_CurrentUnits = 0;
_Spawned = [];
switch (typeName _Location) do {
	case "OBJECT": { _Location = getPos _Location; };
	case "STRING": { _Location = getMarkerPos _Location;};
	default { _Location = _Location };
};

Switch (_EnemySide) do
{
	case BLUFOR:	// BLUFOR settings
	{
		_Units = [
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_LAT_F"
		]; // Class names for infantry units.
	};
	case OPFOR:		// OPFOR settings
	{
		_Units = [
			"O_Soldier_AR_F",
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
		_Units = [
			"I_Soldier_AR_F",
			"I_medic_F",
			"I_Soldier_GL_F",
			"I_soldier_M_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_LAT_F"
		];
	};
};

while {_CurrentUnits < _MaxUnits && {isPlayer _X} count (_Location nearEntities ["Man",_PlayerDistanceDisable]) == 0} do {

	if({_X distance _Location < 5} count _Spawned == 0) then{
		_NewGroup = CreateGroup _EnemySide;
		
		For "_i" from 1 to _UnitsPerSpawn do {

			_Unit = _NewGroup CreateUnit [(_Units call BIS_FNC_selectRandom), _Location, [], 0, "NONE"];
			_Unit setRank "PRIVATE";
			[_Unit,"FSM"] remoteExec ["disableAI",0];
			[_Unit,"UP"] remoteExec ["setUnitPos",0];
			_CurrentUnits = _CurrentUnits + 1;
			_Spawned pushBackUnique _Unit;

		};

		{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",3]} foreach units _NewGroup;
		[_NewGroup,300,15,[],[],true] remoteExec ["lambs_wp_fnc_taskRush",0];
	} else {
		SystemChat "Units on spawn stuck. Cancelled next spawn.";
	};
	sleep _DelayPerSpawn;

};
if({isPlayer _X} count (_Location nearEntities ["Man",_PlayerDistanceDisable]) > 0) exitWith { SystemChat "Nearby Players. Script exited.."};

