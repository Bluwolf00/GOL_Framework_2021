		/*
			[Position,30,EAST] spawn OKS_Populate_StaticWeapons;
			[GetPos Object,30,EAST] spawn OKS_Populate_StaticWeapons;


			[Trigger,0,EAST] spawn OKS_Populate_StaticWeapons;
			[Trigger_1,0,EAST] spawn OKS_Populate_StaticWeapons;
		*/

		if(HasInterface && !isServer) exitWith {};

		Params["_Position","_Range","_Side"];
		Private ["_Statics","_StaticGroup","_Units"];

		Switch (_Side) do
		{
			case BLUFOR:	// BLUFOR settings
			{
				_Units = ["B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for infantry units.
			};
			case OPFOR:		// OPFOR settings
			{
				_Units = ["O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
			};
			case INDEPENDENT:	// INDEPENDENT Settings
			{
				_Units = ["I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
			};

			// DO NOT EDIT ANYTHING BELOW \\
			default
			{
				_SkillVariables = "";
				_Skill = "";
				_Leaders = "";
				_Units = "";
			};
		};

		Switch (typeName _Position) do {

			case "OBJECT":{
				_Statics = Vehicles select {_X isKindOf "StaticWeapon" && _X inArea _Position && _X emptyPositions "gunner" > 0};
				_StaticGroup = CreateGroup _Side;
				if(!(_Statics isEqualTo [])) then {
					{
						_Unit = _StaticGroup CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 5, "NONE"];
						_Unit setRank "PRIVATE";
						//systemChat str [_Unit,_X];
						_Unit assignAsGunner _X;
						[_Unit] orderGetIn true;
						_Unit moveInAny _X;
						[_Unit] remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
					} foreach _Statics;
				};
			};

			case "ARRAY":{
				_Statics = nearestObjects [_Position,["StaticWeapon"],_Range];
				_Statics = _Statics select {_X emptyPositions "gunner" > 0};
				_StaticGroup = CreateGroup _Side;

				if(!(_Statics isEqualTo [])) then {
					{
						_Unit = _StaticGroup CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 5, "NONE"];
						_Unit setRank "PRIVATE";
						//systemChat str [_Unit,_X];
						_Unit assignAsGunner _X;
						[_Unit] orderGetIn true;
						_Unit moveInAny _X;
						[_Unit] remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
					} foreach _Statics;
				};
			};
		};

