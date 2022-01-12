// execVM "Scripts\OKS_Support\Action.sqf";

if (hasInterface) then {

	_Settings = [side player] call OKS_Support_Settings;
	_Settings Params ["_AircraftClass","_Timer"];

    _conditionLaserTarget = {
    	player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4] &&
    	(currentWeapon player in ["Laserdesignator_02_ghex_F","Laserdesignator_02","Laserdesignator_01_khk_F","Laserdesignator_03","Laserdesignator"]) &&
    	!(player getVariable ["OKS_CAS_TIMER",false]) && !isNull laserTarget player
    };

    _conditionMapTarget = {
    	player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4] &&
    	!(player getVariable ["OKS_CAS_TIMER",false]) && isNull laserTarget player
	};

	_GunsMap =
	{
		openMap true;
		[side player, systemChat "CAS: Awaiting coordinates"] onMapSingleClick
		{
			[Side Player, systemChat "CAS: Awaiting direction",_pos] onMapSingleClick {
				_Direction = (_This select 2) getDir _pos;
				[(_This select 2),(_This select 0),0,_Direction,true] spawn OKS_Support_SpawnModule;
				onMapSingleClick "";
				[player,_Timer] spawn {
					(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
					sleep (_this select 1);
					(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
				};
			}
		};
	};
	_RocketsMap =
	{
		openMap true;
		[side player, systemChat "CAS: Awaiting coordinates"] onMapSingleClick
		{
			[Side Player, systemChat "CAS: Awaiting direction",_pos] onMapSingleClick {
				_Direction = (_This select 2) getDir _pos;
				[(_This select 2),(_This select 0),1,_Direction,true] spawn OKS_Support_SpawnModule;
				onMapSingleClick "";
				[player,_Timer] spawn {
					(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
					sleep (_this select 1);
					(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
				};
			}
		};
	};
	_GunsRocketsMap =
	{
		openMap true;
		[side player, systemChat "CAS: Awaiting coordinates"] onMapSingleClick
		{
			[Side Player, systemChat "CAS: Awaiting direction",_pos] onMapSingleClick {
				_Direction = (_This select 2) getDir _pos;
				[(_This select 2),(_This select 0),2,_Direction,true] spawn OKS_Support_SpawnModule;
				onMapSingleClick "";
				[player,_Timer] spawn {
					(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
					sleep (_this select 1);
					(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
				};
			}
		};
	};
	_BombRunMap =
	{
		openMap true;
		[side player, systemChat "CAS: Awaiting coordinates"] onMapSingleClick
		{
			[Side Player, systemChat "CAS: Awaiting direction",_pos] onMapSingleClick {
				_Direction = (_This select 2) getDir _pos;
				[(_This select 2),(_This select 0),3,_Direction,true] spawn OKS_Support_SpawnModule;
				onMapSingleClick "";
				[player,_Timer] spawn {
					(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
					sleep (_this select 1);
					(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
				};
			}
		};
	};
	_GunsLaser =
	{
		[player,side player,0,-1,true] spawn OKS_Support_SpawnModule;
		[player,_Timer] spawn {
			(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
			sleep (_this select 1);
			(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
		};
	};
	_RocketsLaser =
	{
		[player,side player,1,-1,true] spawn OKS_Support_SpawnModule;
		[player,_Timer] spawn {
			(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
			sleep (_this select 1);
			(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
		};
	};
	_GunsRocketsLaser =
	{
		[player,side player,2,-1,true] spawn OKS_Support_SpawnModule;
		[player,_Timer] spawn {
			(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
			sleep (_this select 1);
			(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
		};
	};
	_BombRunLaser =
	{
		[player,side player,3,-1,true] spawn OKS_Support_SpawnModule;
		[player,_Timer] spawn {
			(_this select 0) setVariable ["OKS_CAS_TIMER",true,true];
			sleep (_this select 1);
			(_this select 0) setVariable ["OKS_CAS_TIMER",false,true];
		};
	};

	// NEKY EDIT END

    _action = ["CASM", "Close Air Support (Map)","\a3\Modules_F_Curator\Data\portraitCAS_ca.paa", {}, _conditionMapTarget] call ace_interact_menu_fnc_createAction;
    _guns = ["CAS0M", "Guns","\a3\ui_f\data\igui\cfg\simpletasks\letters\g_ca.paa", _GunsMap, _conditionMapTarget] call ace_interact_menu_fnc_createAction;
    _rockets = ["CAS1M", "Rockets","\a3\ui_f\data\igui\cfg\simpletasks\letters\r_ca.paa", _RocketsMap, _conditionMapTarget] call ace_interact_menu_fnc_createAction;
    _gunsrockets = ["CAS2M", "Guns and rockets","\a3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa", _GunsRocketsMap, _conditionMapTarget] call ace_interact_menu_fnc_createAction;
    _bombs = ["CAS3M", "Bombing Run","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa", _BombRunMap, _conditionMapTarget] call ace_interact_menu_fnc_createAction;

    _actionL = ["CASL", "Close Air Support (Laser)","\a3\Modules_F_Curator\Data\portraitCAS_ca.paa", {}, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;
    _gunsL = ["CAS0L", "Guns","\a3\ui_f\data\igui\cfg\simpletasks\letters\g_ca.paa", _GunsLaser, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;
    _rocketsL = ["CAS1L", "Rockets","\a3\ui_f\data\igui\cfg\simpletasks\letters\r_ca.paa", _RocketsLaser, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;
    _gunsrocketsL = ["CAS2L", "Guns and rockets","\a3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa", _GunsRocketsLaser, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;
    _bombsL = ["CAS3L", "Bombing Run","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa", _BombRunLaser, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;

    [typeOf player, 1, ["ACE_SelfActions","Request_Support"], _action] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASM"], _guns] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASM"], _rockets] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASM"], _gunsrockets] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASM"], _bombs] call ace_interact_menu_fnc_addActionToClass;

    [typeOf player, 1, ["ACE_SelfActions","Request_Support"], _actionL] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASL"], _gunsL] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASL"], _rocketsL] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASL"], _gunsrocketsL] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASL"], _bombsL] call ace_interact_menu_fnc_addActionToClass;

};
//_condition = {leader (group player) isEqualTo (leader player)}; for sp testing
