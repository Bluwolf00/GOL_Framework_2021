/// [this, true,true] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";
/// [vehicle,ShouldAddMortar,AddServiceStationInCargo,ShouldDisableThermals,ShouldDisableNVG]
/// Add MSS Box true/false

if(!isServer) exitWith {};

Params
[
	["_Vehicle", ObjNull, [ObjNull]],
	["_Flag",nil,[""]],
	["_AddMortar", false, [true]],
	["_ServiceStation", true, [true]],
	["_ShouldDisableThermal", true, [true]],
	["_shouldDisableNVG", false, [true]],
	["_MortarType","heavy",[""]]
];

sleep 5;

if(!isNil "_Flag") then {
	_Vehicle forceFlagTexture _Flag;
};

Private _Debug_Variable = false;
_Vehicle setVariable ["GW_Disable_autoRemoveCargo",true,true];

clearItemCargoGlobal _Vehicle;
clearWeaponCargoGlobal _Vehicle;
clearMagazineCargoGlobal _Vehicle;
clearBackpackCargoGlobal _Vehicle;
_Vehicle setFuelConsumptionCoef 3;

if(_ShouldDisableThermal) then {
	_Vehicle disableTIEquipment true;
	_Vehicle setVariable ["A3TI_Disable", true,true];
};
if(_shouldDisableNVG) then {
	_Vehicle disableNVGEquipment true;
};

_Vehicle setVariable ["gw_gear_blackList",true,true];
waitUntil{!isNil "OKS_MISSION_SETTINGS"};
if(_Debug_Variable) then {SystemChat "Setting Cargo Space"};
waitUntil {sleep 1; !(isNil "ace_cargo_fnc_setSpace")};

_Vehicle spawn {
	Params ["_Vehicle"];
	while {alive _Vehicle} do {
		[_Vehicle, 40] call ace_cargo_fnc_setSpace;
		sleep 60;
	}
};

if(_ServiceStation && !(_Vehicle getVariable ["GOL_isMSS",false]) && GOL_NEKY_SERVICESTATION isEqualTo 1) then {
	if(_Debug_Variable) then {SystemChat "Adding Service Station Box"};
	_Crate = "Box_NATO_Support_F" createVehicle [0,0,0];
	ClearMagazineCargoGlobal _Crate;
	ClearWeaponCargoGlobal _Crate;
	ClearItemCargoGlobal _Crate;

	_fuelCan = "FlexibleTank_01_forest_F" createVehicle [0,0,0];
	[_fuelCan,100] call ace_refuel_fnc_makeJerryCan;

	//[_vehicle, ["car","west"]] call GW_Gear_Fnc_Init;
	waitUntil {!isNil "NEKY_MobileSS"};
	_MSS = [_Crate,_Vehicle,_fuelCan] spawn {
		Params ["_Crate","_Vehicle","_fuelCan"];
		[_Crate,25,true] remoteExec ["NEKY_MobileSS",0];
		_Crate setVariable ["ace_rearm_isSupplyVehicle", true];
		[_Crate,_Vehicle,true] call ace_cargo_fnc_loadItem;
		[_fuelCan,_Vehicle,true] call ace_cargo_fnc_loadItem;
	};
};

_Vehicle addItemCargoGlobal ["Toolkit",2];
_Vehicle addMagazineCargoGlobal ["SatchelCharge_Remote_Mag",5];
if(_AddMortar) then {
	if(_Debug_Variable) then {SystemChat "Adding Mortar Equipment"};
	//add a new backpack to the vehicle
	Switch (_MortarType) do {
		case "light": {
			_Vehicle addBackpackCargoGlobal ["PB_Bergen", 1];
			_Vehicle addWeaponCargoGlobal ["UK3CB_BAF_M6",2];
			_Vehicle addMagazineCargoGlobal ["UK3CB_BAF_1Rnd_60mm_Mo_Shells", 32];
		};
		case "heavy":{
			_Vehicle addBackpackCargoGlobal ["I_Mortar_01_weapon_F",1];
			_Vehicle addBackpackCargoGlobal ["I_Mortar_01_support_F",1];
		};
	};


	//Find the added backpack
	_BP = (everyBackpack _Vehicle) select (count (everyBackpack _Vehicle) - 1);

	if(!isNil "_BP") then {
		//Fill it with your stuff
		_BP addMagazineCargoGlobal ["UK3CB_BAF_1Rnd_60mm_Mo_Shells", 16];
	};
};


if (["FV432_Mk3_GPMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["Panther_GPMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["WMIK_GPMG",(typeOf _Vehicle)] call BIS_fnc_inString ) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_762_200Rnd_T",10];
};

if (["Passenger_HMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["L111A1",(typeOf _Vehicle)] call BIS_fnc_inString || ["FV432_Mk3_RWS",(typeOf _Vehicle)] call BIS_fnc_inString || ["LandRover_WMIK_HMG",(typeOf _Vehicle)] call BIS_fnc_inString ) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_127_100Rnd",10];
};

if(["L134A1",(typeOf _Vehicle)] call BIS_fnc_inString || ["WMIK_GMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["Passenger_GMG",(typeOf _Vehicle)] call BIS_fnc_inString) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_32Rnd_40mm_G_Box",10];
};

if(["WMIK_Milan",(typeOf _Vehicle)] call BIS_fnc_inString) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_1Rnd_Milan",5];
};

if(["WMIK",(typeOf _Vehicle)] call BIS_fnc_inString || ["Coyote",(typeOf _Vehicle)] call BIS_fnc_inString || ["Jackal2",(typeOf _Vehicle)] call BIS_fnc_inString  ) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_762_100Rnd_T",10];
};


if(_Debug_Variable) then {SystemChat "Add Smoke Generator and Smoke Ammo"};
// Add Smokegenerator and Smoke Screen Ammo
_Vehicle addweaponTurret ["rhs_weap_smokegen",[-1]];
_Vehicle AddMagazineTurret ["rhs_mag_smokegen",[-1]];

for [{private _i = 0}, {_i < 6}, {_i = _i + 1}] do {
	_Vehicle addMagazineTurret ["SmokeLauncherMag",[0,0]];
	_Vehicle addMagazineTurret ["rhsusf_mag_L8A3_8",[0,0]];
};

waitUntil {sleep 1; !(isNil "ace_cargo_fnc_loadItem") && !(isNil "ace_cargo_fnc_removeCargoItem")};
if(!(_Vehicle getVariable ["GOL_isMHQ",false])) then {
	["ACE_Wheel", _Vehicle, 4] call ace_cargo_fnc_removeCargoItem;
	["ACE_Track", _Vehicle, 4] call ace_cargo_fnc_removeCargoItem;
};

if(_Vehicle isKindOf "Tank" && !(_Vehicle getVariable ["GOL_isMHQ",false])) then {
	//systemChat "Is tank, giving tracks";
	if(_Debug_Variable) then {SystemChat "Is Tracked, giving Tracks"};
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;

};

if(_Vehicle isKindOf "Car" && !(_Vehicle getVariable ["GOL_isMHQ",false])) then {
	if(_Debug_Variable) then {SystemChat "Is Wheeled, giving Wheels"};
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
};

sleep 5;

// Fix APS - Automatic Smoke
if(_Debug_Variable) then {SystemChat "Remove dapsCanSmoke"};
_Vehicle setVariable["dapsCanSmoke",0,true];

/*
while{alive _Vehicle} do {
	if(_Vehicle getVariable "dapsCanSmoke" isEqualTo 1) then {
		if(_Debug_Variable) then {SystemChat "dapsCanSmoke detected. Removing Again..."};
		_Vehicle setVariable["dapsCanSmoke",0,true];
	};
	sleep 5;
};
*/



// _Vehicle spawn {
// 	_Vehicle = _this;
// 	while {alive _Vehicle} do {
// 		if(fuel _Vehicle > 0.4) then {
// 			_Vehicle setFuel 0.4;
// 		};
// 		sleep 30;
// 	}
// }