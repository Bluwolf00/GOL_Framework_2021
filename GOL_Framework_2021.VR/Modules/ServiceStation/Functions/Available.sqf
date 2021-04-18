//	
//	
//	
//	
//	

Params ["_SS","_Variable"];

NEKY_ServiceStationActive DeleteAt (NEKY_ServiceStationActive find _SS); 
PublicVariable "NEKY_ServiceStationActive"; 
if (_Variable) then {Hint "You have left the Service station, service ending."};