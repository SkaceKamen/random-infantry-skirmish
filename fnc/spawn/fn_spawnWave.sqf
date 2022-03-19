/*
	Function:
	RSTF_fnc_spawnWave

	Description:
	Spawns wave of specified side

	Parameters:
		0: SIDE INDEX - side index of side that should spawn
		1: BOOLEAN - instant spawn, default false
		2: BOOLEAN - skip RSTF_GROUPS publish, only used in general loop, defualt false

	Author:
	Jan Zípek
*/

private _sideIndex = param [0];
private _instantSpawn = param [1, false];
private _skipPublish = param [2, false];

private _groups = RSTF_GROUPS select _sideIndex;
private _side = east;
if (_sideIndex == 1) then {
	_side = west;
};

// Clear empty groups
_groups = _groups select { !isNull(_x) && { count(units(_x)) > 0 } };
RSTF_GROUPS set [_sideIndex, _groups];

// Enemy can have units advantage
private _unitsPerGroup = RSTF_LIMIT_UNITS;
if (_side == east) then {
	_unitsPerGroup = _unitsPerGroup + RSTF_ENEMY_ADVANTAGE_UNITS;
};
private _groupsPerSide = RSTF_LIMIT_GROUPS;
if (_side == east) then {
	_groupsPerSide = _groupsPerSide + RSTF_ENEMY_ADVANTAGE_GROUPS;
};

// Calculate unit counts for this side
private _totalUnits = _unitsPerGroup * _groupsPerSide;
private _aliveUnits = 0;
{
	_aliveUnits = _aliveUnits + count(units(_x));
} foreach _groups;

// Spawn new units (Limit spawn count?)
private _group = grpNull;
private _i = 0;
private _spawnQueue = [];
for [{_i = 0}, {_i < (_totalUnits - _aliveUnits)}, {_i = _i + 1}] do {
	if (_i % _unitsPerGroup == 0 || isNull(_group)) then {
		_group = createGroup [_side, true];
		if (isNull(_group)) exitWith {
			diag_log text(format["Failed to create %1 group, too many groups?", _side]);
			diag_log text(format["Groups: %1", count(_groups)]);

			systemChat format["Failed to create %1 group, too many groups?", _side];
		};

		_groups pushBack _group;

		[_group, _sideIndex] call RSTF_fnc_refreshGroupWaypoints;

		if (RSTF_DEBUG) then {
			private _marker = createMarkerLocal [str(_group), [0,0,0]];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "waypoint";
			_marker setMarkerColor (RSTF_SIDES_COLORS select _sideIndex);
		};
	};

	if (_instantSpawn) then {
		[_group, _sideIndex] call RSTF_fnc_createRandomUnit;
	} else {
		_spawnQueue pushBack [_group, _sideIndex];
	};
};

if (RSTF_DEBUG) then {
	if (_instantSpawn) then {
		systemChat format["[SIDE-%1] Spawned %2 units", _side, _i];
	} else {
		systemChat format["[SIDE-%1] Queued %2 units to spawn", _side, _i];
	};
};

if (not _instantSpawn) then {
	[_spawnQueue, _groups, _sideIndex] spawn {
		private _queue = param [0];
		private _groups = param [1];
		private _sideIndex = param [2];

		private _lastGroup = grpNull;

		// Gradually spawn units
		while { count(_queue) > 0 } do {
			_item = _queue call BIS_fnc_arrayPop;
			_item call RSTF_fnc_createRandomUnit;

			/*
			// Refresh targets for spawned groups
			if (_item#0 != _lastGroup) then {
				_lastGroup = _item#0;
				[_item#0, _sideIndex] call RSTF_fnc_refreshGroupWaypoints;
			};
			*/

			sleep 0.1;
		};

		if (RSTF_DEBUG) then {
			systemChat format["[SIDE-%1] Done spawning queued units", _sideIndex];
		};
	};
} else {
	[_side] call RSTF_fnc_refreshSideWaypoints;
};

if (not _skipPublish) then {
	publicVariable "RSTF_GROUPS";
};
