// [reinforce_1,reinforce_2,reinforce_3,west,[4,["rhs_btr60_msv"], 6, 25],[true,6], false, "variable", "small", true, true] spawn OKS_Convoy_Reinforce;
// [spawnpos_1,waypoint_1,end_1,east,[4,["rhs_btr60_msv"], 6, 30],[true,6], false, "variable", "small", true, true] execVM "Scripts\OKS_Spawn\OKS_Convoy\OKS_Convoy_Reinforce.sqf";
/*
	Params:
	1 - Object - Spawn Position
	2 - Object - First Waypoint
	3 - Object - Final Waypoint (Where they spread out in the area)
	4 - Side
	5 - Vehicle Array
		1 - Integer - Count of Vehicles
		2 - Array of Classnames or String
		3 - Integer M/S Speed
		4 - Dispersion
	6 - Troop Array
		1 - Bool - Should spawn troop in cargo
		2 - Integer - Max Number of Soldiers per vehicle
	7 - Convoy Array (Array that gets filled with convoy units)
	8 - Should be forced to careless (No reaction from Convoy)
	9 - Variable set to true when complete
	10 - Resupply Size
	11 - Should Create Resupply Task
	12 - Should Resupply

*/

if(!isServer) exitWith {};

Params [
	["_Spawn",objNull,[objNull]],
	["_Waypoint",objNull,[objNull]],
	["_End",objNull,[objNull]],
	["_Side",east,[sideUnknown]],
	["_VehicleArray",[3,["UK3CB_ARD_O_BMP1"],6,25],[[]]],
	["_CargoArray",[true,4],[[]]],
	["_ForcedCareless",false,[false]],
	["_VariableSetToTrue","",[""]],
	["_ResupplySize","small",[""]],
	["_ShouldCreateTask",true,[false]],
	["_ShouldResupply",true,[true]]
];
_CargoArray Params ["_ShouldHaveCargo","_Soldiers"];
_VehicleArray Params ["_Count","_Vehicles","_SpeedMeterPerSecond","_DispersionInMeters"];
_ConvoyArray = [];

Private ["_crewClass","_Units","_Leader","_Vehicles","_DismountCode","_Classname","_StartMarker","_EndMarker"];
private _Debug_Variable = false;

if(isNil "_ConvoyArray") then {
	_ConvoyArray = [];
};
private _WaitUntilCombat = {

	private _DismountCode = {
		Params ["_Group","_Vehicle"];
		_Group leaveVehicle _Vehicle;
		{unassignVehicle _X; doGetOut _X;} foreach units _Group;
		[_Group, getPos _Vehicle, 100] call lambs_wp_fnc_taskPatrol;
	};

	Params ["_Vehicle","_Crew","_CargoGroup","_Debug_Variable"];
	waitUntil {sleep 0.5; {behaviour _X isEqualTo "COMBAT"} count units _Crew > 0};
	_CargoGroup setBehaviour "SAFE";
	_Crew setBehaviour "SAFE";
	_CargoGroup setCombatMode "RED"; 
	_Crew setCombatMode "RED"; 

    _Vehicle forceSpeed 0;
    _Vehicle setFuel 0;
    _Vehicle setVehicleLock "UNLOCKED";
	_Vehicle setVariable ["GW_Disable_autoRemoveCargo",true,true];
    [_CargoGroup,_Vehicle] spawn _DismountCode;
};

For "_i" from 1 to _Count do {

	Switch (_Side) do
	{
		case blufor:	// BLUFOR settings
		{
			_crewClass = "B_crew_F";
			_Leader = "B_soldier_TL_F";
			_Units = [
				"B_Soldier_A_F",
				"B_Soldier_AR_F",
				"B_Soldier_AR_F",
				"B_medic_F",
				"B_medic_F",
				"B_Soldier_GL_F",
				"B_HeavyGunner_F",
				"B_soldier_M_F",
				"B_Soldier_F",
				"B_Soldier_F",
				"B_Soldier_F",
				"B_Soldier_LAT_F"
			];
		};
		case opfor:	// BLUFOR settings
		{
			_crewClass = "O_crew_F";
			_Leader = "O_soldier_TL_F";
			_Units = [
				"O_Soldier_A_F",
				"O_Soldier_AR_F",
				"O_Soldier_AR_F",
				"O_medic_F",
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
		case independent:	// BLUFOR settings
		{
			_crewClass = "I_crew_F";
			_Leader = "I_soldier_TL_F";
			_Units = [
				"I_Soldier_A_F",
				"I_Soldier_AR_F",
				"I_Soldier_AR_F",
				"I_medic_F",
				"I_medic_F",
				"I_Soldier_GL_F",
				"I_HeavyGunner_F",
				"I_soldier_M_F",
				"I_Soldier_F",
				"I_Soldier_F",
				"I_Soldier_F",
				"I_Soldier_LAT_F"
			];
		};
		// DO NOT EDIT ANYTHING BELOW \\
		default
		{
			_Units = "";
		};
	};

	_startMarker = createMarker [format["convoyReinforceStart_%1",random 9999], _Spawn];
	_endMarker = createMarker [format["convoyReinforceEnd_%1",random 9999], _End];
	_startMarker setMarkerType "Contact_pencilTask3";
	_startMarker setMarkerColor "colorBlufor";
	_endMarker setMarkerType "loc_defend";
	_endMarker setMarkerColor "colorBlufor";
	_startMarker setMarkerSIze [0.7,0.7];
	_endMarker setMarkerSIze [0.7,0.7];

	waitUntil {sleep 1; if(_Debug_Variable) then {systemChat "Waiting for clearance near _Spawn"}; (getPos _Spawn nearEntities ["LandVehicle", _DispersionInMeters]) isEqualTo []};
	if(_Debug_Variable) then {systemChat format ["Spawning Vehicle.."]};

	if(_Vehicles isNotEqualTo []) then {
		_Classname = _Vehicles select 0;
		_Vehicles deleteAt 0;
		if(_Debug_Variable) then{
			systemChat str [_Classname,_Vehicles];
		}		
	};
	_Vehicle = CreateVehicle [_Classname,getPos _Spawn];
	if(GOL_Remove_HE_From_StaticAndVehicle) then {
		[_Vehicle] spawn OKS_RemoveVehicleHE;	
	};		
	_Vehicle setDir (getDir _Spawn);
	_Vehicle setVehicleLock "LOCKED";

    _Group = createGroup _Side;
    _Group setVariable ["acex_headless_blacklist",true,true];
	_Group setVariable ["lambs_danger_disableAI", true,true];

    if(_Debug_Variable) then {systemChat format ["Group: %3 Side: %2 - %1 Class Selected",_crewClass,_Side,_Group]};
    if(_Vehicle emptyPositions "commander" > 0) then {
        if(_Debug_Variable) then { systemChat "Creating Commander"};
        _Commander = _Group CreateUnit [_crewClass, [0,0,0], [], 5, "NONE"];
        _Commander setRank "SERGEANT";
        _Commander moveinCommander _Vehicle;
    };
    if(_Vehicle emptyPositions "gunner" > 0) then {
        if(_Debug_Variable) then { systemChat "Creating Gunner"};
        _Gunner = _Group CreateUnit [_crewClass, [0,0,0], [], 5, "NONE"];
        _Gunner setRank "CORPORAL";
        _Gunner moveinGunner _Vehicle;
    };
    if(_Vehicle emptyPositions "driver" > 0) then {
        if(_Debug_Variable) then { systemChat "Creating Driver"};
        _Driver = _Group CreateUnit [_crewClass, [0,0,0], [], 5, "NONE"];
        _Driver setRank "PRIVATE";
        _Driver moveinDriver _Vehicle;
    };
    _Vehicle forceSpeed _SpeedMeterPerSecond;

    _Group setBehaviour "CARELESS";
	_Group setCombatMode "BLUE";
    _WP = _Group addWaypoint [getPos _Waypoint,0];
    _WP setWaypointType "MOVE";

	_CargoGroup = createGroup [_Side,true];
	_CargoGroup setVariable ["acex_headless_blacklist",true,true];

    Private ["_EndWP"];
    _EndWP = _Group addWaypoint [_End,1];
    _EndWP setWaypointType "MOVE";

    if(_ShouldHaveCargo && ([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - ([TypeOf _Vehicle,false] call BIS_fnc_crewCount) >= 4) then {
		_CargoSeats = ([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - ([TypeOf _Vehicle,false] call BIS_fnc_crewCount);
		if(_CargoSeats > _Soldiers) then { _CargoSeats = _Soldiers };
			/// Create Leader
			_Unit = _CargoGroup CreateUnit [_Leader, [0,0,0], [], 0, "NONE"];
			_Unit setRank "SERGEANT";
			_Unit MoveInCargo _Vehicle;
			_CargoGroup selectLeader _Unit;
		for "_i" from 1 to (_CargoSeats - 1) do
		{
			Private "_Unit";
			_Unit = _CargoGroup CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
			_Unit setRank "PRIVATE";
			_Unit MoveInCargo _Vehicle;
		};
    };
	_CargoGroup setBehaviour "CARELESS";
	_CargoGroup setCombatMode "BLUE";
    _ConvoyArray pushBackUnique _Group;
	_ConvoyArray pushBackUnique _CargoGroup;
	if(_ForcedCareless) then {
		_Vehicle setCaptive true;
		{_X setCaptive true; _X setBehaviour "CARELESS"; _X setCombatMode "BLUE"; } foreach units _Group;
		{_X setCaptive true; _X setBehaviour "CARELESS"; _X setCombatMode "BLUE"; } foreach units _CargoGroup;
		_Vehicle setBehaviour "CARELESS"; _Vehicle setCombatMode "BLUE";
	};	
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _CargoGroup;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;

	if (!(_ForcedCareless)) then {
		[_Vehicle,_Group,_CargoGroup,_Debug_Variable] spawn _WaitUntilCombat;
	};   
};

waitUntil{
	sleep 2;
	{
		(leader _X) distance _End < 25;
	} count _ConvoyArray > 0
};
if(_Debug_Variable) then {SystemChat "Reached Site, Deploying.."};
{_X setBehaviour "COMBAT"; _X setCombatMode "RED"; } foreach _ConvoyArray;
sleep 10;
Call Compile Format ["%1 = True; PublicVariable '%1'",_VariableSetToTrue];

private _SpawnResupplyCrateWithTask = {

	params ["_LeadVehicle","_Size","_ShouldCreateTask","_VariableSetToTrue","_StartMarker","_EndMarker"];
	private _BoxClass = "";
	private _BoxCode = {};
	Switch (OKS_FRIENDLY_SIDE) do
	{
		Case WEST: {
			_BoxCode = {[_This, ["small_box","west"]] call GW_Gear_Fnc_Init;};
			_BoxClass = "B_supplyCrate_F";		
		};
		Case EAST: {
			_BoxCode = {[_This, ["small_box","east"]] call GW_Gear_Fnc_Init};
			_BoxClass = "O_supplyCrate_F";		
		};
		Case INDEPENDENT: {
			_BoxCode = {[_This, ["small_box","indep"]] call GW_Gear_Fnc_Init};
			_BoxClass = "I_supplyCrate_F";		
		};
		default {
			_BoxCode = {[_This, ["small_box","west"]] call GW_Gear_Fnc_Init;};
			_BoxClass = "B_supplyCrate_F";		
		};
	};

	_CratePos = [getPos _LeadVehicle, 2, 5, 1, 0, 0, 0] call BIS_fnc_findSafePos;
	_Crate = CreateVehicle [_BoxClass, _CratePos, [], 0, "CAN_COLLIDE"];
	_Crate call _BoxCode;

	if(_ShouldCreateTask) then {
		sleep 5;
		[true, _VariableSetToTrue, ["A friendly force has brought in resupply for your squad. Make use of the supplies.", "1-1 Resupply", "1-1 Resupply"], _Crate, "ASSIGNED", 2, true, "rearm"] call BIS_fnc_taskCreate;
		
		waitUntil {sleep 5; {_X distance _Crate < 5} count allPlayers > 0 };
		[_VariableSetToTrue,"SUCCEEDED"] call BIS_fnc_taskSetState;
	};
};

if(_ShouldResupply) then {
	[leader (_ConvoyArray select 0),_ResupplySize,_ShouldCreateTask,_VariableSetToTrue,_StartMarker,_EndMarker] spawn _SpawnResupplyCrateWithTask;
};

if(!isNil "_startMarker") then {
	deleteMarker _startMarker;
};
if(!isNil "_endMarker") then {
	deleteMarker _endMarker;
};	


