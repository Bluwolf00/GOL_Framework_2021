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
			"BAF-W",
			"BAF-W-FALK",
			"GER-FLK",
			"FRENCH-D",
			"USMC-D",
			"USMC-W",
			"USA-W",
			"USA-CW-W",
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"LIVONIA-W",
			"NORWEGIAN",
			"SWEDISH",
			"POLISH",
			"CZECH-W",
			"CZECH-D",
			"AUS-TAN",
			"IRAQ-SF",
			"AFGHAN-W",
			"LATVIAN",
			"ISRAELI",
			"AAF-W",
			"AAF-SF-W",
			"CUSTOM-W"
		],
		[
			"NATO Desert",
			"NATO Woodland",
			"British Armed Forces",
			"Falklands Royal Marines",
			"Bundeswehr Flecktarn",
			"French Army Desert",
			"USMC Desert",
			"USMC Woodland",
			"US Army Modern MTP",
			"US Army Cold War Woodland",
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
			"Livonian Army Woodland",
			"Norwegian Army",
			"Swedish Army",
			"Polish Army",
			"Czech Woodland",
			"Czech Desert",
			"Austrian Tan",
			"Iraqi Special Forces",
			"Afghan National Army Woodland",
			"Latvian Army",
			"Israeli Defence Force",
			"AAF-Woodland",
			"AAF SF Woodland",
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
			"SOVIET-W",
			"CZECH-SOVIET-W",
			"TURKEY-D",
			"SYRIA-D",
			"TAKISTAN-D",
			"ISLAMICSTATE",
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"INSURGENT-TANOA",
			"CUSTOM-E"
		],
		[
			"CSAT-Hex",
			"CSAT-Woodland",
			"CSAT-SF-Woodland",
			"CSAT-Urban",
			"Russian Woodland",
			"Russian SF Woodland",
			"Soviet Desert",
			"Soviet Woodland",
			"Czech Soviet Woodland",
			"Turkish Army Desert",
			"Syrian Army Desert",
			"Takistani Desert",
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
			"PMC",
			"TAKISTAN-D",
			"ISLAMICSTATE",
			"SYRIA-D",
			"INSURGENT-ME",
			"INSURGENT-CHDKZ",
			"INSURGENT-AFRICA",
			"CUSTOM-I"
		],
		[
			"AAF-Woodland",
			"AAF SF Woodland",
			"PMC",
			"Takistani Desert",
			"Islamic State",
			"Syrian Army Desert",
			"INSURGENT Middle Eastern",
			"INSURGENT ChDkz",
			"INSURGENT African",
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
			"CIVI-TAKISTAN"
		],
		[
			"ALTIS",
			"CHERNARUS",
			"TAKISTAN"
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
