//	null = [side, "heli type", Search and Destroy or Egress and despawn, "unload/paradrop", "Spawn position", "unload/paradrop position", "Egress/SAD position", [number of groups, % of cargo to be filled], ["unit waypoints", "last waypoint SAD"], override] execVM "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf";
////////////////////////
//	Parameters
////////////////////////
//
//	1. Side: 	Side of heli crew. (West/BLUFOR,East/OPFOR or Independent works fine)
//	2. String: 	Class name of the type of heli you want to spawn. Type   nil   for default values.
//	3. Boolean:	Whether the heli should go on a Search And Destroy task after unloading troops. True = SAD, False = Egress and despawn.
//	4. String:	Select whether the heli will unload or paradrop. "Unload" or "Paradrop" available.
//	5. Array/String:  Spawn position for heli, can be [X,Y,Z] or "Markername".
//	6. Array/String:  Unload / Paradrop position, can be [X,Y,Z] or "Markername".
//	7. Array/String:  Search and Destroy or Egress and despawn position, can be [X,Y,Z] or "Markername".
//	8. Array: [number of groups, % of total cargo to be filled with units]. [2,1] will spawn 2 groups and fill 100% available cargo seats. [4,0.5] will spawn 4 groups and fill 50% available cargo seats.
//	9. Array of [X,Y,Z] or Strings:  Unit waypoints to follow when disembarking, last waypoint is a "Search and Destroy" waypoint. ["FirstWaypoint","SecondWaypoint",[Third,Way,Point]]
//	10. Boolean: This is an override to my ghetto fix for paradropping (only) units. This will be in place until BIS fixes their AI Pilots (broke this script from 1.60). By keeping this False (default) there will be no gunners and the helo will paradrop units as intended. If you override this command by using True, the helicopter will have gunners but the script might not work because of AI behaviour.
//	More settings in NEKY_Settings.sqf
//
////////////////
//	Examples:
////////////////
//
//	null = [east, "O_Heli_Light_02_unarmed_F", False, "unload", "AirDropSpawn", _LZ, "AirDropDespawn", [2,1], [_LZ]] execVM "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf";
//	[east, "O_Heli_Light_02_F", True, "unload", "AirDropSpawn2", "AirDropTarget2", "AirDropSAD", [2,1], ["wp3","wp2"]] execVM "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf";
//	null = [west, "", false, "paradrop", "ingress", (getpos player), "Egress", [2, 1], ["zone1"],false,false] execVM "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf";
//
//
//
///////////////////////
//	Made By NeKo-ArroW
//	Version 1.01
///////////////////////

if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

Private ["_HeliType","_WPDistance","_ChuteHeight","_SpareIndex","_SkillVariables","_Rendevouz","_Type","_AIPilotSkill","_AICrewSkill","_AIUnitSkill","_UnitTypes","_OldDropMarker","_DropPosition","_Dir","_Sectors","_CrewSpots","_PilotClasses","_CrewClasses","_EmptyCargoSeats","_LZ","_TeamLeaders","_Temp","_Side","_Direction","_Position","_Index","_HeliClass","_SAD","_UnloadOrDrop","_Ingress","_UnloadOrDropMarker","_Egress","_Units","_UnitsWPs","_Group","_Heli","_x","_HeliGroup","_Pilot","_UnitClasses","_y","_i","_OKS_Dir"];

Params
[
	["_Side", west, [SideUnknown]],
	["_HeliType", "", [""]],
	["_SAD", false, [true]],
	["_UnloadOrDrop", "unload", [""]],
	["_Ingress", "", ["",[],objNull]],
	["_UnloadOrDropMarker", "", ["",[]]],
	["_Egress", "", ["",[],objNull]],
	["_Units", [1,1], [[]]],
	["_UnitsWPs", [""], [[""],[]]],
	["_Override", false, [true]],			// AS LONG AS BI HAVEN'T FIXED THEIR SHIT
	["_Airbase", true,[true]],
	["_OKS_Zone", ObjNull,[ObjNull]]

];

#include "NEKY_Settings.sqf"
_UnloadOrDrop = (toLower _UnloadOrDrop);

_TeamLeaders = [(_UnitTypes select 0), (_UnitTypes select 1)];
_UnitClasses = [];
_Index = 2;
for "_i" from 1 to ((count _UnitTypes) -2) do
{
	_UnitClasses PushBack (_UnitTypes select _Index);
	_Index = _Index +1;
};

// AI Skill Setting
NEKY_AirDropAISkill =
{
	Private ["_Temp","_Type","_Skill","_Index","_This","_SkillVariables","_HeliClass","_PilotClasses","_CrewClasses","_UnitTypes","_PilotSkill","_CrewSkill","_UnitSkill"];

	Params ["_Temp","_Type","_Side"];
	#include "NEKY_Settings.sqf"

	call Compile Format ["_Skill = _%1Skill",_Type];
	_Index = 0;
	for "_i" from 1 to (count _SkillVariables) do
	{
		_Temp setSkill [(_SkillVariables select _Index), (_Skill select _Index)];
		_Index = _Index +1;
	};
};

// Convert possible markers to XYZ
_Index = 0;
for "_i" from 0 to ((count _UnitsWPs) -1) do
{
	if (typeName (_UnitsWPs select _Index) == "STRING") then {_Temp = getMarkerPos (_UnitsWPs select _Index); _UnitsWPs set [_Index, _Temp]; _Index = _Index +1;};
};
if (typeName _Ingress == "STRING") then {_Ingress = getMarkerPos _Ingress; _OKS_Dir = MarkerDir _Ingress};
if (typeName _UnloadOrDropMarker == "STRING") then {_UnloadOrDropMarker = getMarkerPos _UnloadOrDropMarker};
if (typeName _Egress == "STRING") then {_Egress = getMarkerPos _Egress};
if (typeName _Egress == "OBJECT") then { _Egress = getPos _Egress; };
if (typeName _Ingress == "OBJECT") then {_OKS_Dir = getDir _Ingress; _Ingress = getPos _Ingress; };


// Create Heli and Crew
if (_HeliType == "") then {_HeliType = _HeliClass};


if(_Airbase) then {
	_Heli = CreateVehicle [_HeliType, _Ingress, [], 0, "CAN_COLLIDE"];
	_Heli setDir _OKS_Dir;
	_Direction = [_Heli, _UnloadOrDropMarker] call BIS_fnc_dirTo;
	_Position = [_UnloadOrDropMarker, 150, (_Direction + 180)] call BIS_fnc_relPos;
}
else
{
	_Heli = CreateVehicle [_HeliType, _Ingress, [], 0, "FLY"];
	_Direction = [_Heli, _UnloadOrDropMarker] call BIS_fnc_dirTo;
	_Heli setDir _Direction;
	_Position = [_UnloadOrDropMarker, 150, (_Direction + 180)] call BIS_fnc_relPos;
};



if (_UnloadOrDrop isEqualTo "paradrop") then
{
	if (_Override) then
	{
		_HeliGroup = CreateGroup _Side;
		_Pilot = _HeliGroup CreateUnit [(_PilotClasses call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
		_Pilot assignAsDriver _Heli;
		_Pilot MoveInDriver _Heli;
		_Pilot SetRank "SERGEANT";
		_Pilot setVariable ["oks_disable_hunt",true];
		[_Pilot, "pilot",_Side] call NEKY_AirDropAISkill;
		removeBackPack _Pilot;
		_Pilot addBackPack "B_Parachute";
		sleep 1;

		_CrewSpots = AllTurrets [_Heli,true];
		{
			_Temp = _HeliGroup CreateUnit [(_CrewClasses call BIS_FNC_SelectRandom), [0,0,200], [], 0, "NONE"];
			_Temp assignAsTurret [_Heli,_x];
			[_Temp] OrderGetIn True;
			_Temp MoveInTurret [_Heli,_x];
			_Temp setVariable ["oks_disable_hunt",true];
			if (_Heli getCargoIndex _Temp == -1) then
			{
				[_Temp, "crew",_Side] call NEKY_AirDropAISkill;
				removeBackPack _Temp;
				_Temp addBackpack "B_Parachute";
				_Temp SetBehaviour "SAFE";
				_Temp SetCombatMode "YELLOW";
			} else {
				unAssignVehicle _Temp;
				moveOut _Temp;
				deleteVehicle _Temp;
			};
		} forEach _CrewSpots;
	} else {
		_Pilot = CreateAgent [(_PilotClasses call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
		_Pilot MoveInDriver _Heli;
		_Pilot setRank "SERGEANT";
		_Pilot SetBehaviour "STEALTH";
		_Pilot setCombatMode "BLUE";
		_Pilot disableAI "FSM";
		_Pilot setVariable ["oks_disable_hunt",true];
	};
} else {
	_HeliGroup = CreateGroup _Side;
	_Pilot = _HeliGroup CreateUnit [(_PilotClasses call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
	_Pilot assignAsDriver _Heli;
	_Pilot MoveInDriver _Heli;
	_Pilot SetRank "SERGEANT";
	_Pilot setVariable ["oks_disable_hunt",true];
	[_Pilot, "pilot",_Side] call NEKY_AirDropAISkill;
	removeBackPack _Pilot;
	_Pilot addBackPack "B_Parachute";
	sleep 1;

	_CrewSpots = AllTurrets [_Heli,true];
	{
		_Temp = _HeliGroup CreateUnit [(_CrewClasses call BIS_FNC_SelectRandom), [0,0,200], [], 0, "NONE"];
		_Temp assignAsTurret [_Heli,_x];
		[_Temp] OrderGetIn True;
		_Temp MoveInTurret [_Heli,_x];
		_Temp setVariable ["oks_disable_hunt",true];
		if (_Heli getCargoIndex _Temp == -1) then
		{
			[_Temp, "crew",_Side] call NEKY_AirDropAISkill;
			removeBackPack _Temp;
			_Temp addBackpack "B_Parachute";
			_Temp SetBehaviour "SAFE";
			_Temp SetCombatMode "YELLOW";
		} else {
			unAssignVehicle _Temp;
			moveOut _Temp;
			deleteVehicle _Temp;
		};
	} forEach _CrewSpots;
};

sleep 0.5;
_EmptyCargoSeats = (_Heli emptyPositions "Cargo");

// Heli waypoints
Switch (_UnloadOrDrop) do
{
	Private ["_DropPosition","_Direction","_Position","_Heli","_UnloadOrDropMarker","_HeliGroup","_SAD","_Heli","_LZ","_OldDropMarker"];
	case "unload":
	{
		_HeliGroup addWaypoint [_Position, 0, 1];
		[_HeliGroup, 1] SetWaypointType "MOVE";
		[_HeliGroup, 1] SetWaypointCombatMode "YELLOW";
		sleep 1;

		_HeliGroup addWaypoint [_UnloadOrDropMarker, 0, 2];
		[_HeliGroup, 2] SetWaypointType "TR Unload";
		sleep 1;

		_Pilot SetBehaviour "CARELESS";
		sleep 1;

		if (_SAD) then
		{
			_HeliGroup addWaypoint [_Egress, 0, 3];
			[_HeliGroup, 3] SetWaypointType "SAD";
			[_HeliGroup, 3] SetWaypointBehaviour "AWARE";
			[_HeliGroup, 3] SetWaypointCombatMode "RED";
		} else {
			_HeliGroup addWaypoint [_Egress, 0, 3];
			[_HeliGroup, 3] SetWaypointType "MOVE";
			sleep 1;

			_HeliGroup addWaypoint [[0,0,100], 0, 4];
			[_HeliGroup, 4] SetWaypointType "MOVE";
		};
	};

	case "paradrop":
	{
		_Heli setPosATL [(GetPosATL _Heli select 0), (GetPosATL _Heli select 1), ((GetPosATL _Heli select 2) + 60)];
		_Heli flyInHeight 130;
		_Dir = [_Heli, _UnloadOrDropMarker] call BIS_fnc_dirTo;
		if ((_Units select 0) > 0) then
		{
			_Temp = 50 * (2 * ((_EmptyCargoSeats / (_Units select 0)) * (_Units select 1)) );
			sleep 1;
			_DropPosition = [_UnloadOrDropMarker, _Temp, _Dir] call BIS_fnc_relPos;
			_Temp = 20 * (2 * ((_EmptyCargoSeats / (_Units select 0)) * (_Units select 1)) );
		} else {
			_DropPosition = _UnloadOrDropMarker;
			_Temp = 0;
		};
		sleep 1;
		_OldDropMarker = _UnloadOrDropMarker;
		_UnloadOrDropMarker = [_UnloadOrDropMarker, _Temp, _Dir + 180] call BIS_fnc_relPos;

		if (_Override) then
		{
			_HeliGroup addWaypoint [_UnloadOrDropMarker, 0, 1];
			[_HeliGroup, 1] SetWaypointType "MOVE";
			sleep 1;

			_HeliGroup addWaypoint [_DropPosition, 0, 2];
			[_HeliGroup, 2] SetWaypointType "MOVE";
			[_HeliGroup, 2] setWaypointCompletionRadius 150;
			sleep 1;

			_Pilot SetBehaviour "CARELESS";
			sleep 1;

			if (_SAD) then
			{
				_HeliGroup addWaypoint [_Egress, 0, 3];
				[_HeliGroup, 3] SetWaypointType "SAD";
				[_HeliGroup, 3] SetWaypointBehaviour "AWARE";
				[_HeliGroup, 3] SetWaypointCombatMode "RED";
			} else {
				_HeliGroup addWaypoint [_Egress, 0, 3];
				[_HeliGroup, 3] SetWaypointType "MOVE";
				sleep 1;

				_HeliGroup addWaypoint [[0,0,100], 0, 4];
				[_HeliGroup, 4] SetWaypointType "MOVE";
			};
		} else {
			_Pilot moveTo _UnloadOrDropMarker;
			[_Pilot,_Egress,_UnloadOrDropMarker,_DropPosition] Spawn
			{
				Params ["_Pilot","_Egress","_UnloadOrDropMarker","_DropPosition"];
				WaitUntil {Sleep 0.5; ((_Pilot distance2D _UnloadOrDropMarker) < 50)};

				_Pilot MoveTo _DropPosition;
				WaitUntil {Sleep 0.5; ((_Pilot distance2D _DropPosition) < 50)};

				_Pilot MoveTo _Egress;
			};
		};
	};
};

//	Create groups, units and waypoints
if ((_Units Select 0) > 0) then
{
	_Groups = [];
	_UnitsPerGroup = round ( (round (_EmptyCargoSeats * (_Units select 1))) / (_Units select 0) );	// # OF GROUPS = (_Units select 0)  ||  % OF CARGO = (_Units select 1)
	_SpareIndex = ( (round (_EmptyCargoSeats * (_Units select 1))) - (_UnitsPerGroup * (_Units select 0)) );

	for "_y" from 1 to (_Units select 0) do
	{
		_Group = CreateGroup _Side;
		_Group setVariable ["GW_Performance_autoDelete", false, true];
		for "_i" from 1 to (_UnitsPerGroup + _SpareIndex) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_TeamLeaders call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
				_Unit setRank "SERGEANT";
				[_Unit, "unit", _Side] call NEKY_AirDropAISkill;
				NEKY_Hunt_CurrentCount pushBackUnique _Unit;
				publicVariable "NEKY_Hunt_CurrentCount";
			} else {
				_Unit = _Group CreateUnit [(_UnitClasses call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
				_Unit setRank "PRIVATE";
				[_Unit, "unit", _Side] call NEKY_AirDropAISkill;
				NEKY_Hunt_CurrentCount pushBackUnique _Unit;
				publicVariable "NEKY_Hunt_CurrentCount";
			};
			_Unit assignAsCargo _Heli;
			_Unit moveInCargo _Heli;
			if (!isNil "FRAMEWORK_Gear_Run") then { [_Unit, (SelectRandom FRAMEWORK_AI_PresenceRolesDefined)] spawn FRAMEWORK_Gear_Run };
			if (_UnloadOrDrop == "paradrop") then
			{
				// Save unit backpack and give it back when landing
				[_Unit,_Heli] spawn
				{
					_Unit = _This select 0;
					_Heli = _This select 1;
					_Backpack = Backpack _Unit;
					_BackpackItems = BackpackItems _Unit;

					WaitUntil {Sleep 3; !(_Unit in _Heli)}; // Wait for unit to dismount

					// To prevent AI to faceplant and die
					WaitUntil {Sleep 0.1; ( (!Alive _Unit) or ((getPosATL _Unit select 2) < 2) )};
					if !(Alive _Unit) exitWith {False};
					[[[_Unit], {(_This select 0) allowdamage false}], "BIS_FNC_SPAWN", (Owner _Unit)] call BIS_FNC_MP;
					_Time = Time + 10;
					WaitUntil {Sleep 0.1; (isTouchingGround _Unit) or (_Time < Time)};
					[[[_Unit], {(_This select 0) allowdamage true}], "BIS_FNC_SPAWN", (Owner _Unit)] call BIS_FNC_MP;

					RemoveBackpack _Unit;
					sleep 1;
					_Unit addBackpack _Backpack;
					ClearAllItemsFromBackpack _Unit;
					sleep 1;
					{_Unit addItemToBackpack _x} forEach _BackpackItems;
				};

				// Give unit Parachute
				[_Unit,_Heli,_ChuteHeight] spawn
				{
					_Unit = _This select 0;
					_Heli = _This select 1;
					_ChuteHeight = _This select 2;

					WaitUntil {sleep 0.5; !(_Unit in _Heli) or !(Alive _Unit)};

					if !(Alive _Unit) exitWith {False};
					removeBackPack _Unit;
					WaitUntil {sleep 0.1; ((getPosATL _Unit select 2) < _ChuteHeight) or !(Alive _Unit)};

					if !(Alive _Unit) exitWith {False};
					_Unit addBackPack "B_Parachute";
				};
			};
			if (_SpareIndex > 0) then {_SpareIndex = _SpareIndex -1};
			if (_SpareIndex < 0) then {_SpareIndex = _SpareIndex +1};
			sleep 0.5;
		};
		_Groups PushBack _Group;
		{_x disableCollisionWith _Heli} forEach (units _Group);

		// Group Waypoints
		_Index = 0;
		_WPIndex = 1;

		//	Paradrop Rendevouz
		if (_UnloadOrDrop isEqualTo "paradrop" && _Rendevouz) then
		{
			_Group addWaypoint [_OldDropMarker, 40, _WPIndex];
			[_Group,_WPIndex] SetWaypointType "MOVE";
			[_Group,_WPIndex] setWaypointBehaviour "AWARE";
			[_Group,_WPIndex] setWaypointCombatMode "YELLOW";
			[_Group,_WPIndex] setWaypointSpeed "FULL";
			[_Group,_WPIndex] SetWaypointFormation "WEDGE";
			_WPIndex = _WPIndex +1;
		};

		//	Waypoints
		for "_i" from 1 to (count _UnitsWPs -1) do
		{
			_Group addWaypoint [(_UnitsWPs select _Index), 20, _WPIndex];
			[_Group,_WPIndex] SetWaypointType "MOVE";
			[_Group,_WPIndex] setWaypointBehaviour "AWARE";
			[_Group,_WPIndex] setWaypointCombatMode "YELLOW";
			[_Group,_WPIndex] setWaypointSpeed "NORMAL";
			[_Group,_WPIndex] SetWaypointFormation "WEDGE";
			_WPIndex = _WPIndex +1;
			_Index = _Index +1;
		};
		_Group addWaypoint [(_UnitsWPs select _Index), 30, _WPIndex];
		[_Group,_WPIndex] SetWaypointType "SAD";
		[_Group,_WPIndex] setWaypointBehaviour "AWARE";
		[_Group,_WPIndex] setWaypointCombatMode "RED";
		[_Group,_WPIndex] SetWaypointFormation "WEDGE";
		sleep 1;

		// 	Add waypoints around the target area
		for "_i" from 1 to 5 do
		{
			_WPIndex = _WPIndex +1;
			_Temp = [(_UnitsWPs select _Index), ((_WPDistance * 0.3) + (random (_WPDistance * 0.7))), (random 360)] call BIS_fnc_relPos;
			_Group addWaypoint [_Temp, 0, _WPIndex];
			[_Group,_WPIndex] SetWaypointType "SAD";
			[_Group,_WPIndex] setWaypointBehaviour "AWARE";
			[_Group,_WPIndex] setWaypointCombatMode "RED";
		};
		sleep 1;
	};

	//	One group setting up sectors on LZ
	if (_UnloadOrDrop isEqualTo "unload") then
	{
		_Sectors = [_UnloadOrDropMarker, (_UnitsWPs select 0)] call BIS_fnc_dirTo;
		_Position = [_UnloadOrDropMarker, 20, _Sectors] call BIS_fnc_relPos;
		_Group = _Groups select 0;
		_Group addWaypoint [_Position, 20, 1];
		[_Group,1] SetWaypointType "MOVE";
		[_Group,1] setWaypointBehaviour "AWARE";
		[_Group,1] setWaypointCombatMode "GREEN";
		[_Group,1] setWaypointSpeed "FULL";
		[_Group,1] SetWaypointFormation "WEDGE";
		_Group lockWP True;
		WaitUntil {sleep 1; ( !((Alive _Pilot) or (Alive _Heli)) or ((3 <= (CurrentWaypoint _HeliGroup)) && ((GetPosATL _Heli select 2) > 5)) )};
		sleep 10;
		_Group LockWP false;
		_Group SetCurrentWaypoint [_Group, 2];
	};

	// Ejecting paradrop units
	if (_UnloadOrDrop isEqualTo "paradrop") then
	{
		if (_Override) then
		{
			WaitUntil {sleep 1; !((Alive _Heli) or (Alive _Pilot)) or (2 <= (CurrentWaypoint _HeliGroup))};
		} else {
			WaitUntil {Sleep 0.1; !((Alive _Heli) or (Alive _Pilot)) or ((_Heli distance2D _UnloadOrDropMarker) < 75)};
			SystemChat "DEBUG: Dropping!";
		};
		_Index = 0;
		for "_i" from 1 to (count _Groups) do
		{
			_Group = (_Groups select _Index);
			_Dir = GetDir _Heli;
			{if (Alive _x) then {unAssignVehicle _x; MoveOut _x; _x setDir _Dir; _x setVelocity (Velocity _Heli); _x disableAI "MOVE"; [_x] spawn {sleep 10; (_This select 0) EnableAI "MOVE"}; sleep 0.25;};} forEach (Units _Group);
			_Index = _Index +1;
		};
		if (_SAD) then {_Heli FlyInHeight 100};
	};

	// Make landed troops hunt
	if !(isNil "NEKY_Hunt_Run") then
	{
		/// Change to massive zone to have unlimited hunt?
		{ if ( {Alive _x} count (Units _x) != 0) then { [_x, nil, _OKS_Zone, 0, 30, 0, {}] Spawn NEKY_Hunt_Run} } forEach _Groups;
	};

};

//	Despawn if killed or at last waypoint (excluding SAD)
if !(_SAD) then
{
	Sleep 20;

	[_Heli,_Egress] Spawn
	{
		Params ["_Heli","_Egress"];
		WaitUntil {sleep 5; ((_Heli distance2D _Egress) < 200) or ((!Alive _Heli) or (!Alive (Driver _Heli)))};

		if ((Alive _Heli) and (Alive (Driver _Heli))) then {{deleteVehicle _x} forEach (Crew _Heli); DeleteVehicle _Heli};
		if ((!Alive _Heli) or (!Alive (Driver _Heli))) then {sleep 600; {deleteVehicle _x} forEach (Crew _Heli); deleteVehicle _Heli};
	};
};