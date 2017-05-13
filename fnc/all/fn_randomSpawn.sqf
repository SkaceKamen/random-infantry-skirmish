params ["_side"];

private _center = RSTF_SPAWNS select _side;
private _direction = RSTF_DIRECTION;
private _width = 200;
private _height = 50;
private _xx = -_width/2 + random(_width/2);
private _yy = -_height/2 + random(_height/2);

private _position = [
	_xx * sin(_direction) + _yy * sin(_direction + 90),
	_xx * cos(_direction) + _yy * cos(_direction + 90),
	0
];

_position = _position vectorAdd _center;
_position;