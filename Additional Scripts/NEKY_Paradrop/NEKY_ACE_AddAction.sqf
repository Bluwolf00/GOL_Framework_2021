	if (hasInterface) then {

    _condition = {player in [wpl,epl,ipl,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew2,i1a,i1a1,i1b1,icrew1,icrew4]}; //<only works MP
    _code = {openMap true; [NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_Paradrop\NEKY_OnMapClick.sqf"};

	_change = ["ChangeDrop","Reposition Dropzone","\A3\ui_f\data\map\markers\Military\end_CA.paa",_code,_condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","Request_Support"], _change] call ace_interact_menu_fnc_addActionToClass;

}
