
// ===========================

// GRENADE
_grenade = "HandGrenade";
_grenademini = "MiniGrenade";
_grenadeIR = "B_IR_Grenade";
_smokegrenadeW = "SmokeShell";
_smokegrenadeB = "SmokeShellBlue";
_smokegrenadeG = "SmokeShellGreen";
_smokegrenadeO = "SmokeShellOrange";
_smokegrenadeP = "SmokeShellPurple";
_smokegrenadeR = "SmokeShellRed";
_smokegrenadeY = "SmokeShellYellow";

_chemB = "ACE_Chemlight_HiBlue";
_chemG =  "ACE_Chemlight_HiGreen";
_chemR = "ACE_Chemlight_HiRed";
_chemY =  "ACE_Chemlight_HiYellow";

// GRENADE LAUNCHER ITEMS
_glHE = "1Rnd_HE_Grenade_shell";
_glsmokeW = "1Rnd_Smoke_Grenade_shell";
_glsmokeB = "1Rnd_SmokeBlue_Grenade_shell";
_glsmokeG = "1Rnd_SmokeGreen_Grenade_shell";
_glsmokeO = "1Rnd_SmokeOrange_Grenade_shell";
_glsmokeP = "1Rnd_SmokePurple_Grenade_shell";
_glsmokeR = "1Rnd_SmokeRed_Grenade_shell";
_glsmokeY = "1Rnd_SmokeYellow_Grenade_shell";

_glflareG = "ACE_40mm_Flare_green";
_glflareR = "ACE_40mm_Flare_red";
_glflareW = "ACE_40mm_Flare_white";

// Mortar Items.
_1rndMortarHE = "UK3CB_BAF_1Rnd_60mm_Mo_Shells";
_1rndMortarAB = "UK3CB_BAF_1Rnd_60mm_Mo_AB_Shells";
_1rndMortarFlareW = "UK3CB_BAF_1Rnd_60mm_Mo_Flare_White";
_1rndMortarWPSmokeW = "UK3CB_BAF_1Rnd_60mm_Mo_WPSmoke_White";
_1rndMortarSmokeW = "UK3CB_BAF_1Rnd_60mm_Mo_Smoke_White";

_mortarWeapon = "UK3CB_BAF_M6";
_packedHEround = "GOL_Packed_60mm_HE";
_packedHEABround = "GOL_Packed_60mm_HEAB";
_packedSmokeRound = "GOL_Packed_60mm_Smoke";
_packedFlareRound = "GOL_Packed_60mm_Flare";
// ===========================
// Item

_map = "ItemMap";
_gps = "ItemGPS";
_compass = "ItemCompass";
_watch = "ItemWatch";
_nvg = "ACE_NVG_Gen4_Black";
_parachute = "B_Parachute";

_demoCharge = "DemoCharge_Remote_Mag";			// Small
_satchelCharge = "SatchelCharge_Remote_Mag";	// Big

if (true) then {
	_cTab = "ItemcTab";
	_Android = "ItemAndroid";
	_microDAGR = "ItemMicroDAGR";
	_microDAGRGps = "ItemMicroDAGR";
	_HelmetCam = "ItemcTabHCam";
	_UAVTerminal = "B_UavTerminal";
	_UAVTerminalB = "B_UavTerminal";
	_UAVTerminalO = "O_UavTerminal";
	_UAVTerminalI = "I_UavTerminal";
	_gps = "";
	if(hasInterface) then {
		if(_role in ["sm","lightdragon"]) then {
			_gps = _microDAGR;
		};
		if (_role in ["pl","fac","crew","sl","ftl","pm"]) then {
			_gps = _Android;
		};
		if (_role in ["p","pj","dragon","marksman"]) then {
			_gps = _cTab;
		};
	};
};

_toolKit = "ToolKit";

// Radios (for cargo boxes)
_tfarPersonalRadio = "TFAR_pnr1000a";
_tfarHandheldRadio = "TFAR_anprc152";
_acrePRC343 = "ACRE_PRC343";
_acrePRC148 = "ACRE_PRC148";
_acrePRC117F = "ACRE_PRC117F";
_bandage = "FirstAidKit";
_blood = "MediKit";
_IFAK = [[_bandage,2]];					//	Individual First Aid Kits
_FAKSmall = [[_bandage,15]];			//	Medic Kit Small
_FAKMedium = [[_bandage,20],[_blood,1]];	//	Medic Kit Big
_FAKSquad = [[_bandage,25],[_blood,1]];	//	Medic Kit Big
_FAKPlatoon = [[_bandage,25],[_blood,1]];	//	Medic Kit Big

_bandage = "ACE_elasticBandage";
_blood = "ACE_bloodIV";
_epi = "ACE_epinephrine";
_morph = "ACE_morphine";
_tourn = "ACE_tourniquet";
_pak = "ACE_personalAidKit";
_saline = "ACE_salineIV";
_salineSm = "ACE_SalineIV_500";

_IFAK = [[_bandage,17],[_tourn,2],[_morph,5]];

_FAKSmall = [
	[_bandage,5],
	[_tourn,2],
	[_morph,5]
];
_FAKMedium = [
	[_bandage,15],
	[_tourn,3],
	[_morph,5],
	[_epi,5],
	[_saline,10],
	[_pak,1]
];	
_FAKSquad = [
	[_bandage,25],
	[_tourn,3],
	[_morph,10],
	[_epi,10],
	[_saline,16],
	[_pak,1]
];				
_FAKPlatoon = [
	[_bandage,30],
	[_tourn,5],
	[_morph,15],
	[_epi,15],
	[_saline,25],
	[_pak,1]
];


_barrel = "";
_cables = "";
_clacker = "";
_defusalKit = "";
_IRStrobe = "";
_mapFlashLight = "";
_mapTools = "";
_rangefinder = "Binocular";
_laserDesignator = "Laserdesignator";
_battery = "Laserbatteries";
_rangecard = "";
_mortarRangeCard = "";
_minedetector = "ACE_MineDetector";
_mineDetectorVMM3 = "ACE_VMM3";
_mineDetectorVMH3 = "ACE_VMH3";
_mineDetectorVMM3Weapon = [_mineDetectorVMM3, "", "", "", ""];
_mineDetectorVMH3Weapon = [_mineDetectorVMH3, "", "", "", ""];
_markerFlagGreen = "ace_marker_flags_green";
_markerFlagRed = "ace_marker_flags_red";

_mineAperMineDispenserMag = "APERSMineDispenser_Mag";
_mineClaymoreMag = "ClaymoreDirectionalMine_Remote_Mag";
_mineSlamMag = "SLAMDirectionalMine_Wire_Mag";
_mineAperBoundingMag = "APERSBoundingMine_Range_Mag";
_spraypaintRed = "ACE_SpraypaintRed";
_spraypaintGreen = "ACE_SpraypaintGreen";
_fortifyTool = "ACE_Fortify";
_incendiaryGrenade = "ACE_M14";
_packedMortar = "GOL_Packed_Mortar";
_packedHMG = "GOL_Packed_HMG";
_packedGMG = "GOL_Packed_GMG";
_packedAT = "GOL_Packed_AT";
_packedDroneAP = "GOL_Packed_Drone_AP";
_packedDroneAT = "GOL_Packed_Drone_AT";
_packedDroneRecon = "GOL_Packed_Drone_Recon";
_packedDroneSupply = "GOL_Packed_Drone_Supply";

_flashBang = "";
_handFlareG = "";
_handFlareR = "";
_handFlareW = "";
_handFlareY = "";
if (true) then {
	_barrel = "ACE_SpareBarrel";
	_wirecutter = "ACE_wirecutter";
	_cables = "ACE_CableTie";
	_clacker = "ACE_M26_Clacker";
	_defusalKit = "ACE_DefusalKit";
	_IRStrobe = "ACE_IR_Strobe_Item";
	_mapFlashLight = "ACE_Flashlight_XL50";
	_mapTools = "ACE_MapTools";
	_rangefinder = "ACE_Vector";
	_microDAGR = "ACE_DAGR";
	_rangecard = "ACE_RangeCard";
	_mortarRangeCard = "ACE_artilleryTable";
	_Earplugs = "ACE_EarPlugs";
	_ATrag = "ACE_ATragMX";
	_Kestrel = "ACE_Kestrel4500";
	_glHEDP = "rhs_mag_M433_HEDP";
	_flashBang = "ACE_M84";
	_handFlareG = "ACE_HandFlare_Green";
	_handFlareR = "ACE_HandFlare_Red";
	_handFlareW = "ACE_HandFlare_White";
	_handFlareY = "ACE_HandFlare_Yellow";
	_entrenchingTool = "ACE_EntrenchingTool";
	_notepad = "acex_intelitems_notepad";
	_FacPanels = "42cdo_vs17_item";
};

/*
	_gps = _microDAGR;
	if (_isPlayer && (_role in ["sl","ftl"])) then {
		[[_gps,1]] call _addToUniform;
	};
*/
