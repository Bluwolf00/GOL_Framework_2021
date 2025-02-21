/*


	Use the default GOL copy-paste function for
	Spawn Group (Not Static) and replace the spawn
	code to OKS_SpawnPatrol.

	********** call GW_Common_fnc_spawnGroup > ******** call OKS_SpawnPatrol;

*/

	if(!isServer) exitWith {};

	Params ["_UnitArray","_VehicleArray","_WaypointArray",["_Side",east,[sideUnknown]]];
	_UnitArray params ["_UnitData"];

	//SystemChat str _UnitArray;
	_Settings = [_Side] Call OKS_Dynamic_Setting;
	_Settings Params ["_Units"];

	_Units Params ["_Leaders","_Units","_Officer"];
	Private ["_Unit","_Group"];

	_Group = CreateGroup _Side;
	{
		Params ["_UnitData"];
		_UnitData Params ["_UnitSubData"];
		_UnitSubData Params ["_Position","_Radius","_Array"];

		if ((count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
			_Unit setRank "SERGEANT";
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
			_Unit setRank "PRIVATE";
		};
		_Unit setRank "PRIVATE";	
	} foreach _UnitData;

	{
		_X Params ["_WaypointPosition","_WaypointSubArray"];
		//systemChat str _WaypointSubArray;
		_WaypointSubArray params ["_WaypointSubSubArray"];
		_WaypointSubSubArray params ["_Radius","_WaypointType"];

		//systemChat format["Position: %1",_WaypointPosition];
		//systemChat format["Radius: %1",_Radius];
		//systemChat format["Type: %1",_WaypointType];

		_WP = _Group addWaypoint [_WaypointPosition,_Radius];
		_WP setWaypointType _WaypointType;
	} foreach _WaypointArray;	

