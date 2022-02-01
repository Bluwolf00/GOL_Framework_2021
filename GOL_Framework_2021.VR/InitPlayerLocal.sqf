// Ranks
private ["_ltd","_sgt","_uid","_cpl","_rank"];

_ltd = "LIEUTENANT";
_sgt = "SERGEANT";
_cpl = "CORPORAL";

_uid = getPlayerUID (_this select 0);

switch _uid do {

case "76561198013929549": {_rank = _ltd};
case "76561198086056020": {_rank = _sgt};
case "76561198110128838": {_rank = _sgt};
case "76561198005972885": {_rank = _cpl};
case "76561198014971848": {_rank = _cpl};
case "76561198024730389": {_rank = _cpl};

default {_rank ="PRIVATE";};
};

(_this select 0) setrank _rank;

// ACE Medical - Pop Up Message Script
// Will be transferred to the GW Addon at a later date... hopefully
fnc_myFunction = {
  params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];
  _Unconscious = _target getVariable ["ACE_isUnconscious",false];
  _Action = "DEBUG";
  switch (_usedItem) do {
      case ("ACE_tourniquet"): {
          _Action = "Applying A Tourniquet To";
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
      case "ACE_plasmaIV_500": {_Action = "Transfusing Fluids To";};

      case ("ACE_personalAidKit"): {
          _Action = "Applying A PAK To";
      };
      case ("ACE_splint"): {
          _Action = "Applying A Splint To";
      };
      case ("ACE_morphine"): {
          _Action = "Injecting Morphine To";
      };
      case ("ACE_epinephrine"): {
          _Action = "Injecting Epinephrine To";
      };
      case ("ACE_adenosine"): {
          _Action = "Injecting Adenosine To";
      };
      case ("ACE_surgicalKit"): {
          _Action = "Stitching Your";
      };
      default {
          _Action = "Tending To";
      };
  };

  if !(_Unconscious) then {
    switch (_selectionName) do {
        case ("head"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " Is " + _Action + " Your Head"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("leftarm"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " Is " + _Action + " Your Left Arm"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("rightarm"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " Is " + _Action + " Your Right Arm"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("leftleg"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " Is " + _Action + " Your Left Leg"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("rightleg"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " Is " + _Action + " Your Right Leg"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
        case ("body"): {
            [[name _caller,_Action],{Params ["_caller","_Action"]; titleText [(_caller + " Is " + _Action + " Your Torso"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];
        };
      };
    } else {[[name _caller,_Action],{Params ["_caller","_Action"]; titleText [("Somebody Is Tending To You"),"PLAIN DOWN"]}] remoteExec ["BIS_FNC_CALL",_target];};
};
["ace_treatmentStarted", fnc_myFunction] call CBA_fnc_addEventHandler;
