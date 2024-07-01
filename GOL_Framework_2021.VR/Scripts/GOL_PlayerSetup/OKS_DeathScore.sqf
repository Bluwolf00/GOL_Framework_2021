
// execVM "Scripts\OKS_Ambience\OKS_DeathScore.sqf";

private _stringHint = "";
private _ArrayOfDeathsAndNames = "";
private _SupportUnits = [
	"wcrew1","wcrew2","wcrew3","wcrew4","wcrew5","wcrew6","wecho1","wecho2","wecho3","wecho4","wecho5","wecho6",
	"ecrew1","ecrew2","ecrew3","ecrew4","ecrew5","ecrew6","eecho1","eecho2","eecho3","eecho4","eecho5","eecho6"
];

// Calculate Squad Casualties
_GroundPlayers = (allPlayers - entities "HeadlessClient_F") select {!((str _X) in _SupportUnits)};

if(count _GroundPlayers > 0) then {
	private _DeathSortedPlayerArray = [_GroundPlayers, [], {_X getVariable ["GOL_Player_Deaths",0]}, "ASCEND"] call BIS_fnc_sortBy;

	private _allPlayerDeaths = 0;
	{
		_Deaths = (_X getVariable ["GOL_Player_Deaths",0]);
		_allPlayerDeaths = _allPlayerDeaths + _Deaths;
	} foreach _GroundPlayers;

	Private _CasualtyRate = round ((_allPlayerDeaths / (count _GroundPlayers)) * 100);
	private _ArrayOfDeathsAndNames = format ["Infantry Casualty Rate: %1",_CasualtyRate] + "%\n";
	{
		_i = (_DeathSortedPlayerArray find _X) + 1;
		_Deaths = (_X getVariable ["GOL_Player_Deaths",0]);
		_ArrayOfDeathsAndNames = _ArrayOfDeathsAndNames + ( format ["%3. %1: Deaths %2\n",name _X,_Deaths,_i]);
	} forEach _DeathSortedPlayerArray;

	private _Color = "";
	if(_allPlayerDeaths <= (count _GroundPlayers * 0.3)) then {
		_Color = "#24930C";
	};
	if(_allPlayerDeaths > (count _GroundPlayers * 0.3) && _allPlayerDeaths < (count _GroundPlayers * 0.6)) then {
		_Color = "#fcba03";
	};
	if(_allPlayerDeaths >= (count _GroundPlayers * 0.6)) then {
		_Color = "#ff0000";
	};

	if(!isNil "scoreboard_west") then {
		scoreboard_west setObjectTexture [0,format["#(rgb,512,512,3)text(0, 1,""PuristaBold"", 0.06, ""#FFFFFF"", ""%2"",""%1"")",_ArrayOfDeathsAndNames,_Color]];
	};
	if(!isNil "scoreboard_east") then {
		scoreboard_east setObjectTexture [0,format["#(rgb,512,512,3)text(0, 1,""PuristaBold"", 0.06, ""#FFFFFF"", ""%2"",""%1"")",_ArrayOfDeathsAndNames,_Color]];
	};
};

// Calculate Support Casualties
_SupportPlayers = (allPlayers - entities "HeadlessClient_F") select {(str _X) in _SupportUnits};

if(count _SupportPlayers > 0) then {
	private _DeathSortedSupportPlayerArray = [_SupportPlayers, [], {_X getVariable ["GOL_Player_Deaths",0]}, "ASCEND"] call BIS_fnc_sortBy;

	private _allSupportPlayerDeaths = 0;
	{
		_Deaths = (_X getVariable ["GOL_Player_Deaths",0]);
		_allSupportPlayerDeaths = _allSupportPlayerDeaths + _Deaths;
	} foreach _SupportPlayers;

	Private _SupportCasualtyRate = round ((_allSupportPlayerDeaths / (count _SupportPlayers)) * 100);
	private _ArrayOfSupportDeathsAndNames = format ["Support Casualty Rate: %1",_SupportCasualtyRate] + "%\n";
	{
		_i = (_DeathSortedSupportPlayerArray find _X) + 1;
		_Deaths = (_X getVariable ["GOL_Player_Deaths",0]);
		_ArrayOfSupportDeathsAndNames = _ArrayOfSupportDeathsAndNames + ( format ["%3. %1: Deaths %2\n",name _X,_Deaths,_i]);
	} forEach _DeathSortedSupportPlayerArray;

	private _ColorSupport = "";
	if(_allSupportPlayerDeaths <= (count _SupportPlayers * 0.3)) then {
		_ColorSupport = "#24930C";
	};
	if(_allSupportPlayerDeaths > (count _SupportPlayers * 0.3) && _allSupportPlayerDeaths < (count _SupportPlayers * 0.6)) then {
		_ColorSupport = "#fcba03";
	};
	if(_allSupportPlayerDeaths >= (count _SupportPlayers * 0.6)) then {
		_ColorSupport = "#ff0000";
	};

	if(!isNil "scoreboard_west_support") then {
		scoreboard_west_support setObjectTexture [0,format["#(rgb,512,512,3)text(0, 1,""PuristaBold"", 0.06, ""#FFFFFF"", ""%2"",""%1"")",_ArrayOfSupportDeathsAndNames,_ColorSupport]];
	};
	if(!isNil "scoreboard_east_support") then {
		scoreboard_east_support setObjectTexture [0,format["#(rgb,512,512,3)text(0, 1,""PuristaBold"", 0.06, ""#FFFFFF"", ""%2"",""%1"")",_ArrayOfSupportDeathsAndNames,_ColorSupport]];
	};
};