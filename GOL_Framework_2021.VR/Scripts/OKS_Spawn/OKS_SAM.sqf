// How to use
// [SAMLAUNCHER,RATEOFFIRE,AMMO,RELOADRATE] spawn OKS_SAM;
// [this,20,4,30] spawn OKS_SAM;
// [this,20,4,30] execVM "OKS_SAM".sqf;
// Put this in the the missions init.sqf after 10 second delay

Params [
	"_SAM",
	"_Radar",
	["_RateOfFire",20,[0]],
	["_Ammo",4,[0]],
	["_ReloadRate",20,[0]],
	["_MinimumAltitude",100,[0]],
	["_MaxRange",3000,[0]]
];

_SAM setVariable ["SAM_Name",_SAM];
_SAM setVariable ["SAM_ROF",_RateOfFire];
_SAM setVariable ["SAM_Ammo_Full",_Ammo];
_SAM setVariable ["SAM_Ammo",_Ammo];
_SAM setVariable ["SAM_RR",_ReloadRate];

OKS_SAM_FIRED =
{
	params["_Object"];

	//SystemChat "SAM Ready..";
	_SAM = _Object getVariable "SAM_Name";
	_RateOfFire = _Object getVariable "SAM_ROF";
	_Ammo = _Object getVariable "SAM_Ammo";
	_AmmoFull = _Object getVariable "SAM_Ammo_Full";
	_ReloadRate = _Object getVariable "SAM_RR";

	SystemChat format["SAM FIRED - Prior Ammo: %1",_Ammo];
	_SAM setVariable ["isReloading",true,true];
	_SAM setVehicleReceiveRemoteTargets false;
	//systemChat "Reloading - disabling remote targets";
	_Ammo = _Ammo - 1;

	_SAM setVariable ["SAM_Ammo",_Ammo];
	SystemChat Format ["Ammo after launch: %1",_Ammo];

	sleep (_RateOfFire + (Random _RateOfFire));

	SystemChat "Reload Complete";
	_SAM setVariable ["isReloading",false,true];
	_SAM setVehicleReceiveRemoteTargets true;
	//systemChat "Reloaded - enabling remote targets";

	if (_Ammo < 1) then
	{

		//SystemChat "SAM RELOAD STARTED..";
		_SAM setVehicleReceiveRemoteTargets false;

		sleep _ReloadRate; _SAM setVehicleAmmo 0.25;
		//SystemChat "Reload 0.25";
		sleep _ReloadRate; _SAM setVehicleAmmo 0.50;
		//SystemChat "Reload 0.50";
		sleep _ReloadRate; _SAM setVehicleAmmo 0.75;
		//SystemChat "Reload 0.75";
		sleep _ReloadRate; _SAM setVehicleAmmo 1;
		//SystemChat "Reload Ready";

		_SAM setVariable ["SAM_Ammo",_AmmoFull];
		_SAM setVehicleReceiveRemoteTargets true;

	};

};

_SAM addEventHandler ["Fired",{ [_this select 0] spawn OKS_SAM_FIRED; }];

while {alive _SAM} do {
	_NearbyTargets = (_Radar targets [true, _MaxRange]) select {_X isKindOf "AIR" && getPos _X select 2 >= _MinimumAltitude};
	if(count _NearbyTargets > 0) then {
		if(!(_SAM getVariable ["isReloading",false])) then {
			_SAM setVehicleReceiveRemoteTargets true;
			//systemChat "Not reloading - enabling remote targets";
		};
	} else {
		//systemChat "No targets - disable remote targets";
		_SAM setVehicleReceiveRemoteTargets false;
	};

	sleep 2;
};