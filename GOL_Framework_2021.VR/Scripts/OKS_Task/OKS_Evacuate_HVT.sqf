// [Group HVT_1,getPos ExfilSite_1,west] execVM "Scripts\OKS_Task\OKS_Evacuate_HVT.sqf";

if(!isServer) exitWith {};

	Params [
		["_UnitsOrGroup",[],[[],grpNull,objNull]],
		["_ExfilSite",[0,0,0],[[],objNull]],
		["_Side",west,[sideUnknown]]
	];

	Private ["_Units","_ExfilPosition"];
	if(typeName _UnitsOrGroup == "OBJECT") then {
		_Units = [_UnitsOrGroup];
		group _UnitsOrGroup setVariable ["acex_headless_blacklist",true,true];
	};
	if(typeName _UnitsOrGroup == "GROUP") then {
		_Units = units _UnitsOrGroup;
		_UnitsOrGroup setVariable ["acex_headless_blacklist",true,true];
	};
	if(typeName _UnitsOrGroup == "ARRAY") then {
		_Units = _UnitsOrGroup;
		(Group (_Units select 0)) setVariable ["acex_headless_blacklist",true,true];
	};
	if(typeName _ExfilSite == "OBJECT") then {
		_ExfilPosition = getPos _ExfilSite;
	} else {
		_ExfilPosition = _ExfilSite;
	};

	{
		_X disableAI "MOVE"; _X setUnitPos "MIDDLE"; _X setCaptive true;
	} forEach _Units;

	waitUntil {sleep 10; {!Alive _X || _X distance _ExfilPosition < 150} count _Units == count _Units};
	if({!Alive _X} count _Units == count _Units) exitWith {
		// Fail
		[
			true,
			format["RescueHVTTask_%1",(random 9999)],
			[
				"You have failed the extraction of HVTs. The HVTs were killed!",
				"Extract HVT",
				"Extract"
			],
			objNull,
			"FAILED",
			-1,
			true,
			"exit",
			false
		] call BIS_fnc_taskCreate;		
	};

	["hq","side","Be advised, extraction helicopter is inbound for your HVTs. Load them up when it arrives, HQ out"] remoteExec ["OKS_Chat",0];
	[_Side,"",["helicopter_Spawn",_ExfilPosition,"helicopter_despawn","helicopter_despawn"],false] execVM "Scripts\NEKY_PickUp\NEKY_PickUp.sqf";

	waitUntil{sleep 10; {!Alive _X || (ObjectParent _X) isKindOf "Helicopter"} count _Units == count _Units};
	if({!Alive _X} count _Units == count _Units) exitWith {
		// Fail
		[
			true,
			format["RescueHVTTask_%1",(random 9999)],
			[
				"You have failed the extraction of HVTs. The HVTs were killed!",
				"Extract HVT",
				"Extract"
			],
			objNull,
			"FAILED",
			-1,
			true,
			"exit",
			false
		] call BIS_fnc_taskCreate;
	};

	// Succeeded
	[
		true,
		format["RescueHVTTask_%1",(random 9999)],
		[
			"You have successfully extracted HVTs. Good work!",
			"Extract HVT",
			"Extract"
		],
		objNull,
		"SUCCEEDED",
		-1,
		true,
		"exit",
		false
	] call BIS_fnc_taskCreate;
		
