/*
	Function:
	RSTF_fnc_addUnitMoney

	Description:
	Adds amount of money associated with unit specified by its id.

	Parameter(s):
	_id - unit id [String]
	_money - money to be added [Number]

	Returns:
	Resulting amount [Number]
*/
private _id = param [0];
private _money = param [1];
private _current = [_id] call RSTF_fnc_getUnitMoney;
[_id, _current + _money] call RSTF_fnc_setUnitMoney;
_current + _money;