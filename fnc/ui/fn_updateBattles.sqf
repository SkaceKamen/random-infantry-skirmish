private _ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
private _current = lnbCurSelRow _ctrlBattles;

if (_current < 0) then {
	_current = RSTF_BATTLE_SELECTION_INDEX;
};

if (_current < 0) then {
	_current = round(random(count(RSTF_POINTS) - 1));
};

lnbClear _ctrlBattles;

private _rowIndex = 0;

private _votes = str(RSTF_POINT_VOTES select count(RSTF_POINTS));
if (!isMultiplayer) then { _votes = ""; };
_ctrlBattles lnbAddRow ["Custom location", _votes];
_ctrlBattles lnbSetData [[_rowIndex, 0], str(-1)];
_rowIndex = _rowIndex + 1;

{
	_votes = str(RSTF_POINT_VOTES select _foreachIndex);
	if (!isMultiplayer) then {
		_votes = "";
	};

	_ctrlBattles lnbAddRow ["Battle for " + ((_x select 0) select 0), _votes];
	_ctrlBattles lnbSetData [[_rowIndex, 0], str(_foreachIndex)];

	_rowIndex = _rowIndex + 1;
} foreach RSTF_POINTS;

if (_current >= 0) then {
	_ctrlBattles lnbSetCurSelRow _current;
};