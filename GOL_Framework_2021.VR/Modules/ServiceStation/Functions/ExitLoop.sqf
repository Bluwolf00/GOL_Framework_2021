//	[Vehicle, ServiceStation, Radius] Spawn NEKY_ServiceStation_ExitLoop;
//	
//	This resets a service station
//	
//	Made by NeKo-ArroW

// Remove Actions when leaving station.
Params ["_Veh","_SS","_Radius"];

WaitUntil {Sleep 0.5; ( ((_Veh Distance _SS) > _Radius) or !(_SS in NEKY_ServiceStations) or !(Alive _Veh))};

_Veh setVariable ["NEKY_ServiceStation_MSS_Active",False,true];
_Veh setVariable ["NEKY_ServiceStation_InStation",[false],true];
NEKY_ServiceStationArray deleteAt (NEKY_ServiceStationArray find _Veh);
if (_SS in NEKY_ServiceStationActive) then {[_SS,false] call NEKY_ServiceStation_Available};
PublicVariable "NEKY_ServiceStationArray";