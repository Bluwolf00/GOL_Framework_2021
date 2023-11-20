//	[IdentifySpeed] Call NEKY_AI_LaserScan;
//	
//	1. IdentifySpeed.
//		a) How quickly AI will gain additional knowledge about the origin of the laser.
//	
//	This handles scanning AI to react to the laser pointer.
//	
//	Made by NeKo-ArroW
//	Version 1.0

Params ["_Speed"];

// Intersecting positions
_BegPos = positionCameraToWorld [0,0,0];
_BegPosASL = AGLTOASL _BegPos;
_EndPos = (_BegPos vectorAdd ((Player weaponDirection (currentWeapon Player)) vectorMultiply 100)); 
_EndPosASL = AGLTOASL _EndPos;

// Intersecting objects
_ins = lineIntersectsSurfaces [_BegPosASL, _EndPosASL, player, objNull, true, 1, "FIRE", "NONE"];
_ins select 0 params ["_OriginalPos"];
if (isNil "_OriginalPos") exitWith {False};
_Pos = ASLTOATL _OriginalPos;

// Area to scan for units
_Units = (_Pos NearEntities ["Man",20]) select {!isPlayer _x};

// Check each unit and reveal if able to see laser.
{
	if ((currentVisionMode _x) == 1) then // If using nightvision
	{
		if (((_x getRelDir _Pos) > 300) or ((_x getRelDir _Pos) < 60)) then // If looking in the general direction of the laser position
		{
			_Knowledge = _x knowsAbout Player;
			if (_Knowledge < 3.8) then
			{
				_Value = [1, _Knowledge + (4*_Speed)] select ((_Knowledge >= 1) && (_Speed != 0));
				[[_x,_Value,Player],
				{
					Params ["_Unit","_Value","_Player"];
					_Unit Reveal [_Player, _Value];
				}] remoteExec ["BIS_FNC_SPAWN",_x];
			};
		};
	};
} forEach _Units;