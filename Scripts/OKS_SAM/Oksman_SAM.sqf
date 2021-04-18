// How to use
// [SAMLAUNCHER,RATEOFFIRE,AMMO,RELOADRATE] execVM "Scripts\OKS_SAM\Oksman_SAM.sqf";
// [this,20,4,30] execVM "Scripts\OKS_SAM\Oksman_SAM.sqf";

_SAM = _this select 0;
_RateOfFire = _this select 1;
_Ammo = _this select 2;
_ReloadRate = _this select 3;

_SAM setVariable ["SAM_Name",_this select 0];
_SAM setVariable ["SAM_ROF",_this select 1];
_SAM setVariable ["SAM_Ammo_Full",_this select 2];
_SAM setVariable ["SAM_Ammo",_this select 2];
_SAM setVariable ["SAM_RR",_this select 3];

_SAM addEventHandler ["Fired",{ [_this select 0] spawn OKS_SAM_FIRED; }];

OKS_SAM_FIRED =
{
	params["_Object"];

	SystemChat "SAM Ready..";
	_SAM = _Object getVariable "SAM_Name";
	_RateOfFire = _Object getVariable "SAM_ROF";
	_Ammo = _Object getVariable "SAM_Ammo";
	_AmmoFull = _Object getVariable "SAM_Ammo_Full";
	_ReloadRate = _Object getVariable "SAM_RR";

	SystemChat format["SAM FIRED - Prior Ammo: %1",_Ammo];
	_SAM setVehicleReceiveRemoteTargets false;
	_Ammo = _Ammo - 1;

	_SAM setVariable ["SAM_Ammo",_Ammo];
	SystemChat Format ["Ammo after launch: %1",_Ammo];

	sleep _RateOfFire + (Random _RateOfFire);

	SystemChat "Reload Complete";
	_SAM setVehicleReceiveRemoteTargets true;

	if (_Ammo < 1) then
	{

		SystemChat "SAM RELOAD STARTED..";
		_SAM setVehicleReceiveRemoteTargets false;

		sleep _ReloadRate; _SAM setVehicleAmmo 0.25;
		SystemChat "Reload 0.25";
		sleep _ReloadRate; _SAM setVehicleAmmo 0.50;
		SystemChat "Reload 0.50";
		sleep _ReloadRate; _SAM setVehicleAmmo 0.75;
		SystemChat "Reload 0.75";
		sleep _ReloadRate; _SAM setVehicleAmmo 1;
		SystemChat "Reload Ready";

		_SAM setVariable ["SAM_Ammo",_AmmoFull];
		_SAM setVehicleReceiveRemoteTargets true;

	};

};
