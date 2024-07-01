	// OKS_StaticGroup_NearestBuilding
	// [group this,getPos house_1] call OKS_StaticGroup_NearestBuilding;
	//  [group this] execVM "Scripts\OKS_Task\OKS_StaticGroup_NearestBuilding.sqf";
	if(!isServer) exitWith {};

	Params [
		["_NumberOfInfantry",5,[0]],
		["_HouseLocation",[0,0,0],[[]]],
		["_Side",west,[sideUnknown]]
	];
	Private ["_Group","_GarrisonPositions","_GarrisonMaxSize"];
	Private _Debug_Variable = false;
		
	_Settings = [_Side] call OKS_TASK_Setting;
	_Settings Params ["_Leaders","_Units"];
	_Building = nearestBuilding _HouseLocation;
	_Building setVariable ["OKS_IsObjective",true];
	_GarrisonMaxSize = Count ([_Building] call BIS_fnc_buildingPositions);
	_GarrisonPositions = ([_Building] call BIS_fnc_buildingPositions);

	if(_GarrisonMaxSize == 0) exitWith {
		format["%1 did not have any buildingPositions.",typeOf _Building]
	};

	// If Garrison is too big for Building, set to max size.
	if(_NumberOfInfantry >= _GarrisonMaxSize) then {
		_NumberOfInfantry = _GarrisonMaxSize;
		if(_Debug_Variable) then { systemChat str _NumberOfInfantry };
	};

	// Create the Garrison Group
	_Group = CreateGroup _Side;
	
	for "_i" from 1 to _NumberOfInfantry do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _HouseLocation, [], 0, "NONE"];
			_Unit setRank "SERGEANT";
			_SelectedLeader = _Unit;
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _HouseLocation getPos [(random 8),(random 360)], [], 0, "NONE"];
			_Unit setRank "PRIVATE";
		};
		if(_Debug_Variable) then {SystemChat format ["%1 Pos %2",group _unit,getPos _Unit]};
		_Unit disableAI "PATH";
		_Unit setCombatMode "YELLOW";

		if(side _Unit == side player) then {
			_Unit setSkill 1;
		};	

		_Select = selectRandom _GarrisonPositions;
		_GarrisonPositions deleteAt (_GarrisonPositions find _Select);
		_Unit setPosATL _Select;

		if(_Side isNotEqualTo civilian) then {
			_Unit setUnitPos (selectRandom ["UP","MIDDLE"]);
		};
	};

_Group