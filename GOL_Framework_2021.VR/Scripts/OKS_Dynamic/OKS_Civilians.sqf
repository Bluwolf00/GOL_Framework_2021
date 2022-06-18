/*

	Civilian Presence Script by Oksman

	Parameters:
	1: Trigger (Object)
	2: Number of Civilians (Number)
	3: Count of House Waypoints (Number)
	4: Count of Random Outside Waypoints (Number)
	5: Use Agents? (TRUE/FALSE)
	6: Use Panic Mode? (TRUE/FALSE)
	7: Ethnicity - (STRING) Refer to OKS_FACESWAP (Optional: Default "Caucasian")
	8: MainTrigger - Trigger Object - Will delete all civilians when told in this area.

	[Trigger_1,15,12,15,true,true,"african"] execVM "Scripts\OKS_Dynamic\OKS_Civilians.sqf";
	[Trigger_1,15,12,15,true,true,"african"] spawn OKS_Civilians;
*/

if(HasInterface && !isServer) exitWith {};

Params ["_Trigger","_CivilianCount","_HouseWaypoints","_RandomWaypoints","_UseAgents","_UsePanicMode","_Ethnicity","_MainTrigger"];
Private _Debug_Variable = false;
Private _Spawns = 0;
Private _AllModules = [];

Private _CreateSafeSpot = {
	Params ["_Position","_UseBuilding","_SpawnPosition"];


	_SafeSpot = _Group createUnit ["ModuleCivilianPresenceSafeSpot_F", _Position, [], 0, "NONE"];
	_SafeSpot setVariable ["#capacity",2];
	_SafeSpot setVariable ["#usebuilding",_UseBuilding];
	_SafeSpot setVariable ["#terminal",false];
	_AllModules pushBackUnique _SafeSpot;
	//_m1 setVariable ["#type",5];

	if(_SpawnPosition && _Spawns < 4) then {
		_SpawnSpot = _Group createUnit ["ModuleCivilianPresenceUnit_F", _Position, [], 0, "NONE"];
		_AllModules pushBackUnique _SpawnSpot;
		_Spawns = _Spawns + 1;
	};
	//if(_Debug_Variable) then { systemChat format ["Created SafeSpot: %1 %2 %3",_Position,_UseBuilding,_SpawnPosition]};
};

if(isNil _Ethnicity) then {
	_Ethnicity = "caucasian"
};

if(_Debug_Variable) then { systemChat format ["Civilian Initiated.."]};

_Group = createGroup civilian;

_Area = (TriggerArea _Trigger);
_Size = (_Area#0) max (_Area#1);
_Buildings = nearestObjects [_Trigger, ["House"], _Size];
_InArea = _Buildings inAreaArray _Trigger;

For "_i" from 0 to _RandomWaypoints do
{
	_RandomPos = _Trigger call BIS_fnc_randomPosTrigger;
	_SafePos = [_RandomPos, 1, 100, 3, 0, 0, 0] call BIS_fnc_findSafePos;

	if(_HouseWaypoints <= 0) then {
		[_SafePos,false,true] call _CreateSafeSpot
	} else {
		[_SafePos,false,false] call _CreateSafeSpot
	};
};

For "_i" from 0 to _HouseWaypoints do
{
	_House = selectRandom _InArea;
	if(isNil "_House") exitWith {};
	_InArea deleteAt (_InArea find _House);
	[getPos _House,true,true] call _CreateSafeSpot;
};

if(isNil "OKS_FaceSwap") then {
	waitUntil{sleep 5; !(isNil "GW_Gear_Fnc_Handler")}
} else {
	waitUntil{sleep 5; !(isNil "GW_Gear_Fnc_Handler") && !(isNil "OKS_FaceSwap")}
};

if(_Debug_Variable) then { systemChat format ["Creating Civilian Module.."]};
_Module = _Group createUnit ["ModuleCivilianPresence_F", [0,0,0], [], 0, "NONE"];
_AllModules pushBackUnique _Module;
_Module setVariable ["#area",[getPos _Trigger,_Area#0,_Area#1,0,true,-1]];  // Fixed! this gets passed to https://community.bistudio.com/wiki/inAreaArray
_Module setVariable ["#debug",_Debug_Variable]; // Debug mode on
_Module setVariable ["#useagents",_UseAgents];
_Module setVariable ["#usepanicmode",_UsePanicMode];
_Module setVariable ["#unitcount",_CivilianCount];
_Module getVariable ["#onCreated",{[_this, "r"] call GW_Gear_Fnc_Handler; _this spawn { sleep 5; [_this,_Ethnicity] spawn OKS_FaceSwap}}];
if(_Debug_Variable) then { systemChat format ["Area %1 - %2 - Count %3",_Area#0,_Area#1,_CivilianCount]};

waitUntil{sleep 30; if(_Debug_Variable) then { systemChat "Waiting to delete civilians.."}; _MainTrigger getVariable ["OKS_Disable_Dynamic_Civilians",false]};

SystemChat "Deleting Civilians..";
{deleteVehicle _X} foreach _AllModules;
{ if ([_X] call GW_Common_Fnc_getSide == civilian && _X inArea _MainTrigger) then {deleteVehicle _X}} foreach allUnits;
