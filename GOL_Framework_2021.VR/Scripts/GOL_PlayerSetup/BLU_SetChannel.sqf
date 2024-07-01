/*
Author: Blu.

Set the Teamspeak Channel to the appropriate one according to the real-time date.

Do not question the math as I have no idea myself.

*/


_currentDate = systemTime;
_year = _currentDate select 0;
_month = _currentDate select 1;
_day = _currentDate select 2;
 
_monthChart = [0,3,3,6,1,4,6,2,5,0,3,5]; 
_monthCode = 0; 

if ((str(_month) select [0,1]) == "0") then { 
 _monthCode = _month select [1,1]; 
} else {_monthCode = _month}; 
 
_monthCode = _monthCode - 1; 
 
_yearEnd = parseNumber (str(_year) select [2,2]); 
 
_quotient = floor (_yearEnd / 4); 
 
_addition = _day + (_monthChart select _monthCode) + 6 + _yearEnd + _quotient; 

_weekDayNum = _addition mod 7;

if (((_year mod 4) == 0) && (_month < 3)) then 
 { 
  _weekDayNum = _weekDayNum - 1; 
 };

switch (_weekDayNum) do { 
 case 0: {
    // Sunday - Main Operations Channel
  ["TFAR_Teamspeak_Channel_Name", "Main Operations", 1, "mission"] call CBA_settings_fnc_set; 
  ["TFAR_Teamspeak_Channel_Password", "", 1, "mission"] call CBA_settings_fnc_set; 
 }; 
 
 case 4: {
    // Thursday - Thursday Operations Channel
  ["TFAR_Teamspeak_Channel_Name", "Thursday Operations", 1, "mission"] call CBA_settings_fnc_set; 
  ["TFAR_Teamspeak_Channel_Password", "", 1, "mission"] call CBA_settings_fnc_set; 
 }; 
 
 default { 
  // Any other day - TaskForceRadio Channel

    if (("TFAR_Teamspeak_Channel_Name" call CBA_settings_fnc_get) != "TaskForceRadio") then
    {
        ["TFAR_Teamspeak_Channel_Name", "TaskForceRadio", 1, "mission"] call CBA_settings_fnc_set; 
        ["TFAR_Teamspeak_Channel_Password", "123", 1, "mission"] call CBA_settings_fnc_set;
    };
 }; 
};