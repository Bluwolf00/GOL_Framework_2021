// [spawn_1,waypoint_1,end_1,west,[4,["rhs_btr60_msv"], 6, 25],[true,6]]] spawn OKS_Convoy_Spawn;
// [spawnpos_1,waypoint_1,end_1,east,[4,["rhs_btr60_msv"], 6, 30],[true,6]]] execVM "Scripts\OKS_Ambience\OKS_Convoy_Spawn.sqf";

if(!isServer) exitWith {};

Params ["_Spawn","_Waypoint","_End","_Side","_VehicleArray","_CargoArray"];
_CargoArray Params ["_ShouldHaveCargo","_Soldiers"];
_VehicleArray Params ["_Count","_Vehicles","_SpeedMeterPerSecond","_DispersionInMeters"];

Private ["_crewClass","_Units","_Leader","_Vehicles","_DismountCode","_Classname"];
Private _ConvoyArray = [];
private _Debug_Variable = false;
private _WaitUntilCombat = {

	private _DismountCode = {
		Params ["_Group","_Vehicle"];
		_Group leaveVehicle _Vehicle;
		{unassignVehicle _X; doGetOut _X;} foreach units _Group;
		[_Group,1500,30,[],[],false] spawn lambs_wp_fnc_taskRush;
	};

	Params ["_Vehicle","_Crew","_CargoGroup","_Debug_Variable"];
    waitUntil {sleep 0.5; {behaviour _X isEqualTo "COMBAT"} count units _Crew > 0};
	_CargoGroup setBehaviour "COMBAT";
	_Crew setBehaviour "COMBAT";
	_CargoGroup setCombatMode "RED"; 
	_Crew setCombatMode "RED"; 
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
    	[_Crew, 1500, 60, [], [], false] spawn lambs_wp_fnc_taskHunt;
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
	_Vehicle setDir (getDir _Spawn);
	_Vehicle setVehicleLock "LOCKED";

    _Group = createGroup _Side;
    _Group setVariable ["acex_headless_blacklist",true];
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
    _Vehicle forceSpeed _SpeedMeterPerSecond;
    _Group setBehaviour "CARELESS";
	_Group setCombatMode "BLUE";
    _WP = _Group addWaypoint [getPos _Waypoint,0];
    _WP setWaypointType "MOVE";

	_CargoGroup = createGroup [_Side,true];
	_CargoGroup setVariable ["acex_headless_blacklist",true];
	

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
	_CargoGroup setBehaviour "CARELESS";
	_CargoGroup setCombatMode "BLUE";
    _ConvoyArray pushBackUnique _Group;
	_ConvoyArray pushBackUnique _CargoGroup;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _CargoGroup;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
    [_Vehicle,_Group,_CargoGroup,_Debug_Variable] spawn _WaitUntilCombat;
};

waitUntil{
	sleep 2;
	{
		{isTouchingGround (vehicle _X) && isPlayer _X} count ((leader _X) targets [true, 0, [], 20]) > 0;
	} count _ConvoyArray > 0
	||
	{
		{(vehicle _X) isKindOf "AIR" && isPlayer _X} count ((leader _X) targets [true, 1000, [], 20]) > 0;
	} count _ConvoyArray > 0
	||
	{
		{!Alive _X} count units _X > 0
	} count _ConvoyArray > 0;
};
if(_Debug_Variable) then {SystemChat "Detected Enemy. Enabling Combat."};
{_X setBehaviour "COMBAT"; _X setCombatMode "RED"; } foreach _ConvoyArray;