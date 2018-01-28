RSTF_MODE_CLASSIC_scoreChanged = {
	// Notify clients
	remoteExec ["RSTF_fnc_onScore"];

	// Check for win
	{
		if (_x > RSTF_SCORE_LIMIT) then {
			[_foreachindex] remoteExec ["RSTF_fnc_onEnd"];
		};
	} foreach RSTF_SCORE;
};

RSTF_MODE_CLASSIC_init = {

};

RSTF_MODE_CLASSIC_unitKilled = {
	private _killed = param [0];
	private _killer = param [1];
	if (count(_this) > 2) then {
		_killer = param [2];
	};

	// Side is forgotten shortly after dying for some reason
	private _side = _killed getVariable ["SPAWNED_SIDE", civilian];

	// Get killer side index
	private _index = -1;
	if (side(group(_killer)) == east) then {
		_index = SIDE_ENEMY;
	};
	if (side(group(_killer)) == west) then {
		_index = SIDE_FRIENDLY;
	};

	// Attribute score
	if (_index != -1) then {
		private _score = (RSTF_SCORE select _index);
		private _added = 0;

		// Calculate correct score amount
		if (side(_killer) == _side) then {
			_added = RSTF_SCORE_PER_TEAMKILL;
		} else {
			_added = RSTF_SCORE_PER_KILL;
		};

		// Enemy can have advantage
		if (_index == SIDE_ENEMY) then {
			_added = _added * RSTF_ENEMY_ADVANTAGE_SCORE;
		};

		// Save score result
		RSTF_SCORE set [_index, _score + _added];
		call RSTF_MODE_CLASSIC_scoreChanged;
	};

	// Dispatch message if necessary
	if (isPlayer(_killer)) then {
		private _message = "";
		private _distance = round(_killed distance _killer);

		if (_side != side(_killer)) then {
			_message = format["+%1 <t color='#dddddd'>Kill</t> (%2 m)", RSTF_SCORE_PER_KILL, _distance];
		} else {
			_message = format["%1 <t color='#dddddd'>Teamkill</t>", RSTF_SCORE_PER_TEAMKILL];
		};

		[_message, 5] remoteExec ["RSTF_fnc_UI_AddMessage", _killer];
	};
};

RSTF_MODE_CLASSIC_taskCompleted = {
	private _taskName = param [0];
	private _taskScore = param [1];

	[format["+%2 <t color='#dddddd'>%1</t>", _taskName, _taskScore], 5] remoteExec ["RSTF_fnc_UI_addGlobalMessage"];

	RSTF_SCORE set [SIDE_FRIENDLY, (RSTF_SCORE select SIDE_FRIENDLY) + _taskScore];
	call RSTF_MODE_CLASSIC_scoreChanged;
};

[
	RSTF_MODE_CLASSIC_init,
	RSTF_MODE_CLASSIC_unitKilled,
	RSTF_MODE_CLASSIC_taskCompleted
];