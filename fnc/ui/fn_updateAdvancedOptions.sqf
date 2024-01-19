#include "..\..\dialogs\advancedConfigDialog.inc"

private _padding = 0.05;
private _yy = _padding;
private _xx = _padding;
private _width = RSTF_ADV_OPS_W - _padding * 2;

{
	private _ctrl = _x select 0;
	private _label = _x select 1;
	private _config = _x select 5;
	private _type = getText(_config >> "type");

	if (_type == 'spacer') then {
		_yy = _yy + 0.05;
		continue;
	};

	private _disabledScript = if (isText(_config >> "disabled")) then { compile(getText(_config >> "disabled")) } else { false };
	private _visibleScript = if (isText(_config >> "visible")) then { compile(getText(_config >> "visible")) } else { false };
	private _shown = true;

	if (typeName(_disabledScript) != typeName(false)) then {
		_ctrl ctrlEnable !(call _disabledScript);
		_ctrl ctrlCommit 0;
	};

	if (typeName(_visibleScript) != typeName(false)) then {
		_shown = (call _visibleScript);
	};

	_label ctrlSetPosition [_xx, _yy, RSTF_ADV_OPS_W * 0.495 - _padding, 0.037];

	if (_type == "checkbox") then {
		_ctrl ctrlSetPosition [_xx + _width * 0.5, _yy - 0.002, 0.03, 0.03 * safeZoneW / safeZoneH];
	} else {
		_ctrl ctrlSetPosition [_xx + _width * 0.5, _yy, _width * 0.5, 0.04];
	};

	_ctrl ctrlShow _shown;
	_ctrl ctrlCommit 0;
	_label ctrlShow _shown;
	_label ctrlCommit 0;

	if (_shown) then {
		_yy = _yy + 0.06;
	};
} foreach RSTF_ADVANCED_LASTOPTIONS;

private _display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
private _spacerCtrl = _display displayCtrl 6;

_spacerCtrl ctrlSetPosition [0, _yy, RSTF_ADV_OPS_W, 0.06];
_spacerCtrl ctrlCommit 0;
