// [this] execVM "Scripts\NEKY_ServiceStation\Ace_Rearm_Doorgunner.sqf";

Params ["_Box"];

if (hasInterface) then {
    _condition = {count (_target nearEntities [["helicopter"], 30]) > 0};
	_rearmCode =
	{
		_Helicopters = _target nearEntities [["helicopter"], 30];
		if(count _Helicopters isEqualTo 0) exitWith {
			"No Helicopters in the vicinity." remoteExec ["SystemChat",_player];
		};		
		[_Helicopters,_Player] spawn {
			Params ["_Helicopters","_Player"];

			OKS_AIR_MagazineForeach = {
				Params ["_Vehicle","_Magazine","_Index","_MagazineCount"];

				for "_i" from 1 to _MagazineCount do {
					_vehicle removeMagazineTurret [_Magazine,[_Index]];
				};

				for "_i" from 1 to _MagazineCount do {
					_vehicle addMagazineTurret [_Magazine,[_Index]];
				};
			};

			{
				private _Helicopter = _X;
				_MagazineCount = _Helicopter getVariable ["OKS_DoorgunMagazineCount",""];
				_MagazineClass = _Helicopter getVariable ["OKS_DoorGunMagazineClass",""];
				_TurretIndex = _Helicopter getVariable ["OKS_DoorGunIndexes",""];

				if({_X isEqualTo ""} count [_MagazineCount,_MagazineClass,_TurretIndex] > 0) exitWith {
					//format["Doorguns were not defined on %1. Cannot rearm, try the default rearm.",getText (configFile >> "CfgVehicles" >> typeOf _Helicopter >> "displayName")] remoteExec ["SystemChat",_player];
				};

				{			
					[_Helicopter, _MagazineClass, _X, _MagazineCount] spawn OKS_AIR_MagazineForeach;
				} foreach _TurretIndex;

				format[
					"%1 rearmed %2 guns with %3 magazines each.",
					getText (configFile >> "CfgVehicles" >> typeOf _Helicopter >> "displayName"),
					count _TurretIndex,
					_MagazineCount
				] remoteExec ["SystemChat",_player];
			} foreach _Helicopters;
		};
	};

    _action = ["Rearm_Doorgunner", "Rearm (Door Gunners)","\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa", _rearmCode, _condition] call ace_interact_menu_fnc_createAction;
    [_Box, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};
