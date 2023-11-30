//
//  [_Trigger,_Side,_InfantryNumber,_CreateObjective,_CreateLocalPatrols] spawn OKS_Populate_Strongpoints;
//  execVM "Scripts\OKS_Dynamic\OKS_Populate_Strongpoints.sqf"
//

if(HasInterface && !isServer) exitWith {};

Params["_MainTrigger","_Side","_InfantryNumber","_CreateObjective","_CreateLocalPatrols"];
private ["_StrongholdNumber","_House","_AllBuildings","_buildingArray","_SelectedBuildings","_HouseCount","_i","_HouseMax","_Strongpoint","_Location","_CountStrongpoints","_Group","_GarrisonNumber","_Location","_Debug_Variable","_Strongpoint","_SortedBuildings","_SafePos","_Marker","_AllNumbers","_SelectedStrongpoints","_Strongpoints","_MarkerPos","_PlacedStrongpoints","_Locations","_PatrolNumber"];

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_ObjectiveTypes","_Configuration"];
_UnitArray Params ["_Leaders","_Units","_Officer"];
_Configuration Params ["_CompoundSize","_EnableEnemyMarkers"];

_Debug_Variable = false;
_SelectedStrongpoints = [];
_Strongpoints = [];
_Locations = [];
private _Compounds = [];

//{_Locations pushBackUnique getPos _X} foreach nearestObjects [_MainTrigger, ["LocationCamp_F","LocationResupplyPoint_F","LocationRespawnPoint_F","LocationEvacPoint_F","LocationFOB_F","LocationCityCapital_F","LocationCity_F","LocationVillage_F","LocationArea_F"], (TriggerArea _MainTrigger select 0)];
//{_Compounds pushBackUnique getPos _X} foreach nearestObjects [_MainTrigger, ["LocationBase_F","LocationOutpost_F"], (TriggerArea _MainTrigger select 0)];

_Locations = OKS_Locations select {_X inArea _MainTrigger};
_Compounds = OKS_Compounds select {_X inArea _MainTrigger};
_Strongholds = OKS_Strongholds select {_X inArea _MainTrigger};

if(_Debug_Variable) then {
	systemChat format ["Locations: %1",count _Locations];
	systemChat format ["Array: %1",_Locations];
};

if(_Locations isEqualTo [] && _Compounds isEqualTo []) then {
	if(_Debug_Variable) then {systemChat format ["Locations is Empty. Compounds is not Empty."]};
	{_Locations pushBackUnique (locationPosition _X)} foreach nearestLocations [_MainTrigger,["NameVillage","NameCity","NameCityCapital","Hill","Name","NameLocal","fakeTown"],(TriggerArea _MainTrigger select 0)];
	_Locations = _Locations select {_X inArea _MainTrigger};
};
/*
if(!isNil "OKS_Populate_StaticWeapons") then {
	[_MainTrigger,(TriggerArea _MainTrigger select 0 / 2),_Side] spawn OKS_Populate_StaticWeapons;
};
*/
if(count _Locations > 0) then {
	{
		if(typeName _X == "OBJECT") then {
			_Location = nearestBuilding (getPos _X);
		} else {
			_Location = nearestBuilding _X;
		};
		_AllBuildings = (_Location) nearObjects ["House",125];
		_SortedBuildings = [_AllBuildings,[],{(_Location) distance _x},"ASCEND"] call BIS_fnc_sortBy;
		_SortedBuildings = _SortedBuildings select { 6 < count([_X] call BIS_fnc_buildingPositions) && !(isObjectHidden _X) };
		sleep 2;
		if(count _SortedBuildings >= 3) then {
			_Strongpoint = createMarker [format ["oks_SP_Marker_%1",str round(random 90000)],_Location];
			//SystemChat str [_Strongpoint];
			_SelectedStrongpoints pushBackUnique (getMarkerPos _Strongpoint);
			//SystemChat str [_SelectedStrongpoints];

			if(_Debug_Variable) then {
				_Strongpoint setMarkerShape "ICON";
				_Strongpoint setMarkerType "hd_dot";
				_Strongpoint setMarkerText "Strongpoint";
				_Strongpoint setMarkerColor "ColorBLACK";
			};
		};
	} foreach _Locations;
};

_CountStrongpoints = ((count _SelectedStrongpoints) + (count _Compounds) + (count _Strongholds));
if(_CountStrongpoints > 0) then {

	_AllNumbers = round(_InfantryNumber / _CountStrongpoints);
	systemChat str _AllNumbers;
	if(_CreateLocalPatrols) then {
		if(_Debug_Variable) then {
			systemChat format ["CreateLocalPatrols is True."];
		};
		_GarrisonNumber = round(_AllNumbers * 0.4);
		_StrongholdNumber = round(_AllNumbers * 0.4);
		_PatrolNumber = round((_AllNumbers * 0.2) / 3);
	} else {
		if(_Debug_Variable) then {
			systemChat format ["CreateLocalPatrols is False."];
		};
		_GarrisonNumber = _AllNumbers;
		_StrongholdNumber = _AllNumbers;
		_PatrolNumber = 0;
	};

	if(_Compounds isNotEqualTo []) then {
		{
			_Compound = createMarker [format ["oks_Compound_Marker_%1",str round(random 90000)],_X];
			if(_EnableEnemyMarkers && _Side != civilian) then {
				[_Compound,_Side,"infantry",_GarrisonNumber,0.8] spawn OKS_CreateUnitMarker;
			};
			[_GarrisonNumber,getPos _X,_Side,_UnitArray,_CompoundSize] spawn OKS_Garrison_Compound;
			if(_CreateLocalPatrols) then {
				if(_Debug_Variable) then {
					systemChat format ["%1 Patrol Number - Creating patrols",_PatrolNumber];
				};
				for "_i" from 0 to 3 step 1 do
				{
					Private _DirectionPos = (getPos _X) getPos [75,(random 360)];
					_SafePos = [getPos _X, 1, 75, 5, 0, 0.2, 0] call BIS_fnc_findSafePos;
					_Group = CreateGroup _Side;
					for "_i" from 0 to _PatrolNumber do
					{
						Private "_Unit";
						if ( (count (units _Group)) == 0 ) then
						{
							_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _SafePos, [], 0, "NONE"];
							_Unit setRank "SERGEANT";
							_Unit remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
						} else {
							_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SafePos, [], 0, "NONE"];
							_Unit setRank "PRIVATE";
							_Unit remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
						};
						sleep 1;
					};
					[_Group, _DirectionPos, (_CompoundSize * 2)] call CBA_fnc_taskPatrol;
					{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
					_Group setBehaviour "SAFE";
				};
			};
			if(_CreateObjective && {_X getVariable ["isSectorTrigger",false]} count (_X nearObjects ["EmptyDetector",(_CompoundSize * 3)]) < 1) then {
				[getPos _X,"sector",(_CompoundSize * 2),_Side,_Settings] spawn OKS_CreateObjectives;
			};
			sleep 3;
		} foreach _Compounds;
	};

	if(_Strongholds isNotEqualTo []) then {
		{
			_Stronghold = createMarker [format ["oks_Stronghold_Marker_%1",str round(random 90000)],_X];
			if(_EnableEnemyMarkers && _Side != civilian) then {
				[_Compound,_Side,"infantry",_StrongholdNumber,0.8] spawn OKS_CreateUnitMarker;
			};

			_Group = [_StrongholdNumber,nearestBuilding (getPos _X),_Side,_UnitArray] call OKS_Garrison;

			if(_CreateObjective) then {
				[_Group,"neutralize",100,_Side,_Settings] spawn OKS_CreateObjectives;
			};
			sleep 3;
		} foreach _Strongholds;
	};

	if(_Debug_Variable) then {
		systemChat format ["Garrison Number: %1 | Count Strongpoints: %2 | AllNumbers: %3",_GarrisonNumber,_CountStrongpoints,_AllNumbers];
	};
	_HouseMax = round(_GarrisonNumber / 4);
	if(_Debug_Variable) then {
		systemChat format ["Selected Strongpoints: %1",count _SelectedStrongpoints];
	};

	{
		if(_Debug_Variable) then {
			systemChat format ["%1 Garrison for %4 Max-Houses & 3 Patrols of %3 of total %2",_GarrisonNumber,(_GarrisonNumber) + (_PatrolNumber * 3),_PatrolNumber,_HouseMax];
		};
		_MarkerPos = _X;

		if(_CreateObjective && {_X getVariable ["isSectorTrigger",false]} count (_X nearObjects ["EmptyDetector", 250]) < 1) then {
			[_MarkerPos,"sector",125,_Side,_Settings] spawn OKS_CreateObjectives;
		};

		if(_CreateLocalPatrols) then {
			if(_Debug_Variable) then {
				systemChat format ["%1 Patrol Number - Creating patrols",_PatrolNumber];
			};
			{
				Private _DirectionPos = _MarkerPos getPos [75,(random 360)];
				_SafePos = [_MarkerPos, 1, 75, 5, 0, 0.2, 0] call BIS_fnc_findSafePos;
				_Group = CreateGroup _Side;
				for "_i" from 1 to _PatrolNumber do
				{
					Private "_Unit";
					if ( (count (units _Group)) == 0 ) then
					{
						_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _SafePos, [], 0, "NONE"];
						_Unit setRank "SERGEANT";
						_Unit remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
					} else {
						_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SafePos, [], 0, "NONE"];
						_Unit setRank "PRIVATE";
						_Unit remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
					};
					sleep 1;
				};
				[_Group, _DirectionPos, 100] call CBA_fnc_taskPatrol;
				_Group setBehaviour "SAFE";
			} foreach [1,2,3];

		};

			_SelectedBuildings = [];
			_AllBuildings = nearestObjects [_X,["House"],125];
			_RemoveBuildings = nearestObjects [_X,["Land_i_Addon_03_V1_F","Land_i_Addon_03mid_V1_F","Land_i_Addon_04_V1_F"],125];

			_AllBuildings = _AllBuildings - _RemoveBuildings;

			_SortedBuildings = [_AllBuildings,[],{_MarkerPos distance _x},"ASCEND"] call BIS_fnc_sortBy;
			_SortedBuildings = _SortedBuildings select { 6 < count([_X] call BIS_fnc_buildingPositions) };

			sleep 1;

			if(count _SortedBuildings > 0) then {
				For "_i" to (_HouseMax - 1) do {_House = (selectRandom _SortedBuildings); if(!isNil "_House") then {_SelectedBuildings pushBackUnique _House; _SortedBuildings deleteAt (_SortedBuildings find _House)}};
				{
					[4,_X,_Side,_UnitArray] spawn OKS_Garrison;
					if(_EnableEnemyMarkers && _Side != civilian) then {
						_Marker = createMarker [format ["oks_SP_Marker_%1",str round(random 90000)],getPos _X];
						[_marker,_Side,"infantry",4,0.8] spawn OKS_CreateUnitMarker;
					};
				} foreach _SelectedBuildings;

				if(_Debug_Variable) then {
					//systemChat str [_HouseMax,count _SortedBuildings,count _SelectedBuildings];
				};
			};
	} foreach _SelectedStrongpoints;
};
