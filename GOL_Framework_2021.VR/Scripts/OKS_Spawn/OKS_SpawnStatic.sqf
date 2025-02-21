	// OKS_Garrison
	// [[positions],independent] spawn OKS_SpawnStatic;

	if(!isServer) exitWith {};

/*

[
	[
		[
			[4349.69,3973.94,3.58235],233,"Auto",[]
		],
		[
			[4352.35,3972.95,3.65498],233,"Auto",[]
		]
	],
	[	
		["UK3CB_ADE_O_DSHKM",[4352.14,3975.61,3.65926],267,[["gunner",-1,[0]]],[]]
	],
	[],
	[],
	GUER]
*/
Params [
	"_Array"
];
_Array Params [
	["_InfantryArray",[],[[]]],
	["_VehicleArray",[],[[]]],
	["_UnknownArray",[],[[]]],
	["_Side",independent,[sideUnknown]]
];

	_Settings = [_Side] Call OKS_Dynamic_Setting;
	_Settings Params ["_Units"];
	_Units Params ["_Leaders","_Units","_Officer"];
	Private ["_GarrisonPositions","_GarrisonMaxSize","_GarrisonMaxSize","_Unit","_Group"];

	_Group = CreateGroup _Side;
	_Group setVariable ["lambs_danger_disableGroupAI", true];
	{
		_X Params ["_Position","_Direction","_Stance","_Unknown"];

		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
			_Unit setRank "SERGEANT";
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
			_Unit setRank "PRIVATE";
		};
		_Unit setRank "PRIVATE";
		_Unit setDir _Direction;
		[_Unit,"PATH"] remoteExec ["disableAI",0];
		[_Unit,_Stance] remoteExec ["setUnitPos",0];				
	} foreach _InfantryArray;

	{
		Params ["_Type","_Position","_Dir","_Crew"];
		systemChat str [_Type,_Position,_Dir,_Crew];
		_Vehicle = CreateVehicle [_Type,_Position];
		_Vehicle setPosATL _Position;
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side,0,0] call OKS_AddVehicleCrew;
	} forEach _VehicleArray;