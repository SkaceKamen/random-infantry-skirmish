private ["_center", "_radius", "_attempt", "_position", "_direction", "_distance"];

_center = _this select 0;
_radius = _this select 1;
_position = _center;

_attempt = 0;
while{_attempt < 99} do {
	_direction = random(360);
	_distance = random(_radius);
	
	_position = [(_center select 0) + sin(_direction) * _distance, (_center select 1) + cos(_direction) * _distance];
	if (!surfaceIsWater _position) exitWith { };
	
	_attempt = _attempt + 1;
};

_position;