// [west,"CUP_B_CH53E_USMC",[2,1],getPos start,getpos drop,getpos exit,trigger_1] spawn OKS_FastRope

params ["_OKS_Side","_Classname","_Troops","_Start","_Drop","_Exit","_HuntZone"];

private ["_Unit","_UnitArray","_PilotClasses","_pilot","_Leader","_Groups","_y","_i","_Group","_NewGroup","_heli"];
_Groups = [];

systemchat str ["FASTROPE",_OKS_Side,_Classname,_Start,_Drop,_Exit,_HuntZone];

	switch (_OKS_Side) do {

		case blufor:{
			_PilotClasses = ["B_Pilot_F"];
			_UnitArray = ["B_Soldier_TL_F","B_Soldier_TL_F","B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"];
		};
		case opfor:{
			_PilotClasses = ["O_Pilot_F"];
			_UnitArray = ["O_Soldier_TL_F","O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
		};
		case independent:{
			_PilotClasses = ["I_Pilot_F"];
			_UnitArray = ["I_Soldier_TL_F","I_Soldier_TL_F","I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
		};

	};

		_heli = createVehicle [_Classname, _Start, [], 0, "NONE"];
		[_heli] call ace_fastroping_fnc_equipFRIES;
		_crew = createGroup _OKS_Side;
		_pilot = _crew CreateUnit [(_PilotClasses call BIS_fnc_selectRandom), [0,0,0], [], 0, "NONE"];
		_pilot moveInDriver _heli;
		_pilot setBehaviour "CARELESS";
		_pilot setCombatMode "BLUE";
		_pilot disableAI "FSM";

		_EmptyCargoSeats = (_Heli emptyPositions "Cargo");
		_UnitsPerGroup = round ( (round (_EmptyCargoSeats * (_Troops select 1))) );	// # OF GROUPS = (_Units select 0)  ||  % OF CARGO = (_Units select 1)

		// Limit Group Size to 8
		if (_UnitsPerGroup > 8) then {
			_UnitsPerGroup = 8;
		};

		_Group = CreateGroup _OKS_Side;
		_Groups pushBack _Group;
		for "_i" from 1 to _EmptyCargoSeats do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Leader = _Group CreateUnit [(_UnitArray call BIS_FNC_selectRandom), _Start, [], 0, "NONE"];
				_Leader setRank "SERGEANT";
				_Leader MoveInCargo _Heli;
			} else {
				_Unit = _Group CreateUnit [(_UnitArray call BIS_FNC_selectRandom), _Start, [], 0, "NONE"];
				_Unit setRank "PRIVATE";
				_Unit MoveInCargo _Heli;

			};
		};

_MoveWP = _crew addWaypoint [_Drop,0];
_MoveWP setWaypointType "MOVE";

//_MoveWP setWaypointScript {_Heli flyinHeight 10;}

_fastropeWP = _crew addWaypoint [_Drop,1];
[_Heli,_Crew,_FastRopeWP,_HoldWP] Spawn
{
    Params ["_Heli","_Crew","_FastRopeWP","_HoldWP"];
    _Index = _FastRopeWP#1 - 1;
    WaitUntil { Sleep 0.5; (CurrentWaypoint _Crew) > _Index };

    SystemChat "DEBUG: PASSED FASTROPE";

    Sleep 1; // Try adjusting this a bit to see when and if it overwrites.
    _Heli flyInHeight 7;
};
_fastropeWP setWaypointType "SCRIPTED";
_fastropeWP setWaypointScript "\z\ace\addons\fastroping\functions\fnc_deployAIWaypoint.sqf";

_HoldWP = _crew addWaypoint [_Drop,2];

_HoldWP setWaypointType "HOLD";
_HoldWP setWaypointBehaviour "CARELESS";
_HoldWP setWaypointCombatMode "BLUE";


//_heli flyInHeight 15;
/// Make a trigger for this later
waitUntil{sleep 1; _heli distance _Drop < 350};
//_heli flyInHeight 5;
//_pilot flyInHeight 5;
waitUntil{sleep 1; _heli distance _Drop < 350 && getPos _heli select 2 < 35 && speed _heli < 2};
_floor = createVehicle ["Land_HelipadEmpty_F", [getpos _heli select 0,getpos _heli select 1,0], [], 0, "NONE"];
_fastRopeWP setWaypointPosition [(getPos _floor),-1];
_HoldWP setWaypointPosition [(getPos _floor),-1];
_heli flyInHeight 5;
_Sleep = (_EmptyCargoSeats * 3);
Sleep _Sleep;

	//_Max = round ((_EmptyCargoSeats * (_Troops select 1)) / (_Troops select 0));
	/*for "_y" from 1 to (_Troops select 0) do
	{
		_NewGroup = CreateGroup _OKS_Side;
		for "_i" from 1 to _UnitsPerGroup do
		{
			systemchat str ["TEST",_i,units (_groups select _y),units _Group];
			systemChat str ((units _Group) select _i);
			[(units _Group) select _i] join _NewGroup;
		};
		_Groups PushBack _NewGroup;
	};
*/

deleteWaypoint _HoldWP;
[_Group, nil, _HuntZone, 0, 30, 0, {}] Spawn NEKY_Hunt_Run;
_heli flyInHeight 25;
_exitWP = _crew addWaypoint [_Exit,3];
waitUntil {Sleep 5; _heli distance _Exit < 400};
deleteVehicle driver _heli;
deleteVehicle _heli;
