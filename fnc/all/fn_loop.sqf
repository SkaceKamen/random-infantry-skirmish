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

	if (RSTF_AI_MONEY_PER_SECOND > 0) then {
		{
			private _groups = _x;
			{
				private _units = units(_x);
				{
					if (!isPlayer(_x)) then {
						[_x getVariable ["ORIGINAL_NAME", name(_x)], RSTF_AI_MONEY_PER_SECOND] call RSTF_fnc_addUnitMoney;
					};
				} foreach _units;
			} foreach _groups;
		} foreach RSTF_GROUPS;
	};

	if (RSTF_DEBUG) then {
		private _debugText = [];

		private _sideCounts = [];
		private _avgMoney = [];
		
		{
			private _side = _x;
			private _groups = RSTF_GROUPS select _side;
			private _aliveUnits = 0;
			private _totalMoney = 0;
			private _moneyCount = 0;

			{
				_aliveUnits = _aliveUnits + count(units(_x));
				{
					private _name = _x getVariable ["ORIGINAL_NAME", -1];
					if (!(_name isEqualTo -1)) then {
						_totalMoney = _totalMoney + ([_name] call RSTF_fnc_getUnitMoney);
						_moneyCount = _moneyCount + 1;
					};
				} forEach units(_x);

			} foreach _groups;

			{
				_totalMoney = _totalMoney + ([_x] call RSTF_fnc_getUnitMoney);
				_moneyCount = _moneyCount + 1;
			} forEach (RSTF_QUEUE_NAMES select _x);

			_sideCounts set [_x, str(_aliveUnits)];
			if (_moneyCount > 0) then {
				_avgMoney set [_x, str(round(_totalMoney/_moneyCount))];
			} else {
				_avgMoney set [_x, '-'];
			};

		} foreach [SIDE_FRIENDLY, SIDE_ENEMY];

		_debugText pushBack format["Units (FR|EN): %1", _sideCounts joinString " | "];
		_debugText pushBack "<br/>";
		_debugText pushBack format["%1s until next spawn", _spawn];
		_debugText pushBack "<br/>";
		_debugText pushBack format["AVG MONEY: %1", _avgMoney joinString " | "];

		hintSilent parseText(_debugText joinString "");
	};

	sleep 1;
};