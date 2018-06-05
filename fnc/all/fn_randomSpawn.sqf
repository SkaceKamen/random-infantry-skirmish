/*
	Function:
	RSTF_fnc_randomSpawn

	Description:
	Returns randomized spawn position.

	Parameter(s):
	_side - side index that spawn should be for [Number]
	_center - spawn center, optional [Position]
	_direction - spawn direction from center, optional [Number]
	_width - spawn width, optional [Number]
	_height - spawn height, optional [Number]

	Returns:
	Randomized spawn position [Position]
*/

private _side = param [0];
private _center = param [1, RSTF_SPAWNS select _side];
private _direction = param [2, RSTF_DIRECTION];
private _width = param [3, 300];
private _height = param [4, 60];

private _xx = -(_height/2) + random(_height);
private _yy = -(_width/2) + random(_width);

private _position = [
	_xx * sin(_direction) + _yy * sin(_direction - 90),
	_xx * cos(_direction) + _yy * cos(_direction - 90),
	0
];

_position = _position vectorAdd _center;
_position;