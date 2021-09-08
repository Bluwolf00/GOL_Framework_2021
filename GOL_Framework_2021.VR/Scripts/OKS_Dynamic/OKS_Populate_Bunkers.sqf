//
//  [_Position,_Side,_InfantryNumber,_Range] spawn OKS_Populate_Bunkers;
//  execVM "Scripts\OKS_Dynamic\OKS_Populate_Bunkers.sqf"
//

if(HasInterface && !isServer) exitWith {};


Params["_Position","_Side","_InfantryNumber","_Range"];
private ["_Units"];
_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian"];
_UnitArray Params ["_Leaders","_Units","_Officer"];

	_Group = CreateGroup _Side;
	for "_i" from 1 to (_InfantryNumber - 1) do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [_Position select 0,_Position select 1,0], [], 10, "NONE"];
			_Unit setRank "SERGEANT";
			_Unit setUnitPos "UP";
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_Position select 0,_Position select 1,0], [], 10, "NONE"];
			_Unit setRank "PRIVATE";
			_Unit setUnitPos "UP";
		};
	};
	[[_Position select 0,_Position select 1,0], nil, units _Group, _Range, 0, true, true] remoteExec ["ace_ai_fnc_garrison",0];
	sleep 2;
	[_Group] remoteExec ["OKS_SetStatic",0];
