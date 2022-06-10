/*
	OKS_Rush_SpawnGroup
	[SpawnPos,UnitsPerBase,Side,Range] spawn OKS_Rush_SpawnGroup;
	[SpawnPos,UnitsPerBase,Side,Range] execVM "Scripts\OKS_Dynamic\OKS_Rush_SpawnGroup.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_SpawnPos","_NumberInfantry","_Side","_Range"];
	private ["_RandomPos","_Center"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	_Group = CreateGroup _Side;
	for "_i" from 1 to (_NumberInfantry) do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _SpawnPos getPos [5,(random 360)], [], 0, "NONE"];
			_Unit setRank "SERGEANT";
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SpawnPos getPos [5,(random 360)], [], 0, "NONE"];
			_Unit setRank "PRIVATE";
		};
		sleep 0.5;
	};
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	waitUntil {sleep 1; !isNil "lambs_wp_fnc_moduleRush"};
	[_Group,_Range,30,[],[],true] remoteExec ["lambs_wp_fnc_taskRush",0];

