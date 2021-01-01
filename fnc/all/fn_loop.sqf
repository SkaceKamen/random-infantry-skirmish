private _spawn = 0;
private _interval = 0;

while { true } do {
	if (_interval > 2) then {
		_interval = 0;

		[false] call RSTFGC_fnc_tick;
	} else {
		_interval = _interval + 1;
	};

	if (_spawn == 0) then {
		_spawn = RSTF_LIMIT_SPAWN;

		private _index = 0;
		{
			private _groups = _x;
			private _side = east;
			if (_index == 1) then {
				_side = west;
			};

			// Clear empty groups
			_groups = _groups select { !isNull(_x) && { count(units(_x)) > 0 } };
			RSTF_GROUPS set [_foreachIndex, _groups];

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
			for [{_i = 0}, {_i < (_totalUnits - _aliveUnits)}, {_i = _i + 1}] do {
				if (_i % _unitsPerGroup == 0 || isNull(_group)) then {
					_group = createGroup [_side, true];
					if (isNull(_group)) exitWith {
						diag_log text(format["Failed to create %1 group, too many groups?", _side]);
						diag_log text(format["Groups: %1", count(_groups)]);

						systemChat format["Failed to create %1 group, too many groups?", _side];
					};

					_groups pushBack _group;

					if (RSTF_DEBUG) then {
						private _marker = createMarkerLocal [str(_group), [0,0,0]];
						_marker setMarkerShape "ICON";
						_marker setMarkerType "waypoint";
						_marker setMarkerColor (RSTF_SIDES_COLORS select _index);
					};
				};

				[_group, _index] call RSTF_fnc_createRandomUnit;
			};

			// Update group target waypoint
			{
				private _group = _x;

				_dis = selectRandom([-1,1]) * random(RSTF_DISTANCE * 0.3);
				_wppoint = [_index, true] call RSTF_fnc_getAttackWaypoint;

				// Delete and recreate waypoint
				// This sometimes helps with stuck units
				deleteWaypoint [_group, 0];
				_wp = _group addWaypoint [_wppoint, 50];
				_wp setWaypointType "SAD";

				if (RSTF_DEBUG) then {
					(str(_group)) setMarkerPos _wppoint;
				};
			} foreach _groups;

			_index = _index + 1;
		} foreach RSTF_GROUPS;

		// TODO: Only do when groups changed?
		publicVariable "RSTF_GROUPS";
	} else {
		_spawn = _spawn - 1;
	};

	if (isServer && RSTF_TASK == "") then {
		0 call RSTF_TASKS_start;
	};

	call RSTF_fnc_loopMultikills;

	sleep 1;
};