// [spawn_1,waypoint_1,end_1,west,[4,["rhs_btr60_msv"]],[true,6]]] spawn OKS_Convoy_Spawn;
// [spawnpos_1,waypoint_1,end_1,east,[4,["rhs_btr60_msv"]],[true,6]]] execVM "Scripts\OKS_Ambience\OKS_Convoy_Spawn.sqf";

if(!isServer) exitWith {};

Params ["_Spawn","_Waypoint","_End","_Side","_VehicleArray","_CargoArray"];
_CargoArray Params ["_ShouldHaveCargo","_Soldiers"];
_VehicleArray Params ["_Count","_Vehicles"];

Private ["_crewClass","_Units","_Leader","_Vehicles","_DismountCode","_Classname"];
Private _ConvoyArray = [];
private _Debug_Variable = true;
private _WaitUntilCombat = {

	private _DismountCode = {
		Params ["_Group","_Vehicle"];
		_Group leaveVehicle _Vehicle;
		{unassignVehicle _X; doGetOut _X;} foreach units _Group;
		[_Group,500,15,[],[],false] spawn lambs_wp_fnc_taskRush;
	};

	Params ["_Vehicle","_Crew","_CargoGroup","_Debug_Variable"];
    waitUntil {combatBehaviour _Crew isEqualTo "COMBAT"};
    if(_Debug_Variable) then {systemChat format [systemChat "Ambush Detected. Halting Convoy.."]};
    _Vehicle forceSpeed 0;
    _Vehicle setFuel 0;
    _Vehicle setVehicleLock "UNLOCKED";
    [_CargoGroup,_Vehicle] spawn _DismountCode;

    if(((!isNull gunner _Vehicle) || (_Vehicle emptyPositions "gunner"> 0)) || ((!isNull commander _Vehicle) || (_Vehicle emptyPositions "commander"> 0))) then {
    	if(_Debug_Variable) then {systemChat format ["Vehicle is armed, will apply hunt."]};
    	sleep (30 + (Random 30));
    	_vehicle forceSpeed -1;
    	_Vehicle setFuel 1;

		if(_Debug_Variable) then {systemChat format ["Hunt Applied to %1 in %2 - %3",_Crew,_Vehicle,[configFile >> "CfgVehicles" >> typeOf _Vehicle] call BIS_fnc_displayName]};
    	[_Crew, 500, 60, [], [], false] spawn lambs_wp_fnc_taskHunt;
    } else {
    	if(_Debug_Variable) then {systemChat format ["Vehicle is unarmed, dismount and rush."]};
    	[_Crew,_Vehicle] spawn _DismountCode;
    };
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


	waitUntil {sleep 1; systemChat "Waiting for clearance near _Spawn"; (getPos _Spawn nearEntities ["LandVehicle", 20]) isEqualTo []};
	if(_Debug_Variable) then {systemChat format ["Spawning Vehicle.."]};

	if(_Vehicles isNotEqualTo []) then {
		systemChat str _Vehicles;
		_Classname = _Vehicles select 0;
		_Vehicles deleteAt 0;
		systemChat str [_Classname,_Vehicles];
	};
	_Vehicle = CreateVehicle [_Classname,getPos _Spawn];
	_Vehicle setDir (getDir _Spawn);
	_Vehicle setVehicleLock "LOCKED";

    _Group = createGroup _Side;
    _Group setVariable ["hc_blacklist",true];
	_Group setVariable ["lambs_danger_disableAI", true];

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
    _Vehicle forceSpeed 6;
    _Group setBehaviour "SAFE";
    _WP = _Group addWaypoint [getPos _Waypoint,0];
    _WP setWaypointType "MOVE";

	_CargoGroup = createGroup [_Side,true];
	_CargoGroup setVariable ["hc_blacklist",true];

    Private _Position = _End getPos [25+(random 15),round(random 360)];
    _EndWP = _Group addWaypoint [_Position,1];
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
    _ConvoyArray pushBackUnique _Group;
    [_Vehicle,_Group,_CargoGroup,_Debug_Variable] spawn _WaitUntilCombat;
};

waitUntil{ {combatBehaviour _X isEqualTo "COMBAT"} count _ConvoyArray > 0};
{_X setCombatBehaviour "COMBAT"} foreach _ConvoyArray;