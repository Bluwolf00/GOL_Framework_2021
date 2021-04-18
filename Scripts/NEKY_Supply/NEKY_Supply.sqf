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
//	5. Box Content, either enter a script path "Scripts\NEKY_Supply\Supply Box Templates\Resupply.sqf" and fill that file with items or enter it all manually using {}. Use _Box instead of "this" in the code.
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

Private ["_PilotClass","_Correction","_Signal","_SignalClass","_Chute","_ChuteClass","_Position","_Box","_BoxClass","_HeliPad","_Index","_Pilot","_Side","_HeliClass","_This","_Type","_STD","_STDs","_Box","_Vulnerable","_x","_Pilot","_Text","_Parameters","_Temp"];

_Side = [_This, 0, BLUFOR, [SideUnknown]] call BIS_fnc_param;
_HeliClass = toLower ([_This, 1, "", [""]] call BIS_fnc_Param);
_Type = toLower ([_This, 2, "drop", [""]] call BIS_fnc_Param);
_STDs = [_This, 3, [""], [[""],[]]] call BIS_fnc_Param;
_BoxCode = [_This, 4,  "", ["", {}]] call BIS_fnc_Param;
_Vulnerable = [_This, 5, false, [false]] call BIS_fnc_Param;

// Debugger \\
NEKY_SupplyDebug =
{
	private ["_this","_Parameters","_Text"];
	if (true) exitWith {false};   							// false = shows debugging text. true = doesn't show debugging text. (EDITOR ONLY)

	_Text = _this select 0;
	_Parameters = _this select 1;
	SystemChat format [_Text,_Parameters];
};

["Script Running %1","NEKY_Supply.sqf"] spawn NEKY_SupplyDebug;

//	Turning markers in to XYZ
_STD = []; {if (typeName _x == "STRING") then {_Temp = GetMarkerPos _x; _STD PushBack _Temp} else {_STD PushBack _x}; } forEach _STDs;
sleep 1;
["STD Array: %1",_STD] call NEKY_SupplyDebug;

// Define classes based on side
switch (_Side) do
{
	Private ["_BoxClass","_HeliClass","_ChuteClass","_PilotClass"];

	case BLUFOR:
	{
		if (_HeliClass == "") then {_HeliClass = "B_Heli_Transport_03_unarmed_F";};
		_BoxClass = "B_CargoNet_01_ammo_F";
		_ChuteClass = "B_Parachute_02_F";
		_PilotClass = "B_Pilot_F";
	};

	case OPFOR:
	{
		if (_HeliClass == "") then {_HeliClass = "O_Heli_Transport_04_F";};
		_BoxClass = "O_CargoNet_01_ammo_F";
		_ChuteClass = "O_Parachute_02_F";
		_PilotClass = "O_Pilot_F";
	};

	case INDEPENDENT:
	{
		if (_HeliClass == "") then {_HeliClass = "I_Heli_light_03_unarmed_F";};
		_BoxClass = "I_CargoNet_01_ammo_F";
		_ChuteClass = "I_Parachute_02_F";
		_PilotClass = "I_Pilot_F";
	};
};

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"} else {_SignalClass = "Chemlight_green"};

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
		[_Pilot,_Heli,_BoxClass,_BoxCode,_ChuteClass,_SignalClass,_STD] Spawn
		{
			Params ["_Pilot","_Heli","_BoxClass","_BoxCode","_ChuteClass","_SignalClass","_STD"];

			WaitUntil {sleep 0.5; ( (!(Alive _Heli) or !(CanMove _Heli)) or !(Alive _Pilot) or ((_STD Select 1) distance2D _Heli < 200))};

			_Pilot moveTo (_STD Select 2);
			if ((Alive _Heli) && (Alive _Pilot)) then
			{
				// Create box and Chute and make it fall
				_Box = CreateVehicle [_BoxClass, [0,0,0], [], 0, "NONE"];
				_Box disableCollisionWith _Heli;
				[_Box,_BoxCode] spawn
				{
					_Box = _This select 0;
					_BoxCode = _This select 1;
					sleep 2;
					if (TypeName _BoxCode == "STRING") Then {if (_BoxCode != "") then {[_Box] execVM _BoxCode};} else {[_Box] call _BoxCode};
				};
				_Box HideObjectGlobal True;
				_Chute = CreateVehicle [_ChuteClass, [0,0,0], [], 0, "NONE"];
				_Chute AllowDamage False;
				_Chute disableCollisionWith _Heli;
				_Chute disableCollisionWith _Box;
				_Box attachTo [_Chute,[0,0,0]];
				_Chute HideObjectGlobal True;
				_Temp = [_Heli, 50, (GetDir _Heli)] call BIS_fnc_relPos;
				_Temp = [_Temp select 0, _Temp select 1, ((_Temp select 2) - 10)];
				_Chute SetPosATL _Temp;
				_Chute SetDir (getDir _Heli);
				_PitchBank = _Chute call BIS_fnc_getPitchBank;
				[_Chute,25,(_PitchBank select 1)] call BIS_fnc_SetPitchBank;
				sleep 0.7;
				_Box HideObjectGlobal False;
				_Chute HideObjectGlobal False;
				_Chute setVelocity [((Velocity _Heli) select 0), ((Velocity _Heli) select 1),-5];
				[_Chute] spawn { For "_i" from 1 to 10 do { Params ["_Chute"]; _Chute setvelocity [Velocity _Chute select 0, Velocity _Chute select 1, -5]; sleep 0.5 } };

				[_SignalClass, _Box] spawn
				{
					_SignalClass = _This select 0;
					_Box = _This select 1;

					sleep 15;
					_Signal = createVehicle [_SignalClass, [0,0,0], [], 0, "NONE"];
					_Signal AttachTo [_Box,[0,0,0]];
					WaitUntil {(((GetPosATL _Box) select 2) <= 1)};

					Detach _Box;
					"Pilot: Supplies Landed!" remoteExec ["systemChat"];
				};
			};
		};
	};

	case "unload":
	{
		_HeliPad = createVehicle ["Land_HelipadEmpty_F", (_STD select 1), [], 0, "NONE"];
		[_Pilot,_PilotClass,_Heli,_HeliPad,_BoxClass,_BoxCode,_SignalClass,_STD] spawn
		{
			Params ["_Pilot","_PilotClass","_Heli","_HeliPad","_BoxClass","_BoxCode","_SignalClass","_STD"];

			_Heli forceSpeed 100;
			WaitUntil {sleep 2; ( (!(Alive _Heli) or !(CanMove _Heli)) or !(Alive _Pilot) or ((_Heli distance _HeliPad) < 600))};
			if ((Alive _Heli) && (Alive _Pilot)) then
			{
				_Heli Land "LAND";
				doStop _Heli;
				createVehicle [_SignalClass, (getPos _HeliPad), [], 5, "CAN_COLLIDE"];
				WaitUntil {sleep 2; ( (!(Alive _Heli) or !(CanMove _Heli)) or !(Alive _Pilot) or (((GetPosATL _Heli) Select 2) < 5))};
				_Pilot forceSpeed 0;
				_Pilot DisableAI "MOVE";
				sleep 2;
				_Heli EngineOn True;
				sleep 10;
				If ((Alive _Pilot) && (Alive _Heli)) then						// Make this check for crew and move this to affect Pilot only once BI fixes Crew issue.
				{
					_Position = [_Heli, 5, ((GetDir _Heli) + 90)] call BIS_fnc_relPos;
					if (Alive _Heli) then
					{
						_Box = CreateVehicle [_BoxClass, _Position, [], 0, "CAN_COLLIDE"];
						if (TypeName _BoxCode == "STRING") Then {if (_BoxCode != "") then {[_Box] execVM _BoxCode};} else {[_Box] call _BoxCode};
					};
					"Pilot: Supplies Unloaded." remoteExec ["systemChat"];
					DeleteVehicle _Pilot;
					_Pilot = CreateAgent [_PilotClass, [0,0,0], [], 0, "NONE"];		// Ghetto fix for agent getting stuck on "_Heli Land 'LAND'".
					_Pilot MoveInDriver _Heli;
					_Pilot setRank "SERGEANT";
					_Pilot SetBehaviour "STEALTH";
					_Pilot setCombatMode "BLUE";
					_Pilot disableAI "FSM";
					_Pilot MoveTo (_STD Select 2);
				};
			} else {
				deleteVehicle _Helipad;
				false;
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