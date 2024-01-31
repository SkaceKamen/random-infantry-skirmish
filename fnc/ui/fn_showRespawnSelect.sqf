private _deathCenter = param [0, RSTF_POINT];

RSTF_RESPAWN_SELECT_layout = [missionConfigFile >> "RespawnSelectDialog"] call ZUI_fnc_createDisplay;
RSTF_RESPAWN_SELECT_CENTER = _deathCenter;

_display = [RSTF_RESPAWN_SELECT_layout] call ZUI_fnc_display;
_display displayAddEventHandler ["unload", {
	if (_this select 1 != 0) then {
		RSTF_DEATH_SIDE spawn RSTF_fnc_spawnPlayer;
	};
}];

private _listCtrl = [RSTF_RESPAWN_SELECT_layout, "list"] call ZUI_fnc_getControlById;
_listCtrl ctrlAddEventHandler ["LBSelChanged", {
	private _ctrl = _this select 0;
	private _row = lnbCurSelRow _ctrl;
	private _unit = RSTF_RESPAWN_SELECT_UNITS select _row;
	private _alive = alive _unit;

	RSTF_CAM camSetTarget _unit;
	RSTF_CAM camSetRelPos [0, -4, 5];
	RSTF_CAM camCommit 0;

	private _spawnCtrl = [RSTF_RESPAWN_SELECT_layout, "respawn"] call ZUI_fnc_getControlById;
	_spawnCtrl ctrlEnable _alive;
	_spawnCtrl ctrlSetTooltip (if (_alive) then { "" } else {"Unit is dead"});
}];

[RSTF_RESPAWN_SELECT_layout, "refresh", "ButtonClick", {
	call RSTF_fnc_refreshRespawnSelect;
}] call ZUI_fnc_on;

[RSTF_RESPAWN_SELECT_layout, "respawn", "ButtonClick", {
	private _ctrl = [RSTF_RESPAWN_SELECT_layout, "list"] call ZUI_fnc_getControlById;
	private _row = lnbCurSelRow _ctrl;
	private _unit = RSTF_RESPAWN_SELECT_UNITS select _row;

	if (alive _unit || isPlayer _unit) then {
		[_unit, 0.5] spawn RSTF_fnc_assignPlayer;
		([RSTF_RESPAWN_SELECT_layout] call ZUI_fnc_display) closeDisplay 0;
	} else {
		call RSTF_fnc_refreshRespawnSelect;
	};
}] call ZUI_fnc_on;

private _spawnCtrl = [RSTF_RESPAWN_SELECT_layout, "respawn"] call ZUI_fnc_getControlById;
ctrlSetFocus _spawnCtrl;

call RSTF_fnc_refreshRespawnSelect;