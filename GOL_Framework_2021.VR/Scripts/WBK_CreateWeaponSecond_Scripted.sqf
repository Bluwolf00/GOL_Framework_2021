WKB_CreateWeaponSecond_Scripted = {
	Params [
		["_unit",objNull,[objNull]],
		["_weap","arifle_MXC_F",[""]],
		["_primaryWeaponMagazine",["30Rnd_65x39_caseless_mag",""],[[]]],
		["_silencer","",[""]],
		["_laser","",[""]],
		["_optics","",[""]],
		["_bipod","",[""]]	
	];

	if (!(isNil {_unit getVariable "WBK_SecondWeapon"})) exitWith {};

	_primaryWeaponItems1 = _silencer;
	_primaryWeaponItems2 = _laser;
	_primaryWeaponItems3 = _optics;
	_primaryWeaponItems4 = _bipod;
	_primaryWeaponMagazine1 = _primaryWeaponMagazine select 0;
	_primaryWeaponMagazineGl = _primaryWeaponMagazine select 1;
	_primaryWeaponMagazine2 = [];

	systemChat str _primaryWeaponMagazine select 1;
	if(!isNil "(_primaryWeaponMagazine select 1)") then { systemChat "defined"} else {systemchat "undefined"};
	if (!(isNil "_primaryWeaponMagazineGl")) then {
		_primaryWeaponMagazine2 = [_primaryWeaponMagazineGl,getNumber(configFile >> "CfgMagazines" >> _primaryWeaponMagazineGl >> "count")];
	};

	_primaryWeapon = [
		_weap,
		_primaryWeaponItems1,
		_primaryWeaponItems2,
		_primaryWeaponItems3,
		[_primaryWeaponMagazine1, getNumber(configFile >> "CfgMagazines" >> _primaryWeaponMagazine1 >> "count")],
		_primaryWeaponMagazine2,
		_primaryWeaponItems4
	];
	_weaponHolder = createVehicle ["DummyWeapon_Wbk", getPosATL _unit, [], 0, "CAN_COLLIDE"];
	_weaponHolder addWeaponWithAttachmentsCargoGlobal [_primaryWeapon, 1];
    copyToClipboard str (_primaryWeapon);
	_unit setVariable ["WBK_SecondWeapon",[_weaponHolder,_primaryWeapon],true];

	if (WBK_LocalParamWhereWeaponIs == "Pelvis") then {
		[_unit,_weaponHolder,"Pelvis"] call WBK_AdjustGunPos;
	}
	else
	{
		[_unit,_weaponHolder,"Spine_normal"] call WBK_AdjustGunPos;
	};

	_unit removeWeapon _weap;
};