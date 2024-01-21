/*
	Function:
	RSTF_fnc_getPlayerMoney

	Description:
	Fetches money for specified player

	Parameter(s):
	_player - player to use optional [Object, defaults to player]

	Returns:
	Money owned [Number]
*/
[(param [0, player]) getVariable ["RSTF_UID", "unknown"]] call RSTF_fnc_getUnitMoney;