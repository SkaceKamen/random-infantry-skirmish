private _markers = [];
private _position = param [0];
private _spawns = param [1];

{
	_direction = _x getDir _position;
	for [{_xx = -160},{_xx <= 160},{_xx = _xx + 64}] do {
		_noise = random(20);
		_marker = createMarker [
			"SPAWN " + str(_foreachIndex) + str(_xx),
			_x vectorAdd [sin(_direction - 90) * _xx + sin(_direction) * _noise, cos(_direction - 90) * _xx + cos(_direction) * _noise, 0]
		];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_ambush";
		_marker setMarkerDir (_direction - 90);

		if (_foreachIndex == SIDE_ENEMY) then {
			_marker setMarkerColor "ColorRed";
		} else {
			_marker setMarkerColor "ColorBlue";
		};

		_markers pushBack _marker;
	};
} foreach _spawns;

_markers;