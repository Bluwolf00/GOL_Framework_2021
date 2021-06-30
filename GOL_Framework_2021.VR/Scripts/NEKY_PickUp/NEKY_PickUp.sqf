//	[side, "heli type classname" (default mid size heli of said side), ["spawn","PickUp","DropOff","despawn"], (Vulnerable, true or false)] execVM "Scripts\NEKY_PickUp\NEKY_PickUp.sqf";
//	
/////////////////
//	Parameters:
/////////////////
//	
//	1. Side of heli crew (West,BLUFOR,East,OPFOR,Independent works fine)
//	2. Class name of the type of heli you want to spawn. If you leave it empty ("") then it'll spawn a preset heli (Blackhawk, Taru, Hellcat)
//	3. ["spawn","PickUp","DropOff","despawn"] markers for where it spawns, Area which players are picked up, where they are dropped off, last waypoint which will despawn heli + crew.
//	4. Vulnerable. True = Heli + crew can take damage. False = Heli + crew cannot take damage.
//	NOTE: If you want radio commands created on their own look in to NEKY_Init.sqf	
//	
///////////
//	Usage:
///////////
//
//	Create a trigger and enter a condition. Then enter this in to the activation line and fill out the parameters to your choosing:
//	null = [blufor,"",["spawn","PickUp","DropOff","despawn"],true] execVM "Scripts\NEKY_PickUp\NEKY_PickUp.sqf";
//	
///////////////
//	Examples:
///////////////
//
//	Made By NeKo-ArroW
//

if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

Private ["_SignalClass"];

Params 
[
	["_Side", WEST, [SideUnknown]],
	["_HeliClass", "", [""]],
	["_STTDs", [""], [[""]]],
	["_Vulnerable", True, [True]]
];

//	Turning markers in to XYZ
_STTD = []; {if (typeName _x == "STRING") then {_Temp = GetMarkerPos _x; _STTD PushBack _Temp} else {_STTD PushBack _x}; } forEach _STTDs;

// Define classes based on side
switch (_Side) do
{
	Private ["_HeliClass"];
	
	case BLUFOR: {if (_HeliClass == "") then {_HeliClass = "B_Heli_Transport_01_F"} };
	case OPFOR: {if (_HeliClass == "") then {_HeliClass = "O_Heli_Transport_04_F"}	};	
	case INDEPENDENT: {if (_HeliClass == "") then {_HeliClass = "I_Heli_light_03_unarmed_F"} };
};

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"} else {_SignalClass = "Chemlight_green"};

// Spawning Heli & Crew
_Heli = CreateVehicle [_HeliClass, (_STTD select 0), [], 0, "FLY"];
_Heli setDir ([(_STTD select 0), (_STTD select 1)] call BIS_fnc_DirTo);
_Heli AllowDamage _Vulnerable;

CreateVehicleCrew _Heli;
{
	_x setSkill 0.4;
	_x SetBehaviour "SAFE";
	_x SetCombatMode "GREEN";
	_x allowDamage _Vulnerable;
	removeBackPack _x;
} forEach crew _Heli;

_Crew = group (driver _Heli);
_Pilot = (Driver _Heli);
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
sleep 0.5;

// Create waypoint and assignment
_Crew addWaypoint [(_STTD select 1),0,1];
[_Crew,1] SetWaypointSpeed "NORMAL";
[_Crew,1] SetWaypointType "MOVE";
[_Crew,1] setWaypointCompletionRadius 0;
[_Crew,1] SetWaypointCombatMode "GREEN";
_Crew SetCurrentWaypoint [_Crew,1];

// Pick up zone
_HeliPad = createVehicle ["Land_HelipadEmpty_F", (_STTD select 1), [], 0, "NONE"];
_Heli forceSpeed 100;
WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance _HeliPad) < 600))};

_Crew lockWP True;
_Crew setSpeedMode "LIMITED";	
WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance _HeliPad) < 200))};

if ((Alive _Heli) && (Alive (driver _Heli))) then 
{
	_Heli land 'land';
	doStop _Heli;
	createVehicle [_SignalClass, (getPos _HeliPad), [], 5, "CAN_COLLIDE"];
	WaitUntil {sleep 2; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or (((GetPosATL _Heli) Select 2) < 5))};
	
	sleep 2;
	[_Heli] spawn {WaitUntil {Speed (_This select 0) < 1}; sleep 2; (_This select 0) EngineOn True};
	
	[[_Heli],
	{
		(_This select 0) addAction ["<t color='#00FF00'>Pilot, Take off!</t>",
		{
			_Heli = (_This select 0);
			_ID = (_This select 2);
			[[_ID,_Heli],{(_This select 1) DoMove (getpos (_This select 1)); (_This select 1) RemoveAction (_This select 0); (_This select 1) lockWP False}] remoteExec ["BIS_FNC_SPAWN",0];
		},[],0,false,true,"","_Target distance _This < 8"];
	}] RemoteExec ["BIS_FNC_SPAWN",0];
	
	WaitUntil {sleep 1; (_Heli emptyPositions "CARGO" == 0) or (!Alive _Heli or !Alive (driver _Heli) or !CanMove _Heli) or ({(isPlayer _x) && (isNull objectParent _x) && (Alive _x)} Count (NearestObjects [_Heli, ["CAMANBase"], 300]) == 0) or (((GetPosATL _Heli) Select 2) > 15)};
	
	[[_Heli],{RemoveAllActions (_This select 0)}] remoteExec ["BIS_FNC_SPAWN",0];
	if ((!Alive _Heli) or (!Alive (driver _Heli)) or (!CanMove _Heli)) exitWith {DeleteVehicle _Helipad; False};
	_Heli DoMove (getpos _Heli);
	_Crew lockWP false;
	_Crew setSpeedMode "NORMAL";
	_Heli forceSpeed -1;
	deleteVehicle _Helipad;
} else {
	deleteVehicle _Helipad;
	false;
};

Sleep 1;
WaitUntil {((_Heli distance (_STTD select 1) > 50) or (((getPosATL _Heli) select 2) > 15)) or ((!Alive _Heli) or (!Alive (driver _Heli)) or (!CanMove _Heli))};

if ((!Alive _Heli) or (!Alive (driver _Heli)) or (!CanMove _Heli)) exitWith {False};

// Dropoff zone
// Create waypoint and assignment
_Crew addWaypoint [(_STTD select 2),0,2];
[_Crew,2] SetWaypointSpeed "NORMAL";
[_Crew,2] SetWaypointType "MOVE";
[_Crew,2] setWaypointCompletionRadius 0;
[_Crew,2] SetWaypointCombatMode "GREEN";
_Crew SetCurrentWaypoint [_Crew,2];

_HeliPad = createVehicle ["Land_HelipadEmpty_F", (_STTD select 2), [], 0, "NONE"];
_Heli forceSpeed 100;
WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance _HeliPad) < 600))};

_Crew lockWP True;
_Crew setSpeedMode "LIMITED";
WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or ((_Heli distance _HeliPad) < 200))};

if ((Alive _Heli) && (Alive (driver _Heli))) then 
{
	_Heli land 'land';
	doStop _Heli;
	WaitUntil {sleep 2; ( (!(Alive _Heli) or !(CanMove _Heli)) or (({Alive _x} count units _Crew) < 1) or (((GetPosATL _Heli) Select 2) < 5))};
	
	sleep 2;
	
	[_Heli] spawn {WaitUntil {Speed (_This select 0) < 1}; sleep 0.5; (_This select 0) EngineOn True};
	{ 
		UnassignVehicle _x;
		[_x] orderGetIn False;
		doGetOut _x;
		_x action ["getOut", _Heli] ;
	} forEach ((crew _Heli) - (Units _Crew));
	Sleep 3;
	
	if ((!Alive _Heli) or (!Alive (driver _Heli)) or (!CanMove _Heli)) exitWith {DeleteVehicle _Helipad; False};
	_Heli DoMove (getpos _Heli);
	_Crew lockWP false;
	_Crew setSpeedMode "NORMAL";
	_Heli forceSpeed -1;
	deleteVehicle _Helipad;
} else {
	deleteVehicle _Helipad;
	False;
};

Sleep 1;
_Crew addWaypoint [(_STTD select 3),0,3];
[_Crew,3] SetWaypointSpeed "NORMAL";
[_Crew,3] SetWaypointType "MOVE";
[_Crew,3] setWaypointCompletionRadius 0;
[_Crew,3] SetWaypointCombatMode "GREEN";
_Crew SetCurrentWaypoint [_Crew,3];

// Despawning
[_Crew,_Heli,_STTD] spawn
{
	sleep 30;
	_Crew = (_This select 0);
	_Heli = (_this select 1);
	_STTD = (_This select 2);
	
	WaitUntil {sleep 1; (!(Alive _Heli) or ({Alive _x} count (units _Crew) == 0) or (_Heli distance2d (_STTD select 3) <= 150))};
	if (!(Alive _Heli) or ({Alive _x} count (units _Crew) == 0)) then {Sleep 900} else {sleep 5};
	{DeleteVehicle _x} forEach units _Crew;
	DeleteVehicle _Heli;
};