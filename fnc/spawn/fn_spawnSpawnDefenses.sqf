private ["_iiii"];

private _side = param [0];
private _position = param [1];

// Direction to mission center
private _direction = _position getDir RSTF_POINT;

private _transportClasses = (RSTF_VEHICLES select _side) select RSTF_VEHICLE_TRANSPORT;
private _transports = [];

private _transportsCount = 2 + random(2);

if (count(_transportClasses) > 0) then {
	for "_iiii" from 1 to _transportsCount do {
		_pos = [[[_position, 100]]] call BIS_fnc_randomPos;
		_vehicle = (selectRandom _transportClasses) createVehicle _pos;
		_vehicle setVehicleLock "LOCKEDPLAYER";
		_vehicle setDir (_direction - 10 + random(20));
		_transports pushBack _vehicle;
	};
};

RSTF_SPAWN_VEHICLES set [_side, _transports];