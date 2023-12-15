// Ranks
private ["_ltd","_sgt","_uid","_cpl","_rank"];

_ltd = "LIEUTENANT";
_sgt = "SERGEANT";
_cpl = "CORPORAL";

_uid = getPlayerUID (_this select 0);

/* Set Earplugs Settings */
waitUntil {!isNil "ace_hearing_fnc_putInEarplugs"};
[player, true] call ace_hearing_fnc_putInEarplugs;

switch _uid do {

case "76561198013929549": {_rank = _ltd};
case "76561198086056020": {_rank = _sgt};
case "76561198110128838": {_rank = _sgt};
case "76561198005972885": {_rank = _cpl};
case "76561198014971848": {_rank = _cpl};
case "76561198091519166": {_rank = _cpl};
case "76561198058521961": {_rank = _cpl};

default {_rank ="PRIVATE";};
};

(_this select 0) setrank _rank;

// ACE Medical - Pop Up Message Script
// Will be transferred to the GW Addon at a later date... hopefully

fnc_displayText = {
    params ["_caller","_target","_bodyPart","_action"];
    if (_bodyPart == "") then {
        [[("<t size='1.3'>" + "Someone" + " is " + _action + " you" + "</t>"), "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", _target];
    } else {
        if (_action in ["CheckPulse","CheckBloodPressure","PersonalAidKit","Diagnose"]) then {
            [[("<t size='1.3'>" + (name _caller) + " is " + _action + " you" + "</t>"), "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", _target];
        } else {
            [[("<t size='1.3'>" + (name _caller) + " is " + _action + " your " + _bodyPart + "</t>"), "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", _target];
        };
    };
};

fnc_medicalMessage = {
    params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

    if (!(_caller == _target)) then {
        _uncon = _target getVariable ["ace_isUnconscious", false];
        _action = "Tending to";

        switch (_className) do {
            case "ApplyTourniquet": {
                _action = "applying a tourniquet to ";
            };

            case "Morphine": {
                _action = "injecting morphine to";
            };

            case "Epinephrine": {
                _action = "injecting epinephrine to";
            };

            case "FieldDressing";
            case "ElasticBandage";
            case "PackingBandage";
            case "QuikClot": {
                _action = "bandaging";
            };

            case "BloodIV";
            case "BloodIV_500";
            case "BloodIV_250";
            case "PlasmaIV";
            case "PlasmaIV_500";
            case "PlasmaIV_250";
            case "SalineIV";
            case "SalineIV_500";
            case "SalineIV_250": {
                _action = "transfusing fluids to";
            };

            case "PersonalAidKit": {
                _action = "PAKing";
            };

            case "CheckPulse": {
                _action = "checking your pulse";
            };

            case "CheckBloodPressure": {
                _action = "checking your blood pressure";
            };

            case "Diagnose": {
                _action = "diagnosing";
            };

            default {
                _action = "tending to";
            };
        };
        if !(_uncon) then {
            switch (_selectionName) do {
                case "head": {
                    [_caller, _target, "Head", _action] call fnc_displayText;
                };

                case "leftarm": {
                    [_caller, _target, "Left arm", _action] call fnc_displayText;
                };
                
                case "rightarm": {
                    [_caller, _target, "Right arm", _action] call fnc_displayText;
                };

                case "leftleg": {
                    [_caller, _target, "Left leg", _action] call fnc_displayText;
                };

                case "rightleg": {
                    [_caller, _target, "Right leg", _action] call fnc_displayText;
                };

                case "body": {
                    [_caller, _target, "Body", _action] call fnc_displayText;
                };

                default {
                    [_caller, _target, "", "tending to"] call fnc_displayText;
                };
            };
        } else {
            [_caller, _target, "", "tending to"] call fnc_displayText;
        };
    };
};

["ace_treatmentStarted", fnc_medicalMessage] call CBA_fnc_addEventHandler;
