/*
	Author: GuzzenVonLidl - Edit and Adapted by Oksman
	Cretes objects around a selected vehicle from a base template

	Usage:
	[Object, "roadblock",EAST] spawn OKS_CreateComposition;
	"Scripts\OKS_Dynamic\OKS_CreateComposition.sqf";

	Arguments:
	0: Centered Object <OBJECT>
	1: Objects to be created <ARRAY>

	Return Value: NO

	Public: No
*/

if (!isServer) exitWith {false};

params [
	["_Object",[objNull,[0,0,0]]],
	["_typeString",[""]],
	["_Side",[sideEmpty]],
	["_Dir",[0]]
];

private ["_can","_veh","_info","_dir","_marker"];
private _return = [];

	//_info = getRoadInfo _Object;
	//_dir = (_info select 6) getDir (_info select 7);

switch (_typeString) do {
	case "small": {
		_return = [
			["Land_IRMaskingCover_02_F",90,[-0.796722,-3.09734,-0.00529003]],
			["Land_CampingTable_F",189.946,[-1.85233,-6.61244,-0.00528622]],
			["Land_CampingChair_V2_F",230,[-2.26124,-7.54794,-0.00528622]],
			["Land_CampingChair_V2_F",353.474,[-1.2665,-5.82129,-0.00528622]],
			["Land_Portable_generator_F",110,[-2.7164,-5.33063,-0.00528622]],
			["Land_CanisterFuel_F",320,[-2.04576,-5.67267,-0.00528622]],
			["PortableHelipadLight_01_red_F",340,[-1.69991,-6.54645,0.807719]],
			["Land_Sleeping_bag_folded_F",38,[-1.80033,-6.83354,0.807719]],
			["Land_Sleeping_bag_folded_F",121.391,[-2.10519,-6.41302,0.807719]]
		];
	};

	case "medium": {
		_return = [
			["Land_IRMaskingCover_01_F",90,[-0.500839,-5.47292,-0.00528622]],
			["CargoNet_01_barrels_F",210,[3.62416,-6.34792,-0.00528622]],
			["Land_WaterBarrel_F",0,[3.74916,-7.97292,-0.00528622]],
			["Land_CampingTable_F",230,[-3.12584,-10.5979,-0.00528622]],
			["Land_CampingChair_V1_F",30,[-2.87584,-9.47292,-0.00528622]],
			["PortableHelipadLight_01_red_F",0,[-2.87584,-11.2229,0.807719]]
		];
	};
	case "fob": {
			_return = [
				["Land_HBarrier_Big_F",45,[1.49596,6.9942,-0.00528622]],
				["Land_HBarrier_Big_F",215,[-8.31532,16.5477,-0.00528622]],
				["Land_HBarrierWall4_F",50,[-4.26378,11.1359,-0.00528622]],
				["Land_HBarrier_Big_F",95,[4.08037,0.0249233,-0.00528622]],
				["Land_HBarrierWall4_F",145,[-5.62723,-11.5474,-0.00528622]],
				["Land_HBarrierWall_corner_F",145,[0.131363,-10.6316,-0.00528622]],
				["Land_HBarrierWall_corner_F",55,[3.41786,-7.54755,-0.00528622]],
				["Land_HBarrier_Big_F",50,[-17.8708,-11.5409,-0.00528622]],
				["Land_HBarrier_Big_F",230,[-28.7146,0.409781,-0.00528622]],
				["Land_HBarrier_Big_F",50,[-23.0594,-5.9409,-0.00528622]],
				["Land_HBarrierWall_corner_F",230,[-32.4326,6.59099,-0.00528622]],
				["Land_HBarrier_Big_F",5,[-11.2988,-14.5115,-0.00528622]],
				["Land_HBarrierWall4_F",320,[-29.2914,10.0427,-0.00528622]],
				["Land_HBarrierWall_corner_F",320,[-22.0327,16.9493,-0.00528622]],
				["Land_HBarrierWall_corridor_F",230,[-26.2647,14.2141,-0.00528622]],
				["Land_HBarrier_Big_F",5,[-15.9098,18.9867,-0.00528622]],
				["Land_CargoBox_V1_F",80,[-26.6234,2.00134,-0.00528622]],
				["Land_CargoBox_V1_F",25,[-24.6146,-0.392542,-0.00528622]],
				["Land_PaperBox_closed_F",80,[-6.61691,6.55055,-0.00528622]],
				["Land_PaperBox_open_full_F",35,[-7.4754,4.85114,-0.00528622]],
				["Land_PaperBox_closed_F",45,[-5.33134,5.01846,-0.00528622]],
				["WaterPump_01_sand_F",250,[-15.6401,14.9704,-0.00528622]],
				["Land_WaterTank_F",195,[-12.2666,16.0062,-0.00528622]],
				["Land_WaterTank_F",300,[-10.4374,14.604,-0.00528622]],
				["Land_HelipadCircle_F",320,[-12.6296,-4.36905,-0.00528622]]
			];
		};
		case "roadblock": {
			_return = [["Land_Cargo_Patrol_V2_F",179,[-8.55957,0.0584412,-0.0476074]],["Land_CncBarrier_F",42,[11.1416,5.57594,-0.0434418]],["Land_CncBarrier_F",90,[12.1162,3.34172,-0.0438995]],["Land_CncBarrier_F",359,[-7.61133,7.43536,-0.139297]],["Land_CncBarrier_F",359,[-10.251,7.40286,-0.215485]],["Land_CncBarrier_F",317,[-12.5029,6.48199,-0.268311]],["Land_CncBarrier_F",269,[-13.457,4.18968,-0.250473]],["RoadBarrier_F",1,[-8.18457,8.72128,-0.164581]],["RoadBarrier_F",354,[6.38477,8.40816,-0.00723267]],["Land_CncBarrier_F",101,[11.498,-3.42479,-0.0189972]],["Land_CncBarrier_F",149,[10.083,-5.40875,0.00358582]],["Land_CncBarrier_F",179,[7.53711,-6.0211,0.035675]],["Fort_Nest",179,[7.92969,5.10266,0.00144958]],["Land_GuardShed",0,[7.38379,-4.79396,-0.00527954]],["Land_GuardShed",356,[-6.95801,-9.26149,0.255661]]];
		};

		case "roadblock_wide": {
			_return = [["Land_CncBarrier_F",42,[12.4561,7.68579,-0.0576782]],["Land_CncBarrier_F",90,[13.4307,5.45157,-0.0581512]],["Land_CncBarrier_F",359,[-9.37305,7.25304,-0.188049]],["Land_CncBarrier_F",359,[-12.0146,7.22153,-0.264771]],["Land_CncBarrier_F",317,[-14.2686,6.3007,-0.316803]],["Land_CncBarrier_F",269,[-15.2227,4.00935,-0.275406]],["RoadBarrier_F",1,[-9.9502,8.53969,-0.220062]],["RoadBarrier_F",354,[7.7002,10.5176,-0.0325317]],["Land_CncBarrier_F",101,[12.7803,-5.83504,-0.0182037]],["Land_CncBarrier_F",149,[11.3652,-7.81883,0.00874329]],["Land_CncBarrier_F",179,[8.81934,-8.4292,0.0409088]],["Land_Cargo_Patrol_V2_F",179,[-10.3877,1.08855,-0.110931]],["Land_Cargo_Patrol_V2_F",359,[8.67871,-1.62964,-0.00770569]],["Fort_Nest",179,[9.24414,7.21252,-0.0128174]],["Land_GuardShed",0,[8.66602,-7.20403,-0.000152588]],["Land_GuardShed",356,[-8.71191,-9.4492,0.316345]]];
		};
};

private _can = createVehicle ["Land_Compass_F", [0,0,0], [], 0, "NONE"];

if(typeName _object == "ARRAY") then {
	_can setDir _Dir;
	_can setPos _Object
} else {
	_can setDir (getdir _object);
	_can setPos (getPos _object);
};

_ClearTerrainTrigger = createTrigger ["EmptyDetector", getPos _can];
_ClearTerrainTrigger setTriggerArea [25, 25, getDir _can, false,15];
_ClearTerrainTrigger setTriggerStatements ["true", "[thisTrigger, true, []] call GW_Common_fnc_setHideTerrainObjects", ""];

//systemChat str _object;
//systemChat str _return;

{
	_x params ["_type","_dir","_pos","_inventory"];
	_veh = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
	//systemChat str [_dir, getDir _object, (_dir + (getDir _object))];

	if(typeName _object == "ARRAY") then {
		_veh setDir (_dir + _Dir);
	} else {
		_veh setDir (_dir + getDir _object);
	};

	_veh setVehiclePosition [(_can modelToWorld _pos), [], 0, "CAN_COLLIDE"];
	_veh setVectorUp surfaceNormal position _veh;
	_veh enableSimulationGlobal false;
	_veh allowDamage false;
} forEach _return;


private ["_SideMarker","_SideColor","_Units","_Unit","_Group"];
Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_TL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = ["B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for infantry units.
		_SideMarker = "B_installation";
		_SideColor = "ColorBlufor";
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = ["O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
		_SideMarker = "O_installation";
		_SideColor = "ColorOpfor";
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_TL_F","I_Soldier_TL_F"];
		_Units = ["I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
		_SideMarker = "I_installation";
		_SideColor = "ColorIndependent";
	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_SkillVariables = "";
		_Skill = "";
		_Leaders = "";
		_Units = "";
	};
};


	_Houses = [];
	_GarrisonPositions = [];
	{
		_Houses pushBackUnique _X;
	} foreach nearestObjects [_object,["House","BUNKER","VIEW-TOWER"],60];

	{ if(count ([_X] call BIS_fnc_buildingPositions) > 1) then { _GarrisonPositions pushBackUnique ([_X] call BIS_fnc_buildingPositions select (random (count ([_X] call BIS_fnc_buildingPositions))))} else {_GarrisonPositions append ([_X] call BIS_fnc_buildingPositions)}} foreach _Houses;

	_Group = CreateGroup _Side;
	_Bunker = selectRandom nearestObjects [_object,["Land_Cargo_Patrol_V2_F"],40];

	sleep 2;
	if(!isNil "_Bunker") then {
		_MGPos = getPos _Bunker;
		_MGPos = [(_MGPos select 0) + 0.8,(_MGPos select 1) + 0.5,4.38];

		_MG = createVehicle ["rhs_KORD_high_MSV",_MGPos, [], 0, "NONE"];
		_MG setPos _MGPos;
		_Unit = _Group CreateUnit [_Units call BIS_FNC_selectRandom, _MGPos, [], 0, "NONE"];
	    _Unit setRank "PRIVATE";
	    _Unit disableAI "PATH";
	    _Unit setUnitPosWeak "UP";
	    _Unit moveInGunner _MG;
	};

	_Group = CreateGroup _Side;
	for "_i" from 1 to 5 do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [getPos _can select 0,getPos _can select 1,0], [], 10, "NONE"];
			_Unit setRank "SERGEANT";
		} else {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [getPos _can select 0,getPos _can select 1,0], [], 10, "NONE"];
			_Unit setRank "PRIVATE";
		};
	};

	[[getPos _can select 0,getPos _can select 1,0], nil, units _Group, 50, 0, true, true] call ace_ai_fnc_garrison;
	/*

		 * Arguments:
		 * 0: The building(s) nearest this position are used <POSITION>
		 * 1: Limit the building search to those type of building <ARRAY>
		 * 2: Units that will be garrisoned <ARRAY>
		 * 3: Radius to fill building(s) <SCALAR> (default: 50)
		 * 4: 0: even filling, 1: building by building, 2: random filling <SCALAR> (default: 0)
		 * 5: True to fill building(s) from top to bottom <BOOL> (default: false) (note: only works with filling mode 0 and 1)
		 * 6: Teleport units <BOOL> (default: false)

	*/
	//copyToClipboard str _GarrisonPositions;
	[getPos _can,5,150,_Side,_Units] spawn OKS_Patrol_Spawn;
	deleteVehicle _can;

	///[[[11004.6,17042.3,0.194088]],[[10991.4,17049.5,0.194088]],[[11003.1,17064.2,0.194115]],[[11016.9,17058.4,0.194138]]]


	if(typeName _object == "ARRAY") then {
		_marker = createMarker [format ["_OKS_Roadblock_Marker_%1",str (random 2000)],_object];
	} else {
		_marker = createMarker [format ["_OKS_Roadblock_Marker_%1",str (random 2000)],getPos _object];
	};
	_marker setMarkerShape "ICON";
	_marker setMarkerSize [0.6,0.6];
	_marker setMarkerType _SideMarker;
	_marker setMarkerColor _SideColor;
	_marker setMarkerText " Roadblock";

	SystemChat format ["%1 %2 created at %3",_Side,_typeString,getMarkerPos _marker];



