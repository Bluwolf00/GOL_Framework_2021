Params ["_Unit"];
	_Ammo = secondaryWeaponMagazine _Unit;
	Sleep 5;
	systemChat "Added NVGs.";
	_Unit addItem "NVGoggles_OPFOR";
	_Unit assignItem "NVGoggles_OPFOR";
	_Unit removeMagazines (_Ammo select 0);
	//_Unit addMagazine _Ammo;