private _dialogName = "RSTF_RscDialogBattleSelection";
private _ok = createDialog _dialogName;
if (!_ok) exitWith {
	systemChat "Failed to open dialog.";
};

private _ctrlBattles = [_dialogName, "battles"] call RSTF_fnc_getCtrl;

{
	_ctrlBattles lnbAddRow ["Battle of " + text(_x select 0)];
} foreach RSTF_POINTS;

_ctrlBattles ctrlAddEventHandler ["LBSelChanged", {
	_ctrl = _this select 0;
	_selected = _this select 1;
	
	if (_selected >= 0) then {
		_place = RSTF_POINTS select _selected;

		if (isNull(RSTF_CAM)) then {
			call RSTF_fnc_createCam;
		};

		RSTF_CAM camSetTarget getPos(_place select 0);
		RSTF_CAM camSetRelPos [30, 30, 50];
		RSTF_CAM camCommit 0;
	};
}];