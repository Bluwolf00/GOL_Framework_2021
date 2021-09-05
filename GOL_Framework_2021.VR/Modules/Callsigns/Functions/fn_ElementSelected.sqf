params["_index"];

_ctrl = (findDisplay 999) displayCtrl 2101;
_AbleInfCallsigns = ["1-1 Actual","1-1 Alpha","1-1 Bravo","1-1 Charlie"];
_AbleVicCallsigns = ["Pig","Anvil","Bluebell"];
_AbleAACCallsigns = ["Raven","Angel","Giant","Phantom","Banshee"];
_AbleSptCallsigns = ["Dragon","Stallion","Hammer"];

if (_index != -1) then {
    lbClear _ctrl;
    switch (_index) do {
      case 0: {
        {
          _ctrl lbAdd _x
        } forEach _AbleInfCallsigns;
        if (ctrlShown ((findDisplay 999) displayctrl 1400)) then {
          ctrlShow [1400,false];
          ctrlShow [1003,false];
        };
      };

      case 1: {
        {
          _ctrl lbAdd _x
        } forEach _AbleVicCallsigns;
        if (ctrlShown ((findDisplay 999) displayctrl 1400)) then {
          ctrlShow [1400,false];
          ctrlShow [1003,false];
        };
      };

      case 2: {
        {
          _ctrl lbAdd _x
        } forEach _AbleAACCallsigns;
        ctrlShow [1400,true];
        ctrlShow [1003,true];
      };

      case 3: {
        {
          _ctrl lbAdd _x
        } forEach _AbleSptCallsigns;
        if (ctrlShown ((findDisplay 999) displayctrl 1400)) then {
          ctrlShow [1400,false];
          ctrlShow [1003,false];
        };
      };
    };
    _ctrl ctrlEnable true;
};
