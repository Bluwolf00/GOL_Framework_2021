#include "script_Component.hpp"

LOG("Prepping all main functions");
PREPMAIN(changeSetting);
PREPMAIN(Log);
PREPMAIN(LogAdmin);
PREPMAIN(remoteCommand);
PREPMAIN(settingsInit);
PREPMAINFOLDER(spawnList);

LOG("Prepping all main variables");
enableSaving [false, false];
enableEngineArtillery true;
enableSentences false;
enableRadio false;
enableTeamSwitch false;
useAISteeringComponent true;
0 fadeRadio 0;
//	enableSatNormalOnDetail true;		//	<--------

GVARMAIN(settings3denArray) = [];
GVARMAIN(Version) = (getText(missionConfigFile >> "GW_FRAMEWORK" >> "Core" >> "Version"));

//if (false) then {
if (is3DEN) then {
	if !(GVARMAIN(mod_GW)) exitWith {
		["ADDON is not loaded, Exiting Framework","WARNING"] spawn BIS_fnc_3DENShowMessage;
	};
	if (GVARMAIN(mod_GW) && ((getNumber (configFile >> "CfgPatches" >> "GW_Main" >> "version")) < 0.7)) exitWith {
		["ADDON And Framework versions are not compatible!   Exiting Framework","WARNING"] spawn BIS_fnc_3DENShowMessage;
	};
};

LOG("Prepping modules");
#define CORE_Modules (missionConfigFile >> "gw_Modules")
private ["_Modules","_postLoad"];
_Modules = [];
GVARMAIN(logModules) = [];
GVARMAIN(postLoad) = [];

for "_i" from 0 to ((count CORE_Modules) - 1) step 1 do {
	_Modules pushBack (CORE_Modules select _i);
};

{
	private ["_config","_Name","_Authors","_Version","_preInit","_postInit","_Description","_requiredModules"];
	_config = (missionConfigFile >> "gw_Modules" >> configName(_x));
	_Name = getText( _config >> "name");
	_Authors = getArray( _config >> "authors");
	_Version = getNumber( _config >> "version");
	_preInit = getText( _config >> "preInit");
	_postInit = getText( _config >> "postInit");
	_Description = getText( _config >> "description");
	_requiredModules = getArray( _config >> "requiredModules");
	_requiredAddon = getArray( _config >> "requiredAddon");

	{
		if !(isClass ((missionConfigFile >> "GW_Modules" >> _x))) then {
			_preInit = "";
			_postInit = "";
			ERROR(FORMAT_2("Warning! %1 is Missing Module: %2",_Name, _x));
		};
	} forEach _requiredModules;

	{
		if !(isClass (configFile >> "CfgPatches" >> _x)) then {
			_preInit = "";
			_postInit = "";
			ERROR(FORMAT_2("Warning! %1 is Missing Addon: %2",_Name, _x));
		};
	} forEach _requiredAddon;

	if !(_preInit isEqualTo "") then {
		[] call compile preprocessFileLineNumbers ("Modules\" + configName(_x) + "\" + _preInit);
	};

	if !(_postInit isEqualTo "") then {
		GVARMAIN(postLoad) pushback [configName(_x), _postInit];
	};

	if ((count _Authors) isEqualTo 1) then {
		_Authors = format ["%1", (_Authors select 0)];
	} else {
		private _str = "";
		{
			if (_forEachIndex isEqualTo 0) then {
				_str = format ["%1", _x];
			} else {
				_str = (_str + (format [", %1", _x]));
			};
		} forEach _Authors;
		_Authors = _str;
	};

	GVARMAIN(logModules) pushback [_Name, _Authors, _Version, _Description];
	TRACE_3("Module Loaded", _Name, _Authors, _Version);
} forEach _Modules;

LOG(FORMAT_1("Modules Loaded: %1", (count GVARMAIN(logModules))));

if (is3DEN && !(GVARMAIN(settings3denArray) isEqualTo [])) then {
	{
		TRACE_1("CBA Settings", _x);
		[_x, (_x call CBA_settings_fnc_get), 1, "mission", false] call CBA_settings_fnc_set;
	} forEach GVARMAIN(settings3denArray);

	LOG("Making Framework settings global");
};

LOG("preInit finished");
