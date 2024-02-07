/*
	Author: Jan Zípek

	Description:
	Picks random list of possible battle points and spawns.

	Parameter(s):
	0: NUMBER - maximum size of point list (optional, default unlimited)

	Returns:
	ARRAY - each element in format [LOCATION, [SPAWN_POSITION, SPAWN_POSITION], SPAWN_DIRECTION, SPAWN_DISTANCE]
*/

private _i = 0;

// Limits number of results
private _count = param [0, 0];

// Load all locations on map
private _isPredefined = false;
private _locations = if (count(RSTF_PREDEFINED_LOCATIONS) == 0) then {
	private _world_anchor = getArray(configFile >> "CfgWorlds" >> worldName >> "SafePositionAnchor");
	private _locs = nearestLocations [_world_anchor, ["NameCityCapital","NameCity","NameVillage"], 99999999];
	{
		_locs set [_foreachIndex, 
			[
				text(_x),
				getPos(_x),
				[100, 100],
				0
			]
		];
	} forEach _locs;
	_locs;
} else {
	_isPredefined = true;
	RSTF_PREDEFINED_LOCATIONS;
};
private _results = [];

// Shuffle results to make locations random
_locations = _locations call RSTF_fnc_arrayShuffle;

// Pick valid locations
for [{_i = 0}, {_i < count(_locations) && (_count == 0 || count(_results) < _count)},{_i = _i + 1}] do {
	// Direction and distance between two spawns
	_center = _locations select _i;
	_direction = random(360);
	_distance = RSTF_SPAWN_DISTANCE_MIN + random(RSTF_SPAWN_DISTANCE_MAX - RSTF_SPAWN_DISTANCE_MIN);

	// Save center position
	_position = _center select 1;
	_position set [2, 0];

	// Now find usable spawns
	_tries = 0;
	_spawns = [];
	_valid = false;
	while { _tries < 5 } do {
		//Load spawn locations
		//INDEX is side index
		_spawns = [
			_position vectorAdd [sin(_direction) * _distance, cos(_direction) * _distance, 0],
			_position vectorAdd [sin(180 + _direction) * _distance, cos(180 + _direction) * _distance, 0],
			[0,0,0] //For netural defenders
		];

		if (!surfaceIsWater(_spawns select 0) &&
			!surfaceIsWater(_spawns select 1)) exitWith {
			_valid = true;
			true;
		};

		_direction = _direction + 30;
		_tries = _tries + 1;
	};

	if (_valid) then {
		_results pushBack [_center, _spawns, _direction, _distance];
	} else {
		["Invalid location", _center#0] call RSTF_fnc_dbg;
	}
};

_results;