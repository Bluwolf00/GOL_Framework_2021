
// ===========================

// GRENADE
_grenade = "HandGrenade";
_grenademini = "MiniGrenade";
_smokegrenadeW = "SmokeShell";
_smokegrenadeB = "SmokeShellBlue";
_smokegrenadeG = "SmokeShellGreen";
_smokegrenadeO = "SmokeShellOrange";
_smokegrenadeP = "SmokeShellPurple";
_smokegrenadeR = "SmokeShellRed";
_smokegrenadeY = "SmokeShellYellow";

_chemB = "Chemlight_blue";
_chemG =  "Chemlight_green";
_chemR = "Chemlight_red";
_chemY =  "Chemlight_yellow";

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

// ===========================
// Item

_map = "ItemMap";
_gps = "ItemGPS";
_compass = "ItemCompass";
_watch = "ItemWatch";
_nvg = "";
_parachute = "B_Parachute";

_demoCharge = "DemoCharge_Remote_Mag";			// Small
_satchelCharge = "SatchelCharge_Remote_Mag";	// Big

if (GVARMAIN(mod_CTAB)) then {
	_cTab = "ItemcTab";
	_Android = "ItemAndroid";
	_microDAGR = "ItemMicroDAGR";
	_HelmetCam = "ItemcTabHCam";

	if (_isPlayer) then {
		_gps = "";
		if (_role in ["pl","fac","crew","sl","ftl"]) then {
			_gps = _Android;
		};

		if (_role in ["p","pj","dragon","marksman"]) then {
			_gps = _cTab;
		};
	};
};

_toolKit = "ToolKit";
_bandage = "FirstAidKit";
_blood = "MediKit";
_epi = "";
_morph = "";
_IFAK = [[_bandage,2]];					//	Individual First Aid Kits
_FAKSmall = [[_bandage,15]];			//	Medic Kit Small
_FAKMedium = [[_bandage,20],[_blood,1]];	//	Medic Kit Big
_FAKBig = [[_bandage,25],[_blood,1]];	//	Medic Kit Big
if (GVARMAIN(mod_ACE3_Medical)) then {	//	ACE
	_bandage = "ACE_elasticBandage";
	_blood = "ACE_bloodIV";
	_epi = "ACE_epinephrine";
	_morph = "ACE_morphine";
	_tourn = "ACE_tourniquet";
	_pak = "ACE_personalAidKit";
	_saline = "ACE_salineIV";
	_salineSm = "ACE_SalineIV_500";

	_IFAK = [[_bandage,15],["ACE_tourniquet",2],[_morph,3]];

		_FAKSmall = [
			[_bandage,10],
			[_saline,8],
			[_morph,2],
			[_epi,4],
			[_pak,1]
		];
		_FAKMedium = [
			[_bandage,15],
			[_tourn,3],
			[_epi,5],
			[_saline,12],
			[_pak,1]
		];		
		_FAKBig = [
			[_bandage,20],
			[_tourn,4],
			[_morph,6],
			[_epi,6],
			[_saline,18],
			[_pak,1]
		];
};

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

_flashBang = "";
_handFlareG = "";
_handFlareR = "";
_handFlareW = "";
_handFlareY = "";
if (GVARMAIN(mod_ACE3)) then {
	_barrel = "ACE_SpareBarrel";
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
};

/*
	_gps = _microDAGR;
	if (_isPlayer && (_role in ["sl","ftl"])) then {
		[[_gps,1]] call _addToUniform;
	};
*/
