//
//  [_Trigger,_Side,_InfantryNumber] spawn OKS_Populate_Strongpoints;
//  execVM "Scripts\OKS_Dynamic\OKS_Populate_Strongpoints.sqf"
//

if(HasInterface && !isServer) exitWith {};

Params["_MainTrigger","_Side","_InfantryNumber","_SearchLocation"];
private ["_House","_AllBuildings","_buildingArray","_SelectedBuildings","_HouseCount","_i","_HouseMax","_Strongpoint","_Location","_CountStrongpoints","_Group","_GarrisonNumber","_Location","_Debug_Variable","_Strongpoint","_SortedBuildings","_SafePos","_Marker","_AllNumbers","_SelectedStrongpoints","_Strongpoints","_MarkerPos","_PlacedStrongpoints","_Locations"];

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];

_Debug_Variable = false;
_SelectedStrongpoints = [];
_Strongpoints = [];
_Locations = [];


			{_Locations pushBackUnique getPos _X} foreach nearestObjects [_MainTrigger, ["LocationBase_F","LocationOutpost_F","LocationCamp_F","LocationResupplyPoint_F","LocationRespawnPoint_F","LocationEvacPoint_F","LocationFOB_F","LocationCityCapital_F","LocationCity_F","LocationVillage_F","LocationArea_F"], (TriggerArea _MainTrigger select 0 / 2)];

			if(_SearchLocation || _Locations isEqualTo []) then {
				{_Locations pushBackUnique (locationPosition _X)} foreach nearestLocations [_MainTrigger,["NameVillage","NameCity","NameCityCapital","Hill","Name","NameLocal","fakeTown"],(TriggerArea _MainTrigger select 0 / 2)];
			};

			if(count _Locations > 0) then {
				{
					_Location = nearestBuilding _X;
					_AllBuildings = (_Location) nearObjects ["House",125];
					_SortedBuildings = [_AllBuildings,[],{(_Location) distance _x},"ASCEND"] call BIS_fnc_sortBy;
					_SortedBuildings = _SortedBuildings select { 5 < count([_X] call BIS_fnc_buildingPositions) };
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
			_CountStrongpoints = count _SelectedStrongpoints;
if(_CountStrongpoints > 0) then {

	_AllNumbers = round(_InfantryNumber / _CountStrongpoints);
	_GarrisonNumber = round(_AllNumbers * 0.7);
	_PatrolNumber = round((_AllNumbers * 0.3) / 3);

	if(_Debug_Variable) then {
		systemChat format ["Garrison Number: %1 | Count Strongpoints: %2 | AllNumbers: %3",_GarrisonNumber,_CountStrongpoints,_AllNumbers];
	};
	_HouseMax = round(_GarrisonNumber / 4);

	{
		if(_Debug_Variable) then {
			systemChat format ["%1 Garrison for %4 Max-Houses & 3 Patrols of %3 of total %2",_GarrisonNumber,(_GarrisonNumber) + (_PatrolNumber * 3),_PatrolNumber,_HouseMax];
		};
		_MarkerPos = _X;

		if({_X getVariable ["isSectorTrigger",false]} count (_X nearObjects ["EmptyDetector", 250]) < 1) then {
			[_MarkerPos,"sector",125,_Side,_Settings] spawn OKS_CreateObjectives;
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
						_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SafePos, [], 0, "NONE"];
						_Unit setRank "SERGEANT";
					} else {
						_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SafePos, [], 0, "NONE"];
						_Unit setRank "PRIVATE";
					};
					sleep 1;
				};
				[_Group, _DirectionPos, 100] call CBA_fnc_taskPatrol;
				_Group setBehaviour "SAFE";

			} foreach [1,2,3];

			_SelectedBuildings = [];
			_AllBuildings = nearestObjects [_X,["House"],125];
			_RemoveBuildings = nearestObjects [_X,["Land_i_Addon_03_V1_F","Land_i_Addon_03mid_V1_F","Land_i_Addon_04_V1_F"],125];

			_AllBuildings = _AllBuildings - _RemoveBuildings;

			_SortedBuildings = [_AllBuildings,[],{_MarkerPos distance _x},"ASCEND"] call BIS_fnc_sortBy;
			_SortedBuildings = _SortedBuildings select { 5 < count([_X] call BIS_fnc_buildingPositions) };

			sleep 1;

			if(count _SortedBuildings > 0) then {
				/*
					_HouseCount = [];
					_i = 0;
					For [{_i = 1}, {_i < _HouseMax}, {_i = _i + 1}] do {
						_HouseCount append [_i];
					};
				*/

				For "_i" to (_HouseMax - 1) do {_House = (selectRandom _SortedBuildings); if(!isNil "_House") then {_SelectedBuildings pushBackUnique _House; _SortedBuildings deleteAt (_SortedBuildings find _House)}};
				{
					[4,_X,_Side,_Units] spawn OKS_Garrison;
					_Marker = createMarker [format ["oks_SP_Marker_%1",str round(random 90000)],getPos _X];
					_Marker setMarkerShape "ICON";
					_Marker setMarkerType _SideMarker;
					_Marker setMarkerSize [0.6,0.6];
					//_Marker setMarkerText format["%1",_SelectedBuildings find _X];
					_Marker setMarkerColor _SideColor;

				} foreach _SelectedBuildings;

				if(_Debug_Variable) then {
					//systemChat str [_HouseMax,count _SortedBuildings,count _SelectedBuildings];
				};
			};
	} foreach _SelectedStrongpoints;
};