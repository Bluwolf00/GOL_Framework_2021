
///// _null = [ArtyName,TargetObject,WeaponClassname,RateoFire,ReloadTime,Angle] spawn OKS_ArtyFire;
//// _null = [west,this,target_1,"CUP_Vcannon_D30_veh",1,90,2000] spawn OKS_ArtyFire;
//// RHS D-30: RHS_Weap_d30
//// RHS BM-21: rhs_weap_bm21
//// CUP D-30: CUP_Vcannon_D30_veh
///// CUP GRAD: CUP_Vmlauncher_GRAD_veh
//// Vanilla Indep Launcher: rockets_230mm_GAT
/// 2S3M1 RHS: rhs_weap_2a33

OKS_CHECK_TRAVEL = {

	Params["_Projectile","_Launcher"];
	//SystemChat str [_Projectile,_Launcher];
	WaitUntil {_Projectile distance2D _Launcher > 1000};
	deleteVehicle _Projectile;

};


if (isServer) then
{

	Debug = 0;
	if (Debug == 1) then {SystemChat "Start"};

		params["_side","_arty","_target","_weapon","_rof","_time","_angle"];
		private ["_gunner"];

		_gunner = gunner _arty;

		//// Reset Ammo
		_arty setVehicleAmmo 0;
		_arty setVehicleAmmo 1;

		if (!alive gunner _arty) then {
			if (Debug == 1) then {SystemChat format ["%1",_side]};
			/// Initiation
			switch (_side) do
			{
				case blufor:
				{
					if (Debug == 1) then {SystemChat "Selected West"};
					_gunner_group = createGroup west;
					_gunner = _gunner_group createUnit ["B_Soldier_F",[0,0,10], [], 0, "FORM"];

				};

				case opfor:
				{
					if (Debug == 1) then {SystemChat "Selected East"};
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				case independent:
				{
					if (Debug == 1) then {SystemChat "Selected Independent"};
					_gunner_group = createGroup independent;
					_gunner = _gunner_group createUnit ["I_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				default
				{
					if (Debug == 1) then {SystemChat "Selected Default"};
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];

				};
			};
		};

	_gunner moveInGunner _arty;
	_gunner setBehaviour "CARELESS";
	_gunner setCombatMode "BLUE";
	_gunner setVariable ["oks_disable_hunt",true];

	if (Debug == 1) then {SystemChat "Starting Watch and Interval"};

	_arty reveal _target;
	_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];

	sleep (10+(Random 20));
	_gunner disableAI "WEAPONAIM";
	_gunner setBehaviour "CARELESS";
	_gunner setCombatMode "BLUE";
	_gunner disableAI "TARGET";
	_gunner disableAI "AUTOTARGET";
	if (Debug == 1) then {SystemChat "Disable AI"};
	/// While Arty is not destroyed - Continue the loop
	while {Alive _arty} do
	{
		if(_this select 4 > 0) then { sleep _rof; } else { sleep 1; };
		if (_weapon == "RHS_Weap_d30" || _weapon == "CUP_Vcannon_D30_veh") then { _arty addEventHandler ["Fired",{DeleteVehicle (_this select 6)}]}
		else
		{
			_arty addEventHandler ["Fired",{ [(_this select 6),(_this select 0)] Spawn OKS_CHECK_TRAVEL;}];
		};

		if(Alive gunner _arty) then {
			_arty fireAtTarget [_target];
		};

		///// If out of ammo, reload
		if (_arty ammo _weapon < 1) then
		{
			if (Debug == 1) then {SystemChat "Time for Reload"};
			if(_this select 5 > 0) then { sleep _time; } else

			{

			 	sleep 120;

				_gunner enableAI "WEAPONAIM";
				_gunner setBehaviour "CARELESS";
				_gunner setCombatMode "GREEN";
				_gunner EnableAI "TARGET";
				_gunner EnableAI "AUTOTARGET";

				if (_weapon == "RHS_Weap_d30") then {
				_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];
				} else {
					_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];
					};

				sleep 5;

				_gunner disableAI "WEAPONAIM";
				_gunner setBehaviour "CARELESS";
				_gunner setCombatMode "BLUE";
				_gunner disableAI "TARGET";
				_gunner disableAI "AUTOTARGET";

		 	};

			_arty setVehicleAmmo 1;
			if (Debug == 1) then {SystemChat "Reloaded"};

		};

		sleep 0.5;
	};

};