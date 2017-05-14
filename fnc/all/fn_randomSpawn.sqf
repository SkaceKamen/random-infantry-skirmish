params ["_side"];

private _center = RSTF_SPAWNS select _side;
private _direction = RSTF_DIRECTION;
private _width = 300;
private _height = 60;
private _xx = -(_height/2) + random(_height);
private _yy = -(_width/2) + random(_width);

diag_log [_xx, _yy];

private _position = [
	_xx * sin(_direction) + _yy * sin(_direction - 90),
	_xx * cos(_direction) + _yy * cos(_direction - 90),
	0
];

_position = _position vectorAdd _center;
_position;