// [Group HVT_1,getPos ExfilSite_1,west] execVM "Scripts\OKS_Task\OKS_Evacuate_HVT.sqf";

if(!isServer) exitWith {};

	Params [
		["_UnitsOrGroupOrArray",[],[[],grpNull,objNull]],
		["_ExfilSite",[0,0,0],[[],objNull]],
		["_Side",west,[sideUnknown]]
	];

	Private ["_Units","_ExfilPosition"];
	if(typeName _UnitsOrGroupOrArray == "OBJECT") then {
		_Units = [_UnitsOrGroupOrArray];
		group _UnitsOrGroupOrArray setVariable ["acex_headless_blacklist",true,true];
	};
	if(typeName _UnitsOrGroupOrArray == "GROUP") then {
		_Units = units _UnitsOrGroupOrArray;
		_UnitsOrGroupOrArray setVariable ["acex_headless_blacklist",true,true];
	};
	if(typeName _UnitsOrGroupOrArray == "ARRAY") then {
		_Units = _UnitsOrGroupOrArray;
		(Group (_Units select 0)) setVariable ["acex_headless_blacklist",true,true];
	};
	if(typeName _ExfilSite == "OBJECT") then {
		_ExfilPosition = getPos _ExfilSite;
	} else {
		_ExfilPosition = _ExfilSite;
	};

	{
		if([_X] call GW_Common_Fnc_getSide != civilian) then {
			waitUntil {sleep 1; currentWeapon _X != ""};
		};		
		_X disableAI "MOVE";
		_X setUnitPos "MIDDLE";
		_X setCaptive true;
		removeAllWeapons _X;
		removeGoggles _X;
		removeBackpack _X;
		removeHeadgear _X;
		_X addGoggles "G_Blindfold_01_black_F";
		_X playMove "acts_aidlpsitmstpssurwnondnon04";

		_X spawn {
			waitUntil {sleep 1; _this getVariable ["ace_captives_isHandcuffed", false] || !Alive _this};
			if(alive _this) then {
				removeGoggles _this;
			};			
		};
	} forEach _Units;
	
	Private _TaskId = format["RescueHVTTask_%1",(random 9999)];

	waitUntil {sleep 5; {_X getVariable ["ace_captives_isHandcuffed", false]} count _Units > 0 || {!Alive _X} count _Units == count _Units};

	Private _TaskState = "ASSIGNED";
	if({!Alive _X} count _Units == count _Units) then {
		_TaskState = "FAILED";
	};
	[
		true,
		_TaskId,
		[
			"You have found HVTs to extract. Bring them to the exfil site and await the helicopter that will extract them.",
			"Extract HVT",
			"Extract"
		],
		_ExfilPosition,
		_TaskState,
		-1,
		true,
		"exit",
		false
	] call BIS_fnc_taskCreate;
	if(_TaskState == "FAILED") exitWith {false};

	waitUntil {sleep 10; {!Alive _X || _X distance _ExfilPosition < 50} count _Units == count _Units};
	if({!Alive _X} count _Units == count _Units) exitWith {
		// Fail
		[_TaskId, "FAILED", true] call BIS_fnc_taskSetState;			
	};

	["hq","side","Be advised, extraction helicopter is inbound for your HVTs. Load them up when it arrives, HQ out"] remoteExec ["OKS_Chat",0];
	[_Side,"",["helicopter_Spawn",_ExfilPosition,"helicopter_despawn","helicopter_despawn"],false] execVM "Scripts\NEKY_PickUp\NEKY_PickUp.sqf";

	waitUntil{sleep 10; {!Alive _X || (ObjectParent _X) isKindOf "Helicopter"} count _Units == count _Units};
	if({!Alive _X} count _Units == count _Units) exitWith {
		// Fail
		[_TaskId, "FAILED", true] call BIS_fnc_taskSetState;		
	};

	// Succeeded
	[_TaskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;		
		
