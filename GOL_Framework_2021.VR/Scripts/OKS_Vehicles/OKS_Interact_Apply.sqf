
_Vehicle = _this select 0;


_Menu = ['OKS_Menu','Switch Seats','',{true},{true}] call ace_interact_menu_fnc_createAction;
[_Vehicle, 1, ["ACE_SelfActions"], _Menu] call ace_interact_menu_fnc_addActionToObject;


_Move_To_Copilot = ['Move_To_Cpilot',
						'Move to Co-Pilot',
							'',
								{ [_this] spawn OKS_Interact_Copilot; },
									{true}
											] call ace_interact_menu_fnc_createAction;

[_Vehicle, 1, ["ACE_SelfActions","OKS_Menu"], _Move_To_Copilot] call ace_interact_menu_fnc_addActionToObject;


_Move_To_Pilot = ['Move_To_Pilot',
						'Move to Pilot',
							'',
								{ [_this] spawn OKS_Interact_Pilot;},
									{true}
											] call ace_interact_menu_fnc_createAction;

[_Vehicle, 1, ["ACE_SelfActions","OKS_Menu"], _Move_To_Pilot] call ace_interact_menu_fnc_addActionToObject;

_Move_To_DoorGunner = ['Move_To_DoorGunner',
						'Move to Door Gunner',
							'',
								{ [_this] spawn OKS_Interact_DoorGunner; },
									{true}
											] call ace_interact_menu_fnc_createAction;

[_Vehicle, 1, ["ACE_SelfActions","OKS_Menu"], _Move_To_DoorGunner] call ace_interact_menu_fnc_addActionToObject;