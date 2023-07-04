params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

if(!isNull _oldUnit) then {
	_oldDeaths = _oldUnit getVariable ["GOL_Player_Deaths",0];
	_newDeaths = (_oldDeaths + 1);
	_newUnit setVariable ["GOL_Player_Deaths",_newDeaths,true];
};

_newUnit addEventHandler ["HandleScore", {
	false
}];