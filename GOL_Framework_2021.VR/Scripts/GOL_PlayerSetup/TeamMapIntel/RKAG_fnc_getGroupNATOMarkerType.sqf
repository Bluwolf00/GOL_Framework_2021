
params["_group"]; 
private _side = sideUnknown; 
private _mkr = ""; 

private _prefix = ""; 
_prefix = switch (side _group) do  
{ 
	case west: {"b_"}; 
	case east: {"o_"}; 
	case independent: {"n_"}; 
	default {""}; 
}; 

private ["_grp","_vehlist","_infantry","_cars","_apcs","_tanks","_aa","_helis","_planes","_boats","_veh","_type"]; 

_grp = _group; 

_vehlist = []; 
_infantry = 0; 
_cars = 0; 
_apcs = 0; 
_tanks = 0; 
_aa = 0; 
_helis = 0; 
_planes = 0; 
_uavs = 0; 
_boats = 0; 
_artys = 0; 
_mortars = 0; 
_support_reammo = 0; 
_support_repair = 0; 
_support_refuel = 0; 
_support_medic = 0; 
_support = 0; 
{ 
	if (!canstand vehicle _x && alive vehicle _x && !(vehicle _x in _vehlist)) then { 
	_veh = vehicle _x; 
	_vehlist = _vehlist + [_veh]; 

	if (_veh iskindof "car") then {_cars = _cars + 1}; 
	if (_veh iskindof "tank") then {_tanks = _tanks + 1;}; 
	if (getnumber(configfile >> "cfgvehicles" >> typeof _veh >> "artilleryScanner") > 0) then{_artys = _artys + 1;}; 
	if (_veh iskindof "Wheeled_APC_F" || _veh iskindof "APC_Tracked_01_base_F" 
	|| _veh iskindof "APC_Tracked_02_base_F" || _veh iskindof "APC_Tracked_03_base_F") then {_apcs = _apcs + 1}; 
	if (getnumber(configfile >> "cfgvehicles" >> typeof _veh >> "radarType") > 0) then {_aa = _aa + 1}; 
	if (_veh iskindof "helicopter") then {_helis = _helis + 1}; 
	if (_veh iskindof "plane") then {_planes = _planes + 1;}; 
	if (_veh in allUnitsUAV) then {_uavs = _uavs + 1;}; 
	if (_veh iskindof "staticcanon") then {_artys = _artys + 1}; 
	if (_veh iskindof "staticmortar") then {_mortars = _mortars + 1}; 
	if (_veh iskindof "ship") then {_boats = _boats + 1}; 
	_canHeal = getnumber (configfile >> "cfgvehicles" >> typeof _veh >> "attendant") > 0; 
	_canReammo = getnumber (configfile >> "cfgvehicles" >> typeof _veh >> "transportAmmo") > 0; 
	_canRefuel = getnumber (configfile >> "cfgvehicles" >> typeof _veh >> "transportFuel") > 0; 
	_canRepair = getnumber (configfile >> "cfgvehicles" >> typeof _veh >> "transportRepair") > 0; 
	if (_canHeal) then {_support_medic = _support_medic + 1}; 
	if (_canReammo) then {_support_reammo = _support_reammo + 1}; 
	if (_canRefuel) then {_support_refuel = _support_refuel + 1}; 
	if (_canRepair) then {_support_repair = _support_repair + 1}; 
	}; 
	if ((vehicle _x isEqualTo _x)) then {_infantry = (_infantry + 1)}; 
} foreach units _grp; 

_type = "unknown"; 
if (_infantry >= 1) then {_type = "inf"}; 
if (_cars >= 1) then {_type = "motor_inf"}; 
if (_tanks >= 1) then {_type = "armor"}; 
if (_apcs >= 1) then {_type = "mech_inf"}; 
if (_aa >= 1) then {_type = "antiair"}; 
if (_artys >= 1) then {_type = "art"}; 
if (_mortars >= 1) then {_type = "mortar"}; 
if ((_support_reammo + _support_refuel) >= 1) then {_type = "support"}; 
if (_support_repair >= 1) then {_type = "maint"}; 
if (_support_medic >= 1) then {_type = "med"}; 
if ((_support_medic + _support_reammo + _support_refuel + _support_repair) > 1) then {_type = "support"}; 
if (_boats >= 1) then {_type = "naval"}; 
if (_helis >= 1) then {_type = "air"}; 
if (_planes >= 1) then {_type = "plane"}; 
if (_uavs >= 1) then {_type = "uav"}; 
	
_mkr = (_prefix+_type); 
_mkr