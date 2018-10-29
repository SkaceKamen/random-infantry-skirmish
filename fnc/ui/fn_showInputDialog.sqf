disableSerialization;

private _parent = param [0];
private _title = param [1];
private _onOk = param [2];
private _onCancel = param [3];

RSTFUI_INPUT_OK = _onOk;
RSTFUI_INPUT_CANCEL = _onCancel;

private _layout = [missionConfigFile >> "InputDialog", _parent] call ZUI_fnc_createDisplay;
RSTFUI_INPUT_LAYOUT = _layout;

([_layout, "title"] call ZUI_fnc_getControlById) ctrlSetText _title;

[_layout, "ok", "ButtonClick", {
	private _input = [RSTFUI_INPUT_LAYOUT, "input"] call ZUI_fnc_getControlById;
	private _text = (ctrlText _input);
	[RSTFUI_INPUT_LAYOUT] call ZUI_fnc_closeDisplay;
	_text call RSTFUI_INPUT_OK;
}] call ZUI_fnc_on;

[_layout, "cancel", "ButtonClick", {
	[RSTFUI_INPUT_LAYOUT] call ZUI_fnc_closeDisplay;
	call RSTFUI_INPUT_CANCEL;
}] call ZUI_fnc_on;

ctrlSetFocus ([_layout, "input"] call ZUI_fnc_getControlById);

