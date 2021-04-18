#include "script_Component.hpp"

if (GVARMAIN(mod_ACRE)) then {
};

if (GVARMAIN(mod_TFAR)) then {
	[QGVARMAIN(missionLoaded), {
		private _group = (group player);
		_group setVariable ["TF_sw_frequency", TF_freq_west];
		_group setVariable ["TF_dd_frequency", TF_freq_west];
		_group setVariable ["TF_lr_frequency", TF_freq_west_lr];
	}] call CBA_fnc_addEventHandler;

	[QGVARMAIN(playerReady), {
		player setVariable ["TF_receivingDistanceMultiplicator", 1];
		player setVariable ["TF_sendingDistanceMultiplicator", 0.7];
		player setVariable [QGVAR(receiving), (player getVariable "TF_receivingDistanceMultiplicator")];

		private _group = (group player);
		if !((_group getVariable "TF_lr_frequency") isEqualTo TF_freq_west_lr) then {
			_group setVariable ["TF_sw_frequency", TF_freq_west];
			_group setVariable ["TF_dd_frequency", TF_freq_west];
			_group setVariable ["TF_lr_frequency", TF_freq_west_lr];
			ERROR("Radio frequency failed, launching backup");
		};

		[player] spawn FUNC(interference);
	}] call CBA_fnc_addEventHandler;

	[QGVAR(setRadioLoss), {
		params ["_unit","_radioLossReceiving"];
		_unit setVariable ["TF_receivingDistanceMultiplicator", _radioLossReceiving];
//		systemChat format ["RadioLoss:%1", _radioLossReceiving]
	}] call CBA_fnc_addEventHandler;
};

/*
// Testing
[] spawn {
	while {true} do {
		_reciving = (player getVariable ["TF_receivingDistanceMultiplicator", 1]);
		_arr1 = (GVAR(allJamers) apply {_x distance player});
		_arr2 = (GVAR(allJamers) apply {_x distance player});
		_arr1 sort true;
		_object = (GVAR(allJamers) select (_arr2 find (_arr1 select 0)));

		hintSilent format ["%1  |  %2  |  %3", _reciving, round(player distance mhq_1), _object];
		sleep 0.1;
	};
};
*/
