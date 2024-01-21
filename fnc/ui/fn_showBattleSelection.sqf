private _dialogName = "RSTF_RscDialogBattleSelection";
private _display = [_dialogName, RSTF_fnc_showBattleSelection] call RSTF_fnc_spawnDialog;
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
private _ctrlEdit = [_dialogName, "buttonEdit"] call RSTF_fnc_getCtrl;

RSTF_BS_MARKERS = [];

if (!isMultiplayer) then {
	_ctrlTitle ctrlSetText "Select map";
	_ctrlVote ctrlSetText "SELECT";
	_ctrlTimeout ctrlShow false;
	_ctrlTimeout ctrlCommit 0;
};

_ctrlMap ctrlShow false;
_ctrlMap ctrlEnable false;
_ctrlMap ctrlCommit 0;

_ctrlEdit ctrlShow false;
_ctrlEdit ctrlCommit 0;

_ctrlBattles ctrlAddEventHandler ["LBSelChanged", {
	_ctrl = _this select 0;
	_selectedIndex = _this select 1;
	_selected = parseNumber(_ctrl lnbData [_selectedIndex, 0]);

	RSTF_BATTLE_SELECTION_INDEX = _selectedIndex;
	
	_ctrlMap = ["RSTF_RscDialogBattleSelection", "map"] call RSTF_fnc_getCtrl;
	_ctrlEdit = ["RSTF_RscDialogBattleSelection", "buttonEdit"] call RSTF_fnc_getCtrl;

	if (_selected == -1 && (isServer || call BIS_fnc_admin > 0)) then {
		_ctrlEdit ctrlShow true;
		_ctrlEdit ctrlCommit 0;
	};

	if (_selected >= -1) then {
		_spawns = [];
		_position = [];

		if (_selected >= 0) then {
			_place = RSTF_POINTS select _selected;
			_position = (_place select 0) select 1;
			_spawns = _place select 1;
		} else {
			_position = RSTF_CUSTOM_POINT;
			_spawns = RSTF_CUSTOM_POINT_SPAWNS;
		};

		_position set [2, 0];

		if (isNull(RSTF_CAM)) then {
			call RSTF_fnc_createCam;
		};

		RSTF_CAM camSetTarget _position;
		RSTF_CAM camSetRelPos [100, 100, 300];
		RSTF_CAM camCommit 0;

		_ctrlMap ctrlMapAnimAdd [0, 0.05, _position];
		ctrlMapAnimCommit _ctrlMap;

		{
			deleteMarker _x;
		} foreach RSTF_BS_MARKERS;

		RSTF_BS_MARKERS = [_position, _spawns, true] call RSTF_fnc_createPointMarkers;
	};
}];

call RSTF_fnc_updateBattles;

_ctrlMapButton ctrlAddEventHandler ["ButtonClick", {
	_ctrlMap = ["RSTF_RscDialogBattleSelection", "map"] call RSTF_fnc_getCtrl;
	_ctrlMap ctrlShow !(ctrlShown _ctrlMap);
	_ctrlMap ctrlCommit 0;
}];

_ctrlEdit ctrlAddEventHandler ["ButtonClick", {
	closeDialog 0;
	0 spawn RSTF_fnc_customSelectorShow;
}];

_ctrlVote ctrlAddEventHandler ["ButtonClick", {
	_ctrlVote = _this select 0;
	_ctrlBattles = ["RSTF_RscDialogBattleSelection", "battles"] call RSTF_fnc_getCtrl;
	_selected = parseNumber(_ctrlBattles lnbData [lnbCurSelRow _ctrlBattles, 0]);
	
	if (_selected >= -1) then {
		_place = [];

		if (_selected == -1) then {
			_place = [["Custom", RSTF_CUSTOM_POINT], RSTF_CUSTOM_POINT_SPAWNS, RSTF_CUSTOM_DIRECTION, RSTF_CUSTOM_DISTANCE];
		} else {
			_place = RSTF_POINTS select _selected;
		};
		
		// Switch to point immediately if SP
		if (!isMultiplayer) then {
			closeDialog 0;
			_place call RSTF_fnc_assignPoint;
			0 spawn RSTF_fnc_start;
		} else {
			// Disable voting button
			_ctrlVote ctrlEnable false;
			_ctrlVote ctrlCommit 0;

			if (_selected < 0) then {
				_selected = count(RSTF_POINTS);
			};

			// Broadcast option if necessary
			if (isServer) then {
				RSTF_POINT_VOTES set [_selected, (RSTF_POINT_VOTES select _selected) + 1];
				publicVariable "RSTF_POINT_VOTES";
				call RSTF_fnc_updateBattles;
			} else {
				
				if (isNil("RSTF_POINT_VOTE")) then {
					RSTF_POINT_VOTE = _selected;
					[_selected] remoteExec ["RSTF_fnc_setPlayerVote", REMOTE_TARGET_SERVER];
				};
			};
		};
	};
}];
