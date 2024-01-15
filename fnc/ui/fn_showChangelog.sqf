private _changelog = call RSTF_fnc_getLastChangelog;
private _changelogId = _changelog select 0;
private _changelogText = _changelog select 1;
private _lastAccepted = profileNamespace getVariable ["RSTF_LAST_CHANGELOG_SEEN", 0];

/*if (_lastAccepted >= _changelogId) exitWith {
	0 spawn RSTF_fnc_showModeSelector;
};*/

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM camCommit 0;

RSTF_CHANGELOG_layout = [missionConfigFile >> "ChangelogDialog"] call ZUI_fnc_createDisplay;

private _display = [RSTF_CHANGELOG_layout] call ZUI_fnc_display;
_display displayAddEventHandler ["Unload", {
	0 spawn RSTF_fnc_showModeSelector;
}];

private _confirmButton = [RSTF_CHANGELOG_layout, 'confirm'] call ZUI_fnc_getControlById;
private _bodyText = [RSTF_CHANGELOG_layout, 'text'] call ZUI_fnc_getControlById;

_bodyText ctrlSetStructuredText parseText(_changelogText);
_confirmButton ctrlAddEventHandler ["ButtonClick", {
	private _changelog = call RSTF_fnc_getLastChangelog;
	profileNamespace setVariable ["RSTF_LAST_CHANGELOG_SEEN", _changelog select 0];
	[RSTF_CHANGELOG_layout] call ZUI_fnc_closeDisplay;
}];
