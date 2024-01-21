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

[(param [0, player]) getVariable ["RSTF_UID", "unknown"], param [1]] call RSTF_fnc_setUnitMoney;