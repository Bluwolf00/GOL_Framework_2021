params["_index","_Eleindex"];

If (_Index == -1) then {

} else {

_Callsign = lbText [2101,_index];

if (_Eleindex == 2) then {
  if ((ctrlText 1400) != "") then {
    if ((parsenumber (ctrlText 1400)) != 0) then {
      _Callsign = _Callsign + " " + str(parsenumber (ctrlText 1400));
    } else {
      playSound "3DEN_notificationWarning";
    };
  };
};

If !(_Callsign == "") then {
  (group player) setGroupIdGlobal [_Callsign];
  playSound "3DEN_notificationDefault";
} else {
    systemChat "Error: Callsign is Nil";
    playSound "3DEN_notificationWarning";
};
closeDialog 0;

};
