		/*
			[Position,30,EAST] spawn OKS_Populate_StaticWeapons;
			[GetPos Object,30,EAST] spawn OKS_Populate_StaticWeapons;
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


		_Statics = nearestObjects [_Position,["StaticWeapon"],_Range];

		_StaticGroup = CreateGroup _Side;
		{
			_Unit = _StaticGroup CreateUnit [(_Units call BIS_FNC_selectRandom), _Position, [], 5, "NONE"];
			_Unit setRank "PRIVATE";
			//systemChat str [_Unit,_X];
			_Unit assignAsGunner _X;
			[_Unit] orderGetIn true;
			_Unit moveInAny _X;
		} foreach _Statics;