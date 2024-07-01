params ["_Unit","_Task"];
sleep 30;
WaitUntil{_Unit getVariable ["ace_medical_bloodVolume", 6.0] >= 5.7 || !Alive _Unit};

if(Alive _Unit && _Unit getVariable ["ace_medical_bloodVolume", 6.0] >= 5.7) then {
  [_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
} else {
  [_Task,"Failed"] call BIS_fnc_taskSetState;
};

