/*
	Function:
	RSTF_fnc_pickEmplacementPos

	Description:

	Parameter(s):
	_center - center position [Array]
	_radius - radius [Number]
	_direction - direction [Number]
	_usedPositions - used positions [Array]
*/

params ["_center", "_radius", "_direction", "_usedPositions"];

// Pick position
private _position = [];
private _tries = 0;

while { _tries < 100 } do {
	private _centerDistance = _radius * (0.1 + random(0.1));
	private _sideDistance = _radius * 0.75;

	_position = _center vectorAdd [
		sin(_direction) * _centerDistance,
		cos(_direction) * _centerDistance,
		0
	];

	_dis = selectRandom([-1,1]) * random(_sideDistance);
	_position = _position vectorAdd [
		sin(_direction + 90) * _dis,
		cos(_direction + 90) * _dis,
		0
	];

	_position = [_position, 0, 60, 10, 0, 0.1] call BIS_fnc_findSafePos;

	if (count(_position) > 0) then {
		private _closest = _usedPositions findIf { _x distance _position < 25 };
		if (_closest != -1) then {
			_position = [];
		};
	};

	if (count(_position) > 0) exitWith {};

	_tries = _tries + 1;
};

_position;