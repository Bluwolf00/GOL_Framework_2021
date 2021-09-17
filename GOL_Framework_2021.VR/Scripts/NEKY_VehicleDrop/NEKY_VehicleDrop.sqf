//	[Heli Crew Side, "heli type classname" (default mid size heli of said side), ["spawn","DropOff","despawn"], (Vulnerable, true or false), "Vehicle Class Name", [attach,to,adjustment], Vehicle Crew/cargo Side, % of cargo, [Waypoints], {}] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleDrop.sqf";
//	
/////////////////
//	Parameters:
/////////////////
//	
//	1. Side of heli crew (West,BLUFOR,East,OPFOR,Independent works fine)
//	2. Class name of the type of heli you want to spawn. If you leave it empty ("") then it'll spawn a preset heli (Blackhawk, Taru, Merlin)
//	3. ["spawn","DropOff","despawn"] markers for where it spawns, where the Vehicle is dropped off, last waypoint which will despawn heli + crew.
//	4. Vulnerable. True = Heli + crew can take damage. False = Heli + crew cannot take damage.
//	5. "VehicleClassName". Class name of the Vehicle you want delivered.
//	6. [X,Y,Z]. If you want to adjust the position where the vehicle will be attached to the helicopter. For automated positioning enter: nil
//	7. Side of vehicle crew. The side you want your crew/cargo of vehicle to be of (West,BLUFOR,East,OPFOR,Independent works fine). (don't add this or the later 3 parameters if you want an empty vehicle)
//	8. % of cargo to fill. Enter how many % of the cargo seats you want to fill with units (0 = 0%, 1 = 100%).
//	9. [Waypoints]. The waypoints for your vehicle.
//	10. {CODE}, unique code to perform on delivered object. Refer to the object itself using: (_This select 0)
//	
//	null = [BLUFOR, "B_Heli_Light_01_armed_F", ["spawn","Target","Despawn"], true, "I_APC_tracked_03_cannon_F", nil, INDEPENDENT, 0, ["WP1","WP2"]] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleDrop.sqf";
//	
///////////
//	Usage:
///////////
//
//	Create a trigger and enter a condition. Then enter this in to the activation line and fill out the parameters to your choosing:
//	null = [BLUFOR,"",["spawn","DropOff","despawn"],true,"B_MRAP_01_hmg_F",nil,BLUFOR,1,["Marker1","Marker2","Marker3"]] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleDrop.sqf";
//	
//	To set it up by using Radio calls (clicking 0 and 0 again while in-game) see NEKY_Init.sqf for more info.
//	
///////////////
//	Examples:
///////////////
//
//	Made By NeKo-ArroW
//

if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

Private ["_SignalClass","_x","_AutoAdjust","_AutoAdjustment","_Adjustment","_Code","_PilotClasses"];

Params 
[
	["_Side", WEST, [SideUnknown]],
	["_HeliClass", "", [""]],
	["_STDs", [""], [[[""],[]]]],
	["_Vulnerable", True, [True]],
	["_VehicleClass", "B_supplyCrate_F", [""]],
	["_Adjustment", [0], [[]]],
	["_VehicleSide", SideUnknown, [SideUnknown]],
	["_FillCargo", 0, [0]],
	["_Waypoints", [], [[]]],
	["_Code", {}, [{}]]
];

#include "NEKY_UnitSettings.sqf"

// AI Skill Setting
NEKY_VehicleDropAISkill =
{	
	Private ["_Temp","_Type","_Skill","_Index","_This","_SkillVariables","_HeliClass","_PilotClasses","_CrewClasses","_UnitTypes","_PilotSkill","_CrewSkill","_UnitSkill"];
	
	_Temp = _This select 0;
	_Type = _This select 1;
	_Side = _This select 2;
	#include "NEKY_UnitSettings.sqf"
	
	call Compile Format ["_Skill = _%1Skill",_Type];	
	_Index = 0;
	for "_i" from 1 to (count _SkillVariables) do
	{
		_Temp setSkill [(_SkillVariables select _Index), (_Skill select _Index)];
		_Index = _Index +1;
	};
};

//	Turning markers in to XYZ
_STD = []; {if (typeName _x == "STRING") then {_Temp = GetMarkerPos _x; _STD PushBack _Temp} else {_STD PushBack _x}; } forEach _STDs;
_Index = 0;
for "_i" from 0 to ((count _Waypoints) -1) do
{
	if (typeName (_Waypoints select _Index) == "STRING") then {_Temp = getMarkerPos (_Waypoints select _Index); _Waypoints set [_Index, _Temp]; _Index = _Index +1;};
};

// Define classes based on side
switch (_Side) do
{
	Private ["_HeliClass"];
	
	case BLUFOR: {if (_HeliClass == "") then {_HeliClass = "B_Heli_Transport_03_F"} };
	case OPFOR: {if (_HeliClass == "") then {_HeliClass = "O_Heli_Transport_04_F"}	};	
	case INDEPENDENT: {if (_HeliClass == "") then {_HeliClass = "I_Heli_Transport_02_F"} };
};

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"} else {_SignalClass = "Chemlight_green"};

// Spawning Heli & Crew
_Heli = CreateVehicle [_HeliClass, (_STD select 0), [], 0, "FLY"];
_Heli setVariable ["hc_blacklist", true];
_Heli setDir ([(_STD select 0), (_STD select 1)] call BIS_fnc_DirTo);
_Heli AllowDamage _Vulnerable;

// Create object and attach to heli
_Vehicle = CreateVehicle [_VehicleClass, [0,0,1000], [], 0, "NONE"];
_Vehicle setVariable ["hc_blacklist", true];
_Vehicle DisableCollisionWith _Heli;
ClearItemCargoGlobal _Vehicle;
ClearWeaponCargoGlobal _Vehicle;
ClearMagazineCargoGlobal _Vehicle;
ClearBackpackCargoGlobal _Vehicle;

_BoundingBoxHeli = BoundingBoxReal _Heli;
_BoundingBoxVeh = BoundingBoxReal _Vehicle;
_AutoAdjustment = (((_BoundingBoxHeli select 0) select 2) + (0-((_BoundingBoxVeh select 1) select 2)));
if (Count _Adjustment != 3) then {_Adjustment = [0,0,_AutoAdjustment]};
_AutoAdjust = _AutoAdjustment + (-(_AutoAdjustment*1.25));
_Vehicle attachTo [_Heli,_Adjustment];
_Vehicle allowDamage _Vulnerable;

//	Create groups, units and waypoints
if (_VehicleSide != SideUnknown) then {[_VehicleSide,_FillCargo,_Waypoints,_Vehicle] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleUnits.sqf"};

_Crew = CreateGroup _Side;
_Pilot = _Crew CreateUnit [(_PilotClasses call BIS_FNC_SelectRandom), [0,0,0], [], 0, "NONE"];
_Crew setVariable ["hc_blacklist", true];
_Pilot moveInDriver _Heli;
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
_Pilot disableAI "AUTOTARGET";
_Pilot disableAI "AUTOCOMBAT";
_Pilot disableAI "TARGET";
_Pilot disableAI "COVER";
_Pilot disableAI "SUPPRESSION";
_Pilot disableAI "FSM";
_Pilot AllowDamage _Vulnerable;
sleep 0.5;

// Create waypoint and assignment
_Crew addWaypoint [(_STD select 1),0,1];
[_Crew,1] SetWaypointSpeed "NORMAL";
[_Crew,1] SetWaypointType "MOVE";
[_Crew,1] setWaypointCompletionRadius 0;
[_Crew,1] SetWaypointCombatMode "GREEN";
_Crew SetCurrentWaypoint [_Crew,1];

// Pick up zone
_Heli forceSpeed 100;
WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance (_STD Select 1)) < 700))};

_Crew lockWP True;
_Crew setSpeedMode "LIMITED";
_FailSafe = Time + 20;
WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance (_STD Select 1)) < 300) or (_Failsafe < Time))};

if ((Alive _Heli) && (Alive (driver _Heli))) then 
{
	_Heli FlyInHeight (20 + _AutoAdjust);
	createVehicle [_SignalClass, (_STD Select 1), [], 5, "CAN_COLLIDE"];
	_FailSafe = Time + 20;
	_DirCorrection = [_Heli, (_STD Select 1)] call BIS_fnc_dirTo;
	_Correction = [(_STD Select 1), 150, _DirCorrection] call BIS_fnc_relPos;
	[_Crew,1] SetWPPos _Correction;	
	WaitUntil {sleep 0.25; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or (_Heli distance (_STD Select 1) < 100) or (_Failsafe < Time))};
	
	_DirCorrection = [_Heli, (_STD Select 1)] call BIS_fnc_dirTo;
	_Correction = [(_STD Select 1), 150, _DirCorrection] call BIS_fnc_relPos;
	[_Crew,1] SetWPPos _Correction;	
	_Heli FlyInHeight (6 + _AutoAdjust);
	WaitUntil {sleep 0.25; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((((GetPosATL _Heli) Select 2) < (12 + _AutoAdjust))) && (_Heli distance (_STD Select 1) < 75))};
	
	sleep 0.25;
//	[_Heli] spawn {Sleep 2; (_This select 0) engineOn True};
	Detach _Vehicle;
	_Vehicle setVelocity [((Velocity _Vehicle) select 0), ((Velocity _Vehicle) select 1), -5];
	[_Vehicle] spawn _Code;
	_Heli engineOn True;
	_Vehicle allowDamage true;
	
	if ((!Alive _Heli) or (!Alive (driver _Heli)) or (!CanMove _Heli)) exitWith {};
	_Heli DoMove (getpos _Heli);
	_Crew lockWP false;
	_Crew setSpeedMode "NORMAL";
	_Heli forceSpeed -1;
	_Heli FlyInHeight 40;
	sleep 0.5;
};

if ((!Alive _Heli) or (!Alive (driver _Heli)) or (!CanMove _Heli)) exitWith {Detach _Vehicle};

_Crew addWaypoint [(_STD select 2),0,2];
[_Crew,2] SetWaypointSpeed "NORMAL";
[_Crew,2] SetWaypointType "MOVE";
[_Crew,2] setWaypointCompletionRadius 0;
[_Crew,2] SetWaypointBehaviour "CARELESS";
[_Crew,2] SetWaypointCombatMode "GREEN";
_Crew SetCurrentWaypoint [_Crew,2];

// Despawning
[_Crew,_Heli,_STD] spawn
{
	sleep 30;
	_Crew = (_This select 0);
	_Heli = (_this select 1);
	_STD = (_This select 2);
	
	WaitUntil {sleep 1; (!(Alive _Heli) or ({Alive _x} count (units _Crew) == 0) or (_Heli distance (_STD select 2) <= 100))};
	if (!(Alive _Heli) or ({Alive _x} count (units _Crew) == 0)) then {Sleep 900} else {sleep 5};
	{DeleteVehicle _x} forEach units _Crew;
	DeleteVehicle _Heli;
};