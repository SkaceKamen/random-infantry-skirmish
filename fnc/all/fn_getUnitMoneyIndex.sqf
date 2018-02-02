/*
	Function:
	RSTF_fnc_getUnitMoneyIIndex

	Description:
	Fetches index in money array for unit specified by it's ID

	Parameter(s):
	_id - unit id [String]

	Returns:
	Index in money array [Number]
*/
private _id = param [0];
private _index = RSTF_MONEY_INDEX find _id;
if (_index < 0) then {
	_index = count(RSTF_MONEY_INDEX);
	RSTF_MONEY_INDEX pushBack _id;
	RSTF_MONEY pushBack 3000;

	if (isServer) then {
		publicVariable "RSTF_MONEY_INDEX";
		publicVariable "RSTF_MONEY";
	};
};
_index;