
["CBA_settingsInitializedDelayed", {
	_interference = false;	// Sets whether transmissions will interfere with eachother. This, by default, causes signal loss when multiple people are transmitting on the same frequency.
	_fullDuplex = true;	// Sets the duplex of radio transmissions. If set to true, it means that you will receive transmissions even while talking and multiple people can speak at the same time.
	_ignoreAntennaDirection = true;
	_signalLoss = 0;	// Indiciates how much terrian loss should be modelled. Values: 0 no loss, 1 full terrian loss, default: 1
	_revealToAI = true;		// False - AI not hear players, true - AI hear players.

//	[false, true] call acre_api_fnc_setupMission;
	["acre_sys_core_interference", _interference, true, "server"] call CBA_settings_fnc_set;
	["acre_sys_core_fullDuplex", _fullDuplex, true, "server"] call CBA_settings_fnc_set;
	["acre_sys_core_ignoreAntennaDirection", _ignoreAntennaDirection, true, "server"] call CBA_settings_fnc_set;
	["acre_sys_core_terrainLoss", _signalLoss, true, "server"] call CBA_settings_fnc_set;
	["acre_sys_core_revealToAI", _revealToAI, true, "server"] call CBA_settings_fnc_set;

	[{

		{
			[_x, "default", 1, "label", "NET-SQUAD"] call acre_api_fnc_setPresetChannelField;
			[_x, "default", 2, "label", "NET-PLATOON"] call acre_api_fnc_setPresetChannelField;
			[_x, "default", 3, "label", "NET-FAC"] call acre_api_fnc_setPresetChannelField;
			[_x, "default", 4, "label", "NET-AAC"] call acre_api_fnc_setPresetChannelField;
		} forEach ["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"];	// No ACRE_PRC343
	}, [], 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
