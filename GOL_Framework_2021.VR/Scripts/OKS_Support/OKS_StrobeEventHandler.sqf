Params ["_Player","_StrikeArea","_CallArea"];
// {[_X,StrikeArea_1,CallArea_1] execVM "Scripts\OKS_Support\OKS_StrobeEventHandler.sqf"} foreach allPlayers;
_Player addEventHandler ["Fired",{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	//     [wpl,     "Throw",   "IRGrenade","IRGrenade","B_IRStrobe","B_IR_Grenade",1092: b_irstrobe_f.p3d]
	if(_weapon isEqualTo "Throw") then {
		SystemChat "isThrow";
		if(_ammo isEqualTo "B_IRStrobe") then {
			SystemChat "isStrobe";
			_projectile spawn {
				params ["_projectile"];
				systemChat str _projectile;
				sleep 15;
				_Grid = mapGridPosition getPos _projectile;
				_Grid deleteAt 3; _Grid deleteAt 7;
				["HQ","Side",format["Crossroads confirms, strobe location marked at grids %1, out.",_Grid]] remoteExec ["OKS_Chat",0];
				OKS_AllStrobeLocations pushBackUnique (getPos _projectile);
				publicVariable "OKS_AllStrobeLocations";
			};
		};
	}
}];

//["ace_firedPlayer", {copyToClipboard (str _this)}]  call CBA_fnc_addEventHandler;

_Player addAction
[
	"<t color='#F72808'>Call for Precision Strike</t>",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		_arguments params ["_StrikeArea"];
		systemChat str _StrikeArea;
		if(count OKS_AllStrobeLocations select {_X inArea _StrikeArea} > 0) then {
			[_StrikeArea] execVM "Scripts\OKS_Support\OKS_StrobeStrike.sqf";
			_target removeAction _actionId;
		} else {
			["HQ","Side","Be advised, we have no available strobe targets in your area, request is denied, out."] remoteExec ["OKS_Chat",0];
		}		
	},
	[_StrikeArea],		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	format["_this inArea %1 && _this == (leader (group _this)) && _this == _target",_CallArea], 	// condition
	1,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];