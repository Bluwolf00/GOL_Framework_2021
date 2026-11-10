//	[Group, Side] call NEKY_AI_ShareInfo;
//	
//	1. Group
//	  a) If you enter a group, that group will be applied the "Share Info" function. It will share info with other AI of the same side.
//	  b) If you enter TRUE this function will apply this function to all AI units currently in the mission (After a 10sec delay). This is usually for mission start to add all editor placed units.
//	  c) If you enter FALSE this function will remove the function from AI present in the mission.
//	  d) Defaults to GrpNull, aka does nothing.
//	2. Side
//	  a) This parameter selects what sides you want to effect.
//	  b) True = BLUFOR, OPFOR and INDEPENDENT sides.
//	  c) Specific side selected by typing BLUFOR, OPFOR or INDEPENDENT.
//	  d) Does nothing if a Param 1 is a group.
//	3. Loop
//	  a) This parameter makes the last setting loop.
//	  b) True = Loop every 30 seconds with the same parameters.
//	
//	This function makes AI share information between other squads to make AI feel more responsive and less derpy.
//	
//	Made by NeKo-ArroW
//	Version 0.96

if (!isServer && HasInterface) exitWith {};	// Exit everyone but HC and Server.

Private ["_Code","_Groups"];

Params 
[
	["_Group", GrpNull, [GrpNull, True]],
	["_Side", False, [True, SideUnknown]],
	["_Loop", False, [True]]
];

// Exits
if (_Group isEqualTo GrpNull) exitWith {SystemChat "ERROR: NEKY_CombatExperience_AI_ShareInfo - No group selected."};

if (Time < 10) then {Sleep 10};

#include "..\Settings.sqf";

// Select Groups
if (TypeName _Group == "BOOL") then
{
	if (_Group) then // Add EH to all units
	{
		_Sides = [[_Side], [BLUFOR, OPFOR, RESISTANCE]] select (TypeName _Side == "BOOL");
		_Groups = AllGroups select { ((Side _x) in _Sides) && ({ isPlayer _x } Count (Units _x) == 0) && ((Units _x#0) isKindOf "CAMANBase") && !(_x getVariable ["NEKY_AI_ShareInfo_Added",False]) };
		
		// Loop if set to apply to all + loop.
		if (_Loop) then 
		{
			Sleep 30;
			_This Spawn NEKY_AI_ShareInfo;
		};
	} else { // Remove EH from all units of specific side.
		_Sides = [[_Side], [BLUFOR, OPFOR, RESISTANCE]] select (TypeName _Side == "BOOL");
		_Groups = AllGroups select { ((Side _x) in _Sides) && ({ isPlayer _x } count (Units _x) == 0) && ((Units _x#0) isKindOf "CAMANBase") && (_x getVariable ["NEKY_AI_ShareInfo_Added",False]) };
		_Code = 
		{
			_This#0 setVariable ["NEKY_AI_ShareInfo_Added",False,True];
			_EH = _This#0 getVariable ["NEKY_AI_ShareInfo_EH",True];
			if (TypeName _EH == "NUMBER") then { _This#0 removeEventHandler ["FiredMan",_EH] };
			_This#0 setVariable ["NEKY_AI_ShareInfo_EH",nil,True];
		};
	};
} else { _Groups = [_Group] };

if (isNil "_Code") then 
{
	_Code = 
	{
		_EH = _This#0 addEventHandler ["FiredMan",
		{
			Params ["_Unit"];
			_Group = Group _Unit;
			
			// Exit
			if (_Group getVariable ["NEKY_AI_ShareInfo_Reported",false]) exitWith {};
			
			// Set variables
			_Group setVariable ["NEKY_AI_ShareInfo_Reported",true,true];
			[_Group] spawn {Sleep (30+ (random 10)); _This#0 setVariable ["NEKY_AI_ShareInfo_Reported",false,true]};
			
			// Delay for unit to report in, unreal for unit to instantly send info.
			[_Group,_Unit] Spawn 
			{
				Params ["_Group","_Unit"];
				Sleep (4 + (Random 4));
				
				if !(Alive _Unit) exitWith { _Group setVariable ["NEKY_AI_ShareInfo_Reported",False,true] };
				
				#include "..\Settings.sqf";
				
				// Define variables
				_MinScanRange = 1000;
				_UseMinRange = _MinScanRange > NEKY_AI_ShareRange;
				_Side = Side _Group;
				_Sides = [WEST,EAST,RESISTANCE] - [_Side];
				_FriendlySides = [_Side];
				{ if ((_Side getFriend _x) >= 0.6) then {_FriendlySides pushBack _x} } forEach _Sides;
				
				// Define units nearby
				_Near = _Unit nearEntities [["MAN","LANDVEHICLE","AIR"], (_MinScanRange Max NEKY_AI_ShareRange)];
				_NearFriendlies = (_Near select { ((Side _x) in _FriendlySides) && ((_x distance2D _Unit) <= NEKY_AI_ShareRange) });
				_NearFriendlies = if ((Count _ShareTo) == 0) then { _NearFriendlies } else { _NearFriendlies select { _Temp = _x; ((_ShareTo findIF {_Temp isKindOf _x}) != -1) } };
				if (Count _NearFriendlies == 0) exitWith { };
				
				_NearFriendliesGroups = [];
				{ _NearFriendliesGroups pushBackUnique (Group _x) } forEach _NearFriendlies;
				
				_NearEnemies = _Near select { !((Side _x) in _FriendlySides) && (_Group knowsAbout _x) > 0.5};
				if (Count _NearEnemies == 0) exitWith { };
				
				_NearEnemies = _NearEnemies Apply { [_x, _Group knowsAbout _x] };
				
				// Report all known enemies to friendlies.
				{ 
					_FriendlyGroup = _x;
					{
						_Quality = LinearConversion [0, NEKY_AI_ShareRange, ((Units _FriendlyGroup#0) distance2D _Unit), (_x#1 * NEKY_AI_ShareQuality#1), NEKY_AI_ShareQuality#0, false];
						_FriendlyGroup Reveal [_x#0, _Quality];
					} forEach _NearEnemies;		// _x == ["_Enemy","_Knowledge"] No need for if, can't downrate knowledge, it only takes more perf to if (knowsmore) then... than to just do it.
				} forEach _NearFriendliesGroups;
			};
		}];
		_This#0 setVariable ["NEKY_AI_ShareInfo_EH",_EH,true];
	};
};

// Set Variables, add EH
{
	_Group = _x;
	_Group setVariable ["NEKY_AI_ShareInfo_Added",True,True];
	_Units = Units _x;
	{
		[[_x],_Code] remoteExec ["BIS_FNC_CALL",_x];
	} forEach _Units;
} forEach _Groups;