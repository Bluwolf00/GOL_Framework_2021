//	
//	
//	This handles adding addactions to vehicles entering the Service Station
//	
//	Made by NeKo-ArroW

Params ["_Veh"];

_Veh addAction ["<t color='#FF8000'>NeKy's Service Station</t>", {}, [], 10, false, false, "", "((_Target getVariable ['NEKY_ServiceStation_InStation',[false]]) select 0) && ((isNull (objectParent player)) || (_target isEqualTo (objectParent player)))"];
_Veh addaction ["<t color='#F7FE2E'>Repair</t>", 
{
	Params ["_Veh"];
	_SS = (_Veh getVariable "NEKY_ServiceStation_InStation") select 1;
	_Params = [_Veh,_SS,False];
	if (_SS in NEKY_ServiceStationActive) then 
	{
		[] call NEKY_ServiceStation_Busy;
	} else {
		_Params spawn NEKY_ServiceStation_Repair;
		[_SS] Spawn NEKY_ServiceStation_Lights;
	};
}, [], 10, false, true, "", "((_Target getVariable ['NEKY_ServiceStation_InStation',[false]]) select 0) && ((isNull (objectParent player)) || (_target isEqualTo (objectParent player)))"];

_Veh addaction ["<t color='#F7FE2E'>Refuel</t>", 
{
	Params ["_Veh"];
	_SS = (_Veh getVariable "NEKY_ServiceStation_InStation") select 1;
	_Params = [_Veh,_SS,False];
	if (_SS in NEKY_ServiceStationActive) then 
	{
		call NEKY_ServiceStation_Busy;
	} else {
		_Params spawn NEKY_ServiceStation_Refuel; 
		[_SS] Spawn NEKY_ServiceStation_Lights;
	};
}, [], 10, false, true, "", "((_Target getVariable ['NEKY_ServiceStation_InStation',[false]]) select 0) && ((isNull (objectParent player)) || (_target isEqualTo (objectParent player)))"];
	
_Veh addaction ["<t color='#F7FE2E'>Rearm</t>",
{
	Params ["_Veh"];
	_SS = (_Veh getVariable "NEKY_ServiceStation_InStation") select 1;
	_Params = [_Veh,_SS,false];
	if (_SS in NEKY_ServiceStationActive) then 
	{
		call NEKY_ServiceStation_Busy;
	} else {
		_Params spawn NEKY_ServiceStation_Rearm;
		[_SS] Spawn NEKY_ServiceStation_Lights;
	};
}, [], 10, false, true, "", "((_Target getVariable ['NEKY_ServiceStation_InStation',[false]]) select 0) && ((isNull (objectParent player)) || (_target isEqualTo (objectParent player)))"];
	
_Veh addaction ["<t color='#F7FE2E'>Full Service</t>", 
{
	Params ["_Veh"];
	_SS = (_Veh getVariable "NEKY_ServiceStation_InStation") select 1;
	_Params = [_Veh,_SS];
	if (_SS in NEKY_ServiceStationActive) then 
	{
		call NEKY_ServiceStation_Busy;
	} else {
		_Params spawn NEKY_ServiceStation_FullService; 
		[_SS] Spawn NEKY_ServiceStation_Lights;
	};
}, [], 10, false, true, "", "((_Target getVariable ['NEKY_ServiceStation_InStation',[false]]) select 0) && ((isNull (objectParent player)) || (_target isEqualTo (objectParent player)))"];
_Veh addAction ["<t color='#FF8000'>NeKy's Service Station</t>", {}, [], 10, false, false, "", "((_Target getVariable ['NEKY_ServiceStation_InStation',[false]]) select 0) && ((isNull (objectParent player)) || (_target isEqualTo (objectParent player)))"];