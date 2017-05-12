private _dialogName = "RSTF_RscDialogBattleSelection";
private _display = [_dialogName] call RSTF_fnc_spawnDialog;
if (typeName(_display) == typeName(false) && { !_display }) exitWith {
	false;
};

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
private _ctrlTimeout = [_dialogName, "timeout"] call RSTF_fnc_getCtrl;

RSTF_BS_MARKERS = [];

if (!isMultiplayer) then {
	_ctrlTitle ctrlSetText "Select map";
	_ctrlVote ctrlSetText "Select";
	_ctrlTimeout ctrlShow false;
	_ctrlTimeout ctrlCommit 0;
};

_ctrlMap ctrlShow false;
_ctrlMap ctrlEnable false;
_ctrlMap ctrlCommit 0;

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

call RSTF_fnc_updateBattles;

_ctrlMapButton ctrlAddEventHandler ["ButtonClick", {
	_ctrlMap = ["RSTF_RscDialogBattleSelection", "map"] call RSTF_fnc_getCtrl;
	_ctrlMap ctrlShow !(ctrlShown _ctrlMap);
	_ctrlMap ctrlCommit 0;
}];

_ctrlVote ctrlAddEventHandler ["ButtonClick", {
	_ctrlVote = _this select 0;
	_ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
	_selected = lnbCurSelRow _ctrlBattles;
	
	if (_selected >= 0) then {
		_place = RSTF_POINTS select _selected;
		
		// Switch to point immediately if SP
		if (!isMultiplayer) then {
			closeDialog 0;
			_place call RSTF_fnc_assignPoint;
			0 spawn RSTF_fnc_start;
		} else {
			// Disable voting button
			_ctrlVote ctrlEnable false;
			_ctrlVote ctrlCommit 0;

			// Broadcast option if necessary
			if (isServer) then {
				RSTF_POINT_VOTES set [_selected, (RSTF_POINT_VOTES select _selected) + 1];
				publicVariable "RSTF_POINT_VOTES";
				call RSTF_fnc_updateBattles;
			} else {
				RSTF_POINT_VOTE = _selected;
				publicVariable "RSTF_POINT_VOTE";
			};
		};
	};
}];
