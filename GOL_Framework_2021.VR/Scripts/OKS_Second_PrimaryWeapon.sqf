// Example: [unit,"r"] execVM "Scripts\OKS_Second_PrimaryWeapon.sqf";
// This code is automatically run on every role on start and reselection of kits.
Params ["_unit","_role"];

_Weapons = [
	[
		// Weapon select 0
		"UK3CB_BAF_L128A1", 		  // Weapon
		["UK3CB_BAF_12G_Pellets",""], // Magazine and secondary magazine
		"", 						  // Muzzle
		"rhsusf_acc_m952v", 		  // Pointer
		"optic_holosight_blk_f", 	  // Sights
		"", 						  // Bipod
		5 							  // Added Mag Count
	],
	[
		// Weapon select 1
		"hlc_smg_mp5a3_tac", 	 	 // Weapon
		["hlc_30Rnd_9x19_B_MP5",""], // Magazine and secondary magazine
		"", 						 // Muzzle
		"rhsusf_acc_m952v", 		 // Pointer
		"optic_holosight_blk_f", 	 // Sights
		"hlc_grip_pmvfg_black", 	 // Bipod
		5							 // Added Mag Count	
	]
];

_AddSecondaryWeapon = {

	Params ["_Unit","_WeaponArray"];
	_WeaponArray Params ["_Weapon","_MagArray","_Muzzle","_Pointer","_Sight","_Bipod","_MagCount"];
	[ 
		_unit, 
		_Weapon, 
		_MagArray, 
		_Muzzle, 
		_Pointer, 
		_Sight,
		_Bipod
	] call WKB_CreateWeaponSecond_Scripted;
	_unit addMagazines [_MagArray select 0,_MagCount];
};

switch (_role) do {
	case "tl": {
		[_unit,_Weapons select 0] call _AddSecondaryWeapon;
	};
	case "r": {
		[_unit,_Weapons select 0] call _AddSecondaryWeapon;
	};
	case "lr": {
		[_unit,_Weapons select 1] call _AddSecondaryWeapon;
	};
	case "g": {
		[_unit,_Weapons select 0] call _AddSecondaryWeapon;
	};
	case "ag": {
		[_unit,_Weapons select 1] call _AddSecondaryWeapon;
	};
	case "ar": {
		// No Weapon by Default
	};
	case "ammg": {
		// No Weapon by Default
	};
	case "mmg": {
		// No Weapon by Default
	};	
	case "marksman": {
		[_unit,_Weapons select 1] call _AddSecondaryWeapon;
	};		
	default {
		// No Weapon by Default
	};
};