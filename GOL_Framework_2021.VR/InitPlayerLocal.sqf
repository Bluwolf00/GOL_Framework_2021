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
fnc_myFunction = {
  params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];
  if (!(_caller isEqualTo _target) && (_target == player)) then {
  _Unconscious = _target getVariable ["ACE_isUnconscious",false];
  _Action = "DEBUG";
  switch (_usedItem) do {
      case ("ACE_tourniquet"): {
          _Action = "Applying a tourniquet to";
      };
      case "ACE_fieldDressing";
      case "ACE_elasticBandage";
      case "ACE_packingBandage";
      case "ACE_quickclot": {_Action = "Bandaging";};

      case "ACE_bloodIV";
      case "ACE_bloodIV_250";
      case "ACE_bloodIV_500";
      case "ACE_salineIV";
      case "ACE_salineIV_250";
      case "ACE_salineIV_500";
      case "ACE_plasmaIV";
      case "ACE_plasmaIV_250";
      case "ACE_plasmaIV_500": {_Action = "Transfusing fluids to";};

      case ("ACE_personalAidKit"): {
          _Action = "Applying a PAK to";
      };
      case ("ACE_splint"): {
          _Action = "Applying a splint to";
      };
      case ("ACE_morphine"): {
          _Action = "Injecting morphine to";
      };
      case ("ACE_epinephrine"): {
          _Action = "Injecting epinephrine to";
      };
      case ("ACE_adenosine"): {
          _Action = "Injecting adenosine to";
      };
      case ("ACE_surgicalKit"): {
          _Action = "stitching your";
      };
      default {
          _Action = "tending to";
      };
  };

  if !(_Unconscious) then {
    switch (_selectionName) do {
        case ("head"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " is " + _Action + " your head"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("leftarm"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " is " + _Action + " your left Arm"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("rightarm"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " is " + _Action + " your right arm"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("leftleg"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " is " + _Action + " your left leg"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("rightleg"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " is " + _Action + " your right leg"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("body"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " is " + _Action + " your torso"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
      };
    } else {[[name _caller,_Action],{Params ["_caller","_Action"]; titleText [("Someone is tending to you"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];};
};
};
["ace_treatmentStarted", fnc_myFunction] call CBA_fnc_addEventHandler;
