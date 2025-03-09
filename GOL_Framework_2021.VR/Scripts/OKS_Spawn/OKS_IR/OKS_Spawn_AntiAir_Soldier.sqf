Params ["_Position","_Side"];
	Private ["_Classname"];
	if(typeName _Position == "ARRAY") then {
		switch (_Side) do {
			case west: { 
				_Classname = "B_Soldier_AA_F";
			};
			case east: { 
				_Classname = "O_Soldier_AA_F";
			};
			case independent: { 
				_Classname = "I_Soldier_AA_F";
			};				
			default {
				SystemChat "OKS_IR_AA.sqf: Side not recognized"
			};
		};
		_Group = createGroup _Side;
		_Unit = _Group createUnit [_Classname, _Position, [], 0, "CAN_COLLIDE"];
		_Unit setPosATL _Position;
	} else {
		_Unit = _Position;
	};

	[_Unit,"UP"] remoteExec ["setUnitPos",0];
	[_Unit,"PATH"] remoteExec ["disableAI",0];
	_Unit selectWeapon (secondaryWeapon _Unit);

	_Unit;