if (hasInterface) then {
    _condition = {player in [w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1]};//<only works MP 
	
	// NEKY EDIT START
	_code = 
	{
		openMap true;
		[Side Player, systemChat "Pilot: Awaiting coordinates"] onMapSingleClick 
		{
			Private ["_BoxCode"];
			Switch (_This select 0) do
			{
				Case WEST: {_BoxCode = {[_Box, ["med_box","west"]] call GW_Gear_Fnc_Init}};
				Case EAST: {_BoxCode = {[_Box, ["med_box","east"]] call GW_Gear_Fnc_Init}};
				Case INDEPENDENT: {_BoxCode = {[_Box, ["med_box","indep"]] call GW_Gear_Fnc_Init}};
			};
			[(_This select 0),"","drop", ["spawn",_pos,"despawn"],_BoxCode,true] execVM "Scripts\NEKY_supply\NEKY_SupplyMapClick.sqf";
		};
	};

	_landcode = 
	{
		openMap true;
		[Side Player, systemChat "Pilot: Awaiting coordinates"] onMapSingleClick 
		{
			Private ["_BoxCode"];
			Switch (_This select 0) do
			{
				Case WEST: {_BoxCode = {[_Box, ["med_box","west"]] call GW_Gear_Fnc_Init}};
				Case EAST: {_BoxCode = {[_Box, ["med_box","east"]] call GW_Gear_Fnc_Init}};
				Case INDEPENDENT: {_BoxCode = {[_Box, ["med_box","indep"]] call GW_Gear_Fnc_Init}};
			};
			[(_This select 0),"","unload", ["spawn",_pos,"despawn"],_BoxCode,true] execVM "Scripts\NEKY_supply\NEKY_SupplyMapClick.sqf"; //true false = heli damage setting
		};
	};
	// NEKY EDIT END
	
    _action = ["Medical Resupply", "Medical Resupply","Scripts\NEKY_supply\ui\medical_cross.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
    _drop = ["Airdrop", "Airdrop","Scripts\NEKY_supply\ui\Chute.paa", _code, _condition] call ace_interact_menu_fnc_createAction;
    _unload = ["Unload", "Unload","Scripts\NEKY_supply\ui\Helli.paa", _landcode, _condition] call ace_interact_menu_fnc_createAction;
	
    [typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","ACE_Equipment","Medical Resupply"], _drop] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","ACE_Equipment","Medical Resupply"], _unload] call ace_interact_menu_fnc_addActionToClass;
};
//_condition = {leader (group player) isEqualTo (leader player)}; for sp testing
