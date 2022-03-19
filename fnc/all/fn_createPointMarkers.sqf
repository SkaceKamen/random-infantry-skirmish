private _markers = [];
private _position = param [0];
private _spawns = param [1];
private _local = param [2, false];

if (RSTF_MODE_DEFEND_ENABLED || (call RSTF_fnc_getModeId) == 'Defense') then {
	for [{ _d = 0 }, { _d < 360 }, { _d = _d + 50 }] do {
		private _distance = RSTF_MODE_DEFEND_RADIUS + 150 + random(50);
		private _direction = _d + random(8);
		private _marker = "";

		if (_local) then {
			_marker = createMarkerLocal [
				"SPAWN " + str(_d),
				_position vectorAdd [sin(_direction) * _distance, cos(_direction) * _distance, 0]
			];
		} else {
			_marker = createMarker [
				"SPAWN " + str(_d),
				_position vectorAdd [sin(_direction) * _distance, cos(_direction) * _distance, 0]
			];
		};

		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_ambush";
		_marker setMarkerDir (_d + 90);
		_marker setMarkerColor "ColorRed";

		_markers pushBack _marker;
	};
} else {
	{
		if (_foreachIndex != SIDE_NEUTRAL) then {
			_direction = _x getDir _position;
			for [{_xx = -160},{_xx <= 160},{_xx = _xx + 64}] do {
				_noise = random(50);
				_xxx = _xx - 20 + random(40);
				_marker = "";

				if (_local) then {
					_marker = createMarkerLocal [
						"SPAWN " + str(_foreachIndex) + str(_xx),
						_x vectorAdd [sin(_direction - 90) * _xxx + sin(_direction) * _noise, cos(_direction - 90) * _xxx + cos(_direction) * _noise, 0]
					];
				} else {
					_marker = createMarker [
						"SPAWN " + str(_foreachIndex) + str(_xx),
						_x vectorAdd [sin(_direction - 90) * _xxx + sin(_direction) * _noise, cos(_direction - 90) * _xxx + cos(_direction) * _noise, 0]
					];
				};

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
		};
	} foreach _spawns;
};

_markers;