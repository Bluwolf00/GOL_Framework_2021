/* Set GOL Mission Settings */
_Complete = call Compile PreProcessFileLineNumbers "MissionSettings.sqf";
waitUntil{_Complete};

execVM "Scripts\OKS_Dynamic\Init.sqf";
execVM "Scripts\OKS_Task\Init.sqf";

