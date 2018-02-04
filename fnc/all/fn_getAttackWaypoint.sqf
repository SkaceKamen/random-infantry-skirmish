private _side = param [0];

private _point = RSTF_POINT;
if (_side == SIDE_ENEMY) then {
	_point = RSTF_POINT vectorAdd [
		sin(180 + RSTF_DIRECTION) * (RSTF_DISTANCE * 0.3),
		cos(180 + RSTF_DIRECTION) * (RSTF_DISTANCE * 0.3),
		0
	];
} else {
	_point = RSTF_POINT vectorAdd [
		sin(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.3),
		cos(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.3),
		0
	];
};

_dis = selectRandom([-1,1]) * random(RSTF_DISTANCE * 0.4);
_point vectorAdd [
	sin(RSTF_DIRECTION + 90) * _dis,
	cos(RSTF_DIRECTION + 90) * _dis,
	0
];