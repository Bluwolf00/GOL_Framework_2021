/*
	OKS_Hunt_SpawnGroup
	[Spawn,nil,UnitOrClassname,Side,Range] spawn OKS_Hunt_SpawnGroup;
	[Spawn,nil,UnitOrClassname,Side,Range] execVM "Scripts\OKS_Dynamic\OKS_Hunt_SpawnGroup.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_Spawn","_Dir","_ClassnameOrNumber","_Side","_Range"];
	if(typeName _Spawn == "OBJECT") then {
		_Dir = getDir _Spawn;
		_Spawn = getPos _Spawn;
	};
	Private ["_Group"];
	waitUntil {sleep 1; !isNil "OKS_Dynamic_Setting"};
	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	
	if(typeName _ClassnameOrNumber == "SCALAR") then {
		_Group = CreateGroup _Side;
		for "_i" from 1 to (_NumberInfantry) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _Spawn getPos [5,(random 360)], [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Spawn getPos [5,(random 360)], [], 0, "NONE"];
				_Unit setRank "PRIVATE";
			};
			sleep 0.5;
		};
	};
	if(typeName _ClassnameOrNumber == "STRING") then {
		_Vehicle = CreateVehicle [_ClassnameOrNumber,_Spawn];
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
	};
	if(typeName _ClassnameOrNumber == "ARRAY") then {
		_ClassnameOrNumber = selectRandom _ClassnameOrNumber;
		_Vehicle = CreateVehicle [_Classname,_Spawn];
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
	};
	sleep 1;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	if(isNil "_Group") exitWith {false};
	waitUntil {sleep 5; !(isNil "lambs_wp_fnc_taskHunt")};
	[_Group, _Range, 30, [], [], false] spawn lambs_wp_fnc_taskHunt;

