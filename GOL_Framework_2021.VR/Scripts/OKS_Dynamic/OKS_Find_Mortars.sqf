/*
	[Trigger,SizeNumber,_Side] execVM "Scripts\OKS_Dynamic\OKS_Find_Mortars.sqf";
	[Trigger_1,35,_Side] spawn OKS_Find_Mortars;
*/

if(!isServer) exitWith {};

Params ["_MainTrigger","_Side"];
private ["_RandomPos","_Road","_marker","_SideMarker","_typeString","_Units","_SideMarker","_SideColor","_SelectedPos","_Composition","_Repetitions","_Debug_Variable"];

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];

_Debug_Variable = false;

	Switch (_Side) do
	{
		case BLUFOR:	// BLUFOR settings
		{
			_SideMarker = "B_Mortar";
			_SideColor = "ColorBlufor";
		};
		case OPFOR:		// OPFOR settings
		{
			_SideMarker = "O_Mortar";
			_SideColor = "ColorOpfor";
		};
		case INDEPENDENT:	// INDEPENDENT Settings
		{
			_SideMarker = "N_Mortar";
			_SideColor = "ColorIndependent";
		};

		default
		{
			_SideMarker = "O_Mortar";
			_SideColor = "ColorOpfor";
		};
	};

	_Repetitions = 0;
	While {true} do {
		sleep 0.5;
		_Repetitions = _Repetitions + 1;
		_RandomPos = _MainTrigger call BIS_fnc_randomPosTrigger;
		_SelectedPos = [_RandomPos, 1, (TriggerArea _MainTrigger select 0), 20, 0, 0.2, 0] call BIS_fnc_findSafePos;

		if(_Debug_Variable) then {
			systemChat format ["Find Mortar: %1 %2 %3 %4 %5",!(_SelectedPos isEqualTo [0,0,0]),{_SelectedPos Distance _X < 1000} count OKS_Mortar_Positions < 1,_SelectedPos inArea _MainTrigger,{_SelectedPos distance _X < 200} count OKS_Objective_Positions < 1,{_SelectedPos distance _X < 200} count OKS_RoadBlock_Positions < 1];
		};
		if(!(_SelectedPos isFlatEmpty  [-1, -1, 0.05, 45, 0] isEqualTo []) && !(_SelectedPos isEqualTo [0,0,0]) && {_SelectedPos Distance _X < 1000} count OKS_Mortar_Positions < 1 && _SelectedPos inArea _MainTrigger  && {_SelectedPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SelectedPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {"Found"};
		if(_Repetitions > 30) exitWith {};
	};
	if(_Repetitions > 30 || _SelectedPos isEqualTo [0,0,0]) exitWith { if(_Debug_Variable) then {systemChat "Failed to Find Mortar Position"} };

	_Composition = selectRandom ["mortar_1","mortar_2","mortar_3"];

	[_Composition, [_SelectedPos select 0,_SelectedPos select 1,0], [0,0,0], (random 360)] call LARs_fnc_spawnComp;
	_Mortar = createVehicle ["I_G_Mortar_01_F", _SelectedPos, [], 0, "NONE"];
	[_Mortar, _Side, "precise", "light", ["auto", 40],250,1000,30] execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf";

	[_SelectedPos,5,50,_Side,_Units] spawn OKS_Patrol_Spawn;
	[_SelectedPos,_Side,(random 4),15] spawn OKS_Populate_Sandbag;

	_Objects = nearestObjects [_SelectedPos,[],45];
	//SystemChat str _Objects;

	_Objects = _Objects select { getPos _X select 2 > 0 && !(_X isKindOf "MAN") && !(_X isKindOf "StaticWeapon")};
	//copyToClipboard str _Objects;
	{_X setPos [getPos _X select 0,getpos _X select 1,0]} foreach _Objects;

		_Group = CreateGroup _Side;
		for "_i" from 1 to (2 + round(Random 1)) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_SelectedPos select 0,_SelectedPos select 1,0], [], 10, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_SelectedPos select 0,_SelectedPos select 1,0], [], 10, "NONE"];
				_Unit setRank "PRIVATE";
			};
		};
		sleep 0.5;
		[[_SelectedPos select 0,_SelectedPos select 1,0], nil, units _Group, 35, 0, true, true] remoteExec ["ace_ai_fnc_garrison",0];
		[_SelectedPos,_Side,3,15] spawn OKS_Populate_Sandbag;

	OKS_Mortar_Positions pushBackUnique _SelectedPos;
	publicVariable "OKS_Mortar_Positions";

	_marker = createMarker [format ["OKS_Mortar_Marker_%1",str (random 5000)],_SelectedPos];
	_marker setMarkerShape "ICON";
	_marker setMarkerSize [0.6,0.6];
	_marker setMarkerType _SideMarker;
	_marker setMarkerColor _SideColor;

	_Zone = createMarker [format ["OKS_MortarZone_Marker_%1",str (random 5000)],_SelectedPos];
	_Zone setMarkerShape "ELLIPSE";
	_Zone setMarkerSize [1000,1000];
	_Zone setMarkerBrush "Border";
	_Zone setMarkerType _SideMarker;
	_Zone setMarkerColor _SideColor;

	if(_Debug_Variable) then {
		SystemChat format ["%1 Mortar created at %3",_Side,getMarkerPos _marker];
	};