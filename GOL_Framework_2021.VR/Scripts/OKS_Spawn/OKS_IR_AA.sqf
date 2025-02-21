// How to use
// [UnitOrPosition,_Side,_MinimumAltitude,_MinimumRange,_MaximumRange,_ReloadTime] spawn OKS_IR_AA;
// [UnitOrPosition,_Side,_MinimumAltitude,_MinimumRange,_MaximumRange,_ReloadTime] execVM "Scripts\OKS_Spawn\OKS_IR_AA.sqf";

Params [
	["_UnitOrPosition",objNull,[objNull,[]]],
	["_Side",east,[sideUnknown]],
	["_MinimumAltitude",200,[0]],
	["_MinimumRange",500,[0]],
	["_MaximumRange",2500,[0]],
	["_ReloadTime",20,[0]]
];

OKS_Spawn_AntiAir_Soldier = {

	Params ["_Position","_Side"];
	Private ["_Classname"];
	if(typeName _Position == "ARRAY") then {
		switch (_Side) do {
			case west: { 
				_Classname = "B_Soldier_AA_F";
			};
			case east: { 
				_Classname = "O_Soldier_AA_F";
			};
			case independent: { 
				_Classname = "I_Soldier_AA_F";
			};				
			default {
				SystemChat "OKS_IR_AA.sqf: Side not recognized"
			};
		};
		_Group = createGroup _Side;
		_Unit = _Group createUnit [_Classname, _Position, [], 0, "CAN_COLLIDE"];
		_Unit setPos _Position;
	} else {
		_Unit = _Position;
	};

	[_Unit,"UP"] remoteExec ["setUnitPos",0];
	[_Unit,"PATH"] remoteExec ["disableAI",0];

	_Unit;
};

OKS_Remove_InfantryWeapons = {
	Params ["_Unit"];
	_Ammo = secondaryWeaponMagazine _Unit;
	Sleep 5;
	systemChat "Added NVGs.";
	_Unit addItem "NVGoggles_OPFOR";
	_Unit assignItem "NVGoggles_OPFOR";
	_Unit removeMagazines (_Ammo select 0);
	//_Unit addMagazine _Ammo;
};

OKS_Forced_Reload = {
	params ["_Unit","_ReloadTime"];

	_Unit setVariable ["AA_ReloadTime",_ReloadTime];	
	_Unit addEventHandler ["Fired", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

			_ReloadTimer = {
				params ["_Unit","_ReloadTime","_magazine"];
				// _Unit setCombatMode "BLUE";
				// _Unit setBehaviour "CARELESS";
				// {
				// 	_Unit forgetTarget (_X);
				// } foreach (_Unit targets [true]);
				
				systemChat "Reloading - Combat Blue";
				sleep _ReloadTime;
				_Unit setCombatMode "RED";
				_Unit addMagazine _magazine;
				_Unit setBehaviour "COMBAT";		
				systemChat "Reloaded - Combat Red";	
				_Unit setVariable ["AA_isReloading",false,true];	
			};		
			_ReloadTime = _Unit getVariable "AA_ReloadTime";
			if(_weapon == secondaryWeapon _Unit) then {
				[_Unit,_ReloadTime,_magazine] spawn _ReloadTimer; 
				_Unit setVariable ["AA_isReloading",true,true];
			};
		}
	];
};
OKS_Target_Finder = {
	Params ["_Unit","_MinimumAltitude","_MinimumRange","_MaximumRange"];
	Private ["_PreviousTarget"];
	_PreviousTarget = [];
	while {alive _Unit} do {
		_NearbyTargets = AllPlayers select {
			vehicle _X isKindOf "AIR" &&
			getPos _X select 2 >= _MinimumAltitude &&
			(_X distance _Unit <= _MaximumRange) &&
			(_X distance _Unit >= _MinimumRange)
		};		
		if(count _NearbyTargets > 0 && !(_Unit getVariable ["AA_isReloading",false])) then {
			_Unit setCombatMode "RED";
			{
				_Unit reveal [Vehicle _X,4];
				_Unit doTarget Vehicle _X;
				_Unit doFire Vehicle _X;
			} forEach _NearbyTargets;
			_PreviousTarget = _NearbyTargets;
			systemChat "Found Target - Combat Red - Revealed";
		} else {

			if(!(_Unit getVariable ["AA_isReloading",false])) then {
				_Unit setCombatMode "BLUE";
				systemChat "No Target - Combat Blue - Forgot";

				if(_PreviousTarget isNotEqualTo []) then {
					{
						_Unit forgetTarget _X
					} foreach _PreviousTarget;
				};
			}
		};

		if(_PreviousTarget isEqualTo []) then {
			_PreviousTarget = _NearbyTargets;
		};
		/*
		 	Activate in dev release branch Arma 3 2.18
			_NearbyTargets = AllPlayers select {vehicle _X isKindOf "AIR" && _X distance _Unit < 3000};
			SystemChat str _NearbyTargets;
			{
				systemChat str [getPos _X select 2,_X distance _Unit];
				if(getPos _X select 2 >= _MinimumAltitude && _X distance _Unit >= _MinimumRange) then {

					// Activate in dev release branch Arma 3 2.18
					// (group _Unit) ignoreTarget [_X, false];


					SystemChat format["%1 set to target for AA (%2).",_X,_Unit];
				} else {
					// Activate in dev release branch Arma 3 2.18
					//(group _Unit) ignoreTarget [_X, true];
				};
			} foreach _NearbyTargets;
		*/

		sleep 5;		
	};
};

Private ["_Unit"];

// Main Code
if(typeName _UnitOrPosition == "OBJECT") then {
	_Unit = [_UnitOrPosition] call OKS_Spawn_AntiAir_Soldier;
} else {
	_Unit = [_UnitOrPosition,_Side] call OKS_Spawn_AntiAir_Soldier;
};
systemChat str _Unit;
sleep 10;
SystemChat "OKS_IR_AA.sqf: Anti-Air Ready - Removing Infantry Weapons.";
[_Unit] remoteExec ["OKS_Remove_InfantryWeapons",0];
[_Unit,_ReloadTime] remoteExec ["OKS_Forced_Reload",0];

systemChat str _Unit;
[_Unit,_MinimumAltitude,_MinimumRange,_MaximumRange] spawn OKS_Target_Finder;





