/*
	call OKS_CheckFrameworkObjects;

	- Updating Old Missions
	This code is not in the older template versions, if you haven't imported the files, you can instead copy paste the code below into the debug console and run it.
	It will return the missing objects into the return field, and will be copied to your clipboard.

*/
private _ReturnText = "This template is not missing any NEW template items."; 
_Return = []; 
 
_HasAacRearmBox = ({typeOf _X == "VirtualReammoBox_small_F"} count vehicles > 0); 
_HasAacRearmBoxArray = [_HasAacRearmBox,"AAC Rearm Box: "]; 
 
_HasAacRefuelCan = ({typeOf _X == "FlexibleTank_01_forest_F"} count vehicles > 0); 
_HasAacRefuelArray = [_HasAacRefuelCan,"AAC Refuel Can: "]; 
 
_HasAacServiceHelipad = ({typeOf _X == "Land_HelipadSquare_F"} count (allMissionObjects "ALL") > 0); 
_HasAacServiceHelipadArray = [_HasAacServiceHelipad,"AAC Service Helipad: "]; 
 
_HasTentMhq = ({vehicleVarName _X == "Tent_MHQ"} count (allMissionObjects "ALL") > 0); 
_HasTentMhqArray = [_HasTentMhq,"Tent MHQ: "]; 
 
_HasArsenalGL = ({vehicleVarName _X == "GOL_Arsenal_GL"} count allMissionObjects "ALL" > 0); 
_HasArsenalGLArray = [_HasArsenalGL,"GL Arsenal Logic: "]; 
 
_HasArsenalLMG = ({vehicleVarName _X == "GOL_Arsenal_LMG"} count allMissionObjects "ALL" > 0); 
_HasArsenalLMGArray = [_HasArsenalLMG,"LMG Arsenal Logic: "]; 
 
_HasHeadless = ({vehicleVarName _X in ["HC","HC2","HC3"]} count allMissionObjects "ALL" > 0); 
_HasHeadlessArray = [_HasHeadless,"Headless Clients: "]; 

_HasTeamResupply = ({typeOf _X == "Box_Syndicate_Ammo_F"} count vehicles > 0); 
_HasTeamResupplyArray = [_HasTeamResupply,"Team Resupply Box: "]; 

_HasDapsOptions = ({typeOf _X == "DAPS_Options"} count allMissionObjects "LOGIC" > 0); 
_HasDapsOptionsArray = [_HasDapsOptions,"DAPS Options: "]; 
 
{ 
    if((_X select 0) == false) then {
		_Return pushBack _X;
	} 
} foreach [
	_HasAacRearmBoxArray,_HasAacRefuelArray,_HasAacServiceHelipadArray,
	_HasTentMhqArray,_HasArsenalGLArray,_HasArsenalLMGArray,_HasHeadlessArray,
	_HasTeamResupplyArray,_HasDapsOptionsArray
]; 
 
if(_Return isNotEqualTo []) then { 
    _ReturnText = ""; 
    { 
        _ReturnText = _ReturnText + (_X select 1) + str(_x select 0) + " || "; 
    } foreach _Return; 

    _ReturnText = _ReturnText select [0, (count _ReturnText) - 3];
}; 

_ReturnText

