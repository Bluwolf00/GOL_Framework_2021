/*
	[Trigger_1,15,EAST,["O_Soldier_F"],"colorOPFOR",true] execVM "Scripts\OKS_Dynamic\OKS_Find_Roadblocks.sqf";
	[Trigger_2,6,EAST,false] spawn OKS_Find_Roadblocks;
*/

if(!isServer) exitWith {};

Params ["_MainTrigger","_RoadblockCount","_Side","_OnlyTarmac"];
private ["_RandomPos","_Road","_marker","_typeString","_Repetitions","_Debug_Variable","_Condition","_RoadPos"];

_Debug_Variable = true;

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];

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
	private _Condition = true;
	while {_Condition} do {

		_Repetitions = _Repetitions + 1;
		if(_Repetitions >= 100) then {break};
		_RandomPos = _MainTrigger call BIS_fnc_randomPosTrigger;
		_Road = [_RandomPos,500] call BIS_fnc_nearestRoad;

		if(_OnlyTarmac) then {

			if(_Debug_Variable) then {
				//systemChat format ["Tarmac RoadBlock: %1",(!(isNull _Road) && {_Road Distance _X < 300} count OKS_RoadBlock_Positions < 1 && (getPos _Road) inArea _MainTrigger && [_Road] call OKS_CheckRoadConnections && [_Road] call OKS_CheckIfTarmac)];
			};
			if(!(getPos _Road isFlatEmpty  [-1, -1, 0.05, 15, 0] isEqualTo []) && {_Road Distance _X < 300} count OKS_RoadBlock_Positions < 1 && (getPos _Road) inArea _MainTrigger && [_Road] call OKS_CheckRoadConnections && [_Road] call OKS_CheckIfTarmac) exitWith { if(_Debug_Variable) then {
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
	if(_Repetitions > 100) exitWith { if(_Debug_Variable) then {systemChat "Failed to Find Roadblock Position"} };

	if(!isNil "_Road") then {
		if(_Debug_Variable) then {systemChat "_Road Exists."};
		_RoadInfo = getRoadInfo _Road;
		_RoadDir = (_RoadInfo select 6) getDir (_RoadInfo select 7);
		_RoadPos = _RoadInfo select 6;
		_RoadTexture = _RoadInfo select 3;

		if(_RoadPos isEqualTo [0,0,0]) exitWith {};

		//systemChat str _RoadPos;
		private _can = createVehicle ["Land_Compass_F", _RoadPos, [], 0, "NONE"];
		_can setDir _RoadDir;


		if(["tarmac", _RoadTexture] call BIS_fnc_inString) then {

			if(_Debug_Variable) then {systemChat "Roadblock is Wide: Spawn Comp"};
			[ "roadblock_basic_wide", _RoadPos, [0,0,0], _RoadDir] call LARs_fnc_spawnComp;
			_typeString = "roadblock_basic_wide";
		} else {

			if(_Debug_Variable) then {systemChat "Roadblock is Small: Spawn Comp"};
			[ "roadblock_basic_small", _RoadPos, [0,0,0], _RoadDir] call LARs_fnc_spawnComp;
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
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [getPos _can select 0,getPos _can select 1,0], [], 10, "NONE"];
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
		[_RoadPos,5,150,_Side,_Units] spawn OKS_Patrol_Spawn;

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
	_marker setMarkerType _SideMarker;
	_marker setMarkerColor _SideColor;
	_marker setMarkerText "";
	if(_Debug_Variable) then {
		SystemChat format ["%1 %2 created at %3",_Side,_typeString,getMarkerPos _marker];
	};
		[_RoadPos,_Side,4 + (random 2),15] spawn OKS_Populate_Sandbag;
	};
	sleep 10;
}
