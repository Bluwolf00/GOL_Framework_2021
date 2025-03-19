/// [this] execVM "Scripts\OKS_Vehicles\OKS_ReduceDamage.sqf";
/// [vehicle]

if(!isServer) exitWith {};

OKS_ReduceDamage_Data = "";

Params
[
	["_Vehicle", ObjNull, [ObjNull]]
];

	_Vehicle addEventHandler ["HandleDamage",
		{
			params ["_unit", "_selection", "_newDamage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
			private ["_selectedMultiplier","_hitpointName"];
			//SystemChat str [_Selection,_hitIndex,_hitPoint,_directHit];
			//copyToClipboard str [_Selection,_hitIndex,_hitPoint,_directHit];

			// Exits
			if !(Alive _Unit) exitWith {};
			if ( 
				!((ToLower _hitPoint) in ["hithull","hitturret","hitgun","hitengine","hitfuel","hitltrack","hitrtrack"])
			) exitWith {};

			// Variables
			private _Multiplier = 0.1;
			if(["T55", typeOf _unit] call BIS_fnc_inString && ["UK3CB", typeOf _unit] call BIS_fnc_inString) then {
				_Multiplier = 3;
				_unit setVehicleArmor 0.3;
			};
			if(["T34", typeOf _unit] call BIS_fnc_inString && ["UK3CB", typeOf _unit] call BIS_fnc_inString) then {
				_Multiplier = 3;
				_unit setVehicleArmor 0.3;
			};
			if(["T72", typeOf _unit] call BIS_fnc_inString && ["UK3CB", typeOf _unit] call BIS_fnc_inString) then {
				_Multiplier = 3;
				_unit setVehicleArmor 0.3;
			};
			if(["T80", typeOf _unit] call BIS_fnc_inString && ["UK3CB", typeOf _unit] call BIS_fnc_inString) then {
				_Multiplier = 3;
				_unit setVehicleArmor 0.3;
			};		
				
			// Added Damage
			_newDamage = if (_newDamage > 1) then { 1 } else { _newDamage };
			_oldDamage = _Unit getVariable [format["NEKY_oldDamage_%1",_hitPoint],0];
			_AddedDamage = _newDamage - _oldDamage;

			//if !(_AddedDamage < 0) exitWith { 0 };
			// New Damage
			_Damage = _oldDamage + (_AddedDamage * _Multiplier);
			_Damage = if (_Damage > 1) then { 1 } else { _Damage };

			if(ToLower _hitpoint == "hithull") then {
				SystemChat format ["Old: %3 Added: %1 Final: Damage %2",(_AddedDamage * _Multiplier),_Damage,_oldDamage];
			};		
			_Unit setVariable [format["NEKY_oldDamage_%1",_hitPoint],_Damage];

			_Damage
		}
	];



/*
 |____| [21518b0a040# 1809334: bmp3m_era.p3d,"",0,w1a,"rhs_rpg7v2_pg7v",-1,w1a,"",true]
  |____| [21518b0a040# 1809334: bmp3m_era.p3d,"",0,w1a,"rhs_rpg7v2_pg7v_penetrator",-1,w1a,"",true]
   |____| [21518b0a040# 1809334: bmp3m_era.p3d,"",0,w1a,"rhs_rpg7v2_pg7v_penetrator",-1,w1a,"",true]
    |____| [21518b0a040# 1809334: bmp3m_era.p3d,"",0,w1a,"rhs_rpg7v2_pg7v_penetrator",-1,w1a,"",true]
	 |____| [21518b0a040# 1809334: bmp3m_era.p3d,"telo",1.67389,w1a,"rhs_rpg7v2_pg7v_penetrator",1,w1a,"hithull",true]
	  |____| [21518b0a040# 1809334: bmp3m_era.p3d,"vez",2.04551,w1a,"rhs_rpg7v2_pg7v_penetrator",6,w1a,"hitturret",true]
	   |____| [21518b0a040# 1809334: bmp3m_era.p3d,"zbran",1.70459,w1a,"rhs_rpg7v2_pg7v_penetrator",7,w1a,"hitgun",true]