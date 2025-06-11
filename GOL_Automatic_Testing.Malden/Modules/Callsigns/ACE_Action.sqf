_condition = {leader group player == leader player || player in [w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1]};
_action = ["CallsignAct","Change Callsign","\A3\ui_f\data\map\markers\nato\b_unknown.paa",{[_this select 1] spawn Blu_fnc_showCallsigns;},_condition] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","ACE_TeamManagement"], _action] call ace_interact_menu_fnc_addActionToClass;
