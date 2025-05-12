// execVM "Scripts\GOL_PlayerSetup\OKS_DynamicOrbat_Action.sqf";

if (hasInterface) then {
    _condition = {player in [wecho1,wecho2,wecho3,eecho1,eecho2,eecho3]}; // Only pilots 1-3
	//_condition = {true}; // Everyone can move the MHQ
	
	// NEKY EDIT START
	_codeRaven =
	{		
		if(!isNil "wecho1") then {
			Private _Callsign = "Raven 1";
			if(player == wecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "wecho2") then {
			Private _Callsign = "Raven 2";
			if(player == wecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Raven 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};	
		if(!isNil "eecho1") then {
			Private _Callsign = "Raven 1";
			if(player == eecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho2") then {
			Private _Callsign = "Raven 2";
			if(player == eecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Raven 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};			
	};
	_codeGiant =
	{
		if(!isNil "wecho1") then {
			Private _Callsign = "Giant 1";
			if(player == wecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "wecho2") then {
			Private _Callsign = "Giant 2";
			if(player == wecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Giant 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};	
		if(!isNil "eecho1") then {
			Private _Callsign = "Giant 1";
			if(player == eecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho2") then {
			Private _Callsign = "Giant 2";
			if(player == eecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Giant 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};			
	};
	_codeAngel =
	{
		if(!isNil "wecho1") then {
			Private _Callsign = "Angel 1";
			if(player == wecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "wecho2") then {
			Private _Callsign = "Angel 2";
			if(player == wecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Angel 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};	
		if(!isNil "eecho1") then {
			Private _Callsign = "Angel 1";
			if(player == eecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho2") then {
			Private _Callsign = "Angel 2";
			if(player == eecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Angel 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Helicopter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};			
	};
	_codePhantom =
	{
		if(!isNil "wecho1") then {
			Private _Callsign = "Phantom 1";
			if(player == wecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "wecho2") then {
			Private _Callsign = "Phantom 2";
			if(player == wecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
				
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Phantom 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};	
		if(!isNil "eecho1") then {
			Private _Callsign = "Phantom 1";
			if(player == eecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho2") then {
			Private _Callsign = "Phantom 2";
			if(player == eecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Phantom 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};			
	};	
	_codeBanshee =
	{
		if(!isNil "wecho1") then {
			Private _Callsign = "Banshee 1";
			if(player == wecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "wecho2") then {
			Private _Callsign = "Banshee 2";
			if(player == wecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Banshee 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};	
		if(!isNil "eecho1") then {
			Private _Callsign = "Banshee 1";
			if(player == eecho1) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho2") then {
			Private _Callsign = "Banshee 2";
			if(player == eecho2) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};
		if(!isNil "eecho3") then {
			Private _Callsign = "Banshee 3";
			if(player == eecho3) then {
				[
					missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
					nil, nil, nil, str side player, _Callsign, _Callsign, nil, nil, nil, nil, (name player), (rank player), nil, [[(typeof (vehicle player)), 1]]
				] call BIS_fnc_ORBATSetGroupParams;
				player setVariable ["OKS_Callsign",_Callsign,true];
				player setVariable ["OKS_Composition","Fighter",true];
				[group player, _Callsign] call ace_interaction_fnc_renameGroup;
			};
		};			
	};

	_actionCallsign = ["Set_Callsign", "Set Callsign/ORBAT","\A3\ui_f\data\map\Markers\NATO\b_uav.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement"], _actionCallsign] call ace_interact_menu_fnc_addActionToClass;

	_actionAngel = ["Set_Callsign_Angel", "Angel","\A3\ui_f\data\map\Markers\NATO\b_air.paa", _codeAngel, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement","Set_Callsign"], _actionAngel] call ace_interact_menu_fnc_addActionToClass;	

	_actionRaven = ["Set_Callsign_Raven", "Raven","\A3\ui_f\data\map\Markers\NATO\b_air.paa", _codeRaven, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement","Set_Callsign"], _actionRaven] call ace_interact_menu_fnc_addActionToClass;	

	_actionGiant = ["Set_Callsign_Giant", "Giant","\A3\ui_f\data\map\Markers\NATO\b_air.paa", _codeGiant, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement","Set_Callsign"], _actionGiant] call ace_interact_menu_fnc_addActionToClass;	

	_actionPhantom = ["Set_Callsign_Phantom", "Phantom","\A3\ui_f\data\map\Markers\NATO\b_plane.paa", _codePhantom, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement","Set_Callsign"], _actionPhantom] call ace_interact_menu_fnc_addActionToClass;	

	_actionBanshee = ["Set_Callsign_Banshee", "Banshee","\A3\ui_f\data\map\Markers\NATO\b_plane.paa", _codeBanshee, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement","Set_Callsign"], _actionBanshee] call ace_interact_menu_fnc_addActionToClass;	
};