/* Static Spawner

	Params:
	1 - Position - Array Position, Object or Marker
	2 - Direction - Number Degrees
	3 - Role - String: at = Anti-tank, aa = Anti-Air, ar = Automatic Rifleman, mg = Machinegunner, mm = Marksman, default rifleman.
	4 - Enemy Side - Side
	5 - Unit Position - String: "auto" = auto, "up" = stand, "middle" = crouch, "down" = prone


	Example: [position_1,30,"at",east,"up"] execVM "Scripts\OKS_Spawn\OKS_Static_Spawner.sqf";
 */

Params [
	"_Position",
	["_Direction",nil,[0]],
	["_Role","",[""]],
	["_Side",east,[sideUnknown]],
	["_UnitPos","UP",[""]]
];
Private ["_SelectedClassname","_DeleteObject"];

switch (typeName _Position) do {
	case "OBJECT": { _DeleteObject = _Position; _Direction = getDir _Position; _Position = getPosATL _Position; };
	case "STRING": { _Position = getMarkerPos _Position;};
	default { _Position = _Position };
};

Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		switch (toLower _Role) do {
			case "at": { _SelectedClassname = "B_Soldier_LAT_F" };
			case "aa": { _SelectedClassname = "B_Soldier_AA_F" };
			case "ar": { _SelectedClassname = "B_Soldier_AR_F" };
			case "mg": { _SelectedClassname = "B_HeavyGunner_F" };
			case "mm": { _SelectedClassname = "B_Soldier_M_F" };
			default { _SelectedClassname = "B_Soldier_F" };
		};
	};
	case OPFOR:		// OPFOR settings
	{
		switch (toLower _Role) do {
			case "at": { _SelectedClassname = "O_Soldier_LAT_F" };
			case "aa": { _SelectedClassname = "O_Soldier_AA_F" };
			case "ar": { _SelectedClassname = "O_Soldier_AR_F" };
			case "mg": { _SelectedClassname = "O_HeavyGunner_F" };
			case "mm": { _SelectedClassname = "O_Soldier_M_F" };
			default { _SelectedClassname = "O_Soldier_F" };
		};
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		switch (toLower _Role) do {
			case "at": { _SelectedClassname = "I_Soldier_LAT_F" };
			case "aa": { _SelectedClassname = "I_Soldier_AA_F" };
			case "ar": { _SelectedClassname = "I_Soldier_AR_F" };
			case "mg": { _SelectedClassname = "I_HeavyGunner_F" };
			case "mm": { _SelectedClassname = "I_Soldier_M_F" };
			default { _SelectedClassname = "I_Soldier_F" };
		};
	};
};
	if(!isNil "_DeleteObject") then {
		deleteVehicle _DeleteObject
	};

	_NewGroup = CreateGroup _Side;
	_Unit = _NewGroup CreateUnit [_SelectedClassname, _Position, [], 0, "CAN_COLLIDE"];
	_Unit setRank "PRIVATE";
	if(!isNil "_Direction") then {
		_Unit setDir _Direction;
	};
	
	_NewGroup setFormDir _Direction;
	[_Unit,"PATH"] remoteExec ["disableAI",0];
	[_Unit,_UnitPos] remoteExec ["setUnitPos",0];


	

	

