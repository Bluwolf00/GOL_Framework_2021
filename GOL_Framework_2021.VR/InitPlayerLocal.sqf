// Ranks
private ["_ltd","_sgt","_uid","_cpl","_rank"];

_ltd = "LIEUTENANT";
_sgt = "SERGEANT";
_cpl = "CORPORAL";

_uid = getPlayerUID (_this select 0);
_didJIP = (_this select 1);

// Add Static Weapon Actions.
if(_didJIP) then {
    execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";
};

// Unconscious State
["ace_unconscious", {
    params ["_unit","_unconscious"];
    if (_unit isNotEqualTo player) exitWith {};
    if(_unconscious) then {
        private _camera = nil;
        //systemChat format["%1 is unconscious",name _unit];
        _playerbloodVolume = _unit getVariable ["ace_medical_bloodVolume", 6];

        //systemChat str _playerbloodVolume;
        if(_playerbloodVolume <= 5.1) then {
            //systemChat "Player is Tier 2";
            //[false, 0] call ace_medical_feedback_fnc_effectUnconscious;
            [_unit] spawn {
                params ["_unit"];
                private _dir = 0;
                private _height = 4;
                private _distance = 3;

                _camera = _unit getVariable ["GOL_SpectatorCamera",nil];
                if(isNil "_camera") then {
                    //systemChat "Creating Camera";
                    _Position = (getPosATL _unit) getPos [_distance,_Dir];
                    _camera = "camera" camCreate [_Position select 0,_Position select 1,_height];     
                };
                _camera camSetTarget player;
                _unit setVariable ["GOL_SpectatorCamera",_camera,true];	
                cutText ["", "BLACK OUT",1]; sleep 1;
                //systemChat "BLACK OUT";
                
                waitUntil {!isNil "ace_medical_feedback_ppUnconsciousBlur"};
                ppEffectDestroy ace_medical_feedback_ppUnconsciousBlur;            

                waitUntil {!isNil "ace_medical_feedback_ppUnconsciousBlackout"};
                ppEffectDestroy ace_medical_feedback_ppUnconsciousBlackout;      

                showCinemaBorder true;
                _camera cameraEffect ["internal", "back"];
                sleep 2;
                cutText ["", "BLACK IN",3];
                //systemChat "BLACK IN";

                while {!([_unit] call ace_common_fnc_isAwake)} do {
                    _playerbloodVolume = _unit getVariable ["ace_medical_bloodVolume", 6];
                    private _Tier = "<t color='#ffff66'>TIER 3</t>";
                    if(_playerbloodVolume < 5.1) then {
                        _Tier = "<t color='#ff9933'>TIER 2</t>";
                    };
                    if (_playerbloodVolume < 3.6) then {
                        _Tier = "<t color='#ff0000'>TIER 1</t>";
                    };

                    [format["YOU ARE A %1 CASUALTY.",_Tier], -1, 0, 5, 0, 0, 935] spawn BIS_fnc_dynamicText;
                    _Position = (getPosATL _unit) getPos [_distance,_Dir];
                    _Dir = _dir + 10;
                    _camera camSetPos [_Position select 0,_Position select 1,_height];
                    _camera camCommit 1;
                    //systemChat "Unconscious - Moving Camera";
                    sleep 1;
                };			

                //cutText ["", "BLACK IN",1];
                //[true, 0] call ace_medical_feedback_fnc_effectUnconscious;   
            };
        };
    };
    if(!(_unconscious)) then {
        // Exit Camera 
        _unit spawn {
            _camera = _this getVariable ["GOL_SpectatorCamera",objNull];
            _camera camSetPos [(getPosATL _this) select 0,(getPosATL _this) select 1,0.1];
            _camera camSetTarget _this;
            _camera camCommit 0.5;      
            cutText ["", "BLACK OUT",0.5]; sleep 0.6;
            _this setVariable ["GOL_SpectatorCamera",nil,true];
            _camera cameraEffect ["terminate", "back"];			
            camDestroy _camera;
            ["", -1, 0, 1, 2, 0, 935] spawn BIS_fnc_dynamicText;
            sleep 0.05;
            cutText ["", "BLACK IN",1];   
        }
    };
}] call CBA_fnc_addEventHandler;

/* Set Earplugs Settings */
waitUntil {!isNil "ace_hearing_fnc_putInEarplugs"};
[player, true] call ace_hearing_fnc_putInEarplugs;

switch _uid do {

case "76561198013929549": {_rank = _ltd}; // Oksman
case "76561198086056020": {_rank = _ltd}; // Blu.
case "76561199681025229": {_rank = _sgt}; // Rutters
case "76561198005972885": {_rank = _cpl}; // Pilgrim
case "76561198014971848": {_rank = _cpl}; // Filth
case "76561198091519166": {_rank = _cpl}; // Juan Sanchez
case "76561198058521961": {_rank = _cpl}; // Joona
case "76561198210159148": {_rank = _cpl}; // Eric

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

player addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];

    if(_container in [medical_box_west,medical_box_east]) then {
        format["%1 accessed the medical crate at base.",name _unit] remoteExec ["systemChat",0];
    };

    if(typeOf _container in ["Box_Syndicate_Ammo_F","Box_Syndicate_Wps_F","B_supplyCrate_F"] && {_container distance _X < 150} count [flag_west_1,flag_east_1,flag_west_2,flag_east_2] > 0) then {
        format["%1 accessed an ammo crate at base.",name _unit] remoteExec ["systemChat",0];
    };

    if(typeOf _container in ["Box_NATO_Equip_F"] && {_container distance _X < 150} count [flag_west_1,flag_east_1,flag_west_2,flag_east_2] > 0) then {
        format["%1 accessed the equipment crate at base.",name _unit] remoteExec ["systemChat",0];
    };  
}];

// Set Radio Volumes
player spawn {
    waitUntil{
        sleep 5;
        !isNil "TFAR_fnc_activeSWRadio" &&
        !isNil "TFAR_fnc_activeLrRadio" && 
        !isNil "TFAR_fnc_radiosList" && 
        !isNil "TFAR_fnc_setSwVolume" &&
        !isNil "TFAR_fnc_setLrVolume" &&
        !isNil "OKS_TFAR_RadioSetup"
    };
    _this spawn OKS_TFAR_RadioSetup;
};

player spawn {
    waitUntil { 
        sleep 10;
        !isNil "TFAR_CurrentUnit"
    };
    while {true} do {
        _lrspeakers = (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSpeakers;
        _swspeakers = (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSpeakers;

        if(_lrspeakers) then {
            systemChat "WARNING! You have your long-range set to speaker not headphones. Change it!";
        };
        if(_swspeakers) then {
            systemChat "WARNING! You have your short-range set to speaker not headphones. Change it!";
        };       
        sleep 10;
    }
};