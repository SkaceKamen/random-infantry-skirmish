/*
	Function:
	RSTF_fnc_setUnitMoney

	Description:
	Sets amount of money associated with unit specified by its id.

	Parameter(s):
	_id - unit id [String]
	_money - money to be set [Number]
*/
private _id = param [0];
private _money = param [1];
RSTF_MONEY set [[_id] call RSTF_fnc_getUnitMoneyIndex, _money];

if (isServer) then {
	publicVariable "RSTF_MONEY_INDEX";
	publicVariable "RSTF_MONEY";
};