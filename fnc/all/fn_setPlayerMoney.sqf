/*
	Function:
	RSTF_fnc_setPlayerMoney

	Description:
	Fetches money for specified player

	Parameter(s):
	_player - player to use optional [Object]
	_money - amout of money to be set [Number]

	Returns:
	Money owned [Number]
*/
[getPlayerUID(param [0]), param [1]] call RSTF_fnc_setUnitMoney;