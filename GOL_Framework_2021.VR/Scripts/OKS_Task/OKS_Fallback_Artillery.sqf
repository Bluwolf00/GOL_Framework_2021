
/*
 	Add Fallback Objective with Artillery Strike.

	[[artyStrike_1,artyStrike_2],"rhs_ammo_3of56",1,140,10,100,true,nil] spawn OKS_Fallback_Artillery;
	[[artyStrike_1,artyStrike_2],"rhs_ammo_3of56",1,140,10,100,true,"taskdefend"] spawn OKS_Fallback_Artillery;
	[[artyStrike_1,artyStrike_2],"rhs_ammo_3of56",1,140,10,100,true,"taskdefend"] execVM "Scripts\OKS_Task\OKS_Fallback_Artillery.sqf";
*/

if(!isServer) exitWith {false};

Params [
	["_Targets",objNull,[objNull,[]]],
	["_Munition","rhs_ammo_3of56",[""]],
	["_DelayBetweenRounds",5,[0]],
	["_DelayUntilStrike",180,[0]],
	["_AmountOfRounds",10,[0]],
	["_MunitionSpread",100,[0]],
	["_ShouldBeRandom",false,[false]],
	["_TaskParent",nil,[""]]
];

private ["_TaskIdArray","_TaskArray","_TaskId","_MarkerArray"];

if(_ShouldBeRandom) then {
	_Targets = [selectRandom _Targets];
};

OKS_RandomArtillery = {
	Params ["_Target","_Munition","_DelayBetweenRounds","_AmountOfRounds","_MunitionSpread"];
	for "_i" from 1 to _AmountOfRounds do {
		_RandomPos = _Target getPos [(random _munitionSpread),(random 360)];
		_Round = createVehicle [_Munition, [(_RandomPos select 0), (_RandomPos select 1), ((_RandomPos select 2) + 120)], [], 20, "CAN_COLLIDE"];
		_Round setVelocity [0,0,-15];
		sleep (_DelayBetweenRounds + (random _DelayBetweenRounds));
	};
	_Target setVariable ["OKS_StrikeComplete",true,true];
};

_TaskIdArray = [];
_MarkerArray = [];
["hq","side","1st Platoon be advised, enemy artillery has zeroed in on your position! Check your map, we have intel that suggests this area will be struck! Get out of there!"] remoteExec ["OKS_Chat",0];

{
	_TaskId = format["OKS_Fallback_Task_%1",random 9999 + (random 9999)];
	_TaskIdArray pushBackUnique _TaskId;
	_TaskArray = [_TaskId];
	if(!isNil "_TaskParent") then {
		_TaskArray = [_TaskId,_TaskParent];
	};

	_TaskInfo = [true, _TaskArray, ["An enemy artillery strike is inbound, get out of the target area ASAP!", "Incoming Artillery Strike!", ""], _X,"AUTOASSIGNED",-1,true,"destroy"] call BIS_fnc_taskCreate;
	_MarkerBorder = createMarker [format["ZoneBorderMarkerArty_%1",round(random 9999)],getPos _X];
	_MarkerBorder setMarkerShape "ELLIPSE";
	_MarkerBorder setMarkerSize [(_MunitionSpread + 25),(_MunitionSpread + 25)];
	_MarkerBorder setMarkerBrush "Border";
	_MarkerBorder setMarkerColor "colorBlack";

	_Marker = createMarker [format["ZoneMarkerArty_%1",round(random 9999)],getPos _X];
	_Marker setMarkerShape "ELLIPSE";
	_Marker setMarkerSize [(_MunitionSpread + 25),(_MunitionSpread + 25)];
	_Marker setMarkerBrush "FDiagonal";
	_Marker setMarkerColor "colorRed";	

	_MarkerText = createMarker [format["ZoneIconMarkerArty_%1",round(random 9999)],_X getPos [5,0]];
	_MarkerText setMarkerShape "ICON";
	_MarkerText setMarkerType "loc_destroy";
	_MarkerText setMarkerText "  Incoming Artillery strike!";
	_MarkerText setMarkerColor "colorOPFOR";

	_MarkerArray pushBackUnique _Marker;
	_MarkerArray pushBackUnique _MarkerText;
	_MarkerArray pushBackUnique _MarkerBorder;
} foreach _Targets;

_Multiplier = 0.1;
if(isDedicated) then {
	_Multiplier = 1;
};
_Delay = (140 * _Multiplier);
systemChat str _Delay;
sleep _Delay;

{
	[_X,_Munition,_DelayBetweenRounds,_AmountOfRounds,_MunitionSpread] spawn OKS_RandomArtillery;
} foreach _Targets;

waitUntil {
	sleep 10;
	{_X getVariable ["OKS_StrikeComplete",false]} count _Targets == count _Targets
};

{
	[_X,"CANCELED",true] call BIS_fnc_taskSetState
} foreach _TaskIdArray;
{
	deleteMarker _X
} foreach _MarkerArray;
