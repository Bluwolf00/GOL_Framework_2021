/*
	Author: GuzzenVonLidl
	Toggle removal of all damage for player and bullets fired

	Usage:
	true call GW_StartUp_Fnc_WeaponLock;

	Arguments:
	0: Enable weaponlock <BOOL>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
#define CURRENT_WEAPONS player, currentWeapon player, currentMuzzle player

if (_this) then {
	player setCaptive true;
	player allowDamage false;
	player setVariable [QGVAR(weaponLock), true];
	if (GVARMAIN(mod_ACE3)) then {
		player setVariable ["ACE_Medical_AllowDamage", false];
		if ((currentWeapon player) in (player getVariable ["ACE_SafeMode_safedWeapons", []])) then {
			[CURRENT_WEAPONS] call ACE_SafeMode_fnc_lockSafety;
		};
	};
	systemChat "Weapon Lock: Enabled";
} else {
	player setCaptive false;
	player allowDamage true;
	player setVariable [QGVAR(weaponLock), false];
	if (GVARMAIN(mod_ACE3)) then {
		player setVariable ["ACE_Medical_AllowDamage", true];
		if ((currentWeapon player) in (player getVariable ["ACE_SafeMode_safedWeapons", []])) then {
			[CURRENT_WEAPONS] call ACE_SafeMode_fnc_unlockSafety;
		};
	};
	[{
		if (isNull (objectParent player)) then {
			player playActionNow (getText (configfile >> "CfgWeapons" >> (currentWeapon player) >> "reloadAction"));
		};
	}, [], (random 5)] call CBA_fnc_waitAndExecute;
	systemChat "Weapon Lock: Disabled";
};

/*
	{
		player removePrimaryWeaponItem _x;
	} forEach (primaryWeaponMagazine player);
	{
		player removeSecondaryWeaponItem _x;
	} forEach (secondaryWeaponMagazine player);
	{
		player removeHandgunItem _x;
	} forEach (handgunMagazine player);
*/
