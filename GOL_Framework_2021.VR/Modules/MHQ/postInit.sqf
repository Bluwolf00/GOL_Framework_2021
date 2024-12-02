#include "script_Component.hpp"

["CAManBase", "Respawn", {
	[{
		(_this select 0) spawn {
			_this setVariable ["GOL_TeleportDelay",true,true];
			_Delay = 120;
			for [{ private _i = _Delay }, { _i > 0 }, { _i = _i - 1}] do {
				[parseText format[
					("<t color='#f5791b'>"+
					"<t size='1.3'>RESPAWN DELAY</t>"+
					"<br/><t size='1.1'>YOU MAY USE SCRIPTED REINSERT IN:<br/><br/>"+
					"<t size='2'>%1</t></t></t>")
				,_i]] remoteExec ["hintSilent",_this];
				sleep 1;
			};
			[parseText
					("<t color='#f5791b'>"+
					"<t size='1.3'>RESPAWN DELAY</t>"+
					"<br/><br/><t size='1.1'>YOU MAY NOW USED SCRIPTED REINSERT.</t></t>")
			] remoteExec ["hintSilent",_this];
			_this setVariable ["GOL_TeleportDelay",false,true];
		};		
		_this call FUNC(HandlerRespawn);
	}, _this] call CBA_fnc_execNextFrame;
}, true, [], true] call CBA_fnc_addClassEventHandler;

[QGVAR(Enabled), {
	params [
		"_mhq",
		["_toggle",false,[true]],
		["_side","West",["",0]]
	];

	_mhq setVariable [QGVAR(Active), _toggle, true];
	TRACE_3("QGVAR(Enabled)", _mhq, (_mhq getVariable [QGVAR(Active), false]), _toggle);
	if (_mhq getVariable [QGVAR(Active), false]) then {
		_mhq setVariable [QGVAR(Fuel), (fuel _mhq)];
		_mhq setVariable [QGVAR(Side), toLower(_side), true];
		[_mhq,0] remoteExecCall ["setFuel", _mhq];
	} else {	// restore fuel
		[_mhq,(_mhq getVariable [QGVAR(Fuel), (fuel _mhq)])] remoteExecCall ["setFuel", _mhq];
		[QGVAR(Assembled), [_mhq, false]] call CBA_fnc_LocalEvent;
	};
	[QGVAR(Actions), [_mhq]] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(Assembled), {
	params [
		"_mhq",
		["_toggle",false,[true]]
	];

	_mhq setVariable [QGVAR(Assembled), _toggle, true];
	if (_mhq getVariable [QGVAR(Assembled), false]) then {
		[_mhq] call FUNC(prefabCreate);
//		[_mhq, (_mhq getVariable QGVAR(Info)) select 4] call FUNC(getDeployType);
	} else {	// Remove objects
		{
			deleteVehicle _x;
		} forEach (_mhq getVariable QGVAR(objectsCreated));
		_mhq setVariable [QGVAR(objectsCreated), [], true];
	};

	if (_toggle) then {
		GVAR(AssembledArray) pushBackUnique _mhq;
		publicVariable QGVAR(AssembledArray);
		if !(_mhq getVariable [QGVAR(Active), false]) then {
			[QGVAR(Enabled), [_mhq, true]] call CBA_fnc_serverEvent;
		};
	} else {
		GVAR(AssembledArray) deleteAt (GVAR(AssembledArray) find _mhq);
		publicVariable QGVAR(AssembledArray);
	};
	TRACE_3("QGVAR(Assembled)", _mhq, (_mhq getVariable [QGVAR(Assembled), false]), _toggle);
}] call CBA_fnc_addEventHandler;

[QGVAR(Actions), {
	#define	ARGUMENT(VAR) VAR,1,false,false,""
	#define	CONDITION_1 "(alive _target) && (vehicle player isEqualTo player) && !(player getVariable ['GOL_TeleportDelay',false])"
	#define	CONDITION_2 "(_target getVariable 'GW_MHQ_Assembled')"
	#define	CONDITION_3 "(alive _target) && (speed _target) < 0.1"
	#define CONDITION_4 "(gunner _target) == player || (driver _target) == player || (commander _target) == player || vehicle player isNotEqualTo _target"
	params ["_mhq"];
	private	_add = [];
	private _mhqActiveActions = (_mhq getVariable [QGVAR(ActiveActions), []]);
	{
		(_x select 0) removeAction (_x select 1);
	} forEach _mhqActiveActions;
	_mhq setVariable [QGVAR(ActiveActions), []];

	if (_mhq getVariable QGVAR(Active)) then {
		_id = _mhq addAction ["Deactivate MHQ",{ player PlayMove "Acts_carFixingWheel";
			["Deactivating MHQ", 5, {(((_this select 0) select 0) getVariable "GW_MHQ_Active")}, {
				([QGVAR(Enabled), [((_this select 0) select 0), false, str([player] call EFUNC(Common,getSide))]] call CBA_fnc_serverEvent);
				if(objectParent player != ((_this select 0) select 0)) then {
					player SwitchMove "";
				};
				_mhqMarkerId = ((_this select 0) select 0) getVariable ["MHQ_MarkerId",""];
				_mhqMarkerId setMarkerAlpha 0;
				_mhqMarkerAreaId = format["%1_Area",_mhqMarkerId];
				_mhqMarkerAreaId setMarkerAlpha 0;
			},
			{
				if(objectParent player != ((_this select 0) select 0)) then {
					player SwitchMove "";
				};
				hint "Aborted";
			} , [(_this select 0)]] call CBA_fnc_progressBar;
		},ARGUMENT(_mhq),(CONDITION_4 +" && "+ CONDITION_3 + "&& !" + CONDITION_2),7];
		_add pushback [_mhq, _id];

		_id = _mhq addAction ["Assemble MHQ",{
			player PlayMove "Acts_carFixingWheel"; ["Assembling MHQ", 10, {!(((_this select 0) select 0) getVariable "GW_MHQ_Assembled")}, {
				([QGVAR(Assembled), [((_this select 0) select 0), true]] call CBA_fnc_serverEvent); player SwitchMove "";
			}, {hint "Aborted"; player SwitchMove "";}, [(_this select 0)]] call CBA_fnc_progressBar;
		},ARGUMENT(_mhq),(CONDITION_1 + "&& !" + CONDITION_2),7];
		_add pushback [_mhq, _id];

		_id = _mhq addAction ["Disassemble MHQ",{ player PlayMove "Acts_carFixingWheel";
			["Disassemble MHQ", 10, {(((_this select 0) select 0) getVariable "GW_MHQ_Assembled")}, {
				([QGVAR(Assembled), [((_this select 0) select 0), false]] call CBA_fnc_serverEvent); player SwitchMove "";
			}, {hint "Aborted"; player SwitchMove "";}, [(_this select 0)]] call CBA_fnc_progressBar;
		},ARGUMENT(_mhq),(CONDITION_1 + "&& " + CONDITION_2),7];
		_add pushback [_mhq, _id];

		_id = _mhq addAction ["Teleport to Base",{[player, ([(_this select 0)] call FUNC(getFlag))] call bis_fnc_moveToRespawnPosition},ARGUMENT(_mhq),(CONDITION_1),7];
		_add pushback [_mhq, _id];
		private _mhqName = _mhq;
		if(["p3d", str _mhq] call BIS_fnc_inString) then {
			_mhqName = format["%1 MHQ",[configFile >> "CfgVehicles" >> typeOf _mhq] call BIS_fnc_displayName];
		};
		_id = (([_mhq] call FUNC(getFlag))) addAction[format ["Teleport to %1", _mhqName],{
			_EnemyNearUnits = ((_this select 3) nearEntities ["Man", GOL_OKS_MhqSafeZone]) select {(side _X) getFriend (side player) < 0.6 && side _X != civilian};
			if(count _EnemyNearUnits == 0) then {	
				private _height = 5;
				private _sleep = 3.5;	
				private _camera = "camera" camCreate [getPosATL (_this select 3) select 0,getPosATL (_this select 3) select 1,100];		
				cutText ["", "BLACK OUT",1]; sleep 1;
				1 fadeSound 0;
				cutText ["", "BLACK IN",1];
				if(vehicleVarName (_this select 3) == "Tent_MHQ") then {
					[player, (_this select 3)] call bis_fnc_moveToRespawnPosition;
					_camera camSetTarget player;
					_height = 2;
					_sleep = 5;
				} else {
					_camera camSetTarget (_this select 3);
				};	
				showCinemaBorder true;
				_camera cameraEffect ["internal", "back"];
				
				waitUntil { camCommitted _camera; };
				1 fadeSound 1;
				_camera camSetPos [getPosATL (_this select 3) select 0,getPosATL (_this select 3) select 1,_height];
				_camera camCommit 4.5;
				sleep _sleep;
				cutText ["", "BLACK OUT",1];
				waitUntil { sleep 1; camCommitted _camera; };				
				_camera cameraEffect ["terminate", "back"];			
				camDestroy _camera;
				if(vehicleVarName (_this select 3) != "Tent_MHQ") then {
					[player, (_this select 3)] call bis_fnc_moveToRespawnPosition;
				};	
				sleep 1.1;	
				cutText ["", "BLACK IN",1];
				
			} else {
				if(count crew (_this select 3) > 0) then {
					systemChat format["Enemies are near the MHQ. You cannot move to the MHQ until the immediate area is secure (%1m). The crew has been notified.",GOL_OKS_MhqSafeZone];
					(format["Reinsert: %1 attempted to move to the MHQ.",name player]) remoteExec ["SystemChat",crew (_this select 3)];
				} else {
					private ["_GroupLeaders"];
					systemChat format["Enemies are near the MHQ. You cannot move to the MHQ until the immediate area is secure (%1m). Group leaders have been notified",GOL_OKS_MhqSafeZone];
					if(!isNil "flag_west_1") then {
						_GroupLeaders = allPlayers select {leader (group _X) == _X && (_X distance flag_west_1 > 100)};
					};
					if(!isNil "flag_east_1") then {
						_GroupLeaders = allPlayers select {leader (group _X) == _X && (_X distance flag_east_1 > 100)};
					};				
					(format["Reinsert: %1 attempted to move to the MHQ.",name player]) remoteExec ["SystemChat",_GroupLeaders];
				};	
				(player) spawn {
						_this setVariable ["GOL_TeleportDelay",true,true];
						_Delay = 10;
						for [{ private _i = _Delay }, { _i > 0 }, { _i = _i - 1}] do {
							[parseText format[
								("<t color='#f5791b'>"+
								"<t size='1.3'>RESPAWN DELAY</t>"+
								"<br/><t size='1.1'>YOU MAY USE SCRIPTED REINSERT IN:<br/><br/>"+
								"<t size='2'>%1</t></t></t>")
							,_i]] remoteExec ["hintSilent",_this];
							sleep 1;
						};
						[parseText
								("<t color='#f5791b'>"+
								"<t size='1.3'>RESPAWN DELAY</t>"+
								"<br/><br/><t size='1.1'>YOU MAY NOW USED SCRIPTED REINSERT.</t></t>")
						] remoteExec ["hintSilent",_this];
						sleep 2;
						_this setVariable ["GOL_TeleportDelay",false,true];
				};						
			}
		},ARGUMENT(_mhq),(CONDITION_1),7];
		_add pushback [([_mhq] call FUNC(getFlag)), _id];
	} else {
		_id = _mhq addAction ["Activate MHQ",{
			
			_EnemyNearUnits = ((_this select 3) nearEntities ["Man", GOL_OKS_MhqSafeZone]) select {(side _X) getFriend (side player) < 0.6 && side _X != civilian};
			if(count _EnemyNearUnits == 0) then {			
				if(objectParent player != (_this select 3)) then {
					player PlayMove "Acts_carFixingWheel";
				};		
				["Activating MHQ", 5, {!(((_this select 0) select 0) getVariable "GW_MHQ_Active")}, {
					([QGVAR(Enabled), [((_this select 0) select 0), true, str([player] call EFUNC(Common,getSide))]] call CBA_fnc_serverEvent);
					if(objectParent player != ((_this select 0) select 0)) then {
						player SwitchMove "";
					};
					_mhqMarkerId = ((_this select 0) select 0) getVariable ["MHQ_MarkerId",""];
					_mhqMarkerId setMarkerAlpha 1;
					_mhqMarkerId setMarkerPos (getPos ((_this select 0) select 0));
					_mhqMarkerAreaId = format["%1_Area",_mhqMarkerId];
					_mhqMarkerAreaId setMarkerAlpha 1;
					_mhqMarkerAreaId setMarkerPos (getPos ((_this select 0) select 0));
					Private ["_Players"];
					if(!isNil "flag_west_1") then {
						_Players = allPlayers select {_X distance flag_west_1 < 100};
					};
					if(!isNil "flag_east_1") then {
						_Players = allPlayers select {_X distance flag_east_1 < 100};
					};
					
					MHQ_waitUntilDelayOver = {
						Params ["_MHQ"];
						waituntil{sleep 1; !(player getVariable ["GOL_TeleportDelay",false])};

						if(_MHQ getVariable "GW_MHQ_Active") then {					
							hint (parseText
							("<t color='#f5791b'>"+
							"<t size='1.3'>MOBILE HQ ACTIVE</t>"+
							"<br/><br/><t size='1.1'>YOU MAY NOW TELEPORT TO MHQ.</t></t>")) 
						};
					};

					if(!isNil "_Players") then {
						[((_this select 0) select 0)] remoteExec ["MHQ_waitUntilDelayOver",_Players];
					};					
				},
				{
					hint "Aborted";
					if(objectParent player != ((_this select 0) select 0)) then {
						player SwitchMove "";
					};
				}, [(_this select 0)]] call CBA_fnc_progressBar;
			} else {
				systemChat format["Enemies are near the MHQ. You cannot activate the MHQ until the immediate area is secure (%1m).",GOL_OKS_MhqSafeZone];
			};

		},ARGUMENT(_mhq),(CONDITION_4 + "&&" + CONDITION_3),7];
		_add pushback [_mhq, _id];
	};
	_mhq setVariable [QGVAR(ActiveActions), _add];
	TRACE_2("QGVAR(Actions)", _mhq, _mhqActiveActions);
}] call CBA_fnc_addEventHandler;
