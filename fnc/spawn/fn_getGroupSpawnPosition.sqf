/*
	Function:
	RSTF_fnc_groupSpawn

	Description:
	Returns randomized spawn position closest to units in group.

	Parameter(s):
	_group - group [Group]
	_side - side index [Number]

	Returns:
	Randomized spawn position [Position]
*/

private _group = param [0];
private _side = param [1];

private _width = 50;
private _height = 10;
private _enemyCheckRadius = 10;
private _spawnDistanceMin = 80;
private _spawnDistanceMax = 40;

private _direction = RSTF_DIRECTION + 180;
if (_side == SIDE_ENEMY) then {
	_direction = RSTF_DIRECTION;
};

private _position = [];
private _try = 0;
while { _try < 10 } do {
	_position = [];
	
	// Find unit that's alive - perefer leader
	// TODO: Maybe find unit that's closest to objective?
	private _unit = objNull;
	if (alive(leader(_group))) then {
		_unit = leader(_group);
	} else {
		private _alive = units(_group) select { alive _x };

		if (count(_alive) > 0) then {
			_unit = _alive select 0;
		};
	};

	if (isNull(_unit)) exitWith {
		_position = [_side] call RSTF_fnc_randomSpawn;
	};

	// Pick random location within predefined square
	private _distance = _spawnDistanceMin + random(_spawnDistanceMin - _spawnDistanceMax);
	private _center = getPos(_unit) vectorAdd [
		_distance * sin(_direction),
		_distance * cos(_direction),
		0
	];;

	private _xx = -(_height/2) + random(_height);
	private _yy = -(_width/2) + random(_width);

	private _candidate = _center vectorAdd [
		_xx * sin(_direction) + _yy * sin(_direction - 90),
		_xx * cos(_direction) + _yy * cos(_direction - 90),
		0
	];

	// Find suitable empty position near the choosen position
	private _emptyPosition = _candidate findEmptyPosition [0, 20, "C_Soldier_VR_F"];

	// Return this empty position if correct and not on water
	if (count(_emptyPosition) > 0 && !surfaceIsWater _emptyPosition) then {
		// Only allow spawning when there's no enemy nearby
		private _nearUnits = nearestObjects [_candidate, ["Man"], _enemyCheckRadius, true];

		if ({ side(_x) != side(_group) } count _nearUnits == 0) exitWith {
			_position = _emptyPosition;
		};
	};

	if (count(_position) > 0) exitWith {};

	_try = _try + 1;
};

if (count(_position) == 0) then {
	_position = [_side] call RSTF_fnc_randomSpawn;
};

_position;