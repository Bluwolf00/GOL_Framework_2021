#include "script_Component.hpp"

["CAManBase", "Respawn", {
	[{
		(_this select 0) spawn {
			_this setVariable ["GOL_TeleportDelay",true,true];
			_Delay = 120;
			for [{ private _i = _Delay }, { _i > 0 }, { _i = _i - 1}] do {
				[parseText format[
					"<t color='#f5791b'>
					<t size='1.3'>RESPAWN DELAY</t>
					<br/><t size='1.1'>YOU MAY USE SCRIPTED REINSERT IN:<br/><br/>
					<t size='2'>%1</t></t></t>"
				,_i]] remoteExec ["hintSilent",_this];
				sleep 1;
			};
			[parseText
					"<t color='#f5791b'>
					<t size='1.3'>RESPAWN DELAY</t>
					<br/><br/><t size='1.1'>YOU MAY NOW USED SCRIPTED REINSERT.</t></t>"
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
				([QGVAR(Enabled), [((_this select 0) select 0), false, str([player] call EFUNC(Common,getSide))]] call CBA_fnc_serverEvent); player SwitchMove "";
			}, {player SwitchMove ""; hint "Aborted";} , [(_this select 0)]] call CBA_fnc_progressBar;
		},ARGUMENT(_mhq),(CONDITION_1 + "&& !" + CONDITION_2),7];
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

		_id = (([_mhq] call FUNC(getFlag))) addAction[format ["Teleport to %1", _mhq],{
			_nearUnits = (_this select 3) nearEntities ["Man", 200];
			_nearUnits = _nearUnits select {(side _X) getFriend (side player) < 0.6};
			if(count _nearUnits == 0) then {
				[player, (_this select 3)] call bis_fnc_moveToRespawnPosition
			} else {
				systemChat "Enemies are near the MHQ. You cannot move to the MHQ until the immediate area is secure (200m).";
			}
		},ARGUMENT(_mhq),(CONDITION_1),7];
		_add pushback [([_mhq] call FUNC(getFlag)), _id];
	} else {
		_id = _mhq addAction ["Activate MHQ",{ player PlayMove "Acts_carFixingWheel";
			["Activating MHQ", 5, {!(((_this select 0) select 0) getVariable "GW_MHQ_Active")}, {
				([QGVAR(Enabled), [((_this select 0) select 0), true, str([player] call EFUNC(Common,getSide))]] call CBA_fnc_serverEvent); player SwitchMove "";
			}, {hint "Aborted"; player SwitchMove "";}, [(_this select 0)]] call CBA_fnc_progressBar;
		},ARGUMENT(_mhq),CONDITION_1,7];
		_add pushback [_mhq, _id];
	};
	_mhq setVariable [QGVAR(ActiveActions), _add];
	TRACE_2("QGVAR(Actions)", _mhq, _mhqActiveActions);
}] call CBA_fnc_addEventHandler;
