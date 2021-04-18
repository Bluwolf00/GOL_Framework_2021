//	[Side, Number of Units, ["Leader classes"], ["Unit classes"], [Position]] Spawn NEKY_Hunt_Spawn;
//	
//	This handles spawning the group
//	
//	Returns: AI Group
//	
//	Made by NeKo-ArroW

Params ["_Side","_Number","_Leaders","_Units","_Pos"];

_Grp = CreateGroup _Side;
_Leader = _Grp CreateUnit [(selectRandom _Leaders), [0,0,0], [], 10, "NONE"];
_Leader SetRank "Sergeant";
_Pos = [_Pos, 0, 75, 0, 0, 0.5, 0, nil, [_Pos,_Pos]] call BIS_fnc_findSafePos;
_Leader setPos _Pos;

For "_i" from 2 to _Number step 1 do
{
	_Unit = _Grp createUnit [(SelectRandom _Units), _Leader, [], 10, "NONE"];
	_Unit setRank "PRIVATE";
};

// NEKY Framework related
if !(isNil "FRAMEWORK_Gear_Run") then
{
	{
		[_x, (SelectRandom FRAMEWORK_AI_PresenceRolesDefined)] spawn FRAMEWORK_Gear_Run;
	} forEach (Units _Grp);
};

_Grp AllowFleeing 0;

// Returns
_Grp;