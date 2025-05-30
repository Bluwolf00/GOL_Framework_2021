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
	"_compatibleItems","_opticValues",
	"_isMan","_isCar","_isTank","_type","_allowedNightStuff","_isCivilian","_isPlayer","_side","_errorCode","_loadout","_loadoutFile","_insignia",
	"_addEquipment","_addLinkedItems","_addPrimary","_addLaunchers","_addHandGun","_addToUniform","_addToVest","_addToBackPack","_addBino",
	"_grenade","_grenademini",
	"_smokegrenadeW","_smokegrenadeB","_smokegrenadeG","_smokegrenadeO","_smokegrenadeP","_smokegrenadeR","_smokegrenadeY",
	"_chemB","_chemG","_chemR","_chemY",
	"_glHE","_glHEDP","_glsmokeW","_glsmokeB","_glsmokeG","_glsmokeO","_glsmokeP","_glsmokeR","_glsmokeY","_glflareG","_glflareR","_glflareW",
	"_map","_gps","_compass","_watch","_nvg","_parachute","_demoCharge","_satchelCharge","_toolKit",
	"_cTab","_Android","_microDAGR","_HelmetCam",
	"_bandage","_blood","_epi","_morph","_IFAK","_FAKSmall","_FAKMedium","_FAKSquad","_FAKPlatoon","_pak","_saline","_salineSm",
	"_barrel","_cables","_clacker","_defusalKit","_IRStrobe","_mapFlashLight","_mapTools","_rangefinder","_laserDesignator","_battery","_rangecard",
	"_flashBang","_handFlareG","_handFlareR","_handFlareW","_handFlareY",
	"_goggles","_helmet","_uniform","_vest","_backpack","_backpackRadio","_OfficerHelmet",
	"_silencer","_pointer","_sight","_bipod",
	"_rifle","_rifle_mag","_rifle_mag_tr",
	"_rifleL","_rifleL_mag","_rifleL_mag_tr",
	"_rifleC","_rifleC_mag","_rifleC_mag_tr",
	"_pdw","_pdw_mag","_pdw_mag_tr",
	"_rifleGL","_rifleGL_mag","_rifleGL_mag_tr",
	"_rifleMarksman","_rifleMarksman_mag","_rifleMarksman_mag_tr",
	"_rifle_Diver","_rifle_Diver_mag","_rifle_Diver_mag_tr",
	"_LMG","_LMG_mag","_LMG_mag_tr",
	"_MMG","_MMG_mag","_MMG_mag_tr",
	"_LAT","_LAT_mag","_LAT_mag_HE","_LAT_ReUsable",
	"_MAT","_MAT_mag","_MAT_mag_HE",
	"_HAT","_HAT_mag","_HAT_mag_HE",
	"_AA","_AA_Mag",
	"_pistol","_pistol_mag","_pistol_mag_tr",
	"_useFactionRadio","_roleUseRadio","_useMineDetector","_mortarRangeCard","_ATrag","_Kestrel","_wirecutter","_UAVTerminal"
];

params [
	["_unit", objNull, [objNull]],
	["_role", "", ["",[]]],
	["_forceFaction", nil, ["",[]]]
];

if !(_unit isEqualType objNull) exitWith {false};
if !(local _unit) exitWith {false};

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

	_roleArray = [_role];
	switch (_role) do {
		case "pl": { _DisplayName = "Platoon Leader"; _roleArray pushBack _DisplayName};
		case "pm": { _DisplayName = "Platoon Medic"; _roleArray pushBack _DisplayName};
		case "drone": { _DisplayName = "Drone Operator"; _roleArray pushBack _DisplayName};
		case "mortar": { _DisplayName = "Mortar Operator"; _roleArray pushBack _DisplayName};
		case "fac": { _DisplayName = "Forward Air Controller"; _roleArray pushBack _DisplayName};
		case "sl": { _DisplayName = "Squad Leader"; _roleArray pushBack _DisplayName};
		case "sm": { _DisplayName = "Squad Medic"; _roleArray pushBack _DisplayName};
		case "ftl": { _DisplayName = "Fireteam Leader"; _roleArray pushBack _DisplayName};
		case "r": { _DisplayName = "Rifleman"; _roleArray pushBack _DisplayName};
		case "g": { _DisplayName = "Grenadier"; _roleArray pushBack _DisplayName};
		case "ag": { _DisplayName = "Asst. Gunner"; _roleArray pushBack _DisplayName};
		case "ar": { _DisplayName = "Automatic Rifleman"; _roleArray pushBack _DisplayName};
		case "ammg": { _DisplayName = "Asst. Medium Machine Gunner"; _roleArray pushBack _DisplayName};
		case "mmg": { _DisplayName = "Medium Machine Gunner"; _roleArray pushBack _DisplayName};
		case "crew": { _DisplayName = "Vehicle Crew"; _roleArray pushBack _DisplayName};
		case "dragon": { _DisplayName = "Dragon"; _roleArray pushBack _DisplayName};
		case "lr": { _DisplayName = "Light Rifleman"; _roleArray pushBack _DisplayName};
		case "ab": { _DisplayName = "Ammo Bearer"; _roleArray pushBack _DisplayName};
		case "aa": { _DisplayName = "Anti-Air"; _roleArray pushBack _DisplayName};
		case "ahat": { _DisplayName = "Asst. Heavy AT"; _roleArray pushBack _DisplayName};
		case "hat": { _DisplayName = "Heavy AT"; _roleArray pushBack _DisplayName};
		case "amat": { _DisplayName = "Asst. Heavy AT"; _roleArray pushBack _DisplayName};
		case "mat": { _DisplayName = "Heavy AT"; _roleArray pushBack _DisplayName};		
		case "p": { _DisplayName = "Chopper Pilot"; _roleArray pushBack _DisplayName};
		case "pj": { _DisplayName = "Para-Rescueman"; _roleArray pushBack _DisplayName};
		case "jetp": { _DisplayName = "Jet Pilot"; _roleArray pushBack _DisplayName};
		case "marksman": { _DisplayName = "Marksman"; _roleArray pushBack _DisplayName};		
	};
	_unit setVariable ["GOL_SelectedRole",_roleArray,true];

	if(time > 10 && isPlayer _unit) then {
		format["%1 has selected the %2 kit.",name _unit,_roleArray select 1] remoteExec ["systemChat",0];
	};

	_unit setVariable ["BIS_enableRandomization", false];
	if (_isPlayer) then {
		_unit setVariable [QEGVAR(Common,isPlayer), true, true];
		_unit setUnitTrait ["engineer", true];
		_unit setUnitTrait ["explosiveSpecialist", true];
		_unit setUnitTrait ["uavhacker", true];
		if (true) then {
			_unit setVariable ["ACE_Medical_MedicClass", 1, true];
			_unit setVariable ["ACE_IsEngineer", 1, true];
			

			if(_unit getVariable ["GOL_SelectedRole",""] in ["jetp","p","crew"]) then {
				_unit setVariable ["ACE_IsEngineer", 2, true];
				_unit setVariable ["ACE_Medical_MedicClass", 2, true];
				_unit setVariable ["ACE_GForceCoef", 0.5];			// IsPilot
			};
		};
	};

	if (isNil "_forceFaction") then {
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

	if(side group _unit == EAST) then {
		_UAVTerminal = "O_UavTerminal"
	};

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
		if(!isNil "_insignia") then {
			if(_insignia isEqualTo "" && _isPlayer) then {
				[_unit,"GOL_Insignia_Hellfish"] call BIS_fnc_setUnitInsignia;
			} else {
				[_unit,_insignia] call BIS_fnc_setUnitInsignia;
			}
		};		

		if (isMultiplayer || isDedicated) then
		{
			[_isPlayer,_unit] spawn {

				Params ["_isPlayer","_unit"];

				if(!_isPlayer) then { break; };
				
				_unit spawn {
					waitUntil {sleep 1; !isNil "OKS_TFAR_RadioSetup"};
					_this spawn OKS_TFAR_RadioSetup;
				};
			};
		};
		LOG(FORMAT_2("Unit: %1, Role: %2", _unit, _role));
	};
	
	if (_unit getVariable ["acex_headless_blacklist", true] == true) then {
        _unit spawn {
            sleep 5;
            _this setVariable ["acex_headless_blacklist", false, true]; // Gear applied therefore transfer unit to HC
        };
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

	if (!isNil "_forceFaction") then {
		switch (toLower _forceFaction) do {
			case "west": {
				_side = toUpper(GVAR(Blufor));
			};
			case "east": {
				_side = toUpper(GVAR(Opfor));
			};
			case "independent": {
				_side = toUpper(GVAR(Independent));
			};
			case "civilian": {
				_side = toUpper(GVAR(Civilian));
			};
		};
	};

	#include "..\Scripts\Common.sqf"
	#include "..\Scripts\factions.sqf"
	#include "isNilCheck.hpp"

	if !(_unit getVariable ["GW_Disable_autoRemoveCargo",false]) then {
		ClearWeaponCargoGlobal _unit;
		ClearMagazineCargoGlobal _unit;
		ClearItemCargoGlobal _unit;
		ClearBackpackCargoGlobal _unit;
	};

	if !(_errorCode) then {
		switch (_class) do {
			case "gearbox": {
				[_unit] remoteExecCall [QFUNC(actions), 0, true];	// Enables gear actions for all players
				[_unit, _Earplugs, 20] call _fnc_AddObjectsCargo;
				[_unit, "Toolkit", 10] call _fnc_AddObjectsCargo;						
				[_unit, "UK3CB_BAF_M6", 5] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_HE", 15] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_HEAB", 15] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_Smoke", 15] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_Flare", 15] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_Shells", 30] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_AB_Shells", 30] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_Flare_White", 20] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_WPSmoke_White", 20] call _fnc_AddObjectsCargo;
				[_unit, "UK3CB_BAF_1Rnd_60mm_Mo_Smoke_White", 20] call _fnc_AddObjectsCargo;
				[_unit, "42cdo_vs17_item", 15] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeY, 20] call _fnc_AddObjectsCargo;
				[_unit, _glflareW, 20] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 20] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeB, 10] call _fnc_AddObjectsCargo;

				[_unit, "B_UavTerminal", 10] call _fnc_AddObjectsCargo;
				[_unit, "O_UavTerminal", 10] call _fnc_AddObjectsCargo;
				[_unit, "I_UavTerminal", 10] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_HMG", 6] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_GMG", 6] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Mortar", 6] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_AT", 6] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Drone_AP", 30] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Drone_AT", 30] call _fnc_AddObjectsCargo;				
				[_unit, "GOL_Packed_Drone_Recon", 15] call _fnc_AddObjectsCargo;				
				[_unit, "GOL_Packed_Drone_Supply", 10] call _fnc_AddObjectsCargo;				
				[_unit, _MAT_mag_HE, 10] call _fnc_AddObjectsCargo;
				[_unit, (_LAT select 0), 30] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, "ACE_EarPlugs", 50] call _fnc_AddObjectsCargo;
					[_unit, _mortarRangeCard, 10] call _fnc_AddObjectsCargo;			
				};

				if(OKS_Arsenal isEqualTo true) then {

					_compatibleItems = [];

					if(typeName _uniform == "ARRAY") then {
						{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach (_uniform);	
					} else {
						if !(_X in _compatibleItems) then {_compatibleItems pushBack _uniform}
					};

					if(typeName _vest == "ARRAY") then {
						{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach (_vest);
					} else {
						 if !(_X in _compatibleItems) then {_compatibleItems pushBack _vest}
					};

					if(typeName _backpack == "ARRAY") then {
						{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach (_backpack);
					} else {
						 if !(_X in _compatibleItems) then {_compatibleItems pushBack _backpack}
					};

					if(typeName _helmet == "ARRAY") then {
						{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach (_helmet);
					} else {
						 if !(_X in _compatibleItems) then {_compatibleItems pushBack _helmet}
					};

					if(typeName _goggles == "ARRAY") then {
						{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach (_goggles);
					} else {
						 if !(_X in _compatibleItems) then {_compatibleItems pushBack _goggles}
					};
					
					if(typeName _backpackRadio == "ARRAY") then {
						{ if !(_X in _compatibleItems) then {_compatibleItems pushBack _X}} foreach (_backpackRadio);
					} else {
						 if !(_X in _compatibleItems) then {_compatibleItems pushBack _backpackRadio}
					};		

					_blackList = ["rhsusf_acc_SpecterDR_pvs27","JCA_optic_IHO_black_magnifier","JCA_optic_IHO_olive_magnifier","JCA_optic_IHO_sand_magnifier","JCA_optic_MROS_sand_magnifier","JCA_optic_MROS_olive_magnifier","JCA_optic_MROS_black_magnifier","rhsusf_acc_su230","rhsusf_acc_g33_T1","rhsusf_acc_g33_T1_flip","rhsusf_acc_g33_xps3","rhsusf_acc_g33_xps3_flip","rhsusf_acc_g33_xps3_tan","rhsusf_acc_g33_xps3_tan_flip","ACE_acc_pointer_green","ACE_acc_pointer_green_ir","ACE_acc_pointer_red","acc_pointer_ir","acc_pointer_ir_broken","rhsusf_acc_anpeq15_top_h","rhsusf_acc_anpeq15_top_sc","rhsusf_acc_anpeq15_wmx_sc","rhsusf_acc_anpeq15_wmx_h","rhsusf_acc_anpeq15_wmx_light_sc","rhsusf_acc_anpeq15_wmx_light_h","rhsusf_acc_anpeq15_bk_top_h","rhsusf_acc_anpeq15_bk_top_sc","rhsusf_acc_anpeq15_h","rhsusf_acc_anpeq15_sc","rhsusf_acc_anpeq15_light_sc","rhsusf_acc_anpeq15_light_h","rhsusf_acc_anpeq15_bk_h","rhsusf_acc_anpeq15_bk_sc","rhsusf_acc_anpeq15_bk_light_sc","rhsusf_acc_anpeq15_bk_light_h","rhsusf_acc_anpeq16a_top_sc","rhsusf_acc_anpeq16a_top_h","rhsusf_acc_anpeq16a_light_top_sc","rhsusf_acc_anpeq16a_light_top_h","rhsusf_acc_anpas13gv1"];
					_whiteList = ["rhs_weap_optic_smaw"];							

					if(OKS_Optics isEqualTo true) then {
						if(OKS_MagnifiedOptics isEqualTo true) then {
							_opticValues = ["1.0x"]
						} else {
							_opticValues = ["1.0x","1.0x-2.0x"]
						};

						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_rifle select 0) call BIS_fnc_compatibleItems);

						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_rifleC select 0) call BIS_fnc_compatibleItems);

						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_rifleL select 0) call BIS_fnc_compatibleItems);

						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_rifleGL select 0) call BIS_fnc_compatibleItems);	

						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_LMG select 0) call BIS_fnc_compatibleItems);																
					
						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_MMG select 0) call BIS_fnc_compatibleItems);

						{
							_DoesExistInArray = (_X in _compatibleItems);
							_ScopeMagnificationInArray = (["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag) in _opticValues;
							_IsNotSight = ["",(configfile >> "CfgWeapons" >> _X)] call ace_arsenal_fnc_statTextStatement_scopeMag == "?";
							_IsBlackListed = (_X in _blackList);					
		
							if ((!(_DoesExistInArray) && !(_IsBlackListed)) && (_ScopeMagnificationInArray || _IsNotSight)) then {						
								_compatibleItems pushBack _X;
							};
						} foreach ((_pistol select 0) call BIS_fnc_compatibleItems);

						{	
							if(_X in _blackList) then {
								_compatibleItems deleteAt (_compatiblesItems find _X);
							};
						} forEach _compatibleItems;

					};

					_compatibleItemsGL = [];
					{_compatibleItemsGL pushBackUnique _X} foreach _compatibleItems;

					_compatibleItemsLMG = [];
					{_compatibleItemsLMG pushBackUnique _X} foreach _compatibleItems;

					//systemChat str _compatibleItems;
				 	//copyToClipboard str _compatibleItems;
					if(OKS_Weapons isEqualTo true) then {
						if(TYPENAME (_rifle select 0) == "ARRAY") then {
							{
								if !(_X in _compatibleItems) then {_compatibleItems pushBack _X};
							} foreach (_rifle select 0);							
						};	
						if(TYPENAME (_rifleC select 0) == "ARRAY") then {
							{
								if !(_X in _compatibleItems) then {_compatibleItems pushBack _X};
							} foreach (_rifleC select 0);							
						};	
						if(TYPENAME (_rifleGL select 0) == "ARRAY") then {
							{
								if !(_X in _compatibleItemsGL) then {_compatibleItemsGL pushBack _X};
							} foreach (_rifleGL select 0);							
						};	
						if(TYPENAME (_LMG select 0) == "ARRAY") then {
							{
								if !(_X in _compatibleItemsLMG) then {_compatibleItemsLMG pushBack _X};
							} foreach (_LMG select 0);							
						};																															
					};

					_compatibleItems append _whiteList;

					[_unit, _compatibleItems] call ace_arsenal_fnc_initBox;			
					[GOL_Arsenal_LMG, _compatibleItemsLMG] call ace_arsenal_fnc_initBox;
					[GOL_Arsenal_GL, _compatibleItemsGL] call ace_arsenal_fnc_initBox;
				};
				if (true) then {
					[_unit, "TFAR_pnr1000a", 10] call _fnc_AddObjectsCargo;
					[_unit, "TFAR_anprc152", 10] call _fnc_AddObjectsCargo;
				};
				if (false) then {
					[_unit, "ACRE_PRC343", 10] call _fnc_AddObjectsCargo;
					[_unit, "ACRE_PRC148", 10] call _fnc_AddObjectsCargo;
					[_unit, "ACRE_PRC117F", 10] call _fnc_AddObjectsCargo;
				};
			};

			case "drone_box": {		
				[_unit, _glHEDP, 10] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 4] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 5] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 5] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeB, 2] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 15] call _fnc_AddObjectsCargo;
				[_unit, _morph, 5] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, _epi, 5] call _fnc_AddObjectsCargo;
					[_unit, "ACE_salineIV", 5] call _fnc_AddObjectsCargo;
					[_unit, _flashBang, 2] call _fnc_AddObjectsCargo;
					[_unit, true, [0, 1.5, 0], 0, true] call ace_dragging_fnc_setDraggable;
					[_unit, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
				};

				[_unit, _pistol_mag, 3] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 5] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 5] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 5] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, (COUNT_AR_MAGS(_LMG_mag) * 0.5)] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag, 2] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag_HE, 1] call _fnc_AddObjectsCargo;
				[_unit, (_LAT select 0), 2] call _fnc_AddObjectsCargo;
				[_unit, _demoCharge, 2] call _fnc_AddObjectsCargo;

				if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
					[_unit, _glflareW, 4] call _fnc_AddObjectsCargo;
					[_unit, _glflareR, 4] call _fnc_AddObjectsCargo;
					[_unit, _handFlareG, 3] call _fnc_AddObjectsCargo;
					[_unit, _handFlareW, 3] call _fnc_AddObjectsCargo;
					[_unit, _handFlareR, 3] call _fnc_AddObjectsCargo;
					[_unit, _chemB, 3] call _fnc_AddObjectsCargo;
					[_unit, _chemR, 3] call _fnc_AddObjectsCargo;
					[_unit, _chemG, 3] call _fnc_AddObjectsCargo;	
					[_unit, "ACE_Chemlight_HiGreen", 3] call _fnc_AddObjectsCargo;
					[_unit, "ACE_Chemlight_HiBlue", 3] call _fnc_AddObjectsCargo;
					[_unit, "B_IR_Grenade", 3] call _fnc_AddObjectsCargo;											
				};		
			};			

			case "tiny_box": {		
				[_unit, _glHEDP, 16] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 8] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 8] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 10] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeB, 4] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 30] call _fnc_AddObjectsCargo;
				[_unit, _morph, 15] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, _epi, 5] call _fnc_AddObjectsCargo;
					[_unit, "ACE_salineIV", 10] call _fnc_AddObjectsCargo;
					[_unit, _flashBang, 2] call _fnc_AddObjectsCargo;
					[_unit, true, [0, 1.5, 0], 0, true] call ace_dragging_fnc_setDraggable;
					[_unit, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
				};

				[_unit, _pistol_mag, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 12] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 12] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 12] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, (COUNT_AR_MAGS(_LMG_mag) * 1.5)] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag, 4] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag_HE, 4] call _fnc_AddObjectsCargo;
				[_unit, (_LAT select 0), 3] call _fnc_AddObjectsCargo;
				[_unit, _demoCharge, 4] call _fnc_AddObjectsCargo;

				if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
					[_unit, _glflareW, 16] call _fnc_AddObjectsCargo;
					[_unit, _glflareR, 8] call _fnc_AddObjectsCargo;
					[_unit, _handFlareG, 8] call _fnc_AddObjectsCargo;
					[_unit, _handFlareW, 8] call _fnc_AddObjectsCargo;
					[_unit, _handFlareR, 8] call _fnc_AddObjectsCargo;
					[_unit, _chemB, 6] call _fnc_AddObjectsCargo;
					[_unit, _chemR, 6] call _fnc_AddObjectsCargo;
					[_unit, _chemG, 3] call _fnc_AddObjectsCargo;		
					[_unit, "ACE_Chemlight_HiGreen", 6] call _fnc_AddObjectsCargo;
					[_unit, "ACE_Chemlight_HiBlue", 6] call _fnc_AddObjectsCargo;
					[_unit, "B_IR_Grenade", 8] call _fnc_AddObjectsCargo;				
				};		
			};

			case "tiny_box_special": {
				[_unit, _glHEDP, 16] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 8] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 8] call _fnc_AddObjectsCargo;				
				[_unit, _smokegrenadeY, 8] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeB, 6] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 20] call _fnc_AddObjectsCargo;
				[_unit, _morph, 15] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, "ACE_salineIV", 10] call _fnc_AddObjectsCargo;
					[_unit, _epi, 5] call _fnc_AddObjectsCargo;
					[_unit, true, [0, 1.5, 0], 0, true] call ace_dragging_fnc_setDraggable;
					[_unit, true, [0,1,1], 0, true] call ace_dragging_fnc_setCarryable;
				};
				[_unit, _pistol_mag, 8] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 10] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 8] call _fnc_AddObjectsCargo;
				[_unit, _rifleL_mag_tr, 8] call _fnc_AddObjectsCargo;
				[_unit, _rifleMarksman_mag_tr, 10] call _fnc_AddObjectsCargo;
				[_unit, _MMG_mag, (COUNT_AR_MAGS(_MMG_mag) * 1.5)] call _fnc_AddObjectsCargo;
				[_unit, _HAT_mag, 3] call _fnc_AddObjectsCargo;
				[_unit, _AA_mag, 4] call _fnc_AddObjectsCargo;
				[_unit, _demoCharge, 4] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_HE", 5] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_HEAB", 5] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_Smoke", 5] call _fnc_AddObjectsCargo;
				
				[_unit, "GOL_Packed_Drone_AT", 4] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Drone_AP", 4] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Drone_Recon", 1] call _fnc_AddObjectsCargo;				

				if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
					[_unit, _glflareW, 16] call _fnc_AddObjectsCargo;
					[_unit, _glflareR, 8] call _fnc_AddObjectsCargo;
					[_unit, _handFlareG, 8] call _fnc_AddObjectsCargo;
					[_unit, _handFlareW, 8] call _fnc_AddObjectsCargo;
					[_unit, _handFlareR, 8] call _fnc_AddObjectsCargo;
					[_unit, _chemB, 6] call _fnc_AddObjectsCargo;
					[_unit, _chemR, 6] call _fnc_AddObjectsCargo;
					[_unit, _chemG, 3] call _fnc_AddObjectsCargo;	
					[_unit, "ACE_Chemlight_HiGreen", 6] call _fnc_AddObjectsCargo;
					[_unit, "ACE_Chemlight_HiBlue", 6] call _fnc_AddObjectsCargo;
					[_unit, "B_IR_Grenade", 8] call _fnc_AddObjectsCargo;	
					[_unit, "GOL_Packed_60mm_Flare", 5] call _fnc_AddObjectsCargo;											
				};				
			};

			case "small_box": {
				[_unit, _glHEDP, 24] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 20] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 16] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 15] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeB, 5] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 50] call _fnc_AddObjectsCargo;
				[_unit, _morph, 25] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, "ACE_salineIV", 25] call _fnc_AddObjectsCargo;
					[_unit, _epi, 10] call _fnc_AddObjectsCargo;
					[_unit, _flashBang, 10	] call _fnc_AddObjectsCargo;
				};

				[_unit, _pistol_mag, 12] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag, 9] call _fnc_AddObjectsCargo;
				[_unit, _rifle_mag_tr, 9] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag, 7] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 7] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag, 9] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 9] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, (COUNT_AR_MAGS(_LMG_mag) * 3)] call _fnc_AddObjectsCargo;
				[_unit, _MMG_mag, (COUNT_AR_MAGS(_MMG_mag) * 1)] call _fnc_AddObjectsCargo;

				[_unit, "GOL_Packed_60mm_HE", 8] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_HEAB", 8] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_Smoke", 5] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_60mm_Flare", 5] call _fnc_AddObjectsCargo;				
				[_unit, "GOL_Packed_Drone_AT", 8] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Drone_AP", 8] call _fnc_AddObjectsCargo;
				[_unit, "GOL_Packed_Drone_Recon", 2] call _fnc_AddObjectsCargo;
				if (_LAT_ReUsable) then {
					[_unit, _LAT_mag, 6] call _fnc_AddObjectsCargo;
				} else {
					[_unit, (_LAT select 0), 6] call _fnc_AddObjectsCargo;
				};
				[_unit, _MAT_mag, 6] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag_HE, 6] call _fnc_AddObjectsCargo;
				[_unit, _HAT_mag, 2] call _fnc_AddObjectsCargo;
				[_unit, _HAT_mag_HE, 2] call _fnc_AddObjectsCargo;
				[_unit, _demoCharge, 4] call _fnc_AddObjectsCargo;

				if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
					[_unit, _glflareW, 24] call _fnc_AddObjectsCargo;
					[_unit, _glflareR, 10] call _fnc_AddObjectsCargo;
					[_unit, _glflareG, 10] call _fnc_AddObjectsCargo;
					[_unit, _handFlareG, 10] call _fnc_AddObjectsCargo;
					[_unit, _handFlareW, 10] call _fnc_AddObjectsCargo;
					[_unit, _handFlareR, 10] call _fnc_AddObjectsCargo;
					[_unit, _chemB, 12] call _fnc_AddObjectsCargo;
					[_unit, _chemR, 12] call _fnc_AddObjectsCargo;
					[_unit, _chemG, 6] call _fnc_AddObjectsCargo;
					[_unit, "ACE_Chemlight_HiGreen", 12] call _fnc_AddObjectsCargo;
					[_unit, "ACE_Chemlight_HiBlue", 12] call _fnc_AddObjectsCargo;
					[_unit, "B_IR_Grenade", 12] call _fnc_AddObjectsCargo;										
				};
			};

			case "big_box": {
				[_unit, _glHEDP, 50] call _fnc_AddObjectsCargo;
				[_unit, _glsmokeR, 40] call _fnc_AddObjectsCargo;
				[_unit, _glflareR, 40] call _fnc_AddObjectsCargo;
				[_unit, _glflareG, 40] call _fnc_AddObjectsCargo;
				[_unit, _glflareW, 40] call _fnc_AddObjectsCargo;
				[_unit, _grenade, 60] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeY, 60] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeG, 15] call _fnc_AddObjectsCargo;

				[_unit, _bandage, 40] call _fnc_AddObjectsCargo;
				[_unit, _morph, 20] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, "ACE_salineIV", 40] call _fnc_AddObjectsCargo;
					[_unit, _flashBang, 15] call _fnc_AddObjectsCargo;
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
				[_unit, _rifle_mag_tr, 20] call _fnc_AddObjectsCargo;
				[_unit, _rifleC_mag_tr, 6] call _fnc_AddObjectsCargo;
				[_unit, _rifleGL_mag_tr, 20] call _fnc_AddObjectsCargo;
				[_unit, _LMG_mag, ((COUNT_AR_MAGS(_LMG_mag)) * 3)] call _fnc_AddObjectsCargo;
				[_unit, _MMG_mag, ((COUNT_AR_MAGS(_MMG_mag)) * 2)] call _fnc_AddObjectsCargo;

				if (_LAT_ReUsable) then {
					[_unit, _LAT_mag, 4] call _fnc_AddObjectsCargo;
					[_unit, _LAT_mag_HE, 2] call _fnc_AddObjectsCargo;
				} else {
					[_unit, (_LAT select 0), 4] call _fnc_AddObjectsCargo;
				};

				[_unit, _MAT_mag, 4] call _fnc_AddObjectsCargo;
				[_unit, _MAT_mag_HE, 2] call _fnc_AddObjectsCargo;

				[_unit, _demoCharge, 6] call _fnc_AddObjectsCargo;
				[_unit, _satchelCharge, 2] call _fnc_AddObjectsCargo;
			};

			case "med_box": {
				[_unit, _bandage, 100] call _fnc_AddObjectsCargo;
				if (true) then {
					//[_unit, _morph, 50] call _fnc_AddObjectsCargo;
					//[_unit, _epi, 50] call _fnc_AddObjectsCargo;
					[_unit, "ACE_personalAidKit", 5] call _fnc_AddObjectsCargo;
					_tourn = "ACE_tourniquet";
					[_unit, _tourn, 20] call _fnc_AddObjectsCargo;
					[_unit, "ACE_salineIV", 50] call _fnc_AddObjectsCargo;
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

			case "med_box_tiny": {
				[_unit, _bandage, 60] call _fnc_AddObjectsCargo;
				if (true) then {
					_tourn = "ACE_tourniquet";
					[_unit, _tourn, 8] call _fnc_AddObjectsCargo;
					[_unit, "ACE_salineIV", 40] call _fnc_AddObjectsCargo;
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
				if (true) then {
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
				if (true) then {
					[_unit, 15] call ace_cargo_fnc_setSpace;
					[_unit, 6, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
				};
			};

			case "heli": {
				[_unit, "B_Parachute", (count fullCrew [_unit,"",true])] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeP, 2] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 10] call _fnc_AddObjectsCargo;
				if (true) then {
					[_unit, _morph, 5] call _fnc_AddObjectsCargo;
					[_unit, _epi, 5] call _fnc_AddObjectsCargo;
					[_unit, _blood, 5] call _fnc_AddObjectsCargo;
				};
			};

			case "plane": {
				[_unit, "B_Parachute", (count fullCrew [_unit,"",true])] call _fnc_AddObjectsCargo;
				[_unit, _smokegrenadeP, 2] call _fnc_AddObjectsCargo;
				[_unit, _bandage, 10] call _fnc_AddObjectsCargo;
				if (true) then {
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
