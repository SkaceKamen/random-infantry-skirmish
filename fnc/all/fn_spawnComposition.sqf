params ["_position", "_direction", "_name"];

private _spawned = [];
private _conf = call(compile(format["compositions/%1.sqf", _name]));
private _originalDirection = _conf select 0;
private _objects = _conf select 1;
private _directionDiff = _direction - _originalDirection;

{
	_vehPosition = _x select 0;
	_vehPosition = [
		sin(_directionDiff + 90) * (_vehPosition select 0) + sin(_directionDiff) * (_vehPosition select 1),
		cos(_directionDiff + 90) * (_vehPosition select 0) + cos(_directionDiff) * (_vehPosition select 1),
		0
	];
	_vehPosition = _position vectorAdd _vehPosition;
	_vehDirection = _directionDiff + (_x select 1);
	_className = _x select 2;
	_params = _x select 3;
	_fuel = _params select 0;
	_damage = _params select 1;
	
	_vehicle = createVehicle [_className, _vehPosition, [], 0, "CAN_COLLIDE"];
	_vehicle setDir _vehDirection;
	_vehicle setFuel _fuel;
	_vehicle setDamage _damage;
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	clearItemCargo _vehicle;
	
	_spawned pushBack _vehicle;
} foreach _objects;

_spawned;