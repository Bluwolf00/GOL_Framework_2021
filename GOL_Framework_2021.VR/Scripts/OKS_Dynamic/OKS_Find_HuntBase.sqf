/*
	[Trigger,Side] execVM "Scripts\OKS_Dynamic\OKS_Find_HuntBase.sqf";
	[Trigger_1,EAST] spawn OKS_Find_HuntBase;
*/

if(!isServer) exitWith {};

Params ["_MainTrigger","_Side","_HuntArray"];
private ["_RandomPos","_Road","_marker","_SideMarker","_SelectedPos","_Composition","_Repetitions","_BaseType","_SideColor","_SideMarker"];

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian","_ObjectiveTypes","_Configurations"];
_Vehicles Params ["_Wheeled","_APC","_Tank","_Artillery","_Helicopter","_Transport","_Supply"];

_HuntSettings = [] Call OKS_Hunt_Setting;
_HuntSettings Params ["_Respawn","_Waves","_RefreshRate"];
_Configurations Params ["_CompoundSize","_EnableEnemyMarkers","_EnableZoneMarker","_EnableZoneTypeMarker"];

_Respawn Params ["_InfantryRespawnTime","_WheeledRespawnTime","_APCRespawnTime","_TankRespawnTime","_HelicopterRespawnTime"];
_Waves Params ["_InfantryWaves","_WheeledWaves","_APCWaves","_TankWaves","_HelicopterWaves"];
_HuntArray Params ["_InfantryCount","_WheeledCount","_APCCount","_TankCount","_HelicopterCount"];


	Switch (_Side) do
	{
		case BLUFOR:	// BLUFOR settings
		{
			_SideMarker = "B_";
			_SideColor = "ColorBlufor";
			_BaseType = "USMC_WarfareB";
		};
		case OPFOR:		// OPFOR settings
		{
			_SideMarker = "O_";
			_SideColor = "ColorOpfor";
			_BaseType = "RU_WarfareB";
		};
		case INDEPENDENT:	// INDEPENDENT Settings
		{
			_SideMarker = "N_";
			_SideColor = "ColorIndependent";
			_BaseType = "Ins_WarfareB";
		};

		default
		{
			_SideMarker = "O_";
			_SideColor = "ColorOpfor";
			_BaseType = "RU_WarfareB";
		};
	};

Private _FindAndSpawnHuntBase = {

	/*
		[_MainTrigger,_Side,_Vehicles,_BaseType,_Type,_Repsawn,_waves,_Refresh,_SideMarker,_SideColor,_Configurations] spawn _FindAndSpawnHuntBase;
	*/
	Params["_MainTrigger","_Side","_Vehicles","_BaseType","_Type","_Respawn","_Waves","_Refresh","_SideMarker","_SideColor","_Configurations"];
	_Configurations Params ["_CompoundSize","_EnableEnemyMarkers","_EnableZoneMarker","_EnableZoneTypeMarker"];
	Private ["_SelectedPos","_Repetitions","_RandomPos","_Base","_Spawn","_marker","_SizeMarker","_Location","_Position","_BaseDir","_BaseDistance"];
	private _Debug_Variable = false;

	_Repetitions = 0;
	Private _LocationsInArea = OKS_HuntLocations select {_X inArea _MainTrigger};
	if(count _LocationsInArea > 0) then {

		_Location = SelectRandom _LocationsInArea;
		OKS_HuntLocations deleteAt (OKS_HuntLocations find _Location);
		_SelectedPos = getPos _Location;
		_BaseDir = getDir _Location;
		if(_Debug_Variable) then { SystemChat format ["HuntBase Logic found."]};

	} else {

		if(_Debug_Variable) then { SystemChat format ["No Hunt Base Logic Found"]};
		While {true} do {
			sleep 0.5;
			_Repetitions = _Repetitions + 1;
			_RandomPos = _MainTrigger call BIS_fnc_randomPosTrigger;
			_SelectedPos = [_RandomPos, 1, (TriggerArea _MainTrigger select 0), 30, 0, 0, 0] call BIS_fnc_findSafePos;

			if(_Debug_Variable) then {
				systemChat format ["Find HuntBase: %1 %2 %3 %4 %5",!(_SelectedPos isFlatEmpty  [-1, -1, 0.25, 5, 0,false] isEqualTo []),{_SelectedPos Distance _X < 200} count OKS_Mortar_Positions < 1,_SelectedPos inArea _MainTrigger,{_SelectedPos distance _X < 200} count OKS_Objective_Positions < 1,{_SelectedPos distance _X < 200} count OKS_RoadBlock_Positions < 1,{_SelectedPos distance _X < 200} count OKS_Hunt_Positions < 1];
			};
			if(!(_SelectedPos isFlatEmpty  [-1, -1, 0.25, 5, 0,false] isEqualTo []) && !(_SelectedPos isEqualTo [0,0,0]) && {_SelectedPos Distance _X < 200} count OKS_Mortar_Positions < 1 && _SelectedPos inArea _MainTrigger  && {_SelectedPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SelectedPos distance _X < 200} count OKS_RoadBlock_Positions < 1 && {_SelectedPos distance _X < 200} count OKS_Hunt_Positions < 1) exitWith { if(_Debug_Variable) then {"Found"}};
			if(_Repetitions > 30) exitWith {};
		};
	};

	if(_Repetitions > 30 || _SelectedPos isEqualTo [0,0,0]) exitWith { if(_Debug_Variable) then {systemChat "Failed to Find Hunt Position"} };

	OKS_Hunt_Positions pushBackUnique _SelectedPos;

	Switch (_Type) do {
		case "INFANTRY":{
			_sideMarker = _sideMarker + "inf";
			_BaseType = _BaseType + "Barracks";
			_BaseDistance = 15;
		};
		case "WHEELED":{
			_sideMarker = _sideMarker + "motor_inf";
			_BaseType = _BaseType + "LightFactory";
			_BaseDistance = 20;
		};
		case "APC":{
			_sideMarker = _sideMarker + "mech_inf";
			_BaseType = _BaseType + "HeavyFactory";
			_BaseDistance = 20;
		};
		case "TANK":{
			_sideMarker = _sideMarker + "armor";
			_BaseType = _BaseType + "HeavyFactory";
			_BaseDistance = 20;
		};
		case "HELICOPTER":{
			_sideMarker = _sideMarker + "air";
			_BaseType = _BaseType + "AircraftFactory";
			_BaseDistance = 25;
		};
	};

	_Base = createVehicle [_BaseType, _SelectedPos, [], 0, "NONE"];
	OKS_Objective_Positions pushBackUnique _Base;
	if(isNil "_BaseDir") then {
		_BaseDir = random 360;
		_Base setDir _BaseDir;
	} else {
		_Base setDir _BaseDir;
	};
	_Spawn = createVehicle ["Land_ClutterCutter_small_F", _SelectedPos getPos [15,_BaseDir], [], 0, "NONE"];
	publicVariable "OKS_Hunt_Positions";
	if(_EnableEnemyMarkers) then {
		_marker = createMarker [format ["OKS_HuntBase_Marker_%1",str (random 5000)],_SelectedPos];
		_marker setMarkerShape "ICON";
		_marker setMarkerSize [0.6,0.6];
		_marker setMarkerType _SideMarker;
		_marker setMarkerColor _SideColor;

		switch (_Waves) do {
			case 1:{ _SizeMarker = "group_0"};
			case 2:{ _SizeMarker = "group_1"};
			case 3:{ _SizeMarker = "group_1"};
			case 4:{ _SizeMarker = "group_2"};
			case 5:{ _SizeMarker = "group_2"};
			case 6:{ _SizeMarker = "group_3"};
			case 7:{ _SizeMarker = "group_3"};
			case 8:{ _SizeMarker = "group_4"};
			case 9:{ _SizeMarker = "group_5"};
			default {_SizeMarker = "group_6"};
		};

		_marker = createMarker [format ["OKS_HuntBaseSize_Marker_%1",str (random 5000)],_SelectedPos];
		_marker setMarkerShape "ICON";
		_marker setMarkerSize [0.9,0.9];
		_marker setMarkerType _SizeMarker;
		_marker setMarkerColor _SideColor;
	};
	if(_Debug_Variable) then {
		SystemChat format ["%1 Hunt Base created at %3",_Side,getMarkerPos _marker];
		_marker = createMarker [format ["OKS_HuntBaseDebug_Marker_%1",str (random 5000)],getPos _Spawn];
		_marker setMarkerShape "ICON";
		_marker setMarkerSize [1,1];
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor _SideColor;
		_marker setMarkerText "Spawn Pos";
	};

	if(_Type != "HELICOPTER") then {
		if(_Type isEqualTo "INFANTRY") then {
			_Vehicles = selectRandom _Vehicles;
		};
		[_Base, _Spawn, _MainTrigger, _Waves, _Respawn,_Side,_Vehicles,_Refresh] spawn NEKY_Hunt_HuntBase;
	} else {
		[_Base,_Spawn, _MainTrigger,_Side,(selectRandom _Vehicles),"unload",[2,0.8]] spawn NEKY_Airbase;
	};

	// [Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,independent,"CUP_I_LR_MG_AAF",30] spawn NEKY_Hunt_HuntBase;
    // [Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn NEKY_Airbase;
};

//SystemChat str [_MainTrigger,_Side,[4,5,6],_BaseType,"INFANTRY",_InfantryRespawnTime,_InfantryWaves,_RefreshRate,_SideMarker,_SideColor];

For "_i" to (_InfantryCount - 1) do {
	[_MainTrigger,_Side,[4,5,6],_BaseType,"INFANTRY",_InfantryRespawnTime,_InfantryWaves,_RefreshRate,_SideMarker,_SideColor,_Configurations] spawn _FindAndSpawnHuntBase;
};

For "_i" to (_WheeledCount - 1) do {
	[_MainTrigger,_Side,_WHEELED,_BaseType,"WHEELED",_WheeledRespawnTime,_WheeledWaves,_RefreshRate,_SideMarker,_SideColor,_Configurations] spawn _FindAndSpawnHuntBase;
	sleep 5;
};

For "_i" to (_APCCount - 1) do {
	[_MainTrigger,_Side,_APC,_BaseType,"APC",_APCRespawnTime,_APCWaves,_RefreshRate,_SideMarker,_SideColor,_Configurations] spawn _FindAndSpawnHuntBase;
	sleep 5;
};

For "_i" to (_TankCount - 1) do {
	[_MainTrigger,_Side,_TANK,_BaseType,"TANK",_TankRespawnTime,_TankWaves,_RefreshRate,_SideMarker,_SideColor,_Configurations] spawn _FindAndSpawnHuntBase;
	sleep 5;
};

For "_i" to (_HelicopterCount - 1) do {
	[_MainTrigger,_Side,_HELICOPTER,_BaseType,"HELICOPTER",_HelicopterRespawnTime,_HelicopterWaves,_RefreshRate,_SideMarker,_SideColor,_Configurations] spawn _FindAndSpawnHuntBase;
	sleep 5;
};