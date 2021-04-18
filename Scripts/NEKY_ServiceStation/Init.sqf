//	[] execVM "Scripts\NEKY_ServiceStation\Init.sqf";
//	
//	Defines all neccessary functions
//	
//	This has to be executed for all players + server during init.
//	
//	Made by NeKo-ArroW

// Variables
NEKY_ServiceStationActive = [];

// Functions
NEKY_ServiceStation_Repair = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Repair.sqf";
NEKY_ServiceStation_Refuel = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Refuel.sqf";
NEKY_ServiceStation_Rearm = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Rearm.sqf";
NEKY_ServiceStation_ExitLoop = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\ExitLoop.sqf";
NEKY_ServiceStation_FullService = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\FullService.sqf";
NEKY_ServiceStation_Hints = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Hints.sqf";
NEKY_ServiceStation_Busy = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Busy.sqf";
NEKY_ServiceStation_Actions = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\AddActions.sqf";
NEKY_ServiceStation_Lights = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Lights.sqf";
NEKY_ServiceStation_Available = CompileFinal PreprocessFileLineNumbers "Scripts\NEKY_ServiceStation\Functions\Available.sqf";