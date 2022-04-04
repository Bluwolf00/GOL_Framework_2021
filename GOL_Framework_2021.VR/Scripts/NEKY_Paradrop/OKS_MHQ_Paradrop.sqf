//	[flag_west_1, AMHQ_1, true, 120] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
//
//	1. Unit, the unit to be deployed via this script. If in the init of the unit you can use:   This     else you need to use the name of the unit.
//	2. Drop Zone, Place a trigger and name it, adjust trigger size for how big the drop zone should be. (No further input neccessary)
//	3. if Steerable, type:   True    if you want a steerable parachute. if you want a non-steerable, type:   False.
//	4. Deploy Chute Height, the height in meters that the parachute should start deploying. Default is 100m.
//
//	Created by Oksman - Modified Neky Paradrop
//


Params
[
	["_ActionObject",ObjNull,[ObjNull]],
	["_FlyingMHQObject",ObjNull,[ObjNull]],
	["_Steerable",true,[true]],
	["_Height",100,[0]]
];

if(!isNil "OKS_MHQ_Paradrop_Actions") then {
	{
		if(!isNil "_X") then {
			_ActionObject removeAction _X
		}
	} foreach OKS_MHQ_Paradrop_Actions;
};

if(isServer) then {
	missionNamespace setVariable ["MHQ_Paradrop_Info",[_ActionObject,_Steerable,_Height]];
	[
		_FlyingMHQObject, /* 0 Vehicle Object */
		10, /* 1 Delay */
		nil, /* 2 desertDelay */
		nil, /* 3 respawnCount */
		{
			/* 4 Code upon Respawn */
			 Params ["_NewVehicle","_OldVehicle"];
			_Settings = missionNamespace getVariable ["MHQ_Paradrop_Info",false];
			_Settings params ["_ActionObject","_Steerable","_Height"];
			[_ActionObject,_NewVehicle,_Steerable,_Height] remoteExec ["OKS_MHQ_Paradrop",0];
		},
		0,    /* 5 Respawn Position */
		2,    /* 6 Respawn Selection Type */
		2,    /* 7 Type of Deletion */
		0, /* 8 Should Show Notification */
		0,    /* 9 Forced Respawn */
		0, /* 10 desertedDistance */
		true /* 11 respawnwhendisabled*/
	] call BIS_fnc_moduleRespawnVehicle;

	OKS_MHQ_Paradrop_Array = [];
	OKS_MHQ_Paradrop_Actions = [];
	publicVariable "OKS_MHQ_Paradrop_Array";
	publicVariable"OKS_MHQ_Paradrop_Actions";
};

_id1 = _ActionObject addAction ["<t color='#31EC08'>Request MHQ Paradrop</t>", {

		Params ["_ActionObject", "_Unit", "_id", "_ExtraParams"];
		_ExtraParams Params ["_FlyingMHQObject"];
		_Any = (crew _FlyingMHQObject select 0);
		if(isNil "_Any") exitWith {SystemChat "Paradrop Reinsert is currently unavailable.."};
		[_Any,format ["%1 has requested a paradrop reinsert..",name _Unit]] remoteExec ["groupChat",0];
		OKS_MHQ_Paradrop_Array pushBackUnique _Unit;
		publicVariable "OKS_MHQ_Paradrop_Array";
	},
	[_FlyingMHQObject],
	0,
	false,
	true,
	"",
	"!(_this in OKS_MHQ_Paradrop_Array)"
];

_id2 = _ActionObject addAction ["<t color='#EC1508'>Cancel MHQ Paradrop</t>", {

		Params ["_ActionObject", "_Unit", "_id", "_ExtraParams"];
		_ExtraParams Params ["_FlyingMHQObject"];
		OKS_MHQ_Paradrop_Array deleteAt (OKS_MHQ_Paradrop_Array find _Unit);
		publicVariable "OKS_MHQ_Paradrop_Array";
		_Any = (crew _FlyingMHQObject select 0);
		if(isNil "_Any") exitWith {SystemChat "MHQ Paradrop - Failed to find crew in MHQ."};
		[_Any,format ["%1 has cancelled his reinsert request..",_Unit]] remoteExec ["vehicleChat",0];
	},
	[_FlyingMHQObject],
	0,
	false,
	true,
	"",
	"_this in OKS_MHQ_Paradrop_Array"
];

OKS_MHQ_Paradrop_Actions = [_id1,_id2];
publicVariable "OKS_MHQ_Paradrop_Actions";

OKS_MHQ_ChatMessage = {
	if(player in OKS_MHQ_Paradrop_Array) then {
		systemChat "Paradrop in 3 seconds..."
	};
};

_FlyingMHQObject addAction ["<t color='#ECE808'>Deploy Paratroopers</t>", {

		Params ["_ActionObject", "_Unit", "_id", "_ExtraParams"];
		_ActionObject setVariable ["isParadropping",true];
		{[] remoteExec ["OKS_MHQ_ChatMessage",0]} foreach OKS_MHQ_Paradrop_Array;
		sleep 3;
		_ExtraParams Params ["_FlyingMHQObject","_Steerable","_Height"];
		{
			_Any = (crew _FlyingMHQObject select 0);
			if(isNil "_Any") exitWith {SystemChat "Error: Pilot could not be found."};
			[_Any,format ["%1 has been dropped..",name _X]] remoteExec ["groupChat",0];
			[_X,_FlyingMHQObject,_Steerable,_Height] remoteExec ["OKS_EjectFromPlane",0];
			OKS_MHQ_Paradrop_Array deleteAt (OKS_MHQ_Paradrop_Array find _X);
			sleep 2.5;
		} foreach OKS_MHQ_Paradrop_Array;
		_ActionObject setVariable ["isParadropping",false];
	},
	[_FlyingMHQObject,_Steerable,_Height],
	0,
	false,
	true,
	"",
	"!(_target getVariable ['isParadropping',false]) && count OKS_MHQ_Paradrop_Array > 0 && (driver (vehicle _target)) isEqualTo _this && getPos _target select 2 > 200 && speed _target < 250"
];

// Move unit to position and start falling
// TODO: Place further behind plane, if dead remove actions, reset. Even if survive, actions still there, no reset.	
OKS_EjectFromPlane = {

	if(hasInterface) then {

	Params ["_Unit","_FlyingMHQObject","_Steerable","_Height"];
	_Unit allowDamage false;
	sleep 1;
	_EjectPos = _FlyingMHQObject modelToWorld [0,-35,-15];
	_Unit setPos _EjectPos;
	_Unit setDir (getDir _FlyingMHQObject);
	_Unit setVelocity [(random 5), -10, -10];

	sleep 2;
	_Unit allowDamage true;
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
		Sleep 0.5;

		// Add backpack
		removeBackpack _Unit;
		_Unit addBackpack "B_Parachute";

		// Restore backpack
		[_Unit, _Backpack,_BackpackItems] Spawn
		{

			Params ["_Unit","_Backpack","_BackpackItems"];
			WaitUntil { Sleep 0.1; !(isNull objectParent _Unit) or (((getPosATL _Unit) Select 2) < 20)};

			RemoveBackpack _Unit;
			if !(isNull objectParent _Unit) then {(Vehicle _Unit) allowdamage True};
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
	}
};
