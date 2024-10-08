disableSerialization;

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM camCommit 0;

if (RSTF_DEBUG_SKIP_CONFIG) exitWith {
	0 spawn RSTF_fnc_startBattle;
};

RSTF_MAIN_CONFIG_layout = [
	missionConfigFile >> "MainConfigDialog",
	displayNull,
	RSTF_fnc_showConfig,
	true
] call RSTF_fnc_spawnZUIDialog;

private _display = [RSTF_MAIN_CONFIG_layout] call ZUI_fnc_display;
if (typeName(_display) == typeName(false) && { !_display }) then {
	call RSTF_fnc_startBattle;
};

[RSTF_MAIN_CONFIG_layout, 0] call ZUI_fnc_fadeOut;

RSTF_FACTIONS = call RSTF_fnc_loadFactions;

call RSTF_fnc_profileLoad;

[RSTF_MAIN_CONFIG_layout, 0.3] call ZUI_fnc_fadeIn;

private _template = '
	[[RSTF_MAIN_CONFIG_layout] call ZUI_fnc_display, %2, {
		%2 = _this;
		["%1", %2] call RSTF_fnc_configUpdateFactions;
	}] spawn RSTF_fnc_showFactions;
';

{
	private _buttonName = (_x select 0) + "Edit";
	private _listName = (_x select 0) + "List";

	private _ctrl = [RSTF_MAIN_CONFIG_layout, _buttonName] call ZUI_fnc_getControlById;
	_ctrl ctrlAddEventHandler ["ButtonClick", compile(format[_template,_x select 0,_x select 1])];
	call compile format['["%1", %2] call RSTF_fnc_configUpdateFactions',_x select 0,_x select 1];
	
	_ctrl = [RSTF_MAIN_CONFIG_layout, _listName] call ZUI_fnc_getControlById;
	_ctrl ctrlEnable false;
} foreach [
	["friendly", "FRIENDLY_FACTIONS"],
	["neutral", "NEUTRAL_FACTIONS"],
	["enemy", "ENEMY_FACTIONS"]
];

private _ctrl = [RSTF_MAIN_CONFIG_layout, "pickEquipment"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	0 spawn {
		if (!RSTF_CUSTOM_EQUIPMENT) then {
			[parseText("This equipment will be applied only if you allow custom equipment in advanced configuration"), "Warning"] call BIS_fnc_GUImessage;
		};

		closeDialog 0;
		[false] spawn RSTF_fnc_showEquip;
	};
	true;
}];

_ctrl = [RSTF_MAIN_CONFIG_layout, "editConfig"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	[[RSTF_MAIN_CONFIG_layout] call ZUI_fnc_display] spawn RSTF_fnc_showAdvancedConfig;
}];

_ctrl = [RSTF_MAIN_CONFIG_layout, "showPresets"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	[[RSTF_MAIN_CONFIG_layout] call ZUI_fnc_display] spawn RSTFUI_fnc_showPresetDialog;
}];

_ctrl = [RSTF_MAIN_CONFIG_layout, "switchSides"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	private _enemyFactions = ENEMY_FACTIONS;
	ENEMY_FACTIONS = FRIENDLY_FACTIONS;
	FRIENDLY_FACTIONS = _enemyFactions;

	["friendly", FRIENDLY_FACTIONS] call RSTF_fnc_configUpdateFactions;
	["enemy", ENEMY_FACTIONS] call RSTF_fnc_configUpdateFactions;
}];
_ctrl ctrlSetTooltip "Switch friendly and enemy factions";

call RSTF_fnc_updateEquipment;

_ctrl = [RSTF_MAIN_CONFIG_layout, "start"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	// Validate settings
	_errors = call RSTF_fnc_configValidate;
	if (count(_errors) > 0) exitWith {
		_message = "";
		{
			_message = _message + _x + "<br />";
		} foreach _errors;
		[parseText(_message), "Configuration error", true, false, [RSTF_MAIN_CONFIG_layout] call ZUI_fnc_display] spawn BIS_fnc_GUImessage;
	};

	// Broadcast settings	
	call RSTF_fnc_syncServerOptions;

	// Save config to profile namespace
	call RSTF_fnc_profileSave;

	// Load list of possible battles
	if (RSTF_MAP_VOTE) then {
		RSTF_POINTS = RSTF_MAP_VOTE_COUNT call RSTF_fnc_pickRandomPoints;
	} else {
		RSTF_POINTS = 1 call RSTF_fnc_pickRandomPoints;
	};

	RSTF_CUSTOM_POINT = (RSTF_POINTS#0)#0#1;
	RSTF_CUSTOM_POINT_SPAWNS = (RSTF_POINTS#0)#1;
	RSTF_CUSTOM_DIRECTION = (RSTF_POINTS#0)#2;
	RSTF_CUSTOM_DISTANCE = (RSTF_POINTS#0)#3;

	// Fill votes array
	RSTF_POINT_VOTES = [];
	{
		RSTF_POINT_VOTES pushBack 0;
	} foreach RSTF_POINTS;

	RSTF_POINT_VOTES pushBack 0 ;

	// Stop if no battle was found
	if (count(RSTF_POINTS) == 0) exitWith {
		[parseText("No suitable location found on this map."), "Configuration error"] spawn BIS_fnc_GUImessage;
	};

	// Dispatch selected locations
	publicVariable "RSTF_POINTS";
	publicVariable "RSTF_POINT_VOTES";

	// Close config dialog
	([RSTF_MAIN_CONFIG_layout] call ZUI_fnc_display) closeDisplay 0;

	// Start map selection if not dedicated
	if (RSTF_MAP_VOTE) then {
		0 spawn RSTF_fnc_startBattleSelection;
	} else {
		(RSTF_POINTS select 0) call RSTF_fnc_assignPoint;
		0 spawn RSTF_fnc_startBattle;
	};

	// Show voting or start if voting is disabled
	RSTF_CONFIG_DONE = true;
	publicVariable "RSTF_CONFIG_DONE";
}];
ctrlSetFocus _ctrl;

call RSTF_fnc_updateMainConfigScreen;
