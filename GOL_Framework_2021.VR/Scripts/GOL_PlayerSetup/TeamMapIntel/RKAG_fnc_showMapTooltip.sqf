 params["_group","_vehicleCount","_footCount"]; 
 
with uiNamespace do  
{ 
	private _sideColor = ([side _group, false] call BIS_fnc_sideColor); 
	
	_sideColor set[3,0.75]; 
	RKAGMapInfantryTooltipHeader ctrlSetBackgroundColor (_sideColor); 
	RKAGMapVehicleTooltipHeader ctrlSetBackgroundColor (_sideColor); 
	RKAGMapTooltipGroup ctrlShow true; 

	private _footText = ""; 
	private _vehicleText = ""; 
	private _vehs = []; 

	{ 
		private _unit = _x; 
	
		if (!alive _unit) then {continue}; 
	
		if (_footCount > 0 && (vehicle _unit isEqualTo _unit)) then  
		{ 
			_iconName = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "icon"); 
			_iconPath = getText(configfile >> "CfgVehicleIcons" >> _iconName); 
			_footText=(_footText+"<img image='"+_iconPath+"' shadow='0' size='1.2' valign='middle'></img>"); 
		}; 
		
		if (_vehicleCount > 0 && !(vehicle _unit isEqualTo _unit) && !(vehicle _unit in _vehs)) then 
		{ 
			_vehs pushBack vehicle _unit; 	
			_vehicleText = (_vehicleText+"<img image='"+(getText (configfile >> 'CfgVehicles' >> typeOf vehicle _unit >> 'picture'))+"' shadow='0' size='1.33' valign='middle'></img>"); 
		}; 
    } foreach units _group; 
 
	if !(_footText isEqualTo "") then  
	{ 
		RKAGMapInfantryTooltipHeader ctrlShow true; 
		RKAGMapInfantryTooltipBody ctrlShow true; 
		RKAGMapInfantryTooltipBody ctrlSetStructuredText parseText ("<t size='0.1'>&#160;</t><br/>"+_footText); 
		RKAGMapInfantryTooltipBody ctrlCommit 0; 
	} 
	else  
	{ 
		RKAGMapInfantryTooltipHeader ctrlShow false; 
		RKAGMapInfantryTooltipBody ctrlShow false; 
	}; 
 
	if !(_vehicleText isEqualTo "") then  
	{ 
		RKAGMapVehicleTooltipHeader ctrlShow true; 
		RKAGMapVehicleTooltipBody ctrlShow true; 
		RKAGMapVehicleTooltipBody ctrlSetStructuredText parseText ("<t size='0.5'>&#160;</t><br/>"+_vehicleText); 
		RKAGMapVehicleTooltipBody ctrlCommit 0; 
 
      	if (_footText isEqualTo "") then  
		{ 
			RKAGMapVehicleTooltipHeader ctrlSetPosition [0.0125, 0.02, 0.4375, 0.04]; 
			RKAGMapVehicleTooltipBody ctrlSetPosition [0.0125, 0.06, 0.4375, 0.1]; 
			RKAGMapVehicleTooltipHeader ctrlcommit 0.05; 
			RKAGMapVehicleTooltipBody ctrlcommit 0.05; 
		} 
		else  
		{ 
			RKAGMapVehicleTooltipHeader ctrlSetPosition [0.0125, 0.18, 0.4375, 0.04]; 
			RKAGMapVehicleTooltipBody ctrlSetPosition [0.0125, 0.22, 0.4375, 0.1]; 
			RKAGMapVehicleTooltipHeader ctrlCommit 0.05; 
			RKAGMapVehicleTooltipBody ctrlCommit 0.05; 
		}; 
	} 
	else  
	{  
		RKAGMapVehicleTooltipHeader ctrlShow false; 
		RKAGMapVehicleTooltipBody ctrlShow false; 
	}; 
}; 