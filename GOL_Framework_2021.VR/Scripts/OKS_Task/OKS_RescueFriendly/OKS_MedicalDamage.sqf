params ["_Unit", "_Severe", ["_Terminal", "",[]], ["_IsAssessment",false,[false]]];
Private ["_SelectedSeverity","_lot","_large","_fatal","_dead"];

_NoOfWounds = (round ((random [0.1, 0.25, 0.4])* 10));
_BodyPart = selectRandom ["RightLeg", "LeftLeg", "Body", "RightArm", "LeftArm"];
_Severe = toLower _Severe;

_lot = 5.1;
_large = 4.2;
_fatal = 3.6;
_dead = random [3.5,4,4.5];

if(_isAssessment) then {	
	_lot = _lot * 0.8;
	_large = _large * 0.8;
	_fatal = _fatal * 0.8;
};

_SelectedSeverity = _Severe;
if((toLower _Severe) isEqualTo "random") then {
	_SelectedSeverity = selectRandom["easy","medium","heavy","lot","large","fatal","dead"];
};

//systemChat format["Severity Random: %1",_SelectedSeverity];
switch (_SelectedSeverity) do {
	case "lot": {
		_Unit setUnitPos "AUTO";
		_unit setVariable ["ace_medical_bloodVolume", _lot, true];
		[_unit, true] call ace_medical_fnc_setUnconscious;

		if(!(_IsAssessment)) then {
			for "_j" from 0 to 2 do {
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
	};

	case "large": {
		_unit setVariable ["ace_medical_bloodVolume", _large, true];
		_Unit setUnitPos "AUTO";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		for "_j" from 0 to 2 do {
			[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
	};

	case "fatal": {
		_Unit setUnitPos "AUTO";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		_unit setVariable ["ace_medical_bloodVolume", _fatal, true];
		sleep 1;

		if(!(_IsAssessment)) then {
			for "_j" from 0 to 2 do {
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
	};
};