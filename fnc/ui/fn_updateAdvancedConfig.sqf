#include "..\..\dialogs\advancedConfigDialog.inc"

private _display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
private _categoriesContainer = ["RSTF_RscDialogAdvancedConfig", "categoriesContainer"] call RSTF_fnc_getCtrl;

{
	ctrlDelete _x;
	_x ctrlCommit 0;
} forEach RSTF_ADVANCED_LASTCATEGORIES;
RSTF_ADVANCED_LASTCATEGORIES = [];

private _config = missionConfigFile >> "RSTF_Options";
private _categories = "true" configClasses _config;
private _idc = 1000;
private _yy = 0;
{
	private _category = configName _x;
	private _title = getText(_x >> "title");
	private _visible = true;
	if (isText(_x >> "visible")) then {
		_visible = call(compile(getText(_x >> "visible")));
	};

	if (_visible) then {
		private _ctrl = _display ctrlCreate ["RscButton", _idc, _categoriesContainer];
		_ctrl ctrlSetText _title;
		_ctrl ctrlSetPosition [0, _yy, RSTF_ADV_CAT_W - 0.005, 0.08];
		_ctrl ctrlCommit 0;
		_ctrl ctrlAddEventHandler ["ButtonClick", format["[""%1""] spawn RSTF_fnc_showAdvancedOptions", _category]];

		RSTF_ADVANCED_LASTCATEGORIES pushBack _ctrl;

		_idc = _idc + 1;
		_yy = _yy + 0.085;
	};
} foreach _categories;
