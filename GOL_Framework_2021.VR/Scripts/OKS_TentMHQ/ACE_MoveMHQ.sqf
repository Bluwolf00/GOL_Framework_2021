if (hasInterface) then {
    _condition = {player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4]}; // Only leaders and special kits can move MHQ
	//_condition = {true}; // Everyone can move the MHQ
	
	// NEKY EDIT START
	_code =
	{
		_EnemyNearUnits = (player nearEntities ["Man", 100]) select {(side _X) getFriend (side player) < 0.6 && side _X != civilian};
		if(count _EnemyNearUnits == 0) then {
			[Tent_MHQ,(player getPos [3,getDir player])] remoteExec ["setPos",2];
			_mhqMarkerId = _mhq getVariable ["MHQ_MarkerId",""];
			_mhqMarkerAreaId = format["%1_Area",_mhqMarkerId];
			_mhqMarkerId setMarkerPos _mhq;
			_mhqMarkerAreaId setMarkerPos _mhq;

			_Players = allPlayers select {_X distance flag_west_1 < 100 || _X distance flag_east_1 < 100};
			_Players spawn {
				_Players = _this;
				sleep 5;
				["The MHQ has been moved to a new safe location."] remoteExec ["systemChat",_Players];
			};
		} else {
			systemChat "Enemies are nearby. You cannot move the MHQ until the immediate area is secure (100m).";
		};	
	};

	// NEKY EDIT END
	_action = ["DeployMHQTent", "Deploy Tent MHQ","\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa", _code, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","Request_Support"], _action] call ace_interact_menu_fnc_addActionToClass;

};

//_condition = {leader (group player) isEqualTo (leader player)};
// Thanks to Neko & Guzzman for the scripts and helping fixing errors.
// Here I have made nekos scripts and functions compatabile to the ace UI,
//only thing you can edit really is [blufor,"","drop",["spawn",_pos,"despawn"] so this means/ change side,"","unload or drop", ["markername","mouse click","markername"]
// By Luke.


