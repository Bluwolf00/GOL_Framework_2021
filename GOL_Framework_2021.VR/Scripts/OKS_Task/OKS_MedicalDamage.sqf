params ["_Unit","_Severe",["_Terminal",""]];
removeHeadgear _Unit;
removeVest _Unit;
removeBackpack _Unit;
removeAllWeapons _Unit;
_NoOfWounds = (round ((random [0.1,0.25,0.4])* 10));
_BodyPart = selectRandom ["RightLeg","LeftLeg","Body","RightArm","LeftArm"];
_Severe = toLower _Severe;

switch (_Severe) do {
  case "lot": {
    For "_i" from 0 to 15 do {
      [_Unit, 3, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 3, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 3, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 3, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{
      sleep 0.1;
      _Unit getVariable ["ace_medical_bloodVolume", 6.0] < 5.1
    };
    WaitUntil{
      sleep 0.1;
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "Body", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "Head", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.0075
    };

    if !([_Unit] call ace_medical_blood_fnc_isBleeding) then {
      for "_j" from 0 to 8 do {
        _arm = selectRandom ["LeftArm","RightArm"];
        _leg = selectRandom ["LeftLeg","RightLeg"];
        [_Unit, 2, _leg, selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
        [_Unit, 2, _arm, selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      };
      [_Unit, 0.2, "Body", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 0.2, "Head", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
    } else {
        for "_i" from 0 to 3 do {
          [_Unit, 0.2, "Body", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
          [_Unit, 0.2, "Head", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
        };
    };    
  };

   case "large": {
    For "_i" from 0 to 30 do {
      [_Unit, 4, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 4, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 4, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 4, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{
      sleep 0.1;
      _Unit getVariable ["ace_medical_bloodVolume", 6.0] < 4.2
    };
    WaitUntil{
      sleep 0.1;
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "Body", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "Head", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.007
    };

    if !([_Unit] call ace_medical_blood_fnc_isBleeding) then {
      for "_j" from 0 to 8 do {
        _arm = selectRandom ["LeftArm","RightArm"];
        _leg = selectRandom ["LeftLeg","RightLeg"];
        [_Unit, 2, _leg, selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
        [_Unit, 2, _arm, selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      };
      [_Unit, 0.2, "Body", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 0.2, "Head", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
    } else {
        for "_i" from 0 to 3 do {
          [_Unit, 0.2, "Body", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
          [_Unit, 0.2, "Head", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
        };
    };    
  };

   case "fatal": {
    For "_i" from 0 to 60 do {
      [_Unit, 5, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 5, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 5, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 5, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{sleep 0.1; _Unit getVariable ["ace_medical_bloodVolume", 6.0] < 3.6};
    WaitUntil{
      sleep 0.1;
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "Body", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit, _Unit, "Head", "ElasticBandage"] remoteExec ["ace_medical_treatment_fnc_bandage",2];;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.012
    };

    sleep 1;

    if !([_Unit] call ace_medical_blood_fnc_isBleeding) then {
      for "_j" from 0 to 8 do {
        _arm = selectRandom ["LeftArm","RightArm"];
        _leg = selectRandom ["LeftLeg","RightLeg"];
        [_Unit, 2, _leg, selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
        [_Unit, 2, _arm, selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      };
      [_Unit, 0.2, "Body", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
      [_Unit, 0.2, "Head", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
    } else {
        for "_i" from 0 to 3 do {
          [_Unit, 0.2, "Body", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
          [_Unit, 0.2, "Head", selectRandom ["avulsion","bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit",2];;
        };
    };
  };
};

_Unit setVariable ["GOL_MedicalInjuryReady",true,true];



