//	[Vehicle, ServiceStation, FullService] Spawn NEKY_ServiceStation_Repair;
//	
//	This handles repairing a vehicle
//	
//	Made by NeKo-ArroW

Private ["_Veh","_SS","_FullService","_InspectionSpeed","_RepairingSpeed","_RepairingTrackSpeed","_RepairSpeed","_RemoveWheelSpeed","_MountWheelSpeed","_Wheels","_Tracks","_PartHP","_MsgIndex","_Msg" ];
#include "..\Settings.sqf"

Params ["_Veh","_SS","_FullService"];
if !(_FullService) then {NEKY_ServiceStationActive PushBack _SS; PublicVariable "NEKY_ServiceStationActive"};

ScopeName "Main";
_Veh engineOn False;
["Inspecting Vehicle.", _Veh] spawn NEKY_ServiceStation_Hints;

// Get Vehicle Hit Points
_Temp = getAllHitPointsDamage _Veh;
_AllHitPoints = _Temp select 0;
_AllHitPointsName = _Temp select 1;
_AllHitPointsValue = _Temp select 2;

// Filter Hit Points
// _AllHitPoints Resize (_AllHitPoints find "");  // removes Gun and Turret on the Kuma.
_HitPoints = [];
_Temp = [];
// _AllHitPoints Apply { if ((_x find "Glass") isEqualTo -1) then {_HitPoints pushBack _x}; Sleep _InspectionSpeed};  // Scan for every part save Glass and FFV
_List = ["HitAvionics","HitEngine","HitEngine2","HitFuel","HitHull","HitLAileron","HitLCElevator","HitLCRudder","HitRAileron","HitRElevator","HitRRudder","HitBody","HitLBWheel","HitLF2Wheel","HitLFWheel","HitLMWheel","HitRBWheel","HitRF2Wheel","HitRFWheel","HitRMWheel","HitLTrack","HitRTrack","HitGun","HitTurret","HitFuel2","HitVRotor","HitHRotor"];
_AllHitPoints Apply { if ((_x in _List) && !(_x in _HitPoints)) then {_HitPoints pushBack _x}; Sleep _InspectionSpeed};  // Scan for specific parts
{ _Temp PushBack (_AllHitPoints find _x) } forEach _HitPoints;
_DamagePoints = [];
{ _DamagePoints pushBack (_AllHitPointsValue select _x) } forEach _Temp;

// Remove non-damaged parts
for "_i" from ((count _HitPoints) -1) to 0 step -1 do
{
	if ((_DamagePoints select _i) < 0.05) then { { _x deleteAt _i } forEach [_DamagePoints,_HitPoints] };
};

if !((Count _DamagePoints) isEqualTo 0) then
{
	// Filter Wheels
	_Wheels = [];
	if (_Veh isKindOf "CAR") then
	{
		For "_i" from ((Count _DamagePoints) -1) to 0 step -1 do
		{
			if !(((_HitPoints select _i) find "Wheel") isEqualTo -1) then
			{
				_Wheels pushBack [(_HitPoints select _i),(_DamagePoints select _i)];
				_DamagePoints deleteAt _i;
				_HitPoints deleteAt _i;
			};
		};
	};

	// Repairing
	for "_i" from 0 to ((count _DamagePoints) -1) do
	{
		if (!(_Veh in NEKY_ServiceStationArray)) Then {BreakTo "Main"};
		_Part = (_HitPoints select _i);
		_PartHP = (_DamagePoints select _i);
		_Temp = toArray (Format ["%1",_Part]);
		_Temp deleteRange [0,3];
		_Temp = ToString _Temp;
		_PartName = toUpper _Temp;
		if ((_Part find "Track") isEqualTo -1) then {_RepairSpeed = _RepairingSpeed} else {_RepairSpeed = _RepairingTrackSpeed};
		
		if (_PartHP >= 0.01) then
		{
			_MsgIndex = 0;
			While {_PartHP > 0.01 && (_Veh in NEKY_ServiceStationArray)} do
			{
				["Repairing", _Veh, true, _MsgIndex] spawn NEKY_ServiceStation_Hints;
				if (!(_Veh in NEKY_ServiceStationArray)) then {BreakTo "Main"};
				[[_Veh, _Part, _PartHP, _RepairSpeed],{(_This select 0) setHitPointDamage [(_This select 1), ((_This select 2) - (_This select 3))]}] remoteExec ["BIS_FNC_SPAWN",Owner (_Veh)];
				_PartHP = _Veh getHitPointDamage _Part;
				if (_MsgIndex isEqualTo 2) then {_MsgIndex = 0} else {_MsgIndex = _MsgIndex +1};
				sleep 1;
			};
			[(format ["%1 has been repaired.",_PartName]), _Veh] spawn NEKY_ServiceStation_Hints;
			sleep 2;
		};
	};

	//	Fixing Wheels
	if !((Count _Wheels) isEqualTo 0) then 
	{
		if !(_Veh in NEKY_ServiceStationArray) Then {BreakTo "Main"};
		
		For "_i" from 0 to ((Count _Wheels) -1) step 1 do
		{
			_WheelArray = _Wheels select _i;
			_Wheel = _WheelArray select 0;
			_Damage = _WheelArray select 1;
			if (_Damage > 0.25) then
			{
				["Removing damaged wheel.", _Veh] spawn NEKY_ServiceStation_Hints;
				Sleep _RemoveWheelSpeed;
				
				if !(_Veh in NEKY_ServiceStationArray) Then {BreakTo "Main"};
				[[_Veh,_Wheel],{(_This select 0) setHitPointDamage [(_This select 1), 1]}] remoteExec ["BIS_FNC_SPAWN",Owner _Veh];
				["Mounting new wheel.", _Veh] spawn NEKY_ServiceStation_Hints;
				Sleep _MountWheelSpeed;
				
				if !(_Veh in NEKY_ServiceStationArray) Then {BreakTo "Main"};
				[[_Veh,_Wheel],{(_This select 0) setHitPointDamage [(_This select 1), 0]}] remoteExec ["BIS_FNC_SPAWN",Owner _Veh];
			} else {
				["Repairing Wheel.", _Veh] spawn NEKY_ServiceStation_Hints;
				Sleep _MountWheelSpeed;
				
				if !(_Veh in NEKY_ServiceStationArray) Then {BreakTo "Main"};
				[[_Veh,_Wheel],{(_This select 0) setHitPointDamage [(_This select 1), 0]}] remoteExec ["BIS_FNC_SPAWN",Owner _Veh];
			};
			Sleep 1;
		};
	};

	if (!(_Veh in NEKY_ServiceStationArray)) Then {BreakTo "Main"};
	["Applying finishing Touches", _Veh] spawn NEKY_ServiceStation_Hints;
	sleep 5;

	_Veh setdamage 0;
	["Repairs Complete.", _Veh] spawn NEKY_ServiceStation_Hints;
	sleep 2;
} else {
	["Vehicle is not in need of repairs.", _Veh] spawn NEKY_ServiceStation_Hints;
	Sleep 2;
};
if (!(_Veh in NEKY_ServiceStationArray)) exitWith {[_SS,true] call NEKY_ServiceStation_Available; ["You have left the service station, service ending",_Veh] call NEKY_ServiceStation_Hints};
if (((driver _Veh) in _Veh) && (!_FullService)) then {_Veh engineOn True};
if !(_FullService) then {[_SS,false] call NEKY_ServiceStation_Available} else {[_Veh,_SS,True] call NEKY_ServiceStation_Refuel};