/*
	[Trigger_1,15,EAST,["O_Soldier_F"],"colorOPFOR",true] execVM "Scripts\OKS_Dynamic\OKS_Find_Roadblocks.sqf";
	[Trigger_2,6,EAST,false] spawn OKS_Find_Roadblocks;
*/

if(!isServer) exitWith {};

Params ["_MainTrigger","_RoadblockCount","_Side","_OnlyTarmac","_RoadblockPatrols","_VehicleChance"];
private ["_RandomPos","_Road","_marker","_typeString","_Repetitions","_Debug_Variable","_Condition","_RoadPos","_Type","_VehicleClass","_BaseDir","_SelectedPos","_Location"];

_Debug_Variable = false;

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_ObjectiveTypes","_Configuration"];
_UnitArray Params ["_Leaders","_Units","_Officer"];
_Vehicles Params ["_Wheeled","_APC","_Tank","_Artillery","_Helicopter","_Transport","_Supply"];
_Configuration Params ["_CompoundSize","_EnableEnemyMarkers","_EnableZoneMarker","_EnableZoneTypeMarker","_RoadblockVehicleType"];

Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		_SideMarker = "B_installation";
	};
	case OPFOR:		// OPFOR settings
	{
		_SideMarker = "O_installation";
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_SideMarker = "N_installation";
	};

	default
	{
		_SideMarker = "O_installation";
	};
};

For "_i" from 1 to _RoadblockCount do {

	_Repetitions = 0;
	_VehicleClass = selectRandom _RoadblockVehicleType;

	private _Condition = true;

	Private _LocationsInArea = OKS_Roadblocks select {_X inArea _MainTrigger};
	if(count _LocationsInArea > 0) then {
		_Location = SelectRandom _LocationsInArea;
		OKS_Roadblocks deleteAt (OKS_Roadblocks find _Location);
		_SelectedPos = getPos _Location;
		_BaseDir = getDir _Location;
		_Road = [_SelectedPos, 20] call BIS_fnc_nearestRoad;
		if(_Debug_Variable) then { SystemChat format ["HuntBase Logic found."]};
	} else {
		while {_Condition} do {

			_Repetitions = _Repetitions + 1;
			if(_Repetitions >= 100) then {break};
			_RandomPos = _MainTrigger call BIS_fnc_randomPosTrigger;
			_Road = [_RandomPos,500] call BIS_fnc_nearestRoad;

			if(_OnlyTarmac) then {

				if(_Debug_Variable) then {
					//systemChat format ["Tarmac RoadBlock: %1",(!(isNull _Road) && {_Road Distance _X < 300} count OKS_RoadBlock_Positions < 1 && (getPos _Road) inArea _MainTrigger && [_Road] call OKS_CheckRoadConnections && [_Road] call OKS_CheckIfTarmac)];
				};
				if(!((getRoadInfo _Road select 0) isEqualTo "TRAIL") && !(getPos _Road isFlatEmpty  [-1, -1, 0.15, 25, 0] isEqualTo []) && {_Road Distance _X < 300} count OKS_RoadBlock_Positions < 1 && (getPos _Road) inArea _MainTrigger && [_Road] call OKS_CheckRoadConnections && [_Road] call OKS_CheckIfTarmac) exitWith { if(_Debug_Variable) then {
					systemChat format ["Road Found: %1",_Road]}; _Condition = false};
			} else {
				if(_Debug_Variable) then {
					//systemChat format ["Non Tarmac Road Block: %1",(!(getPos _Road isFlatEmpty  [-1, -1, 0.05, 15, 0] isEqualTo []) && !(isNull _Road) && {_Road Distance _X < 300} count OKS_RoadBlock_Positions < 1 && (getPos _Road) inArea _MainTrigger && [_Road] call OKS_CheckRoadConnections)];
				};
				if( !((getRoadInfo _Road select 0) isEqualTo "TRAIL") && !(getPos _Road isFlatEmpty  [-1, -1, 0.05, 15, 0] isEqualTo []) && {_Road Distance _X < 300} count OKS_RoadBlock_Positions < 1 && (getPos _Road) inArea _MainTrigger && [_Road] call OKS_CheckRoadConnections) exitWith { if(_Debug_Variable) then {
					systemChat format ["Non Tarmac Road Found: %1",_Road]}; _Condition = false};
			};
			sleep 0.5;
		};
	};
	if(_Repetitions > 100 || isNil "_Road") exitWith { if(_Debug_Variable) then {systemChat "Failed to Find Roadblock Position"} };

	if(!isNil "_Road") then {
		if(_Debug_Variable) then {systemChat "_Road Exists."};
		_RoadInfo = getRoadInfo _Road;
		if(isNil "_BaseDir") then {
			_BaseDir = (_RoadInfo select 6) getDir (_RoadInfo select 7);
		};
		_RoadPos = _RoadInfo select 6;
		_RoadTexture = _RoadInfo select 3;

		if(_RoadPos isEqualTo [0,0,0]) exitWith {};

		//systemChat str _RoadPos;
		private _can = createVehicle ["Land_Compass_F", _RoadPos, [], 0, "NONE"];
		_can setDir _BaseDir;

		if(["tarmac", _RoadTexture] call BIS_fnc_inString) then {

			if(_Debug_Variable) then {systemChat "Roadblock is Wide: Spawn Comp"};
			[ "roadblock_basic_wide", _RoadPos, [0,0,0], _BaseDir] call LARs_fnc_spawnComp;
			_typeString = "roadblock_basic_wide";
		} else {

			if(_Debug_Variable) then {systemChat "Roadblock is Small: Spawn Comp"};
			[ "roadblock_basic_small", _RoadPos, [0,0,0], _BaseDir] call LARs_fnc_spawnComp;
			_typeString = "roadblock_basic_small";
		};

		OKS_RoadBlock_Positions pushBackUnique _RoadPos;
		publicVariable "OKS_RoadBlock_Positions";

		if(_typeString isEqualTo "roadblock_basic_wide") then {

			if(_Debug_Variable) then {systemChat "Roadblock is Wide: Deploy Garrison"};
			_Group = CreateGroup _Side;
			for "_i" from 1 to 2 do
			{
				Private "_Unit";
				if ( (count (units _Group)) == 0 ) then
				{
					_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [getPos _can select 0,getPos _can select 1,0], [], 10, "NONE"];
					_Unit setRank "SERGEANT";
				} else {
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [getPos _can select 0,getPos _can select 1,0], [], 10, "NONE"];
					_Unit setRank "PRIVATE";
				};
			};

			[[_RoadPos select 0,_RoadPos select 1,0], nil, units _Group, 35, 0, true, true] remoteExec ["ace_ai_fnc_garrison",0];
			sleep 5;
		};

		_Statics = nearestObjects [GetPos (Leader _Group),["StaticWeapon"],40];
		//SystemChat str _Statics;

		_StaticGroup = CreateGroup _Side;
		{
			_Unit = _StaticGroup CreateUnit [(_Units call BIS_FNC_selectRandom), GetPos (Leader _Group), [], 5, "NONE"];
			_Unit setRank "PRIVATE";
			//systemChat str [_Unit,_X];
			_Unit moveInAny _X;
		} foreach _Statics;
		/*

			 * Arguments:
			 * 0: The building(s) nearest this position are used <POSITION>
			 * 1: Limit the building search to those type of building <ARRAY>
			 * 2: Units that will be garrisoned <ARRAY>
			 * 3: Radius to fill building(s) <SCALAR> (default: 50)
			 * 4: 0: even filling, 1: building by building, 2: random filling <SCALAR> (default: 0)
			 * 5: True to fill building(s) from top to bottom <BOOL> (default: false) (note: only works with filling mode 0 and 1)
			 * 6: Teleport units <BOOL> (default: false)

		*/
		//copyToClipboard str _GarrisonPositions;
		if(_RoadblockPatrols) then {
			[_RoadPos,5,150,_Side] spawn OKS_Patrol_Spawn;
		};

		sleep 2;
		_Objects = nearestObjects [getpos _Road,[],55];
		//SystemChat str _Objects;

		_Objects = _Objects select { getPos _X select 2 > 0 && !(_X isKindOf "MAN") && !(_X isKindOf "StaticWeapon")};
		//copyToClipboard str _Objects;

		{_X setPos [getPos _X select 0,getpos _X select 1,-0.1]; _X setVectorUp [0,0,1] } foreach _Objects;

	if(typeName _RoadPos == "ARRAY") then {
		_marker = createMarker [format ["OKS_Roadblock_Marker_%1",str (random 2000)],_RoadPos];
	} else {
		_marker = createMarker [format ["OKS_Roadblock_Marker_%1",str (random 2000)],getPos _RoadPos];
	};
	_marker setMarkerShape "ICON";
	_marker setMarkerSize [0.6,0.6];

	if(_EnableEnemyMarkers) then {
		_marker setMarkerType _SideMarker;
		_marker setMarkerColor _SideColor;
		_marker setMarkerText "";
	};
	if(_Debug_Variable) then {
		SystemChat format ["%1 %2 created at %3",_Side,_typeString,getMarkerPos _marker];
	};
		waitUntil{sleep 10; !isNil "OKS_Populate_Sandbag"};
		[getMarkerPos _marker,_Side,3 + (random 2),35] spawn OKS_Populate_Sandbag;

		if((random 1) <= _VehicleChance) then {
			if(_Debug_Variable) then {SystemChat str _VehicleClass};
			_Vehicle = createVehicle [_VehicleClass, getMarkerPos _Marker, [], 0, "NONE"];
			if(GOL_Remove_HE_From_StaticAndVehicle) then {
				[_Vehicle] spawn OKS_RemoveVehicleHE;	
			};	
			_Vehicle setDir _BaseDir;
			_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
			_Vehicle engineOn true;
			sleep 1;
			[[driver _Vehicle],{ Params ["_unit"]; _unit disableAI "PATH"; doStop _unit; }] remoteExec ["BIS_FNC_CALL",0]; 
		};
	};
}
