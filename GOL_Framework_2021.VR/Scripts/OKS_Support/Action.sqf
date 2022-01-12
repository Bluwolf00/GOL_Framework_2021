// execVM "Scripts\OKS_Support\Action.sqf";

if (hasInterface) then {

    _conditionLaserTarget = {
    	player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4] &&
    	(currentWeapon player in ["Laserdesignator_02_ghex_F","Laserdesignator_02","Laserdesignator_01_khk_F","Laserdesignator_03","Laserdesignator"]) &&
    	!(player getVariable ["OKS_CAS_TIMER",false]) && !isNull laserTarget player
    };

    _conditionMapTarget = {
    	player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4] &&
    	!(player getVariable ["OKS_CAS_TIMER",false]) && isNull laserTarget player
	};

	_GunsRocketRunMap =
	{
		openMap true;
		[[player] call GW_Common_Fnc_getSide, systemChat "CAS: Awaiting coordinates"] onMapSingleClick
		{
			[Side Player, systemChat "CAS: Awaiting direction",_pos] onMapSingleClick {
				_Direction = (_This select 2) getDir _pos;
				[(_This select 2),(_This select 0),2,_Direction] spawn OKS_Support_SpawnModule;
				player spawn {
					_this setVariable ["OKS_CAS_TIMER",true,true];
					sleep 120;
					_this setVariable ["OKS_CAS_TIMER",false,true];
				};
			}
		};
	};

	_BombRunMap =
	{
		openMap true;
		[[player] call GW_Common_Fnc_getSide, systemChat "CAS: Awaiting coordinates"] onMapSingleClick
		{
			[Side Player, systemChat "CAS: Awaiting direction",_pos] onMapSingleClick {
				_Direction = (_This select 2) getDir _pos;
				[(_This select 2),(_This select 0),3,_Direction] spawn OKS_Support_SpawnModule;
				player spawn {
					_this setVariable ["OKS_CAS_TIMER",true,true];
					sleep 120;
					_this setVariable ["OKS_CAS_TIMER",false,true];
				};
			}
		};
	};

	_GunsRocketRunLaser =
	{
		[player,[player] call GW_Common_Fnc_getSide,2] spawn OKS_Support_SpawnModule;
		player spawn {
			_this setVariable ["OKS_CAS_TIMER",true,true];
			sleep 60;
			_this setVariable ["OKS_CAS_TIMER",false,true];
		};
	};

	_BombRunLaser =
	{
		[player,[player] call GW_Common_Fnc_getSide,3] spawn OKS_Support_SpawnModule;
		player spawn {
			_this setVariable ["OKS_CAS_TIMER",true,true];
			sleep 60;
			_this setVariable ["OKS_CAS_TIMER",false,true];
		};
	};

	// NEKY EDIT END

    _action = ["CASM", "Close Air Support (Map)","\a3\Modules_F_Curator\Data\portraitCAS_ca.paa", {}, _conditionMapTarget] call ace_interact_menu_fnc_createAction;
    _guns = ["CAS1M", "Guns and rockets","Scripts\NEKY_supply\ui\Chute.paa", _GunsRocketRunMap, _conditionMapTarget] call ace_interact_menu_fnc_createAction;
    _bombs = ["CAS2M", "Single Bomb","Scripts\NEKY_supply\ui\Helli.paa", _BombRunMap, _conditionMapTarget] call ace_interact_menu_fnc_createAction;

    _actionL = ["CASL", "Close Air Support (Laser)","\a3\Modules_F_Curator\Data\portraitCAS_ca.paa", {}, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;
    _gunsL = ["CAS1L", "Guns and rockets","Scripts\NEKY_supply\ui\Chute.paa", _GunsRocketRunLaser, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;
    _bombsL = ["CAS2L", "Single Bomb","Scripts\NEKY_supply\ui\Helli.paa", _BombRunLaser, _conditionLaserTarget] call ace_interact_menu_fnc_createAction;

    [typeOf player, 1, ["ACE_SelfActions","Request_Support"], _action] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASM"], _guns] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASM"], _bombs] call ace_interact_menu_fnc_addActionToClass;

    [typeOf player, 1, ["ACE_SelfActions","Request_Support"], _actionL] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASL"], _gunsL] call ace_interact_menu_fnc_addActionToClass;
    [typeOf player, 1, ["ACE_SelfActions","Request_Support","CASL"], _bombsL] call ace_interact_menu_fnc_addActionToClass;

};
//_condition = {leader (group player) isEqualTo (leader player)}; for sp testing
