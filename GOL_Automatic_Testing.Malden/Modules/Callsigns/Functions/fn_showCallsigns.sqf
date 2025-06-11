disableSerialization;

_AvailableElements = ["Infantry","Vehicle","AAC","Support"];

createDialog "Blu_Callsign_Dialog";

waitUntil {!isNull (findDisplay 999);};


_ctrl = (findDisplay 999) displayCtrl 2100;
_ctrl2 = (findDisplay 999) displayCtrl 2101;

{
  _ctrl lbAdd _x
} forEach _AvailableElements;

_ctrl2 ctrlEnable false;
ctrlShow [1400,false];
ctrlShow [1003,false];
