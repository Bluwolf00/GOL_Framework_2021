
///// _null = [east,ArtyName,TargetObject,RoundsFired,RearmTime,ReloadTime] spawn OKS_ArtyFire;
//// _null = [east,this,getMarkerPos "respawn_west",7,300,30] spawn OKS_ArtyFire;
/*
	[east,this,getMarkerPos "respawn_west",10,300,2000] execVM "Scripts\OKS_Ambience\OKS_ArtyFire.sqf";
*/


if(HasInterface && !isServer) exitWith {false};

if (!HasInterface || isServer) then
{

	OKS_CHECK_TRAVEL = {

		Params["_Projectile","_Launcher"];
		//SystemChat str [_Projectile,_Launcher];
		WaitUntil {_Projectile distance2D _Launcher > 1000};
		deleteVehicle _Projectile;

	};

		params["_side","_arty","_target","_rof","_time","_reload"];
		private ["_gunner","_CfgMagazine","_Debug","_Range"];

		_Debug = 1;

		if (_Debug == 1) then {SystemChat "Start"};

		_gunner = gunner _arty;

		//// Reset Ammo
		_arty setVehicleAmmo 0;
		_arty setVehicleAmmo 1;

		if (!alive gunner _arty) then {
			if (_Debug == 1) then {SystemChat format ["%1",_side]};
			/// Initiation
			switch (_side) do
			{
				case blufor:
				{
					if (_Debug == 1) then {SystemChat "Selected West"};
					_gunner_group = createGroup west;
					_gunner = _gunner_group createUnit ["B_Soldier_F",[0,0,10], [], 0, "FORM"];

				};

				case opfor:
				{
					if (_Debug == 1) then {SystemChat "Selected East"};
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				case independent:
				{
					if (_Debug == 1) then {SystemChat "Selected Independent"};
					_gunner_group = createGroup independent;
					_gunner = _gunner_group createUnit ["I_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				default
				{
					if (_Debug == 1) then {SystemChat "Selected Default"};
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];

				};
			};
		};

	_gunner moveInGunner _arty;
	_gunner setBehaviour "AWARE";
	_gunner setCombatMode "BLUE";
	_gunner disableAI "TARGET";
	_gunner disableAI "AUTOTARGET";
	_gunner setVariable ["oks_disable_hunt",true];

	waitUntil {sleep 1; !(isNull _gunner)};

	_CfgMagazine = (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _arty)) >> "magazines") select 0);
    if(_Debug == 1) then {
		systemChat str _CfgMagazine;
    };

	if (!(_target inRangeOfArtillery [[_arty], _CfgMagazine])) then {
		SystemChat "Artillery not in range..";
		_Range = 0;
		while {true} do {

			sleep 0.25;
			_Range = _Range + 250;
			_target = _arty getPos [_Range,(_arty getDir _target)];
			if (_Debug == 1) then {
				SystemChat format["Artillery Position: %1",_target];
				_marker = createMarker [format ["oks_ArtyDebugMarker_%1",str round(random 80000 + random 9999)],_target];
				_marker setMarkerSize [0.6,0.6];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "hd_dot";
			};
			if((_target inRangeOfArtillery [[_arty], _CfgMagazine])) exitWith {"Artillery Target in range..."};
		};
	};


	/*
	if (_Debug == 1) then {SystemChat "Starting Watch and Interval"};

	if(typeName _target == "OBJECT") then {
		_arty reveal _target;
		_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];
	};

	if(typeName _target == "ARRAY") then {
		_arty doWatch [_target select 0,_target select 1,_angle];
		_target = createVehicle ["ClutterCutter_small_2_EP1", _target, [], 0, "NONE"];
	};

	sleep (10+(Random 20));

		_gunner disableAI "WEAPONAIM";
		_gunner setBehaviour "AWARE";
		_gunner setCombatMode "BLUE";
	*/



	if (_Debug == 1) then {SystemChat "Disable AI"};
	/// While Arty is not destroyed - Continue the loop
	while {Alive _arty} do
	{
		/*
		if(_this select 4 > 0) then { sleep _rof; } else { sleep 5; };
		*/
		_arty addEventHandler ["Fired",{ [(_this select 6),(_this select 0)] Spawn OKS_CHECK_TRAVEL;}];

		if(Alive gunner _arty) then {
			/*
			_arty fireAtTarget [_target];
	        _arty action ["UseWeapon", _arty, (gunner _arty), 0];
	        */
    		_gunner enableAI "TARGET";
			_gunner enableAI "AUTOTARGET";
			_gunner setCombatMode "YELLOW";
			sleep 1;
	        if(_Debug == 1) then {
        		systemChat "Firing Artillery..";
	        };
	        _arty doArtilleryFire [_target getPos [(_arty distance _target),_arty getDir _target], _CfgMagazine, _rof];
	        sleep _reload;
		};

		///// If out of ammo, reload
		if (_arty ammo (currentMuzzle (gunner _arty)) < 1) then
		{
			if (_Debug == 1) then {SystemChat "Time for Reload"};
			if(_this select 5 > 0) then { sleep _time; } else
			{
			 	sleep 120;
			 	/*
				_gunner enableAI "WEAPONAIM";
				_gunner setBehaviour "CARELESS";
				_gunner setCombatMode "GREEN";
				_gunner EnableAI "TARGET";
				_gunner EnableAI "AUTOTARGET";


				if(typeName _target == "OBJECT") then {
					_arty reveal _target;
					_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];
				};

				if(typeName _target == "ARRAY") then {
					_arty doWatch [_target select 0,_target select 1,_angle];
				};

				sleep 6;

				_gunner disableAI "WEAPONAIM";
				_gunner setBehaviour "CARELESS";
				_gunner setCombatMode "BLUE";
				_gunner disableAI "TARGET";
				_gunner disableAI "AUTOTARGET";
				*/

		 	};

			_arty setVehicleAmmo 1;
			if (_Debug == 1) then {SystemChat "Reloaded"};

		};

		sleep 0.5;
	};

};