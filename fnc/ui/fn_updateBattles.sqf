private _ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
lnbClear _ctrlBattles;
{
	_votes = str(RSTF_POINT_VOTES select _foreachIndex);
	if (!isMultiplayer) then {
		_votes = "";
	};
	_ctrlBattles lnbAddRow ["Battle of " + text(_x select 0), _votes];
} foreach RSTF_POINTS;