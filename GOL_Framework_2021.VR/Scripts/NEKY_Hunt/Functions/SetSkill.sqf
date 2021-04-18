//	[Group, ["SkillVariables"], [Skill]] Spawn NEKY_Hunt_SetSkill;
//	
//	This handles setting the skill of the AI group
//	
//	Returns: Nothing.
//	
//	Made by NeKo-ArroW

Params ["_Grp","_SkillVariables","_Skill"];

{
	for "_i" from 0 to ((count _SkillVariables) -1) do
	{
		_x setSkill [(_SkillVariables select _i), (_Skill select _i)];
		Sleep 0.1;
	};
} forEach (Units _Grp);