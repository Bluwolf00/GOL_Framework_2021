	if (hasInterface) then {

    _condition = {player in [wpl,epl,ipl,w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1]}; //<only works MP

	_code =
	{
		openMap true;
		Private _VehicleType = "UK3CB_BAF_FV432_Mk3_RWS_Green";
		Private _HelicopterType = "British_Merlin_HC3_Cargo";

		[side player, _HelicopterType, ["helicopter_spawn",_pos,"helicopter_despawn"],false, _VehicleType, nil, nil, nil, nil,{[_this select 0,nil,false] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf"}] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleDropTrigger.sqf";
	};

	_change = ["VehicleDrop","Vehicle Resupply","\A3\ui_f\data\map\markers\NATO\B_mech_inf.paa",_code,_condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _change] call ace_interact_menu_fnc_addActionToClass;
}