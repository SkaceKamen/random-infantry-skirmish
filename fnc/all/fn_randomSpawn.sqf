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
private _width = param [3, RSTF_RANDOM_SPAWN_WIDTH];
private _height = param [4, RSTF_RANDOM_SPAWN_HEIGHT];
private _water = param [5, false];

private _sideSide = [_side] call RSTF_fnc_indexSide;

private _position = [];
private _try = 0;
while { _try < 100 } do {
	if (RSTF_MODE_DEFEND_ENABLED) then {
		if (_side == SIDE_ENEMY) then {
			private _outerRadius = RSTF_MODE_DEFEND_RADIUS + 500;
			private _outerRadius2 = _outerRadius * _outerRadius;
			private _innerRadius = RSTF_MODE_DEFEND_RADIUS + 400;
			private _innerRadius2 = _innerRadius * _innerRadius;

			while { true } do {
				private _xx = -_outerRadius + random(_outerRadius*2);
				private _yy = -_outerRadius + random(_outerRadius*2);
				private _pos = _xx * _xx + _yy * _yy;

				if (_pos >= _innerRadius2 && _pos <= _outerRadius2) exitWith {
					_position = RSTF_POINT vectorAdd [_xx, _yy, 0];
				};
			};
		} else {
			private _radius = RSTF_MODE_DEFEND_RADIUS * 0.25;
			private _radius2 = _radius * _radius;

			while { true } do {
				private _xx = -_radius + random(_radius*2);
				private _yy = -_radius + random(_radius*2);
				private _pos = _xx * _xx + _yy * _yy;

				if (_pos <= _radius2) exitWith {
					_position = RSTF_POINT vectorAdd [_xx, _yy, 0];
				};
			};
		};
	} else {
		private _xx = -(_height/2) + random(_height);
		private _yy = -(_width/2) + random(_width);

		_position = _center vectorAdd [
			_xx * sin(_direction) + _yy * sin(_direction - 90),
			_xx * cos(_direction) + _yy * cos(_direction - 90),
			0
		];
	};

	// Find suitable empty position near the choosen position
	private _emptyPosition = _position findEmptyPosition [0, 20, "C_Soldier_VR_F"];

	// Avoid enemies
	if (count(_emptyPosition) > 0 && RSTF_RANDOM_SPAWN_AVOID_ENEMIES) then {
		private _nearby = nearestObjects [_emptyPosition, ["Man", "Land"], RSTF_RANDOM_SPAWN_AVOID_ENEMIES_RADIUS, true];
		if ({ side(_x) != _sideSide } count(_nearby) > 0) then {
			_emptyPosition = [];
		};
	};

	// Return this empty position if correct and not on water
	if (count(_emptyPosition) > 0 && { _water || !surfaceIsWater _emptyPosition }) exitWith {
		_position = _emptyPosition;
	};

	_try = _try + 1;
};

_position;