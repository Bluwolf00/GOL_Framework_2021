/// [] execVM "Scripts\OKS_Vehicles\OKS_Tanker.sqf";

private ["_condition","_code","_side","_unit","_crew"];

if (hasInterface) then {
    _condition = {player in [wpl,epl,ipl,w1a,w1a1,w1b1,w1c1,e1a,e1a1,e1b1,e1c1,i1a,i1a1,i1b1,i1c1] && {_X in ((vehicle player) call BIS_fnc_objectType)} count ["WheeledAPC","TrackedAPC","Tank"] > 0}; //<only works MP

	    _side = side player;
		switch (_side) do {
			case west: {
				_unit = "B_crew_F";
			};
			case east:{
				_unit = "O_crew_F";
			};
			case independent:{
				_unit = "I_crew_F";
			};
			default{
				_unit = "B_crew_F";
			};
    	};

	_action = ["Vehicle Crew", "Vehicle Crew","\A3\ui_f\data\map\markers\nato\b_mech_inf.paa", {}, _condition,{},[]] call ace_interact_menu_fnc_createAction;
	_create = ["Create Crew", "Create Crew","\a3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa",  { [[_this select 2, "Scripts\OKS_Vehicles\OKS_CreateCrew.sqf"], "BIS_fnc_ExecVM", false] call BIS_fnc_MP; }, _condition,{},[player,_unit]] call ace_interact_menu_fnc_createAction;
	_delete = ["Delete Crew", "Delete Crew","\A3\Modules_F_Kart\data\TimeTrials\quit_igui_ca.paa",  { [[_this select 0, "Scripts\OKS_Vehicles\OKS_DeleteCrew.sqf"], "BIS_fnc_ExecVM", false] call BIS_fnc_MP}, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment","Vehicle Crew"], _delete] call ace_interact_menu_fnc_addActionToClass;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment","Vehicle Crew"], _create] call ace_interact_menu_fnc_addActionToClass;


};



