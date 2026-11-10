//	[Vehicle, ServiceStation, FullService] spawn NEKY_ServiceStation_Refuel;
//	
//	This handles refueling a vehicle
//	
//	Made by NeKo-ArroW

Private ["_Veh","_SS","_FullService","_Refueling","_Msg"];
#include "..\Settings.sqf"

Params ["_Veh","_SS","_FullService"];

if !(_FullService) then {NEKY_ServiceStationActive PushBack _SS; PublicVariable "NEKY_ServiceStationActive"};
ScopeName "Main";

if (fuel _Veh < 0.98) then
{
	_MsgIndex = 0;
	while {fuel _veh < 0.98} do
	{
		["Refueling", _Veh, true, _MsgIndex] spawn NEKY_ServiceStation_Hints;
		if (!(_Veh in NEKY_ServiceStationArray)) Then {BreakTo "Main"};
		_veh setfuel (fuel _veh + _Refueling);
		if (_MsgIndex isEqualTo 2) then {_MsgIndex = 0} else {_MsgIndex = _MsgIndex +1};
		sleep 1;
	};
	["Vehicle has been refueled.", _Veh] spawn NEKY_ServiceStation_Hints;
} else { ["Refueling not needed", _Veh] spawn NEKY_ServiceStation_Hints };
sleep 2;

if (!(_Veh in NEKY_ServiceStationArray)) exitWith {[_SS,true] call NEKY_ServiceStation_Available; ["You have left the service station, service ending",_Veh] call NEKY_ServiceStation_Hints};
if !(_FullService) then {[_SS,false] call NEKY_ServiceStation_Available} else {[_Veh,_SS,true] Spawn NEKY_ServiceStation_Rearm};