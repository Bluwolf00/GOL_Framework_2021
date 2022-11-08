Params ["_Vehicle","_ShouldChangeDoorGuns"];

// How to use (in init of vehicle):
// _null = [] execVM "OKS_AAC\OKS_DAP_Config.sqf";


/*if (TypeOf _Vehicle  == "CUP_B_UH1Y_Gunship_Dynamic_USMC" || TypeOf _Vehicle == "CUP_O_UH1H_gunship_TKA" || TypeOf _Vehicle == "CUP_B_MH47E_USA" || TypeOf _Vehicle == "CUP_B_UH1D_armed_GER_KSK" || typeOf _Vehicle == "CUP_B_UH1D_slick_GER_KSK" ||
typeOf _Vehicle == "CUP_B_UH1D_slick_GER_KSK_Des" || typeOf _Vehicle == "CUP_B_UH1D_gunship_GER_KSK_Des" || typeOf _Vehicle == "CUP_B_UH1D_gunship_GER_KSK" || typeOf _Vehicle == "CUP_B_UH1D_GER_KSK_Des" || typeOf _Vehicle == "CUP_B_UH1D_armed_GER_KSK_Des" || typeOf _Vehicle == "CUP_B_UH1D_GER_KSK") then
*/

/// VTX Guns: vtx_wpn_m134 vtx_wpn_m134_2nd vtx_2000Rnd_65x39_Belt_Tracer_Red

OKS_Global_Air_Array = [];

OKS_AIR_CONFIG = {

	Params["_Vehicle","_ShouldChangeDoorGuns"];

		if !(_Vehicle in OKS_Global_Air_Array && _vehicle isKindOf "Helicopter") then {
			if(_ShouldChangeDoorGuns) then {		
				if (["UH1",TypeOf _Vehicle] call BIS_fnc_inString || ["MH47",TypeOf _Vehicle] call BIS_fnc_inString || ["CH47", TypeOf _Vehicle] call BIS_fnc_inString) then
				{
					_vehicle removeWeaponTurret ["LMG_Minigun_Transport",[1]];
					_vehicle removeWeaponTurret ["LMG_Minigun_Transport2",[2]];
					_vehicle removeWeaponTurret ["rhs_weap_m134_minigun_1",[1]];
					_vehicle removeWeaponTurret ["rhs_weap_m134_minigun_2",[2]];

					//// Add Weapon
					if (Count (_vehicle weaponsTurret [0]) < 1) then {
					_vehicle addWeaponTurret ["rhs_weap_yakB",[0]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[0]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[0]];
					};

					if (Count (_vehicle weaponsTurret [1]) < 1) then {
					_vehicle addWeaponTurret ["rhs_weap_yakB",[1]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[1]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[1]];
					};
				};
				if (["UH60",TypeOf _Vehicle] call BIS_fnc_inString || ["MH60",TypeOf _Vehicle] call BIS_fnc_inString || ["RHS_UH1Y",TypeOf _Vehicle] call BIS_fnc_inString || ["RHS_CH_47",TypeOf _Vehicle] call BIS_fnc_inString) then {

					_vehicle removeWeaponTurret ["LMG_Minigun_Transport",[1]];
					_vehicle removeWeaponTurret ["LMG_Minigun_Transport2",[2]];
					_vehicle removeWeaponTurret ["rhs_weap_m134_minigun_1",[1]];
					_vehicle removeWeaponTurret ["rhs_weap_m134_minigun_2",[2]];

					//// Add Weapon
					if (Count (_vehicle weaponsTurret [1]) < 1) then {
						_vehicle addWeaponTurret ["rhs_weap_yakB",[1]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[1]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[1]];
					};

					if (Count (_vehicle weaponsTurret [2]) < 1) then {
						_vehicle addWeaponTurret ["rhs_weap_yakB",[2]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[2]];
						_vehicle addMagazineTurret ["rhs_mag_127x108mm_1slt_1470",[2]];					
					};
				};
			};

			_null = [_vehicle] spawn OKS_Interact_Apply;
			OKS_Global_Air_Array pushBackUnique _Vehicle;
		};	
};

if(isNull _Vehicle) then {
	while {true} do {
		{ _null = [_X,_ShouldChangeDoorGuns] spawn OKS_AIR_CONFIG; } forEach entities "helicopter";
		sleep 30;
	};
} else {
	[_Vehicle,_ShouldChangeDoorGuns] spawn OKS_AIR_CONFIG; 
};
