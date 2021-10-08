/*
	Author: GuzzenVonLidl, Blu.
	Sets the correct gear for soldier, cargo for vehicles and ammo boxes

	Usage:
	[player, "sl"] call GW_Gear_Fnc_Handler;

	Arguments:
	0: Unit <OBJECT>
	1: Type of gear unit will get <STRING>

	Return Value: NO

	Public: YES

	Available Roles:
	pl		- Platoon leader			(Player)
	fac		- Forward Air Controller	(Player)
	sl		- Squad Leader				(Player)
	sm		- Squad Medic
	ftl		- Fire team leader
	r			- Rifleman
	g			- Grenadier
	ag		- Asst. Gunner
	ar		- Automatic Rifleman
	crew	- Crew memeber
	p			- Pilot
	jetp	- Jet Pilot
	mat		- Rifleman AT Medium
	amat	- Asst. Rifleman AT
	mmg		- Medium Machine Gunner
	ammg	- Asst. Medium Machine Gunner
*/
#include "script_Component.hpp"
#include "functions.sqf"

private [
	"_isMan","_isCar","_isTank","_type","_allowedNightStuff","_isCivilian","_isPlayer","_side","_errorCode","_loadout","_loadoutFile",
	"_addEquipment","_addLinkedItems","_addPrimary","_addLaunchers","_addHandGun","_addToUniform","_addToVest","_addToBackPack","_addBino",
	"_grenade","_grenademini",
	"_smokegrenadeW","_smokegrenadeB","_smokegrenadeG","_smokegrenadeO","_smokegrenadeP","_smokegrenadeR","_smokegrenadeY",
	"_chemB","_chemG","_chemR","_chemY",
	"_glHE","_glsmokeW","_glsmokeB","_glsmokeG","_glsmokeO","_glsmokeP","_glsmokeR","_glsmokeY","_glflareG","_glflareR","_glflareW",
	"_map","_gps","_compass","_watch","_nvg","_parachute","_demoCharge","_satchelCharge","_toolKit",
	"_cTab","_Android","_microDAGR","_HelmetCam",
	"_bandage","_blood","_epi","_morph","_IFAK","_FAKSmall","_FAKBig","_pak","_saline","_salineSm",
	"_barrel","_cables","_clacker","_defusalKit","_IRStrobe","_mapFlashLight","_mapTools","_rangefinder","_laserDesignator","_battery","_rangecard",
	"_flashBang","_handFlareG","_handFlareR","_handFlareW","_handFlareY",
	"_goggles","_helmet","_uniform","_vest","_backpack","_backpackRadio","_OfficerHelmet",
	"_silencer","_pointer","_sight","_bipod",
	"_rifle","_rifle_mag","_rifle_mag_tr",
	"_rifleL","_rifleL_mag","_rifleL_mag_tr",
	"_rifleC","_rifleC_mag","_rifleC_mag_tr",
	"_rifleGL","_rifleGL_mag","_rifleGL_mag_tr",
	"_rifleMarksman","_rifleMarksman_mag","_rifleMarksman_mag_tr",
	"_rifle_Diver","_rifle_Diver_mag","_rifle_Diver_mag_tr",
	"_LMG","_LMG_mag","_LMG_mag_tr",
	"_MMG","_MMG_mag","_MMG_mag_tr",
	"_LAT","_LAT_mag","_LAT_mag_HE","_LAT_ReUsable",
	"_MAT","_MAT_mag","_MAT_mag_HE",
	"_pistol","_pistol_mag","_pistol_mag_tr",
	"_useFactionRadio","_roleUseRadio","_useMineDetector","_mortarRangeCard","_ATrag","_Kestrel"
];

params [
	["_unit", objNull, [objNull]],
	["_role", "", ["",[]]],
	["_forceFaction", "", ["",[]]]
];

if !(_unit isEqualType objNull) exitWith {false};
if !(local _unit) exitWith {false};
//if (getNumber(configfile >> "CfgVehicles" >> (typeOf _unit) >> "side") isEqualTo 3) exitWith {false};	// Civilians

_isMan = _unit isKindOf "CAManBase";
_isCar = _unit isKindOf "Car";
_isTank = _unit isKindOf "Tank";
_errorCode = false;

if (_isMan) then {
	_loadout = [[],[],[],[],[],[],"","",[],[]];
	_loadoutFile = "Default";
	_useFactionRadio = true;
	_roleUseRadio = true;
	_allowedNightStuff = true;
	_useMineDetector = false;
	_isCivilian = (getNumber(configfile >> "CfgVehicles" >> (typeOf _unit) >> "side") isEqualTo 3);
	_isPlayer = (isPlayer _unit);
	_unit setVariable [QGVAR(Loadout), _role, _isPlayer];
	_unit setVariable ["BIS_enableRandomization", false];
	if (_isPlayer) then {
		_unit setVariable [QEGVAR(Common,isPlayer), true, true];
		_unit setUnitTrait ["engineer", true];
		_unit setUnitTrait ["explosiveSpecialist", true];
		if (GVARMAIN(mod_ACE3)) then {
			_unit setVariable ["ACE_Medical_MedicClass", 2];
			_unit setVariable ["ACE_IsEngineer", 1];
			_unit setVariable ["ACE_GForceCoef", 0.5];			// IsPilot
		};
	};

	if (_forceFaction isEqualTo "") then {
		switch (GETSIDE(_unit)) do {
			case 0: {
				_side = toUpper(GVAR(Opfor));
			};
			case 1: {
				_side = toUpper(GVAR(Blufor));
			};
			case 2: {
				_side = toUpper(GVAR(Independent));
			};
			case 3: {
				_side = toUpper(GVAR(Civilian));
			};
		};
	} else {
		_side = _forceFaction;
	};

	#include "..\Scripts\Common.sqf"
	#include "..\Scripts\factions.sqf"
	#include "isNilCheck.hpp"

	if (_isCivilian) then {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		["", "", "", "", "", ""] call _addLinkedItems;
	} else {
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg = "NVGoggles_Opfor";
		};

		if !(_isPlayer || (_unit in switchableUnits)) then {
			_loadoutFile = "Default_AI";
			_unit enableGunLights "forceOn";
		};

		switch (_loadoutFile) do {
			case "Default_AI": {
				#include "..\Scripts\Default_AI.sqf"
			};
			default {
				#include "..\Scripts\Default.sqf"
			};
		};
	};

	if !(_errorCode) then {
		_unit setUnitLoadout _loadout;

		if (_isPlayer && _useFactionRadio && _roleUseRadio) then {
			if (isClass ((missionConfigFile >> "GW_Modules" >> "Radios"))) then {
				[{
					_this call EFUNC(Radios,add);
				}, [_unit, _role], 0.1] call CBA_fnc_waitAndExecute;
			};
		};
		LOG(FORMAT_2("Unit: %1, Role: %2", _unit, _role));
	};
} else {
	_role params [
		["_class", "", [""]],
		["_realSide", (_unit getVariable [QGVAR(side), (EGVAR(Common,Faction))]), [""]],
		["_movable", true, [true]]
	];

	_isVehicle = (_unit isKindOf "AllVehicles");

	if !(_isVehicle) Then {
		[_unit, _movable] call ACE_Dragging_fnc_setCarryable;
		[_unit, _movable] call ACE_Dragging_fnc_setDraggable;
		if !(_movable) then {  // Enable Move Object
			_unit enableRopeAttach false;
		};
	} else {
		if (locked _unit >= 2) then {
			_class = "locked";
		};
	};

	private _side = toUpper(GVAR(Civilian));
	switch (toLower(_realSide)) do {
		case "west": {
			_side = toUpper(GVAR(Blufor));
		};

		case "east": {
			_side = toUpper(GVAR(Opfor));
		};

		case "indep": {
			_side = toUpper(GVAR(Independent));
		};

		case "independent": {
			_side = toUpper(GVAR(Independent));
		};
	};

	#include "..\Scripts\Common.sqf"
	#include "..\Scripts\factions.sqf"
	#include "isNilCheck.hpp"

	ClearWeaponCargoGlobal _unit;
	ClearMagazineCargoGlobal _unit;
	ClearItemCargoGlobal _unit;
	ClearBackpackCargoGlobal _unit;

	if !(_errorCode) then {
		switch (_class) do {
			case "gearbox": {
				[_unit] remoteExecCall [QFUNC(actions), 0, true];	// Enables gear actions for all players
				[_unit, "Toolkit", 10] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_M6", 5] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_Shells", 30] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_AB_Shells", 30] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_Flare_White", 20] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_WPSmoke_White", 20] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_Smoke_White", 20] call _fnc_AddObjectsCargo;
				[_unit, "42cdo_vs17_item", 5] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeY, 20] call _fnc_AddObjectsCargo;
				[_unit, _glflareW, 20] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 20] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeG, 5] call _fnc_AddObjectsCargo;
				[_unit, "B_UavTerminal", 10] call _fnc_AddObjectsCargo;
				[_unit, "O_UavTerminal", 10] call _fnc_AddObjectsCargo;
				[_unit, "I_UavTerminal", 10] call _fnc_AddObjectsCargo;
				if(!(_LAT_ReUsable)) then {
					[_unit, (_LAT select 0), 20] call _fnc_AddObjectsCargo;
				};
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, "ACE_EarPlugs", 50] call _fnc_AddObjectsCargo;
					if (isClass (configFile >> "CfgPatches" >> "GW_StaticWeapons")) then {
						private _staticWeaponList = ["ACE_B_SpottingScope"];
						if (toLower(_realSide) isEqualTo "west") then {
							_staticWeaponList = _staticWeaponList + ["B_static_AA_F","B_Mortar_01_F","B_GMG_01_F","B_HMG_01_F","B_HMG_01_high_F","B_static_AT_F"];
							if (GVARMAIN(mod_CUP_WEAPONS)) then {
								_staticWeaponList = _staticWeaponList + ["CUP_B_TOW_TriPod_USMC","CUP_B_M2StaticMG_USMC","CUP_B_M2StaticMG_MiniTripod_USMC"];
							};
						};
						if (toLower(_realSide) isEqualTo "east") then {
							_staticWeaponList = ["O_static_AA_F","O_Mortar_01_F","O_GMG_01_F","O_HMG_01_F","O_HMG_01_high_F","O_static_AT_F"];
							if (GVARMAIN(mod_CUP_WEAPONS)) then {
								_staticWeaponList = _staticWeaponList + ["CUP_O_KORD_RU","CUP_O_KORD_high_RU","CUP_O_SPG9_ChDKZ","CUP_O_Metis_RU"];
							};
						};
						if ((toLower(_realSide) isEqualTo "independent") || (toLower(_realSide) isEqualTo "indep")) then {
							_staticWeaponList = ["I_static_AA_F","I_Mortar_01_F","I_GMG_01_F","I_HMG_01_F","I_HMG_01_high_F","I_static_AT_F"];
						};
						private _action = ["GW_GetStatics","Static Weapons","",{},{true}] call ace_interact_menu_fnc_createAction;
						[_unit, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

						{
							private _action = format ["GW_GetStatics_%1", _x];
							private _name = format ["%1", getText(configFile >> "CfgVehicles" >> _x >> "DisplayName")];
							private _statement = {
							    params ["_target", "_player", "_params"];
								_player setVariable [QEGVAR(StaticWeapons,type), _params];
								_player addItem "GW_Item_StaticDummy";
							};
							private _condition = {
							    params ["", "_player"];
								!("GW_Item_StaticDummy" in (items player)) || ((_player getVariable [QEGVAR(StaticWeapons,type), ""]) isEqualTo "")
							};
							private _action = [_action, _name, "", _statement, _condition, {}, _x] call ace_interact_menu_fnc_createAction;
							[_unit, 0, ["ACE_MainActions","GW_GetStatics"], _action] call ace_interact_menu_fnc_addActionToObject;
						} forEach _staticWeaponList;

					};
					[_unit, _mortarRangeCard, 10] call _fnc_AddObjectsCargo;
				};

				if(GVARMAIN(mod_ACE3) && (isNil "GOL_ARSENAL_ALLOWED" || GOL_ARSENAL_ALLOWED isEqualTo 1)) then {

					_compatibleItems = ((_rifle select 0) call BIS_fnc_compatibleItems);
					{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach ((_rifleC select 0) call BIS_fnc_compatibleItems);
					{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach ((_pistol select 0) call BIS_fnc_compatibleItems);
					{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach ((_LMG select 0) call BIS_fnc_compatibleItems);
					{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach ((_MMG select 0) call BIS_fnc_compatibleItems);

					/*
					_compatibleItems append ((_rifleC select 0) call BIS_fnc_compatibleItems);
					_compatibleItems append ((_pistol select 0) call BIS_fnc_compatibleItems);
					_compatibleItems append ((_LMG select 0) call BIS_fnc_compatibleItems);
					_compatibleItems append ((_MMG select 0) call BIS_fnc_compatibleItems);
					*/

					_blackList = ["rhsusf_acc_g33_T1","rhsusf_acc_g33_T1_flip","rhsusf_acc_g33_xps3","rhsusf_acc_g33_xps3_flip","rhsusf_acc_g33_xps3_tan","rhsusf_acc_g33_xps3_tan_flip","ACE_acc_pointer_green","ACE_acc_pointer_green_ir","ACE_acc_pointer_red","acc_pointer_ir","acc_pointer_ir_broken","rhsusf_acc_anpeq15_top_h","rhsusf_acc_anpeq15_top_sc","rhsusf_acc_anpeq15_wmx_sc","rhsusf_acc_anpeq15_wmx_h","rhsusf_acc_anpeq15_wmx_light_sc","rhsusf_acc_anpeq15_wmx_light_h","rhsusf_acc_anpeq15_bk_top_h","rhsusf_acc_anpeq15_bk_top_sc","rhsusf_acc_anpeq15_h","rhsusf_acc_anpeq15_sc","rhsusf_acc_anpeq15_light_sc","rhsusf_acc_anpeq15_light_h","rhsusf_acc_anpeq15_bk_h","rhsusf_acc_anpeq15_bk_sc","rhsusf_acc_anpeq15_bk_light_sc","rhsusf_acc_anpeq15_bk_light_h","rhsusf_acc_anpeq16a_top_sc","rhsusf_acc_anpeq16a_top_h","rhsusf_acc_anpeq16a_light_top_sc","rhsusf_acc_anpeq16a_light_top_h","rhsusf_acc_anpas13gv1","hlc_charm_herstal","hlc_charm_izhmash","hlc_charm_teethgang","rhsusf_acc_anpvs27","hlc_isopod"];
					_whiteList = ["rhs_weap_optic_smaw"];

						_CV = 0;
						For [{_CV = 1}, {_CV < (count _compatibleItems)}, {_CV = _CV + 1}] do {
							If ((_compatibleItems select (_CV - 1)) in _blackList) then {
							  _compatibleItems deleteAt (_compatibleItems find (_compatibleItems select (_CV - 1)));
								_CV = _CV - 1;
							};

							_opticMag = (["",(configfile >> "CfgWeapons" >> (_compatibleItems select (_CV - 1)))] call ace_arsenal_fnc_statTextStatement_scopeMag);
							_opticMag = parseNumber _opticMag;

								if(GOL_MAGNIFIED_OPTICS isEqualTo 0 || isNil "GOL_MAGNIFIED_OPTICS") then {
									If (_opticMag > 1 || _opticMag == 0.9) then {
										_compatibleItems deleteAt (_compatibleItems find (_compatibleItems select (_CV - 1)));
										_CV = _CV - 1;
									};
								} else {
									if (_opticMag > 2 || _opticMag == 0.9) then {
										_compatibleItems deleteAt (_compatibleItems find (_compatibleItems select (_CV - 1)));
										_CV = _CV - 1;
									};
								};
							};

							_compatibleItems append _whiteList;
					[_unit, _compatibleItems] call ace_arsenal_fnc_initBox;
				};
				if (GVARMAIN(mod_TFAR)) then {
					[_unit, "TFAR_pnr1000a", 10] call _fnc_AddObjectsCargo;
					[_unit, "TFAR_anprc152", 10] call _fnc_AddObjectsCargo;
				};
				if (GVARMAIN(mod_ACRE)) then {
					[_unit, "ACRE_PRC343", 10] call _fnc_AddObjectsCargo;
					[_unit, "ACRE_PRC148", 10] call _fnc_AddObjectsCargo;
					[_unit, "ACRE_PRC117F", 10] call _fnc_AddObjectsCargo;
				};
			};

			case "tiny_box": {
				[_unit, _glHE, 10] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 6] call _fnc_AddObjectsCargo;
				[_unit, _glflareW, 6] call _fnc_AddObjectsCargo;
				[_unit, _glflareR, 6] call _fnc_AddObjectsCargo;
				[_unit, _glflareG, 6] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 6] call _fnc_AddObjectsCargo;
				[_unit, _grenademini, 6] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 12] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeB, 5] call _fnc_AddObjectsCargo;

				[_unit, _bandage, 20] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, "ACE_salineIV", 10] call _fnc_AddObjectsCargo;
					if ((EGVAR(Settings_ACE,medical_level) isEqualTo 2) || (ace_medical_level isEqualTo 2)) then {
						[_unit, "ACE_elasticBandage", 100] call _fnc_AddObjectsCargo;
						[_unit, "ACE_tourniquet", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_quikclot", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_atropine", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_salineIV", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_personalAidKit", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_surgicalKit", 50] call _fnc_AddObjectsCargo;
					};
				};

				[_unit, _pistol_mag, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 6] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, (COUNT_AR_MAGS(_LMG_mag) * 2)] call _fnc_AddObjectsCargo;
				[_unit, _MMG_mag, (COUNT_AR_MAGS(_MMG_mag) * 1)] call _fnc_AddObjectsCargo;

				if (_LAT_ReUsable) then {
					[_unit, _LAT_mag, 2] call _fnc_AddObjectsCargo;
				} else {
					[_unit, (_LAT select 0), 2] call _fnc_AddObjectsCargo;
				};
				[_unit, _MAT_mag, 2] call _fnc_AddObjectsCargo;

				[_unit, _demoCharge, 4] call _fnc_AddObjectsCargo;
				[_unit, _satchelCharge, 2] call _fnc_AddObjectsCargo;
			};

			case "small_box": {
				[_unit, _glHE, 20] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 20] call _fnc_AddObjectsCargo;
				[_unit, _glflareW, 20] call _fnc_AddObjectsCargo;
				[_unit, _glflareR, 10] call _fnc_AddObjectsCargo;
				[_unit, _glflareG, 10] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 20] call _fnc_AddObjectsCargo;
				[_unit, _grenademini, 20] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 20] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeG, 5] call _fnc_AddObjectsCargo;

				[_unit, _bandage, 40] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, "ACE_salineIV", 15] call _fnc_AddObjectsCargo;
					if ((EGVAR(Settings_ACE,medical_level) isEqualTo 2) || (ace_medical_level isEqualTo 2)) then {
						[_unit, "ACE_elasticBandage", 100] call _fnc_AddObjectsCargo;
						[_unit, "ACE_tourniquet", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_quikclot", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_atropine", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_salineIV", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_personalAidKit", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_surgicalKit", 50] call _fnc_AddObjectsCargo;
					};
				};

				[_unit, _pistol_mag, 10] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag, 9] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 9] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag, 3] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 3] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag, 7] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 7] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, (COUNT_AR_MAGS(_LMG_mag) * 4)] call _fnc_AddObjectsCargo;
				[_unit, _MMG_mag, (COUNT_AR_MAGS(_MMG_mag) * 2)] call _fnc_AddObjectsCargo;

				if (_LAT_ReUsable) then {
					[_unit, _LAT_mag, 3] call _fnc_AddObjectsCargo;
				} else {
					[_unit, (_LAT select 0), 3] call _fnc_AddObjectsCargo;
				};
				[_unit, _MAT_mag, 3] call _fnc_AddObjectsCargo;

				[_unit, _demoCharge, 4] call _fnc_AddObjectsCargo;
				[_unit, _satchelCharge, 2] call _fnc_AddObjectsCargo;
			};

			case "big_box": {
				[_unit, _glHE, 50] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 40] call _fnc_AddObjectsCargo;
				[_unit, _glflareR, 40] call _fnc_AddObjectsCargo;
				[_unit, _glflareG, 40] call _fnc_AddObjectsCargo;
				[_unit, _glflareW, 40] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 60] call _fnc_AddObjectsCargo;
				[_unit, _grenademini, 60] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 60] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeG, 15] call _fnc_AddObjectsCargo;

				[_unit, _bandage, 50] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, "ACE_salineIV", 25] call _fnc_AddObjectsCargo;
					if ((EGVAR(Settings_ACE,medical_level) isEqualTo 2) || (ace_medical_level isEqualTo 2)) then {
						[_unit, "ACE_elasticBandage", 100] call _fnc_AddObjectsCargo;
						[_unit, "ACE_tourniquet", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_quikclot", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_atropine", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_salineIV", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_personalAidKit", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_surgicalKit", 50] call _fnc_AddObjectsCargo;
					};
				};

				[_unit, _pistol_mag, 20] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag, 15] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 15] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag, 10] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 10] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag, 15] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 15] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, ((COUNT_AR_MAGS(_LMG_mag)) * 8)] call _fnc_AddObjectsCargo;
				[_unit, _MMG_mag, ((COUNT_AR_MAGS(_MMG_mag)) * 4)] call _fnc_AddObjectsCargo;

				if (_LAT_ReUsable) then {
					[_unit, _LAT_mag, 8] call _fnc_AddObjectsCargo;
					[_unit, _LAT_mag_HE, 3] call _fnc_AddObjectsCargo;
				} else {
					[_unit, (_LAT select 0), 6] call _fnc_AddObjectsCargo;
				};

				[_unit, _MAT_mag, 4] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag_HE, 4] call _fnc_AddObjectsCargo;

				[_unit, _demoCharge, 8] call _fnc_AddObjectsCargo;
				[_unit, _satchelCharge, 4] call _fnc_AddObjectsCargo;
			};

			case "med_box": {
				[_unit, _bandage, 100] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, _morph, 50] call _fnc_AddObjectsCargo;
					[_unit, _epi, 50] call _fnc_AddObjectsCargo;
					_tourn = "ACE_tourniquet";
					[_unit, _tourn, 50] call _fnc_AddObjectsCargo;
					[_unit, _blood, 50] call _fnc_AddObjectsCargo;
					if ((EGVAR(Settings_ACE,medical_level) isEqualTo 2) || (ace_medical_level isEqualTo 2)) then {
						[_unit, "ACE_elasticBandage", 100] call _fnc_AddObjectsCargo;
						[_unit, "ACE_tourniquet", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_quikclot", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_atropine", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_salineIV", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_personalAidKit", 50] call _fnc_AddObjectsCargo;
						[_unit, "ACE_surgicalKit", 50] call _fnc_AddObjectsCargo;
					};
				};
			};

			case "car": {

				[_unit, _bandage, 5] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 6] call _fnc_AddObjectsCargo;

				[_unit, _pistol_mag, 10] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag, 10] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag_tr, 3] call _fnc_AddObjectsCargo;

				[_unit, _demoCharge, 1] call _fnc_AddObjectsCargo;
				if (_LAT_ReUsable) then {
					[_unit, (_LAT select 0), 1] call _fnc_AddObjectsCargo;
					[_unit, _LAT_mag, 4] call _fnc_AddObjectsCargo;
				} else {
					[_unit, (_LAT select 0), 4] call _fnc_AddObjectsCargo;
				};
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, 15] call ace_cargo_fnc_setSpace;
					[_unit, 8, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
				};
			};

			case "tank": {
				[_unit, _bandage, 5] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 2] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeP, 2] call _fnc_AddObjectsCargo;
				[_unit, _pistol_mag, 3] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag, 4] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, 15] call ace_cargo_fnc_setSpace;
					[_unit, 6, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
				};
			};

			case "heli": {
				[_unit, "B_Parachute", (count fullCrew [_unit,"",true])] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeP, 2] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 10] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, _morph, 5] call _fnc_AddObjectsCargo;
					[_unit, _epi, 5] call _fnc_AddObjectsCargo;
					[_unit, _blood, 5] call _fnc_AddObjectsCargo;
				};
			};

			case "plane": {
				[_unit, "B_Parachute", (count fullCrew [_unit,"",true])] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeP, 2] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 10] call _fnc_AddObjectsCargo;
				if (GVARMAIN(mod_ACE3)) then {
					[_unit, _morph, 5] call _fnc_AddObjectsCargo;
					[_unit, _epi, 5] call _fnc_AddObjectsCargo;
					[_unit, _blood, 5] call _fnc_AddObjectsCargo;
				};
			};

			case "locked": {
				LOG(FORMAT_1("Vehicle is locked: %1", _unit));
			};

			default {
				LOG("Error in Cargo faction");
			};
		};
	};
};

true
