/*
	Function:
	RSTF_fnc_loopMultikills

	Description:
	Multikills logic to be called in game loop.

	Author:
	Jan Zípek
*/

if (RSTF_MONEY_ENABLED) then {
	// Symmetrical arrays with players and their times
	private _keys = RSTF_MULTIKILL_TIMES call AMAP_keys;
	private _values = RSTF_MULTIKILL_TIMES call AMAP_values;

	{
		// Key is player
		private _key = _x;
		// Value is time of last kill
		private _value = _values select _foreachIndex;

		// If at least 2 seconds passed since last kill, evaluate
		if (_value > 0 && _value < time - 3) then {
			// Load number of kills from different map
			// @TODO: Use single map to improve performance?
			private _kills = [RSTF_MULTIKILL_COUNTS, _key, 0] call AMAP_get;

			// Is it proper multikill?
			if (_kills > 1) then {
				// Load text based on kill count
				private _text = RSTF_MULTIKILL_TEXTS select ((_kills - 2) min (count(RSTF_MULTIKILL_TEXTS) - 1));
				// Calculate correct reward
				private _reward = (_kills - 1) * RSTF_MULTIKILL_BONUS;

				// Add money to player
				[_key, _reward] call RSTF_fnc_addPlayerMoney;
				// Display notification to player
				[format["+%1$ <t color='#dddddd'>%2</t>", _reward, _text], 5] remoteExec ["RSTFUI_fnc_addMessage", _key];
			};

			[RSTF_MULTIKILL_TIMES, _key, 0] call AMAP_set;
			[RSTF_MULTIKILL_COUNTS, _key, 0] call AMAP_set;
		};
	} foreach _keys;
};
