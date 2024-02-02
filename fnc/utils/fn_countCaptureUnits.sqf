private _center = param [0, [0,0,0], [[0, 0, 0]]];
private _radius = param [1, 100, [100]];
private _vehiclesCountAs = param [2, 0, [0]];
private _includeNeutrals = param [3, false, [false]];

private _counts = [0, 0, 0];
private _nearest = nearestObjects [_center, ["Man"], _radius, true];
{
	private _index = -1;
	if (alive(_x)) then {
		if (side(_x) == west) then {
			_index = SIDE_FRIENDLY;
		};
		if (side(_x) == east) then {
			_index = SIDE_ENEMY;
		};
		if (_includeNeutrals && side(_x) == resistance) then {
			_index = SIDE_NEUTRAL;
		};
	};

	if (_index >= 0) then {
		_counts set [_index, (_counts select _index) + 1];
	};
} foreach _nearest;

if (_vehiclesCountAs > 0) then {
	private _nearestVehicles = nearestObjects [_center, ["Car", "Tank"], _radius, true];
	{
		private _index = -1;
		if (alive(_x)) then {
			if (side(_x) == west) then {
				_index = SIDE_FRIENDLY;
			};
			if (side(_x) == east) then {
				_index = SIDE_ENEMY;
			};
			if (_includeNeutrals && side(_x) == resistance) then {
				_index = SIDE_NEUTRAL;
			};
		};

		if (_index >= 0) then {
			_counts set [_index, (_counts select _index) + _vehiclesCountAs];
		};
	} foreach _nearestVehicles;
};

_counts;
