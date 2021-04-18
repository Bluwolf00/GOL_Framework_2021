//	[MortarName, side, "Firing Mode", "round type", ["position", inaccuracy], minimum range, maximum range, ammo] execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf";
////////////
//	
//	1. MortarName
//		a. The mortar itself (this - can be used if in the init of a static weapon).
//		b. if you want an Off-map, (no physical mortar) one shot strike, type "OffMap".
//	2. Side, the side you want the mortar to be assigned to (BLUFOR/WEST,OPFOR/EAST,INDEPENDENT). (if off-map, just select any side).
//	3. "Firing Mode", What type of firing mode the Mortar will be assigned.
//		a. "Sporadic", This means it will shoot fairly random (just very inaccurate rounds) rounds at a position (medium refire rate).
//		b. "Precise", This means it will make precise shots at a position (slow refire rate).
//		c. "Barrage", This means it will make a fairly accurate barrage of mortars at a position (very fast refire rate).
//		d. "Guided", This means the first shot is likely to be inaccurate, but each shot afterwards will be more accurate and when on target, the remaining rounds will be fired rapidly.
//		e. "Screen", this means the mortar will fire mortars in a line in rapid succession. Best used as an off-map smoke screen. 
//			NOTE: It will use the markers direction for the line, if no marker it will select a random direction.
//			NOTE: It will also override inaccuracy parameter.
//		f. "Random", This means it will randomly select any of the above firing modes, once finished, it will randomly select a new one.
//	4. "Round Type", what type of rounds predefined in NEKY_Settings.sqf. "Light", "Medium", "Heavy", "Smoke", "Flare" available.
//	5. ["Position", Inaccuracy] The target position where mortars will hit and the inaccuracy of each round.
//		a. "Position" can be [X,Y,Z] or a marker name.
//		b. By typing "Auto" instead of a marker or position, you will let the unit itself choose a target.
//		c. Inaccuracy, how inaccurate the rounds will be, in meters.
//	6. Minimum Range, The minimum range of the Mortar. Ignore this if 5b is not set to "Auto".
//	7. Maximum Range, The maximum range of the Mortar. Ignore this if 5b is not set to "Auto".
//	8. Ammo, the total ammo the mortar can spend. This will override the _Ammo in settings.sqf for this specific mortar. 
//	9. Look in to NEKY_Settings to tweak settings to your taste.
//
//////////
//	Usage
//////////
//
//	For manned mortar:
//	Place a static mortar and enter this code in the init of the mortar (see examples). Code must start with: 
//	Null = PUTCODEHERE
//	Manned mortars that are set to "Auto" will continuously repeat the script until dead or unit has left the mortar.
//	
//	For off-map mortar/artillery:
//	By script or Trigger.
//	If trigger, enter a condition of your liking and then place the code in Activation. remember, start with: Null =	
//	Off-map will only run the script once.
//	
/////////////
//	Examples
/////////////
//	
//	null = [this, east, "random", "light", ["auto", 50],150,400,300] execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf";
//	null = [Mortar1, west, "Barrage", "Medium", ["auto", 30],100,500,20] execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf";
//	null = ["OffMap", west, "Precise", "light", ["marker_position", 75]] execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf";	
//	
///////////////////////
//	Made By NeKo-ArroW
//	Version 1.11
///////////////////////

Private ["_Ammo","_EnableMarking","_Dir","_ScreenSize","_NewInaccuracy","_ScreenReloadTime","_TempPos","_Roll","_GuidedSize","_GuidedReloadTime","_GuidedInaccuracyMultiplier""_SoundOn","_In","_Sound","_SoundTypes","_Marking","_FriendlyNear","_Danger","_DangerClose","_SelectedFiringMode","_SporadicReloadTime","_PreciseReloadTime","_BarrageReloadTime","_Units","_Scanner","_Gunner","_MinRange","_MaxRange","_Zone","_Unit","_Lock","_Group","_Avoid","_OffMap","_RandomFiringMode","_Temp","_This","_Side","_Position","_FiringMode","_BarrageSize","_PreciseSize","_SporadicSize","_Light","_Medium","_Heavy","_Smoke","_Flare","_TravelTime","_MarkSmoke","_MarkFlare","_RandomFiringMode","_Duration"];

if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

#include "NEKY_Settings.sqf"

_Mortar = [_this, 0, objNull, [ObjNull,""]] call BIS_FNC_Param;
_Side = [_this, 1, sideUnknown, [SideUnknown]] call BIS_FNC_Param;
_FiringMode = toLower ([_this, 2, "random", [""]] call BIS_FNC_Param);
_MortarType = toLower ([_this, 3, "", [""]] call BIS_FNC_Param);
_Position = [_this, 4, [], [[]]] call BIS_FNC_Param;
_MinRange = [_This, 5, 0, [0]] call BIS_FNC_Param;
_MaxRange = [_This, 6, 100, [0]] call BIS_FNC_Param;
_Ammo = [_this, 7, _Ammo, [0]] call BIS_FNC_Param;
_Inaccuracy = (_Position select 1);
_EnableMarking = True;

if (typeName _Mortar == "OBJECT") then {sleep 10};
	SystemChat "NEKY_Mortars.sqf running.";

// Check if AUTO or designated location
if (typeName (_Position select 0) == "STRING") then 
{
	_Temp = ToLower (_Position select 0);
	if (_Temp == "auto") then 
	{
		_Scanner = True;
	} else {
		_Units = [];
		_FriendlyNear = False;
		_Scanner = False;
		_Dir = MarkerDir _Temp;
		_Position = getMarkerPos _Temp;
	};
} else {
	_Position = (_Position select 0);
	_Units = [];
	_FriendlyNear = False;
	_Scanner = False;
};

// Define Mortar Type
Switch (_MortarType) do
{
	Private ["_SoundOn","_Sound"];
	case "light":
	{
		_MortarType = _Light;
		_Sound = (_SoundTypes select 0);
		_SoundOn = (_SoundOn select 0);
	};
	
	case "medium":
	{
		_MortarType = _Medium;
		_Sound = (_SoundTypes select 1);
		_SoundOn = (_SoundOn select 1);
	};
	
	case "heavy":
	{
		_MortarType = _Heavy;
		_Sound = (_SoundTypes select 2);
		_SoundOn = (_SoundOn select 2);
	};
	
	case "smoke":
	{
		_MortarType = _Smoke;
		_Sound = (_SoundTypes select 3);
		_SoundOn = (_SoundOn select 3);
		_EnableMarking = False;
	};
	
	case "flare":
	{
		_MortarType = _Flare;
		_Sound = "A3\Sounds_F\weapons\Flare_Gun\flaregun_2_shoot.wss";
		_SoundOn = (_SoundOn select 4);
		_EnableMarking = False;
	};
};

NEKY_MortarAIReset = 
{
	Private ["_Unit","_This"];
	
	_Unit = (_This select 0);
	
	if (Alive _Unit) then
	{
		_Unit enableAI "MOVE";
		_Unit enableAI "AUTOTARGET";
		_Unit enableAI "FSM";
		UnassignVehicle _Unit;
		[_Unit] OrderGetIn False;
		_Unit setBehaviour "Combat";
		_Unit setCombatMode "RED";
		WaitUntil {sleep 30; !Alive _Unit};
		sleep 600;
		DeleteVehicle _Unit;
	};
};

// AI Spawn 
if ( (isNil "_Mortar") or (TypeName _Mortar == "STRING") ) then 
{
	_OffMap = True;
	_Scanner = False;
	_FriendlyNear = False;
	_Unit = ObjNull;
	_Mortar = ObjNull; 
} else {
	if (Alive _Mortar) then 
	{
		if (_Mortar EmptyPositions "Gunner" > 0) then
		{
			// Define side
			Switch (_Side) do
			{
				Private "_Gunner";
				case blufor: {_Gunner = _BLUFORGunner};
				case opfor:  {_Gunner = _OPFORGunner};
				case independent: {_Gunner = _INDEPGunner};
				default {SystemChat "Invalid side"};
			};
			
			systemChat "Spawning Gunner.";
			_Group = CreateGroup _Side;
			_Unit = _Group createUnit [(_Gunner call BIS_FNC_SelectRandom), [0,0,200], [], 0, "NONE"];
			if !(isNil "EnemyCustom") then {if (EnemyCustom) then {[_Unit,"random"] execVM "Gear\AI\Gearhandler.sqf"} }; // NEKY_VanillaTemplate related code.
			_Unit assignAsGunner _Mortar;
			[_Unit] orderGetIn True;
			_Unit MoveInGunner _Mortar;
			_Unit DisableAI "TARGET";
			_Unit DisableAI "AUTOTARGET";
			_Unit DisableAI "FSM";
	
			// Remove eventHandler when AI gunner dies.
			[_Mortar,_Unit] spawn 
			{
				_Mortar = (_This select 0);
				_Unit = (_This select 1);
		
				_Temp = _Mortar addEventHandler ["Fired", {(_This select 6) SetPosATL [0,0,10000]; deleteVehicle (_This select 6)}]; 
				WaitUntil {sleep 20; !(_Unit in _Mortar) or !(Alive _Unit)};
				UnassignVehicle _Unit;
				_Mortar removeEventHandler ["Fired", _Temp];
			};				
			sleep 1;
	
			// Lock mortar if unit dies or disembarks
			if (_Lock) then
			{
				[_Mortar, _Unit] spawn
				{
					Private ["_Mortar","_Unit"];
					_Mortar = (_This select 0);
					_Unit = (_This select 1);
			
					WaitUntil {sleep 20; !(Alive _Unit) or !(_Unit in _Mortar)};
			
					if (Alive _Mortar) then
					{
						[[[_Mortar],{(_This select 0) SetVehicleLock "LOCKED"; (_This select 0) setVehicleAmmo 0;}], "BIS_FNC_SPAWN", true] call BIS_FNC_MP;
						SystemChat "Mortar locked";
					};
					sleep 20;
				};
			};
	
			// Disembark if enemies are close
			if (_Danger) then 
			{
				[_Unit, _DangerClose] spawn
				{
					Private ["_Unit","_Zone","_DangerClose","_x"];
			
					_Unit = (_This select 0);
					_DangerClose = (_This select 1);
					
					// Scan nearby area
					WaitUntil { sleep 5; !(Alive _Unit) or {!((side _x) == (side _Unit)) && ((side _Unit) GetFriend (side _x) < 0.6) && (_Unit distance _x <= _DangerClose) && (((getposATL _x) select 2) < 5)} count allUnits > 0};
					[_Unit] Call NEKY_MortarAIReset;					
				};
			};
		} else {
			_Unit = (Gunner _Mortar);
			_OffMap = False;
			SystemChat "Gunner position is taken";
		};
	} else {
		systemChat "Mortar is destroyed or non-existant"
	};
	_OffMap = False;
};

if ( !(_OffMap) && (isNil "_Unit") ) exitWith {SystemChat "Error while creating mortar gunner, script ends"};

NEKY_MortarMark = 
{
	Private ["_Daytime","_Temp","_SunRise","_SunSet","_Position"];
	
	_Position = _This select 0;	
	#include "NEKY_Settings.sqf"
	
	if ((dayTime > _Sunrise) and (dayTime < _Sunset)) then {_DayTime = True} else {_Daytime = False};

	if (_Daytime) then
	{
		_Temp = CreateVehicle [_MarkSmoke, [(_Position select 0), (_Position select 1), ((_Position select 2) + 100)], [], 20, "CAN_COLLIDE"];
		sleep 1;
		_Temp SetVelocity [0,0,-50];
	} else {
		_Temp = createVehicle [_MarkFlare, [(_Position select 0), (_Position select 1), ((_Position select 2) + 140)], [], 20, "CAN_COLLIDE"];
		_Temp setVelocity [0,0,-10];
		UIsleep 3.1;
		playSound3D ["A3\Sounds_F\weapons\Flare_Gun\flaregun_2_shoot.wss", _Flare, false, [(_Position select 0), (_Position select 1), (_Position select 2) + 140], 8, 1, 300];
	};					
};

NEKY_MortarAISequence = 
{
	Private ["_Mortar","_Unit","_Position","_Mag","_This"];
	
	_Mortar = (_This select 0);
	_Unit = (_This select 1);
	_Position = (_This select 2);
	_Mag = currentMagazine _Mortar;
	
	_Unit doWatch [(_Position select 0),(_Position select 1),((_Position select 2) + 1000)];
	_Mortar addMagazine _Mag;
	_Mortar Fire (CurrentWeapon _Mortar)
};

NEKY_MortarShell = 
{
	Private ["_TravelTime","_Position","_Inaccuracy","_MortarType","_SoundOn","_Sound","_Height","_FallSpeed","_Flare"];
	
	_Position = (_This select 0);
	_Inaccuracy = (_This select 1);
	_MortarType = (_This select 2);
	_Sound = (_This select 3);
	_SoundOn = (_This select 4);
	_TravelTime = (_This select 5);	
	_Flare = (_This select 6);
	
	if (_TravelTime > 2) then {	sleep (_TravelTime - 2) };
	_Pos = CreateVehicle ["Land_HelipadEmpty_F", [(_Position select 0), (_Position select 1), ((_Position select 2) + 50)], [], _Inaccuracy, "CAN_COLLIDE"];
	
	if (_MortarType == _Flare) then 
	{
		_Height = 140; 
		_FallSpeed = -10;
		UIsleep 3.1;
		playSound3D [_Sound, _MortarType, false, [((getPosATL _Pos) select 0), ((getPosATL _Pos) select 1), ((GetPosATL _Pos) select 2) + _Height], 8, 1, 300];
	} else {
		_Height = 300;
		_FallSpeed = -400;
		if ((_SoundOn) && !(_Sound == "")) then {[[[_Pos,_Sound], { (_this select 0) say3D (_This select 1)}], "bis_fnc_call", true] call BIS_fnc_MP;};
	};
	
	sleep 2;
	_Temp = CreateVehicle [_MortarType, [((getPosATL _Pos) select 0), ((getPosATL _Pos) select 1), ((GetPosATL _Pos) select 2) + _Height], [], 0, "CAN_COLLIDE"];
	_Temp setVelocity [0,0,_FallSpeed];
	DeleteVehicle _Pos;
};

While {((Alive _Mortar) && (Alive _Unit) && (_Unit in _Mortar)) or (_OffMap)} do
{
	if (_Ammo < 1) ExitWith 
	{
		SystemChat "Mortar out of ammo, dismounting";
		[_Unit] call NEKY_MortarAIReset;
	};	
	
	// Random Selector
	if (_FiringMode == "random") then {_SelectedFiringMode = toLower (_RandomFiringMode call BIS_FNC_SelectRandom)} else {_SelectedFiringMode = _FiringMode};
	SystemChat Format ["Firing mode: %1",_SelectedFiringMode];
	
	// Inaccuracy definer
	Switch (_SelectedFiringMode) do
	{
		Private ["_NewInaccuracy"];
		case "sporadic":{_NewInaccuracy = (_Inaccuracy * _SporadicInaccuracyMultiplier)};
		case "barrage":	{_NewInaccuracy = (_Inaccuracy * _BarrageInaccuracyMultiplier)};
		case "guided":	{_NewInaccuracy = (_Inaccuracy * _GuidedInaccuracyMultiplier)};		
		default {_NewInaccuracy = _Inaccuracy};
	};

	//  Scanning
	if (_Scanner) then 
	{
		// Create Scan Zone
		_Zone = CreateTrigger ["EmptyDetector",(getPosATL _Mortar),false];
		_Zone SetTriggerActivation ["ANY", "PRESENT", False];
		_Zone SetTriggerArea [_MaxRange, _MaxRange, 0, false];
		
		sleep 1;
		
		SystemChat "Zone Scanning";	
		if (_ScanVehicles) then 
		{
			WaitUntil {sleep 5; { (!(Alive _Unit) or !(Alive _Mortar) or !(_Unit in _Mortar)) or (( (side _Unit) GetFriend (side _x) < 0.6) && (_Unit distance _x > _MinRange) && (_Unit distance _x < _MaxRange) && (((getposATL _x) select 2) < 5))} count (list _Zone) > 0};
		} else {
			WaitUntil {sleep 5; {(!(Alive _Unit) or !(Alive _Mortar) or !(_Unit in _Mortar)) or (( (side _Unit) GetFriend (side _x) < 0.6) && (_Unit distance _x > _MinRange) && (_Unit distance _x < _MaxRange) && (((getposATL _x) select 2) < 5) && (_x isKindOf "CAManBase"))} count (list _Zone) > 0};
		};
	
		SystemChat "Zone Activated";
		_Units = [];
		if (_ScanVehicles) then
		{
			{ if ( (((Side _Unit) knowsAbout _x) > 3.95) && !((side _x) isEqualTo (side _Unit)) && ((side _Unit) GetFriend (side _x) < 0.6) && (_Unit distance _x > _MinRange) && (_Unit distance _x < _MaxRange) && (Alive _x) && (((getposATL _x) select 2) < 5) ) then {_Units PushBack _x}; } ForEach (list _Zone);
		} else {
			{ if ( (((Side _Unit) knowsAbout _x) > 3.95) && !((side _x) isEqualTo (side _Unit)) && ((side _Unit) GetFriend (side _x) < 0.6) && (_Unit distance _x > _MinRange) && (_Unit distance _x < _MaxRange) && (_x isKindOf "CAManBase") && (Alive _x) && (((getposATL _x) select 2) < 5) ) then {_Units PushBack _x}; } ForEach (list _Zone);
		};
		
		sleep 0.5;
		if (Count _Units isEqualTo 0) exitWith {False; _FriendlyNear = False};
		_Position = GetPosATL (_Units call BIS_FNC_SelectRandom);
		if ( (_Avoid) && ( {((side _x isEqualTo side _Unit)) && (_Unit distance _x > _MinRange) && (_Unit distance _x < _MaxRange) && ((side _Unit) getFriend (side _x) > 0.6) && ((_Position distance _x) < (_NewInaccuracy)) && (Alive _x) } count (list _Zone) > 0) ) then {_FriendlyNear = True} else {_FriendlyNear = False};
	};
	
	if ((!(_FriendlyNear) && !(Count _Units isEqualTo 0)) or ((_OffMap) or !(_Scanner))) then 
	{
		// Firing modes
		_Index = 0;
		_Roll = round (random 100);
		
		if !(_OffMap) then {_Unit doWatch [(_Position select 0), (_Position select 1), ((_Position select 2) + 1000)]};
	
		switch (_SelectedFiringMode) do
		{
			Private ["_Temp","_Count","_TempPos","_SleepGuided","_TempInaccuracy"];
			case "sporadic": 
			{
				_Count = _SporadicSize call BIS_FNC_SelectRandom;
				while {( !(_Index == _Count) && ((_OffMap) or ((Alive _Mortar) && (Alive _Unit) && (_Unit in _Mortar) && (_Ammo > 0))) )} do
				{
					if ((_Index == 0) && (_Marking select 0) && _EnableMarking) then 
					{
						[_Position] spawn NEKY_MortarMark;
						sleep (_TravelTime + 5);
					};
			
					if !(_OffMap) then 
					{
						[_Mortar, _Unit, _Position] Spawn NEKY_MortarAISequence;
					};
			
					[_Position, _NewInaccuracy, _MortarType, _Sound, _SoundOn, _TravelTime, _Flare] Spawn NEKY_MortarShell;
					_Index = _Index +1;
					_Ammo = _Ammo -1;
					if (_Index == _Count) then 
					{
						if ((_Scanner) && !(_OffMap)) then 
						{
							Sleep _SporadicReloadTime;
						};
					} else {
						sleep 8;
					};
				};
			};
	
			case "precise":
			{
				_Count = _PreciseSize call BIS_FNC_SelectRandom;
				while {( !(_Index == _Count) && ((_OffMap) or ((Alive _Mortar) && (Alive _Unit) && (_Unit in _Mortar) && (_Ammo > 0))) )} do
				{
					if ((_Index == 0) && (_Marking select 1) && _EnableMarking) then 
					{
						[_Position] spawn NEKY_MortarMark;
						sleep (_TravelTime + 5);
					};
			
					if !(_OffMap) then 
					{
						[_Mortar, _Unit, _Position] Spawn NEKY_MortarAISequence;
					};
			
					[_Position, _NewInaccuracy, _MortarType, _Sound, _SoundOn, _TravelTime, _Flare] Spawn NEKY_MortarShell;
					_Index = _Index +1;
					_Ammo = _Ammo -1;
					if (_Index == _Count) then 
					{
						if ((_Scanner) && !(_OffMap)) then 
						{
							Sleep _PreciseReloadTime;
						};
					} else {
						sleep 11;
					};
				};
			};
	
			case "barrage":
			{
				_Count = _BarrageSize call BIS_FNC_SelectRandom;
				while {( !(_Index == _Count) && ((_OffMap) or ((Alive _Mortar) && (Alive _Unit) && (_Unit in _Mortar) && (_Ammo > 0))) )} do
				{
					if ((_Index == 0) && (_Marking select 2) && _EnableMarking) then 
					{
						[_Position] spawn NEKY_MortarMark;
						sleep (_TravelTime + 5);
					};
			
					if !(_OffMap) then 
					{
						[_Mortar, _Unit, _Position] Spawn NEKY_MortarAISequence;
					};
			
					[_Position, _NewInaccuracy, _MortarType, _Sound, _SoundOn, _TravelTime, _Flare] Spawn NEKY_MortarShell;
					
					_Index = _Index +1;
					_Ammo = _Ammo -1;
					if (_Index == _Count) then 
					{
						if ((_Scanner) && !(_OffMap)) then 	
						{
							Sleep _BarrageReloadTime;
						};
					} else {
						sleep 4;
					};
				};
			};
	
			case "guided":
			{
				_Count = _GuidedSize call BIS_FNC_SelectRandom;
				_SleepGuided = (_TravelTime +5);
				while {( !(_Index == _Count) && ((_OffMap) or ((Alive _Mortar) && (Alive _Unit) && (_Unit in _Mortar) && (_Ammo > 0))) )} do
				{
					if ((_Index == 0) && (_Marking select 3) && _EnableMarking) then 
					{
						[_Position] spawn NEKY_MortarMark;
						sleep (_TravelTime + 5);
					};
			
					if !(_OffMap) then 
					{
						[_Mortar, _Unit, _Position] Spawn NEKY_MortarAISequence;
					};
			
					if (_Index == 0) then 
					{
						if (_Roll > 30) then
						{
							_Temp = CreateVehicle ["Land_HelipadEmpty_F", [(_Position select 0), (_Position select 1), (_Position select 2)], [], _NewInaccuracy, "CAN_COLLIDE"];
							_TempPos = GetPosATL _Temp;
							deleteVehicle _Temp;
							while {((_TempPos distance _Position) < 20)} do
							{
								_Temp = CreateVehicle ["Land_HelipadEmpty_F", [(_Position select 0), (_Position select 1), (_Position select 2)], [], _NewInaccuracy, "CAN_COLLIDE"];
								_TempPos = GetPosATL _Temp;
								deleteVehicle _Temp;
								sleep 0.1;
							};
						} else {
							_Temp = CreateVehicle ["Land_HelipadEmpty_F", [(_Position select 0), (_Position select 1), (_Position select 2)], [], _NewInaccuracy, "CAN_COLLIDE"];
							_TempPos = GetPosATL _Temp;
						};
					};
			
					if ((_Index > 0) && (_TempPos distance _Position > 20)) then 
					{
						_TempInaccuracy = ((_TempPos distance _Position) - 15);
						_TempPos = CreateVehicle ["Land_HelipadEmpty_F", [(_Position select 0), (_Position select 1), (_Position select 2)], [], _TempInaccuracy, "CAN_COLLIDE"];
						_TempPos = GetPosATL _TempPos;
					};

					if (_TempPos distance _Position < 20) then
					{
						[_Position, 20, _MortarType, _Sound, _SoundOn, _TravelTime, _Flare] Spawn NEKY_MortarShell;
					} else {
						[_TempPos, 0, _MortarType, _Sound, _SoundOn, _TravelTime, _Flare] Spawn NEKY_MortarShell;
					};
			
					_Index = _Index +1;
					_Ammo = _Ammo -1;
					if (_Index == _Count) then 
					{
						if ((_Scanner) && !(_OffMap)) then 	
						{
							Sleep _GuidedReloadTime;
						};
					} else {
						sleep _SleepGuided;
						if ( ((_TempPos distance _Position) < 20) && (_SleepGuided > 3) ) then {_SleepGuided = 3};
					};
				};
			};
	
			case "screen":
			{
				_Count = _ScreenSize call BIS_FNC_SelectRandom;
				if (isNil "_Dir") then {_Dir = round (random 360)};
				_TempPos = _Position;
				while {( !(_Index == _Count) && ((_OffMap) or ((Alive _Mortar) && (Alive _Unit) && (_Unit in _Mortar) && (_Ammo > 0))) )} do
				{
					if ((_Index == 0) && (_Marking select 4) && _EnableMarking) then 
					{
						[_TempPos] spawn NEKY_MortarMark;
						sleep (_TravelTime + 5);
					};
			
					if !(_OffMap) then 
					{
						[_Mortar, _Unit, _TempPos] Spawn NEKY_MortarAISequence;
					};
			
					[_TempPos, 5, _MortarType, _Sound, _SoundOn, _TravelTime, _Flare] Spawn NEKY_MortarShell;
					
					_Index = _Index +1;
					_Ammo = _Ammo -1;
					if (_Index == _Count) then 
					{
						if ((_Scanner) && !(_OffMap)) then 	
						{
							Sleep _ScreenReloadTime;
						};
					} else {
						sleep 3;
						_TempPos = [_TempPos, 15, _Dir] call BIS_fnc_relPos;
					};
				};
			};
		};
		
	} else {
		SystemChat "Friendly too close or no hostiles known to mortar faction, rescanning"; 
		sleep 10;
	};
	if ((_OffMap) or !(_Scanner)) exitWith 
	{
		systemChat "Off map mode or not in auto mode, exiting script"
	};
	DeleteVehicle _Zone;
};
	SystemChat "script ending.";