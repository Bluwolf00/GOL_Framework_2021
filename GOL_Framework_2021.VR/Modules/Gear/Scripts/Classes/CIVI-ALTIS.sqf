
_goggles = selectRandom ["","","G_Shades_Black","G_Sport_BlackWhite","G_Sport_Greenblack","G_Aviator"];
_helmet = selectRandom ["","","H_Cap_blu","H_Cap_oli","H_Hat_brown","H_Hat_tan"];
_uniform = selectRandom ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F"];
_vest = selectRandom [""];
_backpack = selectRandom [""];

if ((random 1) > 0.7) then {
	_goggles = "";
	_helmet = "";
	_uniform = selectRandom ["U_C_ConstructionCoverall_Black_F","U_C_ConstructionCoverall_Blue_F","U_C_ConstructionCoverall_Red_F","U_C_ConstructionCoverall_Vrana_F"];
	_vest = "";
	_backpack = "";

	if (_uniform in ["U_C_ConstructionCoverall_Black_F","U_C_ConstructionCoverall_Blue_F","U_C_ConstructionCoverall_Red_F","U_C_ConstructionCoverall_Vrana_F"]) then {
		_goggles = selectRandom ["","","G_EyeProtectors_Earpiece_F","G_Respirator_white_F","G_Respirator_yellow_F","G_Respirator_yellow_F"];
		_helmet = selectRandom ["H_Construction_earprot_red_F","H_Construction_earprot_yellow_F","H_Construction_earprot_white_F","H_Construction_earprot_vrana_F"];
		_vest = selectRandom ["V_Safety_blue_F","V_Safety_orange_F","V_Safety_yellow_F"];
	};
};
