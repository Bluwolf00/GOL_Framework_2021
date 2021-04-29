
/*
 	Usage: _null = [LauncherName,TargetName,LaserName(Laser1)] execVM "Scripts\OKS_Ambience\OKS_CruiseMissile.sqf";

 	Parameters:
	LauncherName - Object name
	TargetName - Object name (will be destroyed by code when missile hits)
	Lasername - Script requires global variables for some reason, so name it differently for all cruiseMissile launchers. No need to place these down, just write a name.
*/


OKS_Delete_Missile = {

	params["_Missile","_Launcher"];

	_Targeted = _Launcher GetVariable ["TARGET",[0,0,0]];
	//SystemChat Format ["%1 - %2 - %3",_Missile,_Launcher,_Targeted];
	sleep 3;
	waitUntil{ (_Missile distance _Targeted < 50 || GetDammage _Missile > 0.5 || isNull _Missile ); };

	/* Below is a system for deleting the cruise missile when it hits and replace it with your choice of explosion defined in _Shell. This is because it's a performance heavy strike, it will level part of town so use with care */

		/*
		waitUntil{ hintSilent format ["Altitude: %1",getPos _Missile select 2]; getPos _Missile select 2 < 3; };
		SystemChat "Deleted";
		//Bomb: ammo_Bomb_SDB  Artillery: Sh_155mm_AMOS
		_Shell = "Sh_155mm_AMOS" createVehicle [getPos _Targeted select 0,getPos _Targeted select 1,0.2];
		_Shell setVelocity [0,0,-5];
		deleteVehicle _Missile;
		SystemChat "Missile Hit";
	*/
	_Missile setPos [getPos _Missile select 0,getPos _Missile select 1,0];
	_Missile setVelocity [0,0,-5];
	_Targeted setDamage 1;

	if(true) exitWith {};

};


if(isServer) then
{
	_Launcher = _this select 0;
	_Target = _this select 1;
	_Laser = _this select 2;
	publicVariable "_Missile";

	//SystemChat Format ["%1 %2",_Launcher,_Target];
	_Launcher setVariable ["TARGET",_Target];
	_Launcher addEventHandler ["Fired",{ _Strike = [(_this select 6),(_this select 0)] spawn OKS_Delete_Missile; }];
	_Laser = createVehicle ["Land_HelipadEmpty_F" ,getPos _Target, [],0,"CAN_COLLIDE"];
	west reportRemoteTarget [_Laser, 3600];
	_Laser confirmSensorTarget [west, true];
	_Launcher fireAtTarget [_Laser, "weapon_vls_01"];

};

