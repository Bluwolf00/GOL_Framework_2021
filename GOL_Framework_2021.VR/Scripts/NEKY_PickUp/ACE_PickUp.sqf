if (hasInterface) then {
    _condition = {player in [w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1]};//<only works MP

	// NEKY EDIT START
	_code =
	{
			Private ["_Classname"];
			Switch (Side Player) do
			{
				Case west: { _Classname = "RHS_UH60M_d" };
				Case east: { _Classname = "O_Heli_Light_02_F" };
				Case independent: { _Classname = "I_Heli_Transport_02_F" };
			};
			SystemChat str _Classname;
			[Side player,"RHS_UH60M_d", ["spawn","_pos","_pos","despawn"], true] execVM "Scripts\NEKY_PickUp\NEKY_PickUpTrigger.sqf";
	};

	// NEKY EDIT END

    _action = ["Extraction", "Extraction","\A3\ui_f\data\map\markers\nato\b_air.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
    _extraction = ["Helicopter Pickup", "Helicopter Pickup","\A3\ui_f\data\map\markers\military\pickup_CA.paa", _code, _condition] call ace_interact_menu_fnc_createAction;

    [typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","ACE_Equipment","Extraction"], _extraction] call ace_interact_menu_fnc_addActionToClass;

};
//_condition = {leader (group player) isEqualTo (leader player)}; for sp testing
