params ["_Unit","_Task"];
sleep 30;
WaitUntil{
  (
      ([_Unit] call ace_medical_status_fnc_getCardiacOutput > 0.07) &&
      [_Unit] call ace_medical_status_fnc_getBloodLoss < 0.001 &&
      {
        [_Unit, _X] call ace_medical_treatment_fnc_hasTourniquetAppliedTo
      } count ["LeftLeg","RightLeg","LeftArm","RightArm"] == 0
  ) || !Alive _Unit
};

if(Alive _Unit) then {
  [_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
} else {
  [_Task,"Failed"] call BIS_fnc_taskSetState;
};

