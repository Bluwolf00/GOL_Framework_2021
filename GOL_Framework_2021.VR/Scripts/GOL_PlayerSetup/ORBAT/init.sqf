/*
	[] execVM "Scripts\GOL_PlayerSetup\ORBAT\Init.sqf";
*/

OKS_Orbat_Setup = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\OKS_Orbat_Setup.sqf";
OKS_Orbat_SetGroupParams = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\OKS_Orbat_SetGroupParams.sqf";
OKS_Orbat_SetGroupInactive = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\OKS_Orbat_SetGroupInactive.sqf";
OKS_Orbat_Platoon = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_Platoon.sqf";
OKS_Orbat_Hammer = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_Hammer.sqf";
OKS_Orbat_1stSquad = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_1stSquad.sqf";
OKS_Orbat_2ndSquad = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_2ndSquad.sqf";
OKS_Orbat_1stSquad_Alpha = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_1stSquad_Alpha.sqf";
OKS_Orbat_2ndSquad_Alpha = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_2ndSquad_Alpha.sqf";
OKS_Orbat_1stSquad_Bravo = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_1stSquad_Bravo.sqf";
OKS_Orbat_2ndSquad_Bravo = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_2ndSquad_Bravo.sqf";
OKS_Orbat_Echo1 = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_Echo1.sqf";
OKS_Orbat_Echo2 = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_Echo2.sqf";
OKS_Orbat_Echo3 = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\ORBAT\Units\OKS_Orbat_Echo3.sqf";

while {!isNil "ORBAT_GROUP"} do
{
	[GOL_Composition] spawn OKS_Orbat_Setup;
	sleep 10;
};
