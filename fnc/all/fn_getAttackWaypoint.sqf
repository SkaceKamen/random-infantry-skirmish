private _sideIndex = param [0];
private _vehicle = param [1, false];

if (RSTF_MODE_DEFEND_ENABLED) then {
	private _offset = if (_sideIndex == SIDE_ENEMY) then { 0 } else { 50 };

	private _distance = if (_vehicle) then { RSTF_MODE_DEFEND_RADIUS + random(_offset * 1.5); } else { RSTF_MODE_DEFEND_RADIUS * random(_offset); };
	private _point = RSTF_POINT;
	private _distance2 = _distance * _distance;

	while { true } do {
		private _xx = -_distance + random(_distance*2);
		private _yy = -_distance + random(_distance*2);
		private _pos = _xx * _xx + _yy * _yy;

		if (_pos <= _distance2) exitWith {
			_point = RSTF_POINT vectorAdd [_xx, _yy, 0];
		};
	};

	_point;
} else {
	private _centerDistance = if (_vehicle) then { RSTF_DISTANCE * (0.1 + random(0.1)); } else { RSTF_DISTANCE * (0.25 + random(0.1)); };
	private _sideDistance = if (_vehicle) then { RSTF_DISTANCE * 0.5 } else { RSTF_DISTANCE * 0.3 };
	private _direction = if (_sideIndex == SIDE_ENEMY) then { 180 + RSTF_DIRECTION } else { RSTF_DIRECTION };
	private _point = RSTF_POINT;

	_point = RSTF_POINT vectorAdd [
		sin(_direction) * _centerDistance,
		cos(_direction) * _centerDistance,
		0
	];

	_dis = selectRandom([-1,1]) * random(_sideDistance);
	_point vectorAdd [
		sin(RSTF_DIRECTION + 90) * _dis,
		cos(RSTF_DIRECTION + 90) * _dis,
		0
	];
};
