/*
	Function:
	RSTF_fnc_loopMultikills

	Description:
	Multikills logic to be called in game loop.

	Author:
	Jan Zípek
*/

if (RSTF_MONEY_ENABLED && !RSTF_DISABLE_MONEY) then {
	{
		// Key is player uid
		private _key = _x;
		// Value is time of last kill
		private _value = _y;

		// If at least 2 seconds passed since last kill, evaluate
		if (_value > 0 && _value < time - 3) then {
			// Load number of kills from different map
			// @TODO: Use single map to improve performance?
			private _kills = RSTF_MULTIKILL_COUNTS getOrDefault [_key, 0];

			// Is it proper multikill?
			if (_kills > 1) then {
				// Load text based on kill count
				private _text = RSTF_MULTIKILL_TEXTS select ((_kills - 2) min (count(RSTF_MULTIKILL_TEXTS) - 1));
				// Calculate correct reward
				private _reward = (_kills - 1) * RSTF_MULTIKILL_BONUS;

				// Add money to player
				[_key, _reward] call RSTF_fnc_addUnitMoney;
				// Display notification to player
				[format["+%1$ <t color='#dddddd'>%2</t>", _reward, _text], 5] remoteExec ["RSTFUI_fnc_addMessage", _key call BIS_fnc_getUnitByUid];
			};

			RSTF_MULTIKILL_TIMES set [_key, 0];
			RSTF_MULTIKILL_COUNTS set [_key, 0];
		};
	} foreach RSTF_MULTIKILL_TIMES;
};
