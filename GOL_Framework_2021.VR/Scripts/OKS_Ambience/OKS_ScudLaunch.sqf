
/// Place an empty 9P129-1M (9M79-1-F) name it and run this code when you want the SCUD launchers to start firing. This code /// repeats itself based on your decided _reloadTime.
/// [_side,_arty,_target,_reloadTime] spawn OKS_ScudLaunch;
/// [east,scud_1,target_1,600] spawn OKS_ScudLaunch;



if(!isServer) exitWith {};

params["_side","_arty","_target","_reloadTime"];
private ["_gunner","_OKS_CHECK_TRAVEL"];


	OKS_CHECK_TRAVEL = {

		Params["_Projectile","_Launcher"];
		//SystemChat str [_Projectile,_Launcher];
		WaitUntil {_Projectile distance2D _Launcher > 1000};
		deleteVehicle _Projectile;

	};


		if (isNull (gunner _arty)) then {

			switch (_side) do
			{
				case blufor:
				{
					_gunner_group = createGroup west;
					_gunner = _gunner_group createUnit ["B_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				case opfor:
				{
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				case independent:
				{
					_gunner_group = createGroup independent;
					_gunner = _gunner_group createUnit ["I_Soldier_F",[0,0,10], [], 0, "FORM"];
				};

				default
				{
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];

				};
			};
		};

	_gunner moveInGunner _arty;
	_gunner setBehaviour "CARELESS";
	_gunner setCombatMode "BLUE";
	_gunner setVariable ["oks_disable_hunt",true];
	_arty addEventHandler ["Fired",{ [(_this select 6),(_this select 0)] Spawn OKS_CHECK_TRAVEL;}];

	sleep (30 + (random 30));

	while {alive _arty} do {

		_arty setVehicleAmmo 1; sleep 1;
		[_arty,1] spawn rhs_fnc_ss21_AI_prepare;
		sleep (60 + (random 30));

		if(!alive gunner _arty) exitWith { systemChat "SCUD Gunner Dead. Killing Script" };
			[_arty, getPos _target]spawn rhs_fnc_ss21_AI_launch;

		sleep _reloadTime;

	};

