// [Group HVT_1] execVM "Scripts\OKS_Task\OKS_Hostage.sqf";
// [Group HVT_1,getPos ExfilSite_1,west,false,nil] spawn OKS_Hostage;
if(!isServer) exitWith {};

	Params [
		["_UnitsOrGroupOrArray",[],[[],grpNull,objNull]],
		["_TaskParent",nil,[""]]
	];

	Private ["_Units","_ExfilPosition","_TaskDescription"];
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

	{
		systemChat format["%1 set to captive hostage.", name _X];
		_X disableAI "MOVE";
		_X setUnitPos "UP";
		_X setCaptive true;
		[_X, true] call ACE_captives_fnc_setHandcuffed;
		removeAllWeapons _X;
		removeGoggles _X;
		removeBackpack _X;
		removeHeadgear _X;
		_X addGoggles "G_Blindfold_01_black_F";

		_X spawn {
			waitUntil {sleep 1; !(_this getVariable ["ace_captives_isHandcuffed", true]) || !Alive _this};
			if(alive _this) then {
				removeGoggles _this;
			};			
		};			
		_X setVariable ["GOL_IsStatic",true,true];
	} forEach _Units;
	
	Private _TaskId = format["HostageTask_%1",(random 9999)];
	Private _TaskArray = _TaskId;
	if(!isNil "_TaskParent") then {
		_TaskArray = [_TaskId,_TaskParent]
	};

	_TaskPosition = [0, 0, 0];
	{
		_TaskPosition = _TaskPosition vectorAdd (getPosWorld _x);
	} forEach _Units;
	_TaskPosition = _TaskPosition vectorMultiply (1 / (count _Units));		

	_TaskDescription = format["You have rescued the hostages, there are %1 alive out of %2 in total. Leave them and move on with your mission.",{Alive _X} count _Units,count _Units];
	[
		true,
		_TaskArray,
		[
			_TaskDescription,
			"Rescued Hostages",
			"Rescue"
		],
		_TaskPosition,
		"CREATED",
		-1,
		false,
		"help",
		false
	] call BIS_fnc_taskCreate;		

	waitUntil {sleep 5; {(_X getVariable ["ace_captives_isHandcuffed", true])} count _Units == 0 || {!Alive _X} count _Units == count _Units};
	if({!Alive _X} count _Units == count _Units) exitWith {
		// Fail
		[_TaskId, "FAILED", true] call BIS_fnc_taskSetState;		
	};

	// Succeeded
	[_TaskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;		
		
