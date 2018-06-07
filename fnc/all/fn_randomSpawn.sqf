/*
	Function:
	RSTF_fnc_randomSpawn

	Description:
	Returns randomized spawn position.

	Parameter(s):
	_side - side index that spawn should be for [Number]
	_center - spawn center, optional, default spawn of _side [Position]
	_direction - spawn direction from center, optional, default RSTF_DIRECTION [Number]
	_width - spawn width, optional, default 300 [Number]
	_height - spawn height, optional, default 60 [Number]
	_water - allow water, optional, default false [Boolean]

	Returns:
	Randomized spawn position [Position]
*/

private _side = param [0];
private _center = param [1, RSTF_SPAWNS select _side];
private _direction = param [2, RSTF_DIRECTION];
private _width = param [3, 300];
private _height = param [4, 60];
private _water = param [5, false];

private _position = [];
private _try = 0;
while { _try < 100 } do {
	private _xx = -(_height/2) + random(_height);
	private _yy = -(_width/2) + random(_width);

	_position = _center vectorAdd [
		_xx * sin(_direction) + _yy * sin(_direction - 90),
		_xx * cos(_direction) + _yy * cos(_direction - 90),
		0
	];

	// Find suitable empty position near the choosen position
	private _emptyPosition = _position findEmptyPosition [0, 20, "C_Soldier_VR_F"];

	// Return this empty position if correct and not on water
	if (count(_emptyPosition) > 0 && { _water || !surfaceIsWater _emptyPosition }) exitWith {
		_position = _emptyPosition;
	};

	_try = _try + 1;
};

_position;