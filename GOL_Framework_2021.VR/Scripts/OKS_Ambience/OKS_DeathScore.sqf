
// execVM "Scripts\OKS_Ambience\OKS_DeathScore.sqf";

private _stringHint = "";
private _ArrayOfDeathsAndNames = "";
private _DeathSortedPlayerArray = [(allPlayers - entities "HeadlessClient_F"), [], {_X getVariable ["GOL_Player_Deaths",0]}, "ASCEND"] call BIS_fnc_sortBy;
private _allPlayerDeaths = 0;
{
	_i = (_DeathSortedPlayerArray find _X) + 1;
	_Deaths = (_X getVariable ["GOL_Player_Deaths",0]);

	_allPlayerDeaths = _allPlayerDeaths + _Deaths;
	_ArrayOfDeathsAndNames = _ArrayOfDeathsAndNames + ( format ["%3. %1: Deaths %2\n",name _X,_Deaths,_i]);
} forEach _DeathSortedPlayerArray;

private _Color = "";
if(_allPlayerDeaths <= (count AllPlayers * 0.3)) then {
	_Color = "#24930C";
};
if(_allPlayerDeaths > (count AllPlayers * 0.3) && _allPlayerDeaths < (count AllPlayers * 0.6)) then {
	_Color = "#fcba03";
};
if(_allPlayerDeaths >= (count AllPlayers * 0.6)) then {
	_Color = "#ff0000";
};

// if(player distance scoreboard > 100) then {
// 	_result = [_ArrayOfDeathsAndNames, "Survival Scoreboard", true, false] call BIS_fnc_guiMessage;
// };

if(!isNil "scoreboard_west") then {
	scoreboard_west setObjectTexture [0,format["#(rgb,512,512,3)text(0, 1,""PuristaBold"", 0.08, ""#FFFFFF"", ""%2"",""%1"")",_ArrayOfDeathsAndNames,_Color]];
};

if(!isNil "scoreboard_east") then {
	scoreboard_east setObjectTexture [0,format["#(rgb,512,512,3)text(0, 1,""PuristaBold"", 0.08, ""#FFFFFF"", ""%2"",""%1"")",_ArrayOfDeathsAndNames,_Color]];
};
