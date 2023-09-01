/// [this] execVM "Scripts\OKS_Vehicles\OKS_Mortar.sqf";

Params
[
	["_Mortar", ObjNull, [ObjNull]]
];

_Mortar enableWeaponDisassembly false;
_Mortar addAction
[
	"<t color='#09F249'>Pack Weapon</t>",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		["Packing Mortar..", 3, {true}, {
			(_this select 0) params ["_target", "_caller", "_actionId"];
			_caller setVariable ["OKS_PackedClassname",typeOf _target,true];
			deleteVehicle _target;
			systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> typeOf _target] call BIS_fnc_displayName];
		},
		{
		},[_target, _caller, _actionId]] call CBA_fnc_progressBar;

	},
	nil,
	1.5,
	true,
	true,
	"",
	"alive _target && (_this getVariable ['OKS_PackedClassname',''] isEqualTo '') && count crew _target == 0 && vehicle _this != _target", // _target, _this, _originalTarget
	5,
	false,
	"",
	""
]



