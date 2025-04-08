with uiNamespace do { 
	_display = (finddisplay 12); 

	RKAGMapTooltipGroup = _display ctrlCreate ["RscControlsGroup", 2300]; 
	RKAGMapTooltipGroup ctrlSetPosition [0, 0, 0.4625, 0.34]; 
	RKAGMapTooltipGroup ctrlCommit 0;  

	RKAGMapInfantryTooltipHeader = _display ctrlCreate ["RscStructuredText", 1100,RKAGMapTooltipGroup]; 
	RKAGMapInfantryTooltipHeader ctrlSetPosition [0.0125, 0.02, 0.4375, 0.04]; 
	RKAGMapInfantryTooltipHeader ctrlSetStructuredText parseText ("<t font='PuristaSemibold' valign='middle' size='1' shadow='0' align='center'>Infantry Intel</t>"); 
	RKAGMapInfantryTooltipHeader ctrlSetBackgroundColor [0.15,0.15,0.15,0.75]; 
	RKAGMapInfantryTooltipHeader ctrlCommit 0; 

	RKAGMapInfantryTooltipBody = _display ctrlCreate ["RscStructuredText", 1101,RKAGMapTooltipGroup]; 
	RKAGMapInfantryTooltipBody ctrlSetPosition [0.0125, 0.06, 0.4375, 0.1]; 
	RKAGMapInfantryTooltipBody ctrlSetBackgroundColor [0.05,0.05,0.05,0.75]; 
	RKAGMapInfantryTooltipBody ctrlCommit 0; 

	RKAGMapVehicleTooltipHeader = _display ctrlCreate ["RscStructuredText", 1102,RKAGMapTooltipGroup]; 
	RKAGMapVehicleTooltipHeader ctrlSetPosition [0.0125, 0.18, 0.4375, 0.04]; 
	RKAGMapVehicleTooltipHeader ctrlSetStructuredText parseText ("<t font='PuristaSemibold' valign='middle' size='1' shadow='0' align='center'>Vehicle Intel</t>"); 
	RKAGMapVehicleTooltipHeader ctrlSetBackgroundColor [0.15,0.15,0.15,0.75]; 
	RKAGMapVehicleTooltipHeader ctrlCommit 0; 

	RKAGMapVehicleTooltipBody = _display ctrlCreate ["RscStructuredText", 1103,RKAGMapTooltipGroup]; 
	RKAGMapVehicleTooltipBody ctrlSetPosition [0.0125, 0.22, 0.4375, 0.1]; 
	RKAGMapVehicleTooltipBody ctrlSetBackgroundColor [0.05,0.05,0.05,0.75]; 
	RKAGMapVehicleTooltipBody ctrlCommit 0; 
}; 
 
addMissionEventHandler ["EachFrame",
{ 
	with uiNamespace do  
	{ 
		RKAGMapTooltipGroup ctrlSetPosition [(getMousePosition select 0),(getMousePosition select 1)+0.05,0.4625, 0.34]; 
		RKAGMapTooltipGroup ctrlCommit 0; 
	}; 
}]; 
   