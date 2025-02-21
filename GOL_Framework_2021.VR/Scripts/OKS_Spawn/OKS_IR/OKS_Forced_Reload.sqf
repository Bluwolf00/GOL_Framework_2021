	params ["_Unit","_ReloadTime"];

	_Unit setVariable ["AA_ReloadTime",_ReloadTime];	
	_Unit addEventHandler ["Fired", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

			_ReloadTimer = {
				params ["_Unit","_ReloadTime","_magazine"];
				// _Unit setCombatMode "BLUE";
				// _Unit setBehaviour "CARELESS";
				// {
				// 	_Unit forgetTarget (_X);
				// } foreach (_Unit targets [true]);
				
				systemChat "Reloading - Combat Blue";
				sleep _ReloadTime;
				_Unit setCombatMode "RED";
				_Unit addMagazine _magazine;
				_Unit setBehaviour "COMBAT";		
				systemChat "Reloaded - Combat Red";	
				_Unit setVariable ["AA_isReloading",false,true];	
			};		
			_ReloadTime = _Unit getVariable "AA_ReloadTime";
			if(_weapon == secondaryWeapon _Unit) then {
				[_Unit,_ReloadTime,_magazine] spawn _ReloadTimer; 
				_Unit setVariable ["AA_isReloading",true,true];
			};
		}
	];