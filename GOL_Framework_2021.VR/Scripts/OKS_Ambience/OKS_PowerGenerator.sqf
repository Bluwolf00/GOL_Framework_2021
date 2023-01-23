// [Generator_1,true,true,1000] execVM "OKS_PowerGenerator.sqf";

Params ["_Generator","_AddAction","_TurnOffNearbyLights","_RangeOfPowerSupply"];

If(_AddAction) then {
	[_Generator,["<t color='#db2316'>Disable Generator</t>",{
		[3, [], {SystemChat "Generator shutting down.."}, {}, "Disabling Generator.."] call ace_common_fnc_progressBar;
		sleep 3;
		(_this select 0) setVariable ["GeneratorOn",false,true];
		removeAllActions (_this select 0);
	}]] remoteExec ["AddAction",0];
};

// Generator Start 8.66 
// Generator Off 3.5
// Generator Idle 5.92
playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Sound\GeneratorOn.wav", _Generator, false, getPosASL _Generator, 4, 1, 40];
sleep 8.66;
_Generator setVariable ["GeneratorOn",true,true];

while {_Generator getVariable ["GeneratorOn",false]} do {
	playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Sound\GeneratorIdle.wav", _Generator, false, getPosASL _Generator, 4, 1, 40];
	sleep 5.88;
	if !(_Generator getVariable ["GeneratorOn",false]) exitWith {
		playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Sound\GeneratorOff.wav", _Generator, false, getPosASL _Generator, 4, 1, 40];
		sleep 3.5;
	};
};

if(_TurnOffNearbyLights) then {
	_lampTypes = [
		"Lamps_Base_F", 
		"PowerLines_base_F",
		"Land_PowerPoleWooden_F", 
		"Land_PowerPoleWooden_small_F", 
		"Land_LampHarbour_F",
		"Land_LampShabby_F",
		"Land_LampStreet_small_F",
		"Land_LampStreet_F",
		"Land_PowerPoleWooden_L_F",
		"Land_LampHalogen_F",
		"Land_LampDecor_F",
		"Land_LampSolar_F",
		"Land_LampAirport_F"
	];
	_lamps = [];
	{{_lamps pushBackUnique _X} foreach (_Generator nearObjects [_X,_RangeOfPowerSupply])} foreach _lampTypes;
	{_x setdamage 0.92; sleep 0.1} foreach _lamps;
};
