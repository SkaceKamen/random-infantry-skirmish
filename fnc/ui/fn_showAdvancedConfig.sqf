#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

_ok = createDialog "RSTF_RscDialogAdvancedConfig";

if (!_ok) exitWith {
	systemChat "Failed to open advanced config dialog.";
};


_display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
_categoriesContainer = ["RSTF_RscDialogAdvancedConfig", "categoriesContainer"] call RSTF_fnc_getCtrl;

_idc = 1000;
_yy = 0;
{
	_category = _x select 0;
	_options = _x select 1;

	_ctrl = _display ctrlCreate ["RscButton", _idc, _categoriesContainer];
	_ctrl ctrlSetText _category;
	_ctrl ctrlSetPosition [0, _yy, RSTF_ADV_CAT_W - 0.005, 0.1];
	_ctrl ctrlCommit 0;
	_ctrl ctrlAddEventHandler ["ButtonClick", format["%1 spawn RSTF_fnc_showAdvancedOptions", _foreachIndex]];

	_idc = _idc + 1;
	_yy = _yy + 0.105;
} foreach RSTF_CONFIG_VALUES;

_saveButton = ["RSTF_RscDialogAdvancedConfig", "saveButton"] call RSTF_fnc_getCtrl;
_saveButton ctrlAddEventHandler ["ButtonClick", {
	call RSTF_fnc_profileSave;
	call RSTF_fnc_updateEquipment;
	closeDialog 0;
}];

_resetButton = ["RSTF_RscDialogAdvancedConfig", "resetButton"] call RSTF_fnc_getCtrl;
_resetButton ctrlAddEventHandler ["ButtonClick", {
	0 spawn {
		if (["Do you really want to reset all configuration to default values?", "Reset", "Yes", "No"] call BIS_fnc_GUImessage) then {
			call RSTF_fnc_profileReset;
			closeDialog 0;
			sleep 0.5;
			call RSTF_fnc_showAdvancedConfig;
		};
	};
}];

0 spawn RSTF_fnc_showAdvancedOptions;