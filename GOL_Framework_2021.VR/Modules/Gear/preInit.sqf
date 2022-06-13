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
			"NATO-D",
			"NATO-W",
			"MALDEN-W",
			"BAF-W",
			"BAF-W-FALK",
			"GER-FLK",
			"UKRAINE-W",
			// "FRENCH-D",
			// "FRENCH-UN",
			"RWANDA-W",
			"USMC-D",
			"USMC-W",
			"USA-W",
			"USA-D",
			"USA-CW-W",
			"USA-XM8-W",
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"LIVONIA-W",
			// "LIVONIA-1950-W",
			"FINLAND-W",
			// "NORWEGIAN",
			"SWEDISH",
			// "POLISH",
			"CZECH-W",
			"CZECH-D",
			"AUS-TAN",
			"IRAQ-SF",
			"AFGHAN-W",
			// "LATVIAN",
			"ISRAELI",
			"AAF-W",
			"AAF-SF-W",
			"UN-IRISH",
			"TAKISTAN-D",
			"TAKISTAN-SF-D",
			"CUSTOM-W"
		],
		[
			"NATO Desert",
			"NATO Woodland",
			"Malden Defence Force Woodland",
			"British Armed Forces",
			"Falklands Royal Marines",
			"Bundeswehr Flecktarn",
			"Ukrainian Army",
			// "French Army Desert",
			// "French Army United Nations",
			"Rwanda Defence Force Woodland",
			"USMC Marpat Desert",
			"USMC Marpat Woodland",
			"US Army 2010 MTP",
			"US Army 2000 UCP",
			"US Army Cold War Woodland",
			"US Army XM-8 Woodland",
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
			"Livonian Army Woodland",
			// "Livonian Army 1950 Woodland",
			"Finnish Army Woodland",
			// "Norwegian Army",
			"Swedish Army",
			// "Polish Army",
			"Czech Woodland",
			"Czech Desert",
			"Austrian Tan",
			"Iraqi Special Forces",
			"Afghan National Army Woodland",
			// "Latvian Army",
			"Israeli Defence Force",
			"AAF-Woodland",
			"AAF SF Woodland",
			"Irish UN",
			"Takistani Desert",
			"Takistani SF Desert",
			"CUSTOM-West"
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
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"INSURGENT-TANOA",
			"CUSTOM-E"
		],
		[
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
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
			"INSURGENT Tanoan",
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
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"INSURGENT-TANOA",
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
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
			"INSURGENT Tanoan",
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
