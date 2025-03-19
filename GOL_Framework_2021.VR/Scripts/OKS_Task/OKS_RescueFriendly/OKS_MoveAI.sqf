	// OKS_Rescue_Friendly
	// [this] spawn OKS_MoveAI;
	// [this] remoteExec ["OKS_MoveAI",0];

	Params [
		["_Unit",objNull,[objNull]]
	];

_unit addAction ["<t color='#f6f211'>Move Soldier</t>",
	{ 
		(_this select 0) attachTo [(_this select 1),[0,1.2,0]];
		(_this select 1) setVariable ["IsCarryingUnit",true,true];
		(_this select 1) addAction ["<t color='#cc271d'>Drop Soldier</t>",
		{
			detach (_this select 3);
			(_this select 1) setVariable ["IsCarryingUnit",false,true];
			(_this select 0) removeAction (_this select 2);
		},
		(_this select 0),		// arguments
		1.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"(_this getVariable ['IsCarryingUnit',false]) && (_this == _target)",		// condition
		5,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];
	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"!(_this getVariable ['IsCarryingUnit',false])",		// condition
	5,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

