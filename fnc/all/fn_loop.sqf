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

		{
			// Spawn new wave
			[_foreachIndex, false, true] call RSTF_fnc_spawnWave;

			// Refresh waypoints for all groups (needs to be done every once in a while to keep AI moving)
			[_foreachIndex] call RSTF_fnc_refreshSideWaypoints;
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