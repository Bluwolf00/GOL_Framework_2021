params ["_Unit","_Severe"];

_NoOfWounds = (round ((random [0.1,0.25,0.4])* 10));
_BodyPart = selectRandom ["RightLeg","LeftLeg","Body","RightArm","LeftArm"];
_Severe = toLower _Severe;

switch (_Severe) do {
  case "easy":{
    [_Unit, selectRandom[0,Random[0.4,0.6,1]], "RightLeg", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,Random[0.4,0.6,1]], "LeftLeg", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,Random[0.4,0.6,1]], "Body", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,0.3], "head", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,Random[0.4,0.6,1]], "RightArm", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,Random[0.4,0.6,1]], "LeftArm", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;

    For "_i" from 0 to _NoOfWounds do {
      [_unit, Random[0.1,0.4,0.6], _BodyPart, selectrandom ["stab","bullet"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
  };

  case "medium":{
    [_Unit, selectRandom[0.2,Random[0.6,1,1.5]], "RightLeg", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.2,Random[0.6,1,1.5]], "LeftLeg", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.4,Random[0.6,1,1.5]], "Body", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,0.3], "head", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.6,Random[0.6,1,1.5]], "RightArm", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.6,Random[0.6,1,1.5]], "LeftArm", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;

    if (_BodyPart == "Body" && _NoOfWounds > 2) then {_NoOfWounds = 2};
    For "_i" from 0 to _NoOfWounds do {
      [_unit, Random[0.5,0.75,1.5], _BodyPart, selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
  };

  case "heavy":{
    [_Unit, selectRandom[0.5,Random[2.1,2.4,3]], "RightLeg", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.5,Random[2.1,2.4,3]], "LeftLeg", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,Random[1.5,1.6,2.5]], "Body", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0,0.3], "head", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.5,Random[2.1,2.4,3]], "RightArm", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;
    [_Unit, selectRandom[0.5,Random[2.1,2.4,3]], "LeftArm", selectrandom ["stab","bullet","grenade"]] call ace_medical_fnc_addDamageToUnit;

    if (_BodyPart == "Body" && _NoOfWounds > 2) then {_NoOfWounds = 2} else {_NoOfWounds = _NoOfWounds + 2};
    For "_i" from 0 to _NoOfWounds do {
      [_unit, Random[1,2.1,3], _BodyPart, selectrandom ["stab","bullet"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
  };

  case "lot": {
    For "_i" from 0 to 15 do {
      [_Unit, 3, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 3, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 3, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 3, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{_Unit getVariable ["ace_medical_bloodVolume", 6.0] < 5.1};
    WaitUntil{
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Body", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Head", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.0055
    };
  };

   case "large": {
    For "_i" from 0 to 30 do {
      [_Unit, 4, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 4, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 4, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 4, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{_Unit getVariable ["ace_medical_bloodVolume", 6.0] < 4.2};
    WaitUntil{
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Body", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Head", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.005
    };
  };

   case "fatal": {
    For "_i" from 0 to 60 do {
      [_Unit, 5, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 5, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 5, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 5, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{_Unit getVariable ["ace_medical_bloodVolume", 6.0] < 3.6};
    WaitUntil{
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Body", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Head", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.008
    };

  };

   case "dead": {
    For "_i" from 0 to 60 do {
      [_Unit, 5, "LeftLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 5, "RightLeg", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 5, "LeftArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
      [_Unit, 5, "RightArm", selectRandom ["avulsion","stab","bullet","velocitywound"]] call ace_medical_fnc_addDamageToUnit;
    };
    _Unit setUnitPos "DOWN";
    [_unit,true] call ace_medical_fnc_setUnconscious;
    WaitUntil{_Unit getVariable ["ace_medical_bloodVolume", 6.0] < (selectRandom [3.6,4.2])};
    WaitUntil{
      [_Unit, _Unit, "LeftArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightArm", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Body", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "LeftLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "RightLeg", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit, _Unit, "Head", "ElasticBandage"] call ace_medical_treatment_fnc_bandage;
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.008
    };
    _Unit setDamage 1;
    sleep 0.5;
  };
};

