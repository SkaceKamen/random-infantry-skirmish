/*
	Function:
	RSTF_fnc_addUnitMoney

	Description:
	Adds amount of money associated with player.

	Parameter(s):
	_player - player [Object]
	_money - money to be added [Number]

	Returns:
	Resulting amount [Number]
*/
[(param [0, player]) getVariable ["RSTF_UID", "unknown"], param [1]] call RSTF_fnc_addUnitMoney;