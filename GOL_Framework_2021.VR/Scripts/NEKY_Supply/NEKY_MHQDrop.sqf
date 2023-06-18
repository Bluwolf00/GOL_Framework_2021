//	[side, "heli type classname" (default mid size heli of said side), "Drop/Unload", ["spawn","target","despawn"], "box content script path" or code , Boolean (Vulnerable, true or false)] execVM "Scripts\NEKY_Supply\NEKY_Supply.sqf";
//
/////////////////
//	Parameters:
/////////////////
//
//	1. Side of heli crew (West,BLUFOR,East,OPFOR,Independent works fine)
//	2. Class name of the type of heli you want to spawn. If you leave it empty ("") then it'll spawn a preset heli (Blackhawk, Taru, Hellcat)
//	3. Drop or Unload. Drop means that it will drop the ammo box with a parachute while unload means it'll land and unload it and fly off again.
//	4. ["spawn","target","despawn"] markers for where it spawns, target area for resupply, last waypoint which will despawn heli + crew.
//	5. Box Content, either enter a script path "Scripts\NEKY_Supply\Supply Box Templates\Resupply.sqf" and fill that file with items or enter it all manually using {}. Use _Vehicle instead of "this" in the code.
//	6. Vulnerable. True = Heli + crew can take damage. False = Heli + crew cannot take damage.
//	7. Override. True = Override ghetto fix for AI pilots behaviour (broken since 1.60). Default: False.
//
///////////
//	Usage:
///////////
//
//	Create a trigger and enter a condition. Then enter this in to the activation line and fill out the parameters to your choosing:
//	null = [blufor,"","drop",["spawn","target","despawn"],"Scripts\NEKY_Supply\Supply Box Templates\Resupply.sqf",false] execVM "Scripts\NEKY_Supply\NEKY_Supply.sqf";
//
//	To set it up by using Radio calls (clicking 0 and 0 again while in-game) see NEKY_SupplyInit.sqf for more info.
//
//	Made By NeKo-ArroW with help from GuzzenVonLidl with tweeks from Luke for ace

if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

Private ["_PilotClass","_Correction","_Signal","_SignalClass","_Chute","_ChuteClass","_Position","_Vehicle","_VehicleClass","_HeliPad","_Index","_Pilot","_Side","_HeliClass","_This","_Type","_STD","_STDs","_Vehicle","_Vulnerable","_x","_Pilot","_Text","_Parameters","_Temp"];

_Side = [_This, 0, BLUFOR, [SideUnknown]] call BIS_fnc_param;
_HeliClass = toLower ([_This, 1, "", [""]] call BIS_fnc_Param);
_Type = toLower ([_This, 2, "drop", [""]] call BIS_fnc_Param);
_STDs = [_This, 3, [""], [[""],[]]] call BIS_fnc_Param;
_VehicleCode = [_This, 4,  "", ["", {}]] call BIS_fnc_Param;
_Vulnerable = [_This, 5, false, [false]] call BIS_fnc_Param;
_VehicleClass = [_This, 6, "B_APC_Wheeled_01_cannon_F", [""]] call BIS_fnc_Param;

// Debugger \\
NEKY_SupplyDebug =
{
	private ["_this","_Parameters","_Text"];
	if (true) exitWith {false};   							// false = shows debugging text. true = doesn't show debugging text. (EDITOR ONLY)

	_Text = _this select 0;
	_Parameters = _this select 1;
	SystemChat format [_Text,_Parameters];
};

["Script Running %1","NEKY_MHQDrop.sqf"] spawn NEKY_SupplyDebug;

//	Turning markers in to XYZ
_STD = []; {if (typeName _x == "STRING") then {_Temp = GetMarkerPos _x; _STD PushBack _Temp} else {_STD PushBack _x}; } forEach _STDs;
sleep 1;
["STD Array: %1",_STD] call NEKY_SupplyDebug;

// Define classes based on side
switch (_Side) do
{
	Private ["_VehicleClass","_HeliClass","_ChuteClass","_PilotClass"];

	case BLUFOR:
	{
		if (_HeliClass == "") then {_HeliClass = "B_Heli_Transport_03_F"};
		if (_VehicleClass == "") then {_VehicleClass = "B_APC_Wheeled_01_cannon_F"};
		_ChuteClass = "B_Parachute_02_F";
		_PilotClass = "B_Pilot_F";
	};

	case OPFOR:
	{
		if (_HeliClass == "") then {_HeliClass = "O_Heli_Transport_04_F"};
		if (_VehicleClass == "") then {_VehicleClass = "O_APC_Tracked_02_cannon_F"};
		_ChuteClass = "O_Parachute_02_F";
		_PilotClass = "O_Pilot_F";
	};

	case INDEPENDENT:
	{
		if (_HeliClass == "") then {_HeliClass = "I_Heli_Transport_02_F"};
		if (_VehicleClass == "") then {_VehicleClass = "I_APC_Wheeled_03_cannon_F"};
		_ChuteClass = "I_Parachute_02_F";
		_PilotClass = "I_Pilot_F";
	};

	default {
		if (_HeliClass == "") then {_HeliClass = "B_Heli_Transport_03_F";};
		if (_VehicleClass == "") then {_VehicleClass = "B_APC_Wheeled_01_cannon_F"};
		_ChuteClass = "B_Parachute_02_F";
		_PilotClass = "B_Pilot_F";
	};
};

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"} else {_SignalClass = "F_40mm_Green"};

// Spawning Heli & Crew
_Heli = CreateVehicle [_HeliClass, (_STD select 0), [], 0, "FLY"];
_Heli setDir ([(_STD Select 0), (_STD Select 1)] call BIS_fnc_DirTo);
_Heli AllowDamage _Vulnerable;

_Pilot = CreateAgent [_PilotClass, [0,0,0], [], 0, "NONE"];
_Pilot MoveInDriver _Heli;
_Pilot setRank "SERGEANT";
_Pilot SetBehaviour "STEALTH";
_Pilot setCombatMode "BLUE";
_Pilot disableAI "FSM";
sleep 1;

/*
// REMOVED UNTIL BI FIXES THEIR SHIT. The crew overrides the pilot and makes it evade hostile units etc etc.

CreateVehicleCrew _Heli;
{
	_x setRank "PRIVATE";
	_x setSkill 0.4;
	_x SetBehaviour "AWARE";
	_x SetCombatMode "GREEN";
	_x allowDamage _Vulnerable;
	removeBackPack _x;
} forEach crew _Heli;
sleep 0.5;
*/

// Waypoints creating and assignment
_Pilot MoveTo (_STD select 1);

Switch (_Type) do
{
	case "drop":
	{
		_Heli flyInHeight 120;
		_DirCorrection = [(_STD select 0), (_STD Select 1)] call BIS_fnc_dirTo;
		_Correction = [(_STD Select 1), 20, _DirCorrection] call BIS_fnc_relPos;
		sleep 0.5;
		[_Pilot,_Heli,_VehicleCode,_ChuteClass,_SignalClass,_VehicleClass,_STD] Spawn
		{
			Params ["_Pilot","_Heli","_VehicleCode","_ChuteClass","_SignalClass","_VehicleClass","_STD"];

			WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or !(Alive _Pilot) or ((_STD Select 1) distance2D _Heli < 200))};

			_Pilot moveTo (_STD Select 2);
			if ((Alive _Heli) && (Alive _Pilot)) then
			{
				// Create box and Chute and make it fall
				_Vehicle = CreateVehicle [_VehicleClass, [0,0,0], [], 0, "NONE"];
				_Vehicle disableCollisionWith _Heli;
				[_Vehicle,_VehicleCode] spawn
				{
					_Vehicle = _This select 0;
					_VehicleCode = _This select 1;
					sleep 2;
					if (TypeName _VehicleCode == "STRING") Then {if (_VehicleCode != "") then {[_Vehicle] execVM _VehicleCode};} else {[_Vehicle] call _VehicleCode};
				};
				_Vehicle HideObjectGlobal True;
				_Chute = CreateVehicle [_ChuteClass, [0,0,0], [], 0, "NONE"];
				_Chute AllowDamage False;
				_Chute disableCollisionWith _Heli;
				_Chute disableCollisionWith _Vehicle;
				_Vehicle attachTo [_Chute,[0,0,0]];
				_Chute HideObjectGlobal True;
				_Temp = [_Heli, 50, (GetDir _Heli)] call BIS_fnc_relPos;
				_Temp = [_Temp select 0, _Temp select 1, ((_Temp select 2) - 10)];
				_Chute SetPosATL _Temp;
				_Chute SetDir (getDir _Heli);
				_PitchBank = _Chute call BIS_fnc_getPitchBank;
				[_Chute,0,(_PitchBank select 1)] call BIS_fnc_SetPitchBank;
				sleep 0.7;
				_Vehicle HideObjectGlobal False;
				_Chute HideObjectGlobal False;
				_Chute setVelocity [((Velocity _Heli) select 0), ((Velocity _Heli) select 1),-3];
				[_Chute] spawn { For "_i" from 1 to 15 do { Params ["_Chute"]; _Chute setvelocity [Velocity _Chute select 0, Velocity _Chute select 1, -0.5]; sleep 0.5 } };

				[_SignalClass, _Vehicle] spawn
				{
					_SignalClass = _This select 0;
					_Vehicle = _This select 1;
					_Vehicle allowDamage false;

					sleep 5;
					_Signal = createVehicle [_SignalClass, [0,0,0], [], 0, "NONE"];
					_Signal AttachTo [_Vehicle,[0,0,0]];
					WaitUntil {(((GetPosATL _Vehicle) select 2) <= 7)};

					Detach _Vehicle;
					Detach _Signal;
					
					"Pilot: Vehicle Landed!" remoteExec ["systemChat"];
					sleep 5;
					_Vehicle allowDamage true;
				};
			};
		};
	};
};

["Waypoint Type: %1", _Type] call NEKY_SupplyDebug;

// Despawning
sleep 10;
[_Pilot,_Heli,_STD] spawn
{
	Params ["_Pilot","_Heli","_STD"];
	WaitUntil {sleep 1; (!(Alive _Heli) or !(Alive (Driver _Heli)) or ((_Heli distance (_STD select 2)) <= 250))};

	if (!(Alive _Heli) or !(Alive (Driver _Heli))) then {Sleep 900} else {sleep 5};
	{DeleteVehicle _x} forEach (crew _Heli);
	DeleteVehicle _Heli;
};