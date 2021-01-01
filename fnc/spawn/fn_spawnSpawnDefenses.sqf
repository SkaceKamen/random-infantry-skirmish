private _iiii = 0;

private _side = param [0];
private _position = param [1];

// Direction to mission center
private _direction = _position getDir RSTF_POINT;

private _transportClasses = (RSTF_VEHICLES select _side) select RSTF_VEHICLE_TRANSPORT;
private _transports = [];

private _transportsCount = 4 + random(2);

if (count(_transportClasses) > 0) then {
	for "_iiii" from 1 to _transportsCount do {
		_cls = (selectRandom _transportClasses);
		_pos = [];

		// Try to search for suitable position
		_tries = 0;
		while { _tries < 5 } do {
			// _pos = [[[_position, 100]]] call BIS_fnc_randomPos;
			_pos = [_side] call RSTF_fnc_randomSpawn;

			_pos = _pos findEmptyPosition [10, 50, _cls];
			_tries = _tries + 1;
			if (count(_pos) > 0) exitWith { 0 };
		};

		if (count(_pos) > 0) then {
			_vehicle = _cls createVehicle _pos;
			_vehicle setVehicleLock "LOCKEDPLAYER";
			_vehicle setDir (_direction - 10 + random(20));
			_transports pushBack _vehicle;

			// DEBUG - Track spawn defenses
			if (RSTF_DEBUG) then {
				private _marker = createMarkerLocal [str(_pos), _pos];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "mil_start";
				_marker setMarkerColor (RSTF_SIDES_COLORS select _side);
			};
		};
	};
};

RSTF_SPAWN_VEHICLES set [_side, _transports];