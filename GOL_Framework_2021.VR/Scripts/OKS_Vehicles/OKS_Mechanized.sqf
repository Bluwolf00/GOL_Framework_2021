/// [this, true,true] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";
/// [vehicle,AddMHQGear,AddServiceStationInCargo]
/// Add MSS Box true/false

if(!isServer) exitWith {};

Params
[
	["_Vehicle", ObjNull, [ObjNull]],
	["_MHQ", false, [ObjNull]],
	["_ServiceStation", false, [ObjNull]]
];
Private _Debug_Variable = false;

clearItemCargoGlobal _Vehicle;
clearWeaponCargoGlobal _Vehicle;
clearMagazineCargoGlobal _Vehicle;


_Vehicle disableTIEquipment true;
_Vehicle setVariable ["A3TI_Disable", true];
_Vehicle setVariable ["gw_gear_blackList",true];

if(_Debug_Variable) then {SystemChat "Seting Cargo Space"};
waitUntil {sleep 5; !(isNil "ace_cargo_fnc_setSpace")};
[_Vehicle, 40] call ace_cargo_fnc_setSpace;
sleep 5;

if(_ServiceStation && !(_Vehicle getVariable ["GOL_isMSS",false])) then {
	if(_Debug_Variable) then {SystemChat "Adding Service Station Box"};
	_Crate = "Box_NATO_Support_F" createVehicle [0,0,0];
	ClearMagazineCargo _Crate;
	ClearWeaponCargo _Crate;
	ClearItemCargo _Crate;

	//[_vehicle, ["car","west"]] call GW_Gear_Fnc_Init;

	[_Crate,25,true] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
	_Crate setVariable ["ace_rearm_isSupplyVehicle", true];
	[_Crate,_Vehicle,true] call ace_cargo_fnc_loadItem;
};

_Vehicle addItemCargo ["Toolkit",2];

if(_MHQ) then {
	if(_Debug_Variable) then {SystemChat "Adding Mortar Equipment"};
	//add a new backpack to the vehicle

	_Vehicle addBackpackCargoGlobal ["PB_Bergen", 1];
	_Vehicle addWeaponCargoGlobal ["UK3CB_BAF_M6",2];
	_Vehicle addMagazineCargoGlobal ["UK3CB_BAF_1Rnd_60mm_Mo_Shells", 32];

	//Find the added backpack
	_BP = (everyBackpack _Vehicle) select (count (everyBackpack _Vehicle) - 1);

	if(!isNil "_BP") then {
		//Fill it with your stuff
		_BP addMagazineCargoGlobal ["UK3CB_BAF_1Rnd_60mm_Mo_Shells", 16];
	};
};



if (["FV432_Mk3_GPMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["Panther_GPMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["WMIK_GPMG",(typeOf _Vehicle)] call BIS_fnc_inString ) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_762_200Rnd_T",5];
};

if (["Passenger_HMG",(typeOf _Vehicle)] call BIS_fnc_inString || ["L111A1",(typeOf _Vehicle)] call BIS_fnc_inString || ["FV432_Mk3_RWS",(typeOf _Vehicle)] call BIS_fnc_inString || ["LandRover_WMIK_HMG",(typeOf _Vehicle)] call BIS_fnc_inString ) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_127_100Rnd",5];
};

if(["L134A1",(typeOf _Vehicle)] call BIS_fnc_inString || ["WMIK_GMG",(typeOf _Vehicle)] call BIS_fnc_inString) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_32Rnd_40mm_G_Box",5];
};

if(["WMIK_Milan",(typeOf _Vehicle)] call BIS_fnc_inString) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_1Rnd_Milan",5];
};

if(["WMIK",(typeOf _Vehicle)] call BIS_fnc_inString || ["Coyote",(typeOf _Vehicle)] call BIS_fnc_inString || ["Jackal2",(typeOf _Vehicle)] call BIS_fnc_inString  ) then {
	_Vehicle AddMagazineCargoGlobal ["UK3CB_BAF_762_100Rnd_T",5];
};


if(_Debug_Variable) then {SystemChat "Add Smoke Generator and Smoke Ammo"};
// Add Smokegenerator and Smoke Screen Ammo
_Vehicle addweaponTurret ["rhs_weap_smokegen",[-1]];
_Vehicle AddMagazineTurret ["rhs_mag_smokegen",[-1]];

for [{private _i = 0}, {_i < 6}, {_i = _i + 1}] do {
	_Vehicle addMagazineTurret ["SmokeLauncherMag",[0,0]];
	_Vehicle addMagazineTurret ["rhsusf_mag_L8A3_8",[0,0]];
};

waitUntil {sleep 1; !(isNil "ace_cargo_fnc_loadItem") && (isNil "ace_cargo_fnc_removeCargoItem")};
if(!(_Vehicle getVariable ["GOL_isMHQ",false])) then {
	["ACE_Wheel", _Vehicle, 10] call ace_cargo_fnc_removeCargoItem;
	["ACE_Track", _Vehicle, 10] call ace_cargo_fnc_removeCargoItem;
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
