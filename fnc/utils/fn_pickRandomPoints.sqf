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
private _world_anchor = getArray(configFile >> "CfgWorlds" >> worldName >> "SafePositionAnchor");
private _locations = nearestLocations [_world_anchor, ["NameCityCapital","NameCity","NameVillage"], 99999999];
private _results = [];

// Shuffle results to make locations random
_locations = _locations call RSTF_fnc_arrayShuffle;

// Pick valid locations
for [{_i = 0}, {_i < count(_locations) && (_count == 0 || count(_results) < _count)},{_i = _i + 1}] do {
	// Direction and distance between two spawns
	_center = _locations select _i;
	_direction = random(360);
	_distance = 200 + random(50);

	// Save center position
	_position = getPos(_center);
	_position set [2, 0];

	//Now find usable spawns
	_tries = 0;
	_spawns = [];
	_valid = false;
	while { _tries < 5 } do {
		//Load spawn locations
		//INDEX is side index
		_spawns = [
			[(_position select 0) + sin(_direction) * _distance,(_position select 1) + cos(_direction) * _distance, 0],
			[(_position select 0) + sin(180 + _direction) * _distance,(_position select 1) + cos(180 + _direction) * _distance, 0],
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
	};
};

_results;