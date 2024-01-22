#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

private _parent = param [0, displayNull];
private _ingame = param [1, false];

if (isNull(_parent)) then {
	_parent = findDisplay 46;
};

RSTF_ADVANCED_CONFIG_DISPLAY = [_parent createDisplay "RSTF_RscDialogAdvancedConfig"];
RSTF_ADVANCED_CONFIG_INGAME = _ingame;

RSTF_ADVANCED_LASTCATEGORIES = [];

_saveButton = ["RSTF_RscDialogAdvancedConfig", "saveButton"] call RSTF_fnc_getCtrl;
_saveButton ctrlAddEventHandler ["ButtonClick", {
	call RSTF_fnc_saveAdvancedOptions;
	RSTF_ADVANCED_LASTOPTIONS = [];
	call RSTF_fnc_profileSave;
	call RSTF_fnc_syncServerOptions;

	if (!RSTF_ADVANCED_CONFIG_INGAME) then {
		call RSTF_fnc_updateMainConfigScreen;
	} else {
		if (RSTF_DEATH_SHOWN) then {
			0 spawn RSTF_fnc_deathUpdate;
			0 spawn RSTF_fnc_updateOverlay;
		};
	};

	RSTF_ADVANCED_CONFIG_DISPLAY#0 closeDisplay 0;
	RSTF_ADVANCED_CONFIG_DISPLAY = [];
}];


_resetButton = ["RSTF_RscDialogAdvancedConfig", "resetButton"] call RSTF_fnc_getCtrl;
_resetButton ctrlShow !RSTF_ADVANCED_CONFIG_INGAME;
_resetButton ctrlAddEventHandler ["ButtonClick", {
	0 spawn {
		if (["Do you really want to reset all configuration to default values?", "Reset", "Yes", "No", RSTF_ADVANCED_CONFIG_DISPLAY#0] call BIS_fnc_GUImessage) then {
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
private _defaultCategory = "General";
private _onlyClient = isMultiplayer && !isServer && (admin clientOwner) == 0;

if (_onlyClient) then {
	_defaultCategory = "Player";
};

[_defaultCategory, true] spawn RSTF_fnc_showAdvancedOptions;
