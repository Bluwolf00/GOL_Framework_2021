Params ["_flag","_RespawnTimer","_DropZone"];

if(TypeName (_DropZone getVariable ["NEKY_Paradrop_AttachedMarker",false]) != "STRING") then {
	Private "_Color";
	Switch (Side (Group Player)) do
	{
		case BLUFOR: {_Color = "ColorBlufor"};
		case OPFOR: {_Color = "ColorOpfor"};
		case INDEPENDENT: {_Color = "ColorIndependent"};
		default {_Color = "ColorBlack"; systemChat "DEBUG - NEKY_Paradrop - AddAction - Faction not found"};
	};
	_MarkerName = (Format ["NEKY_%1_Marker",_DropZone]);
	_Mrk = CreateMarkerLocal [_MarkerName,[0,0,0]];
	_DropZone setVariable ["NEKY_Paradrop_AttachedMarker",_MarkerName];
	_Mrk setMarkerPosLocal (getPos _DropZone);
	_Mrk setMarkerDirLocal 0;
	_Mrk setMarkerShapeLocal "ICON";
	_Mrk setMarkerTypeLocal "hd_pickup_noShadow";
	_Mrk SetMarkerSizeLocal [1,1];
	_Mrk SetMarkerColorLocal _Color;
	_Mrk SetMarkerTextLocal " Dropsite";
	_Mrk SetMarkerAlphaLocal 1;
};

_flag setVariable ["OKS_Reinsert_Stopped",false,true];

OKS_SpawnReinsertBird = {
	if (!isServer) exitWith {false};		// Ensures only server or HC runs this script
	Params [
		["_flag",objNull,[objNull]],
		["_caller",objNull,[objNull]],
		["_actionId",0,[0]],
	 	["_RespawnTimer",30,[0]]
	];
	Private _HeliClass = "";
	_Side = side _caller;
	switch (_Side) do
	{	
		case BLUFOR: {_HeliClass = "RHS_UH60M_d" };
		case OPFOR: {_HeliClass = "O_Heli_Light_02_unarmed_F" };	
		case INDEPENDENT: {_HeliClass = "I_Heli_Transport_02_F" };
		default {_HeliClass = "RHS_UH60M_d"};
	};
	if(isServer) then {
		[side _caller,_HeliClass,["helicopter_spawn",getPos reinsert_helipad,getPos NEKY_PARADROP_TRIGGER,"helicopter_despawn"],true,false] execVM "Scripts\NEKY_PickUp\NEKY_PickUp.sqf";
		_flag setVariable ["OKS_Reinsert_Stopped",true,true];
		sleep _RespawnTimer;
		_flag setVariable ["OKS_Reinsert_Stopped",false,true];
	};
};

_flag addAction
[
	"<t color='#15F117'>* Request Reinsert *</t>",	// title
	{_this remoteExec ["OKS_SpawnReinsertBird",2]},
	_RespawnTimer,		// arguments
	10,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"!(_target getVariable ['OKS_Reinsert_Stopped',false])", 	// condition
	15,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];
