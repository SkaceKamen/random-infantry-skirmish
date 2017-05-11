private _ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
lnbClear _ctrlBattles;
{
	_ctrlBattles lnbAddRow ["Battle of " + text(_x select 0), str(RSTF_POINT_VOTES select _foreachIndex)];
} foreach RSTF_POINTS;