//	villager	- normal
//	worker		- nice cloths
//	farmer		- dirty cloths
//	officials	- police, paramedics etc

_goggles = "";
_helmet = selectRandom ["","LOP_H_Villager_cap","LOP_H_Worker_cap"];
_uniform = selectRandom ["LOP_U_CHR_Villager_03","LOP_U_CHR_Woodlander_01","LOP_U_CHR_Worker_03"];
_vest = "";
_backpack = "";

if ((random 1) > 0.7) then {
	_goggles = "";
	_helmet = "";
	_uniform = selectRandom ["LOP_U_CHR_Policeman_01","LOP_U_CHR_Doctor_01"];
	_vest = "";
	_backpack = "";

	if ((toLower(_role)) isEqualTo "worker") then {
		_uniform = selectRandom ["LOP_U_CHR_Profiteer_01","LOP_U_CHR_Profiteer_02","LOP_U_CHR_Profiteer_04","LOP_U_CHR_Priest_01"];
	};

	if (_uniform isEqualTo "LOP_U_CHR_Policeman_01") then {
		_helmet = "LOP_H_Policeman_cap";
	};
};
