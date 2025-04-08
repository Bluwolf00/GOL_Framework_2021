params["_unit"]; 
 
private _group = group _unit; 
_group spawn  
{
	_Group = _this;
	_Group setGroupIconParams [[1,1,0.9,0.75],"",1,true]; 
	uisleep 0.05; 
	_Group setGroupIconParams [([side _Group, false] call BIS_fnc_sideColor),"",1,true]; 
}; 

_unit spawn 
{  
	comment "Calculate vector forward for turret or man and convert to direction angle"; 
	private _forwardVectorFlat = [0,0,0]; 
	private _angle = 0; 
	
	_forwardVectorFlat = (vehicle _this weaponDirection ((weaponState [vehicle _this,(vehicle _this unitTurret _this)]) select 0)); 
	if (_forwardVectorFlat isEqualTo [0,0,0]) then {
		_forwardVectorFlat = _this weaponDirection currentWeapon _this;
	}; 
	_forwardVectorFlat set[2,0]; 
	_forwardVectorFlat = vectorNormalized _forwardVectorFlat; 
	_angle = acos ([0,1,0] vectorDotProduct _forwardVectorFlat); 
	if ((_forwardVectorFlat select 0) < 0) then {
		_angle = _angle * -1
	}; 
	private _bulletMkr = createMarkerLocal ["marker_"+str(round random 1000000),getPosWorldVisual _this]; 
	_bulletMkr setMarkerShapeLocal "RECTANGLE"; 
	_bulletMkr setMarkerBrushLocal "SolidFull"; 
	_bulletMkr setMarkerColorLocal RKAGBulletMarkerColor; 
	_bulletMkr setMarkerSizeLocal RKAGBulletMarkerSize; 
	_bulletMkr setMarkerDirLocal _angle; 
	private _frameEvent = addMissionEventHandler ["EachFrame",
		{ 
			private _unit = _thisArgs select 0; 
			private _bulletMkr = _thisArgs select 1; 
			private _forwardVector = _thisArgs select 2; 
			private _currentPos = getMarkerPos _bulletMkr; 
			_bulletMkr setMarkerPosLocal (_currentPos vectorAdd (_forwardVector vectorMultiply RKAGBulletMarkerSpeed)); 
		},
		[_this,_bulletMkr,_forwardVectorFlat]
	]; 

	uisleep RKAGBulletMarkerLifetime; 

	removeMissionEventHandler ["EachFrame",_frameEvent]; 

	deleteMarkerLocal _bulletMkr; 
}; 