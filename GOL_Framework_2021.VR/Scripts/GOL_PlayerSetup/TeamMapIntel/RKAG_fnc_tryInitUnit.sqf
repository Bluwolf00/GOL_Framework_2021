params["_unit"]; 
	
private _initValue = _unit getVariable "RKAGInit"; 
if (isNil "_initValue") then  
{ 
	_unit addEventHandler ["FiredMan",{ 
		params["_unit"]; 
		[_unit] spawn RKAG_fnc_spawnFireEffect; 
	}]; 
	_unit setVariable ["RKAGInit",true]; 
};