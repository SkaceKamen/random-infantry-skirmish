private _dialogName = "RSTF_RscDialogBattleSelection";
private _ok = createDialog _dialogName;
if (!_ok) exitWith {
	systemChat "Failed to open dialog.";
};

private _display = _dialogName call RSTF_fnc_getDisplay;
_display displayAddEventHandler ["Unload", {
	{
		deleteMarker _x;
	} foreach RSTF_BS_MARKERS;
	RSTF_BS_MARKERS = [];
}];

private _ctrlBattles = [_dialogName, "battles"] call RSTF_fnc_getCtrl;
private _ctrlMap = [_dialogName, "map"] call RSTF_fnc_getCtrl;
private _ctrlMapButton = [_dialogName, "buttonMap"] call RSTF_fnc_getCtrl;
private _ctrlVote = [_dialogName, "buttonVote"] call RSTF_fnc_getCtrl;
private _ctrlTitle = [_dialogName, "mainTitle"] call RSTF_fnc_getCtrl;

RSTF_BS_MARKERS = [];

if (!isMultiplayer) then {
	_ctrlTitle ctrlSetText "Select map";
	_ctrlVote ctrlSetText "Select";
};

_ctrlMap ctrlShow false;
_ctrlMap ctrlEnable false;
_ctrlMap ctrlCommit 0;

{
	_ctrlBattles lnbAddRow ["Battle of " + text(_x select 0)];
} foreach RSTF_POINTS;

_ctrlBattles ctrlAddEventHandler ["LBSelChanged", {
	_ctrl = _this select 0;
	_selected = _this select 1;
	
	_ctrlMap = ["RSTF_RscDialogBattleSelection", "map"] call RSTF_fnc_getCtrl;

	if (_selected >= 0) then {
		_place = RSTF_POINTS select _selected;
		_position = getPos(_place select 0);
		_position set [2, 0];

		if (isNull(RSTF_CAM)) then {
			call RSTF_fnc_createCam;
		};

		RSTF_CAM camSetTarget _position;
		RSTF_CAM camSetRelPos [30, 30, 50];
		RSTF_CAM camCommit 0;

		_ctrlMap ctrlMapAnimAdd [0, 0.05, _position];
		ctrlMapAnimCommit _ctrlMap;

		{
			deleteMarker _x;
		} foreach RSTF_BS_MARKERS;

		RSTF_BS_MARKERS = [_position, _place select 1, true] call RSTF_fnc_createPointMarkers;
	};
}];

_ctrlMapButton ctrlAddEventHandler ["ButtonClick", {
	_ctrlMap = ["RSTF_RscDialogBattleSelection", "map"] call RSTF_fnc_getCtrl;
	_ctrlMap ctrlShow !(ctrlShown _ctrlMap);
	_ctrlMap ctrlCommit 0;
}];

_ctrlVote ctrlAddEventHandler ["ButtonClick", {
	_ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
	_selected = lnbCurSelRow _ctrlBattles;
	
	if (_selected >= 0) then {
		closeDialog 0;

		_place = RSTF_POINTS select _selected;
		if (!isMultiplayer) then {
			_place call RSTF_fnc_assignPoint;
			0 spawn RSTF_fnc_start;
		};
	};
}];