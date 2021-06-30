//	[Unit, Drop Zone (Trigger name), if steerable (true/false), Drop Height (number), deploy chute height (number)] execVM "Scripts\NEKY_Paradrop\NEKY_Paradrop.sqf";
//	
//	1. Unit, the unit to be deployed via this script. If in the init of the unit you can use:   This     else you need to use the name of the unit.
//	2. Drop Zone, Place a trigger and name it, adjust trigger size for how big the drop zone should be. (No further input neccessary)
//	3. if Steerable, type:   True    if you want a steerable parachute. if you want a non-steerable, type:   False.
//	4. Drop Height, at what height (above land!) to be dropped off at. Default is 200m
//	5. Deploy Chute Height, the height in meters that the parachute should start deploying. Default is 100m.
//
//	Made by NeKo-ArroW
//

Params 
[
	["_Unit",ObjNull,[ObjNull]],
	["_DropZone",ObjNull,[ObjNull]],
	["_Steerable",true,[true]],
	["_DropHeight",200,[0]],
	["_Height",100,[0]]
];

WaitUntil {sleep 0.25; !isNull _Unit && isPlayer _Unit};	// Wait for unit to load in
if !(Local _Unit) exitWith {False};
if (isNull _DropZone) exitWith {SystemChat "NEKY_Paradrop DEBUG: Trigger does not exist."};

// Grab random position and add 200m altitude
_Pos = [[_DropZone], [], {true}] call BIS_fnc_randomPos;
_Pos = [(_Pos select 0), (_Pos select 1), (_DropHeight - (Random 20))];

// Move unit to position and start falling
_Unit setPosATL _Pos;
_Unit setDir (Random 360);
_Unit setVelocity [(random 15), (random 15), -15];

// Create chute and move unit in to it
if !(_Steerable) then 
{
	WaitUntil {((getPosATL _Unit) Select 2) < _Height};
	
	_Chute = CreateVehicle ["NonSteerable_Parachute_F", [0,0,1100], [], 0, "NONE"];
	_Chute allowDamage False;
	_Chute setDir (GetDir _Unit);
	_Chute disableCollisionWith _Unit;
	sleep 0.5;
	_Chute setPosATL (GetPosATL _Unit);
	_Velocity = (Velocity _Unit);
	_Chute setVelocity [_Velocity select 0, _Velocity select 1, -25];
	_Unit MoveInDriver _Chute;
} else {
	// Save backpack and content
	_Backpack = Backpack _Unit;
	_BackpackItems = BackpackItems _Unit;
	Sleep 3;
	
	// Add backpack
	removeBackpack _Unit;
	_Unit addBackpack "B_Parachute";
	
	// Restore backpack
	[_Unit, _Backpack,_BackpackItems] Spawn 
	{
		Params ["_Unit","_Backpack","_BackpackItems"];
		WaitUntil { Sleep 0.1; !(isNull objectParent player) or (((getPosATL _Unit) Select 2) < 20)};
		
		RemoveBackpack _Unit;
		if !(isNull objectParent player) then {(Vehicle _Unit) allowdamage True};
		sleep 1;
		_Unit addBackpack _Backpack;
		ClearAllItemsFromBackpack _Unit;
		sleep 1;
		{_Unit addItemToBackpack _x} forEach _BackpackItems;
	};
	
	// Open parachute
	WaitUntil {((getPosATL _Unit) Select 2) < _Height};
	
	if (isNull objectParent player) then {_Unit action ["openParachute", _Unit]};
};