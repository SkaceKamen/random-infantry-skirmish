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
_groups = _groups select { !isNull(_x) && { { alive(_x) } count(units(_x)) > 0 } };
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

if (RSTF_MODE_PUSH_ENABLED && RSTF_MODE_ATTACKERS_SIDE == _sideIndex) then {
	_groupsPerSide = _groupsPerSide + RSTF_MODE_PUSH_ATTACKERS_ADVANTAGE;
};

// Calculate unit counts for this side
private _totalUnits = _unitsPerGroup * _groupsPerSide;
private _aliveUnits = 0;
{
	private _count = { alive(_x) } count (units(_x));
	_aliveUnits = _aliveUnits + _count;
	_x setVariable ["RSTF_UNITS_COUNT", _count];
} foreach _groups;

private _pickNextGroup = {
	private _group = param [0];
	private _groups = param [1];
	private _sideIndex = param [2];
	private _side = param [3];
	private _unitsPerGroup = param [4];
	private _index = param [5];

	// Try to use existing group
	private _resultGroup = grpNull;
	if (RSTF_SPAWN_REUSE_GROUPS || RSTF_SPAWN_AT_OWN_GROUP) then {
		{
			if (_x getVariable ["RSTF_UNITS_COUNT", 0] < _unitsPerGroup) exitWith {
				_resultGroup = _x;
			};
		} foreach _groups;
	} else {
		if (!isNull(_group) && _index % _unitsPerGroup != 0) exitWith {
			_resultGroup = _group;
		};
	};

	if (!isNull(_resultGroup)) exitWith {
		_resultGroup;
	};

	// Create new group
	private _group = createGroup [_side, true];
	_group setVariable ["RSTF_UNITS_COUNT", 0];
	_groups pushBack _group;
	[_group, _sideIndex] call RSTF_fnc_refreshGroupWaypoints;

	if (RSTF_DEBUG) then {
		private _marker = createMarkerLocal [str(_group), [0,0,0]];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "waypoint";
		_marker setMarkerColor (RSTF_SIDES_COLORS select _sideIndex);
	};

	_group;
};

// Spawn new units (Limit spawn count?)
private _group = grpNull;
private _i = 0;
private _spawnQueue = [];
for [{_i = 0}, {_i < (_totalUnits - _aliveUnits)}, {_i = _i + 1}] do {
	_group = [_group, _groups, _sideIndex, _side, _unitsPerGroup, _i] call _pickNextGroup;

	if (isNull(_group)) exitWith {
		diag_log text(format["Failed to create %1 group, too many groups?", _side]);
		diag_log text(format["Groups: %1", count(_groups)]);

		systemChat format["Failed to create %1 group, too many groups?", _side];
	};

	_group setVariable ["RSTF_UNITS_COUNT", (_group getVariable ["RSTF_UNITS_COUNT", 0]) + 1];

	if (_instantSpawn) then {
		[_group, _sideIndex, true] call RSTF_fnc_createRandomUnit;
	} else {
		_spawnQueue pushBack [_group, _sideIndex, true];
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
	[_sideIndex] call RSTF_fnc_refreshSideWaypoints;
};

if (not _skipPublish) then {
	publicVariable "RSTF_GROUPS";
};
