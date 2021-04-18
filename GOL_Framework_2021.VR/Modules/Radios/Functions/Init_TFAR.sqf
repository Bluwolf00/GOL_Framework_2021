
if (GVARMAIN(mod_TFAR_CORE)) then {
	["CBA_settingsInitializedDelayed", {	// TFAR calls cba settings in postInit so this needs a delay
		_disableAutoLongRange = true;
		_givePersonalRadio = false;
		_giveMicroDager = false;
		_same_SW_Freq = true;
		_same_LR_Freq = true;
		_fullDuplex = true;
		_enableIntercom = true;
		_objectInterceptionEnabled = true;
		_spectatorCanHearEnemyUnits = true;
		_spectatorCanHearFriendlies = true;

		["TFAR_giveLongRangeRadioToGroupLeaders", _disableAutoLongRange, true, "server"] call CBA_settings_fnc_set;
		["TFAR_givePersonalRadioToRegularSoldier", _givePersonalRadio, true, "server"] call CBA_settings_fnc_set;
		["TFAR_giveMicroDagrToSoldier", _giveMicroDager, true, "server"] call CBA_settings_fnc_set;
		["TFAR_SameSRFrequenciesForSide", _same_SW_Freq, true, "server"] call CBA_settings_fnc_set;
		["TFAR_SameLRFrequenciesForSide", _same_LR_Freq, true, "server"] call CBA_settings_fnc_set;
		["TFAR_fullDuplex", _fullDuplex, true, "server"] call CBA_settings_fnc_set;
		["TFAR_enableIntercom", _enableIntercom, true, "server"] call CBA_settings_fnc_set;
		["TFAR_objectInterceptionEnabled", _objectInterceptionEnabled, true, "server"] call CBA_settings_fnc_set;
		["TFAR_spectatorCanHearEnemyUnits", _spectatorCanHearEnemyUnits, true, "server"] call CBA_settings_fnc_set;
		["TFAR_spectatorCanHearFriendlies", _spectatorCanHearFriendlies, true, "server"] call CBA_settings_fnc_set;
	}] call CBA_fnc_addEventHandler;
} else {
	["CBA_settingsInitializedDelayed", {
		_disableAutoLongRange = true;
		_givePersonalRadio = false;
		_giveMicroDager = false;
		_same_SW_Freq = true;
		_same_LR_Freq = true;
		_same_DD_Freq = true;

		["TF_no_auto_long_range_radio", _disableAutoLongRange, true, "server"] call CBA_settings_fnc_set;
		["TF_give_personal_radio_to_regular_soldier", _givePersonalRadio, true, "server"] call CBA_settings_fnc_set;
		["TF_give_microdagr_to_soldier", _giveMicroDager, true, "server"] call CBA_settings_fnc_set;
		["TF_same_sw_frequencies_for_side", _same_SW_Freq, true, "server"] call CBA_settings_fnc_set;
		["TF_same_lr_frequencies_for_side", _same_LR_Freq, true, "server"] call CBA_settings_fnc_set;
		["TF_same_dd_frequencies_for_side", _same_DD_Freq, true, "server"] call CBA_settings_fnc_set;
	}] call CBA_fnc_addEventHandler;
};

TF_west_radio_code = "_golclan";
TF_east_radio_code = "_golclan";
TF_guer_radio_code = "_golclan";

TF_freq_west =    [0 ,6, ["10","20","30","40","50.1","50.2","50.3","50.5"],0, nil, -1, 0];
TF_freq_west_lr = [4 ,6, ["10","20","30","40","50.1","50.2","50.3","50.4","50.5"],0, nil, -1, 0];
TF_freq_east  =   TF_freq_west;
TF_freq_east_lr = TF_freq_west_lr;
TF_freq_guer  =   TF_freq_west;
TF_freq_guer_lr = TF_freq_west_lr;

TF_defaultWestAirborneRadio = "TF_rt1523g";
TF_defaultWestBackpack = "TF_rt1523g";
TF_defaultWestPersonalRadio = "TF_anprc152";
TF_defaultWestRiflemanRadio = "TF_pnr1000a";

TF_defaultEastAirborneRadio = TF_defaultWestAirborneRadio;
TF_defaultEastBackpack = TF_defaultWestBackpack;
TF_defaultEastPersonalRadio = TF_defaultWestPersonalRadio;
TF_defaultEastRiflemanRadio = TF_defaultWestRiflemanRadio;

TF_defaultGuerAirborneRadio = TF_defaultWestAirborneRadio;
TF_defaultGuerBackpack = TF_defaultWestBackpack;
TF_defaultGuerPersonalRadio = TF_defaultWestPersonalRadio;
TF_defaultGuerRiflemanRadio = TF_defaultWestRiflemanRadio;

//	NOTE: Experamental values
TF_terrain_interception_coefficient = 10.0;	 // 7.0
TF_max_voice_volume = 60;
TF_speakerDistance = 20;
