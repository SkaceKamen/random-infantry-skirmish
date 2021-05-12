#include "..\..\dialogs\titles\arcadeUI.inc"

disableSerialization;

if (RSTF_ENDED) exitWith {
	false;
};

private _display = uinamespace getVariable ['ARCADE_UI', displaynull];
private _modeId = call RSTF_fnc_getModeId;

if (_modeId == "Classic" || _modeId == "KOTH") then {
	for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do {
		_score = RSTF_SCORE select _i;
		(_display displayCtrl (4 - _i)) ctrlSetText str(_score);
	};
};

if (_modeId == "Push" || _modeId == "Defense") then {
	private _progress = (RSTF_SCORE select 0) max (RSTF_SCORE select 1);
	private _ctrlPushProgress = _display displayCtrl RSTFUI_ARCADE_PUSH_PROGRESS_IDC;
	_ctrlPushProgress ctrlSetPositionW ((_progress / RSTF_MODE_PUSH_SCORE_LIMIT) * RSTFUI_ARCADE_PUSH_PROGRESS_W);
	_ctrlPushProgress ctrlCommit 0.1;
};
