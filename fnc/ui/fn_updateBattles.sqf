private _ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
private _current = lnbCurSelRow _ctrlBattles;
if (_current < 0) then {
	_current = round(random(count(RSTF_POINTS) - 1));
};

lnbClear _ctrlBattles;
{
	_votes = str(RSTF_POINT_VOTES select _foreachIndex);
	if (!isMultiplayer) then {
		_votes = "";
	};
	_ctrlBattles lnbAddRow ["Battle for " + ((_x select 0) select 0), _votes];
} foreach RSTF_POINTS;

if (_current >= 0) then {
	_ctrlBattles lnbSetCurSelRow _current;
};