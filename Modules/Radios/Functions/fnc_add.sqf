/*
	Author: GuzzenVonLidl
	Gives the unit the radios from his role in Gear handlern

	Usage:
	["sl", "TF_rt1523g"] call GW_Radios_fnc_add;

	Arguments:
	0: Role <STRING>
	1: Classname(Backpack) <STRING>

	Return Value: NO

	Public: NO
*/
#include "script_Component.hpp"

params ["_unit","_role"];

private _radioSmall = ["sl","sm","ftl","r","g","ag","ar","mat","amat","ammg","mmg"];
private _radioMedium = ["pl","fac","ftl","p","crew","marksman"];

if (GVARMAIN(mod_TFAR)) then {
	if ({_x call TFAR_fnc_isRadio} count (items _unit + assignedItems _unit) > 0) then {
		{
			if (_x call TFAR_fnc_isRadio || _x isEqualTo "ItemRadio") then {
				_unit removeItem _x;
				_unit unlinkItem _x;
			};
		} forEach (items _unit + assignedItems _unit);
	};

	if (_role in _radioSmall) then {
		_unit linkItem "tf_pnr1000a";
	};
	if (_role in _radioMedium) then {
		if (_role in _radioSmall) then {
			_unit addItem "tf_anprc152";
		} else {
			_unit linkItem "tf_anprc152";
		};
	};
} else {
	if (GVARMAIN(mod_ACRE)) then {
		private _radioBP = ["pl","fac","sl","p"];
		private _time = 1;
		if ((time < 5) || didJip) then { // For first connection
			_time = 5;
		};
		if (_role in _radioSmall) then {
			_unit addItem "ACRE_PRC343";
		};
		if (_role in _radioMedium) then {
			_unit addItem "ACRE_PRC148";
		};
		if (_role in _radioBP) then {
			private _loadout = (getUnitLoadout _unit);
			_loadout set [5, [((_loadout select 5) select 0), ([["ACRE_PRC117F",1]] + ((_loadout select 5) select 1))]];
			_unit setUnitLoadout _loadout;
		};

		[{
			#define	TrimID ([format ["%1", (groupid (group _unit))], 2, 2] call BIS_fnc_trimString)
			params ["_unit","_role"];

			private _group343List = ["sl","sm","ftl","r","g","ag","ar","mat","amat","ammg","mmg"];
			private _groupNet = 0;
			private _1stNet = 1;
			private _2ndNet = 2;
			private _platoonNet = 1;
			private _facNet = 2;
			private _aacNet = 3;

			if (_role in _group343List) then {
				if (TrimID isEqualTo "1") then {
					_groupNet = _1stNet;
				};
				if (TrimID isEqualTo "2") then {
					_groupNet = _2ndNet;
				};
				[["ACRE_PRC343"] call acre_api_fnc_getRadioByType, _groupNet] call acre_api_fnc_setRadioChannel;
			};

			switch (_role) do {
				case "pl": {
					[["ACRE_PRC148"] call acre_api_fnc_getRadioByType, _platoonNet] call acre_api_fnc_setRadioChannel;
					[["ACRE_PRC117F"] call acre_api_fnc_getRadioByType, _facNet] call acre_api_fnc_setRadioChannel;
				};
				case "fac": {
					[["ACRE_PRC148"] call acre_api_fnc_getRadioByType, _platoonNet] call acre_api_fnc_setRadioChannel;
					[["ACRE_PRC117F"] call acre_api_fnc_getRadioByType, _facNet] call acre_api_fnc_setRadioChannel;
				};
				case "sl": {
					[["ACRE_PRC148"] call acre_api_fnc_getRadioByType, _groupNet] call acre_api_fnc_setRadioChannel;
					[["ACRE_PRC117F"] call acre_api_fnc_getRadioByType, _platoonNet] call acre_api_fnc_setRadioChannel;
				};
				case "ftl": {
					[["ACRE_PRC148"] call acre_api_fnc_getRadioByType, _platoonNet] call acre_api_fnc_setRadioChannel;
				};
				case "p": {
					[["ACRE_PRC148"] call acre_api_fnc_getRadioByType, _facNet] call acre_api_fnc_setRadioChannel;
					[["ACRE_PRC117F"] call acre_api_fnc_getRadioByType, _aacNet] call acre_api_fnc_setRadioChannel;
				};
			};
		}, [_unit, _role], _time] call CBA_fnc_waitAndExecute;
	};
};
