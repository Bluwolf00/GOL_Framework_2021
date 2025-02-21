// How to use
// [UnitOrPosition,_Side,_MinimumAltitude,_MinimumRange,_MaximumRange,_ReloadTime] spawn OKS_IR_AA;
// [UnitOrPosition,_Side,_MinimumAltitude,_MinimumRange,_MaximumRange,_ReloadTime] execVM "Scripts\OKS_Spawn\OKS_IR_AA.sqf";

Params [
	["_UnitOrPosition",objNull,[objNull,[]]],
	["_Side",east,[sideUnknown]],
	["_MinimumAltitude",200,[0]],
	["_MinimumRange",500,[0]],
	["_MaximumRange",2500,[0]],
	["_ReloadTime",20,[0]],
	["_Array",nil,[[]]]
];
Private ["_Unit"];

// Main Code
if(typeName _UnitOrPosition == "OBJECT") then {
	_Unit = [_UnitOrPosition] call OKS_Spawn_AntiAir_Soldier;
} else {
	_Unit = [_UnitOrPosition,_Side] call OKS_Spawn_AntiAir_Soldier;
};

if(!isNil "_Array") then {
	_Array pushBackUnique _Unit;
	publicVariable ["_Array"];
};

[_Unit,_ReloadTime,_MinimumAltitude,_MinimumRange,_MaximumRange] spawn {
	params ["_Unit","_ReloadTime","_MinimumAltitude","_MinimumRange","_MaximumRange"];
	sleep 10;
	SystemChat "OKS_IR_AA.sqf: Anti-Air Ready - Removing Infantry Weapons.";
	[_Unit] remoteExec ["OKS_Remove_InfantryWeapons",0];
	[_Unit,_ReloadTime] remoteExec ["OKS_Forced_Reload",0];

	systemChat str _Unit;
	[_Unit,_MinimumAltitude,_MinimumRange,_MaximumRange] spawn OKS_Target_Finder;
};

_Unit;






