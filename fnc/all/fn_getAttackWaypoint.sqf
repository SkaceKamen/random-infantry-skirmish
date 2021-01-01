private _side = param [0];
private _vehicle = param [1, false];

private _centerDistance = if (_vehicle) then { RSTF_DISTANCE * (0.1 + random(0.1)); } else { RSTF_DISTANCE * (0.25 + random(0.1)); };
private _sideDistance = if (_vehicle) then { RSTF_DISTANCE * 0.5 } else { RSTF_DISTANCE * 0.3 };
private _direction = if (_side == SIDE_ENEMY) then { 180 + RSTF_DIRECTION } else { RSTF_DIRECTION };
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
