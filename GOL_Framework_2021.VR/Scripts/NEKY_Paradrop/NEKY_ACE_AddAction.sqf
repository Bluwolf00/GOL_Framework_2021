	if (hasInterface) then {

    _condition = {player in [wpl,epl,ipl,w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1]}; //<only works MP
    _code = {openMap true; [NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_Paradrop\NEKY_OnMapClick.sqf"};

	_change = ["ChangeDrop","Reposition Dropzone","\A3\ui_f\data\map\markers\HandDrawn\end_CA.paa",_code,_condition] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _change] call ace_interact_menu_fnc_addActionToClass;
	//[_unit, 1, ["ACE_SelfActions","ACE_Equipment"], ] call ace_interact_menu_fnc_addActionToObject;

    //ChangeDropZone = ["ChangeDropZone","Reposition Dropzone","",{ [NEKY_Paradrop] spawn NEKY_OnMapClick; },{visibleMap}] call ace_interact_menu_fnc_createAction;
    //[_unit, 0, ["ACE_SelfActions","ACE_Equipment"], ChangeDropZone] call ace_interact_menu_fnc_addActionToObject;

}