#include "script_Component.hpp"

PREP(actions);
PREP(getAttachments);
PREP(getLoadoutClass);
PREP(Handler);
PREP(Init);
PREP(replaceAttachments);

GVAR(Enabled_101) = true;
GVAR(Enabled_201) = true;
GVAR(Enabled_301) = true;
GVAR(Enabled_302) = true;

GVAR(Index101) = 0;
GVAR(Index201) = 0;
GVAR(Index301) = 0;
GVAR(Index302) = 0;
GVAR(Stamina) = true;
GVAR(StaminaCoef) = 0.5;

[
	QGVAR(Blufor), "LIST",
	["Loadout Blufor", "Loadout for Blufor units"],
	QUOTE(ADDON),
	[
		[
			"AAF-SF-W",
			"AAF-W",
			"AFGHAN-W",
			"AUS-TAN",
			"BAF-D",			
			"BAF-W",
			"BAF-W-FALK",
			"GERMAN-W",			
			"GERMAN-D",
			"CBRN-WINTER",
			"CTRG-D",			
			"CTRG-W",
			"CUSTOM-W",
			"CDF-W",
			"CHINA",
			"CZECH-D",
			"CZECH-W",
			"FINLAND-W",
			"FRANCE-D",							
			"FRANCE-W",				
			"INSURGENT-AFRICA",
			"INSURGENT-CHDKZ",
			"INSURGENT-FIA",
			"INSURGENT-MALDEN",
			"INSURGENT-ME",
			"INSURGENT-TANOA",
			"IRAQ-SF",
			"IRISH-UN",
			"ISRAELI",
			"LIVONIA-W",
			"MALDEN-W",
			"NATO-D",
			"NATO-W",
			"RWANDA-W",
			"SWEDISH",
			"TAKISTAN-D",
			"TAKISTAN-SF-D",
			"TANOA-ARMY",
			"TANOA-SF",
			"USA-D",
			"USA-W",	
			"USA-CW-W",
			"USMC-D",
			"USMC-W",
			"UKRAINE-W"
		],
		[
			"AAF-Woodland SF",
			"AAF-Woodland",
			"Afghan National Army Woodland",
			"Austrian Tan",
			"British Armed Forces Desert",			
			"British Armed Forces Woodland",
			"British Falklands Woodland",
			"Bundeswehr Flecktarn",
			"Bundeswehr Tropentarn",			
			"CBRN Winter",
			"CTRG Desert",
			"CTRG Woodland",
			"CUSTOM-West",
			"Chernarussian Defence Force",
			"Chinese Armed Forces",
			"Czech Desert",
			"Czech Woodland",			
			"Finnish Army Woodland",
			"French Army Desert",
			"French Army Woodland",			
			"INSURGENT African",
			"INSURGENT ChDkz",
			"INSURGENT FIA",
			"INSURGENT Malden",
			"INSURGENT Middle Eastern",
			"INSURGENT Tanoan",
			"Iraqi Special Forces",
			"Irish United Nations",
			"Israeli Defence Force",
			"Livonia Woodland",
			"Malden Defence Force Woodland",
			"NATO Desert",
			"NATO Woodland",
			"Rwanda Defence Force Woodland",
			"Swedish Army",
			"Takistani Desert",
			"Takistani SF Desert",
			"Tanoan Army",
			"Tanoan Special Forces",
			"US Army 2000 UCP",
			"US Army 2010 MTP",
			"US Army Cold War Woodland",
			"USMC Marpat Desert",
			"USMC Marpat Woodland",
			"Ukrainian Army"
		],
		0
	], CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(Opfor),
	"LIST", ["Loadout Opfor", "Loadout for Opfor units"],
	QUOTE(ADDON),
	[
		[
			"CSAT-H",
			"CSAT-W",
			"CSAT-SF-W",
			"CSAT-U",
			"CHINA",
			"CHDKZ-SF-W",
			"RUSSIAN-W",
			"RUSSIAN-SF-W",
			"SOVIET-D",
			"SOVIET-SF-D",
			"SOVIET-W",
			"CZECH-SOVIET-W",
			// "CHDKZ-1950-W",
			"TURKEY-D",
			"SYRIA-W",
			"TAKISTAN-D",
			"TAKISTAN-SF-D",
			"ISLAMICSTATE",
			"AFRICAN-ARMY",
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"INSURGENT-TANOA",
			"INSURGENT-FIA",
			"INSURGENT-MALDEN",
			"CUSTOM-E"
		],
		[
			"CSAT Hex",
			"CSAT Woodland",
			"CSAT SF Woodland",
			"CSAT Urban",
			"Chinese Armed Forces",
			"ChDkz SF Woodland",
			"Russian Woodland",
			"Russian SF Woodland",
			"Soviet Desert",
			"Soviet SF Desert",
			"Soviet Woodland",
			"Czech Soviet Woodland",
			// "ChDkz 1950 Woodland",
			"Turkish Army Desert",
			"Syrian Army Woodland",
			"Takistani Desert",
			"Takistani SF Desert",
			"Islamic State",
			"African Army Desert",			
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
			"INSURGENT Tanoan",
			"INSURGENT FIA",
			"INSURGENT Malden",
			"CUSTOM-East"
		],
		0
	]
	, CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(Independent),
	"LIST", ["Loadout Independent", "Loadout for Independent units"],
	QUOTE(ADDON),
	[
		[
			"AAF-W",
			"AAF-SF-W",
			"MALDEN-W",
			// "FRENCH-UN",
			"PMC",
			"CSAT-H",
			"CSAT-W",
			"CSAT-SF-W",
			"CSAT-U",
			"RUSSIAN-W",
			"RUSSIAN-SF-W",
			"SOVIET-D",
			"SOVIET-SF-D",
			"SOVIET-W",
			"CZECH-SOVIET-W",
			// "CHDKZ-1950-W",
			"TURKEY-D",
			"SYRIA-D",
			"TAKISTAN-D",
			"TAKISTAN-SF-D",
			"ISLAMICSTATE",
			"AFRICAN-ARMY",
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"INSURGENT-TANOA",
			"INSURGENT-FIA",
			"INSURGENT-MALDEN",
			"CUSTOM-I"
		],
		[
			"AAF-Woodland",
			"AAF SF Woodland",
			"Malden Defence Force Woodland",
			// "French Army United Nations",
			"PMC",
			"CSAT Hex",
			"CSAT Woodland",
			"CSAT SF Woodland",
			"CSAT Urban",
			"Russian Woodland",
			"Russian SF Woodland",
			"Soviet Desert",
			"Soviet SF Desert",
			"Soviet Woodland",
			"Czech Soviet Woodland",
			// "ChDkz 1950 Woodland",
			"Turkish Army Desert",
			"Syrian Army Desert",
			"Takistani Desert",
			"Takistani SF Desert",
			"Islamic State",
			"African Army Desert",
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
			"INSURGENT Tanoan",
			"INSURGENT FIA",
			"INSURGENT Malden",
			"CUSTOM-Independent"
		],
		0
	],CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(Civilian),
	"LIST", ["Loadout Civilian", "Loadout for Civilian units"],
	QUOTE(ADDON),
	[
		[
			"CIVI-ALTIS",
			"CIVI-CHERNARUS",
			"CIVI-TAKISTAN",
			"CIVI-AFRICA"
		],
		[
			"ALTIS",
			"CHERNARUS",
			"TAKISTAN",
			"AFRICAN"
		],
		0
	], CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(Auto_Assign), "LIST",
	["Auto assign gear", "automaticly gives gear to spawned units"],
	QUOTE(ADDON),
	[
		[0,1,2,3],
		["Disabled","All Units","Only Copied Units","Ignore Editor Placed"],
		1
	], CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[QGVAR(randomGear), "CHECKBOX", ["Random Role", "Should units get random gear"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
[QGVAR(extraGear), "CHECKBOX", ["Gives units extra loadout", "Medics gets more supplies, AT gets more rockets etc"], QUOTE(ADDON), false, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
[QGVAR(autoRemoveCargo), "CHECKBOX", ["Removes cargo for vehicles", "Automaticly removes cargo"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
