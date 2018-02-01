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
[getPlayerUID(param [0, player])] call RSTF_fnc_getUnitMoney;