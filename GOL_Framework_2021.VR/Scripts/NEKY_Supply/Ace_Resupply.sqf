if (hasInterface) then {
    _condition = {player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4] && isNull laserTarget player}; //<only works MP
	// NEKY EDIT START
	_code =
	{
		openMap true;
		[Side Player, systemChat "Pilot: Awaiting coordinates"] onMapSingleClick
		{
			Private ["_BoxCode"];
			Switch (_This select 0) do
			{
				Case WEST: {_BoxCode = {[_Box, ["small_box","west"]] call GW_Gear_Fnc_Init; [_Box] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";}};
				Case EAST: {_BoxCode = {[_Box, ["small_box","east"]] call GW_Gear_Fnc_Init; [_Box] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf"; }};
				Case INDEPENDENT: {_BoxCode = {[_Box, ["small_box","indep"]] call GW_Gear_Fnc_Init; [_Box] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";}};
			};
			[(_This select 0),GOL_NEKY_SUPPLY_HELICOPTER,"drop", ["helicopter_spawn",_pos,"helicopter_despawn"],_BoxCode,true] execVM "Scripts\NEKY_supply\NEKY_SupplyMapClick.sqf";
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
				Case WEST: {_BoxCode = {[_Box, ["small_box","west"]] call GW_Gear_Fnc_Init}};
				Case EAST: {_BoxCode = {[_Box, ["small_box","east"]] call GW_Gear_Fnc_Init}};
				Case INDEPENDENT: {_BoxCode = {[_Box, ["small_box","indep"]] call GW_Gear_Fnc_Init}};
			};
			[(_This select 0),GOL_NEKY_SUPPLY_HELICOPTER,"unload", ["helicopter_spawn",_pos,"helicopter_despawn"],_BoxCode,true] execVM "Scripts\NEKY_supply\NEKY_SupplyMapClick.sqf";
		};
	};
	// NEKY EDIT END

	_action = ["Resupply", "Resupply","Scripts\NEKY_supply\ui\support64.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
	_drop = ["Airdrop", "Airdrop","Scripts\NEKY_supply\ui\Chute.paa", _code, _condition] call ace_interact_menu_fnc_createAction;
	_unload = ["Unload", "Unload","Scripts\NEKY_supply\ui\Helli.paa", _landcode, _condition] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions","Request_Support"], _action] call ace_interact_menu_fnc_addActionToClass;
	[typeOf player, 1, ["ACE_SelfActions","Request_Support","Resupply"], _drop] call ace_interact_menu_fnc_addActionToClass;
	[typeOf player, 1, ["ACE_SelfActions","Request_Support","Resupply"], _unload] call ace_interact_menu_fnc_addActionToClass;

};

//_condition = {leader (group player) isEqualTo (leader player)};
// Thanks to Neko & Guzzman for the scripts and helping fixing errors.
// Here I have made nekos scripts and functions compatabile to the ace UI,
//only thing you can edit really is [blufor,"","drop",["spawn",_pos,"despawn"] so this means/ change side,"","unload or drop", ["markername","mouse click","markername"]
// By Luke.


