#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

private _parent = param [0, displayNull];

RSTF_ADVANCED_CONFIG_DISPLAY = [_parent createDisplay "RSTF_RscDialogAdvancedConfig"];

RSTF_ADVANCED_LASTCATEGORIES = [];

_saveButton = ["RSTF_RscDialogAdvancedConfig", "saveButton"] call RSTF_fnc_getCtrl;
_saveButton ctrlAddEventHandler ["ButtonClick", {
	call RSTF_fnc_saveAdvancedOptions;
	RSTF_ADVANCED_LASTOPTIONS = [];
	call RSTF_fnc_profileSave;
	call RSTF_fnc_updateMainConfigScreen;
	RSTF_ADVANCED_CONFIG_DISPLAY#0 closeDisplay 0;
	RSTF_ADVANCED_CONFIG_DISPLAY = [];
}];

_resetButton = ["RSTF_RscDialogAdvancedConfig", "resetButton"] call RSTF_fnc_getCtrl;
_resetButton ctrlAddEventHandler ["ButtonClick", {
	0 spawn {
		if (["Do you really want to reset all configuration to default values?", "Reset", "Yes", "No"] call BIS_fnc_GUImessage) then {
			RSTF_ADVANCED_LASTOPTIONS = [];
			call RSTF_fnc_profileReset;
			RSTF_ADVANCED_CONFIG_DISPLAY#0 closeDisplay 0;
			RSTF_ADVANCED_CONFIG_DISPLAY = [];
			sleep 0.5;
			call RSTF_fnc_showAdvancedConfig;
		};
	};
}];

private _config = missionConfigFile >> "RSTF_Options";
private _categories = "true" configClasses _config;
[configName(_categories select 0), true] spawn RSTF_fnc_showAdvancedOptions;
