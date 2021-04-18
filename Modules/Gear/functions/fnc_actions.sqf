/*
	Author: GuzzenVonLidl
	Sets the addactions for gearbox

	Usage:
	[player, "sl"] call GW_Gear_Fnc_Actions;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
#define	bullShit nil,1,false,false,"",""
params [["_unit", objNull, [objNull]]];

_unit addAction ["<t color='#ffff00'>Attachment Menu</t>", {["player", [], -100, ["_this call GW_Gear_Fnc_replaceAttachments","main"]] call cba_fnc_fleximenu_openMenuByDef},bullShit,8];

// Adds ACE Arsenal for Attachments
/*
[_unit, (currentWeapon player) call GW_Gear_Fnc_getAttachments select 0] call ace_arsenal_fnc_initbox;
[_unit, (currentWeapon player) call GW_Gear_Fnc_getAttachments select 1] call ace_arsenal_fnc_addVirtualItems;
[_unit, (currentWeapon player) call GW_Gear_Fnc_getAttachments select 2] call ace_arsenal_fnc_addVirtualItems;
[_unit, (currentWeapon player) call GW_Gear_Fnc_getAttachments select 3] call ace_arsenal_fnc_addVirtualItems;
*/

//	_unit addAction ["Remove Night gear", {
_unit addAction ["<t color='#ff962c'>Remove Night gear</t>", {
	player unassignItem "NVGoggles_OPFOR";
	player removeItem "NVGoggles_OPFOR";
	if (GVARMAIN(mod_ACE3)) then {
		player removeItem "ACE_IR_Strobe_Item";
		player removeItem "ACE_Flashlight_XL50";
	};
},nil,1,false,false,"","!((((getUnitLoadout player) select 9) select 5) isEqualTo '')",8];

_unit addAction ["Platoon > Actual","[player,'pl'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Platoon > Forward Air Controller","[player,'fac'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#2eff2e'>Squad > Squad Leader</t>","[player,'sl'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Squad Medic","[player,'sm'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["<t color='#2eff2e'>Squad > Fire Team Leader</t>","[player,'ftl'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ff3737'>Squad > Rifleman</t>","[player,'r'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ff3737'>Squad > Grenadier</t>","[player,'g'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#6a9fff'>Squad > Asst. Gunner</t>","[player,'ag'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#6a9fff'>Squad > Automatic Rifleman</t>","[player,'ar'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["Special > Asst. Medium AT","[player,'amat'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Special > Medium AT","[player,'mat'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Special > Asst. Medium Machine Gunner","[player,'ammg'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Special > Medium Machine Gunner","[player,'mmg'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["Special > Diver","[player,'diver'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Special > UAV Operator","[player,'uav'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["Echo > Chopper Pilot","[player,'p'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Echo > Para-Rescueman","[player,'pj'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["Echo Special > Jet Pilot","[player,'jetp'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Echo Special > Vehicle Crew","[player,'crew'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Echo Special > Dragon","[player,'dragon'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["Echo Special > Marksman","[player,'marksman'] call GW_Gear_Fnc_Handler;",bullShit,4];
