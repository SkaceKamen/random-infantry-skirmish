disableSerialization;

if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM camCommit 0;

_display = ["RSTF_RscDialogConfig", RSTF_fnc_showConfig] call RSTF_fnc_spawnDialog;
if (typeName(_display) == typeName(false) && { !_display }) then {
	call RSTF_fnc_start;
};

RSTF_FACTIONS = [];
_root = configFile >> "cfgFactionClasses";
for[{_i = 0},{_i < count(_root)},{_i = _i + 1}] do {
	_c = _root select _i;
	if (isClass(_c)) then {
		_side = getNumber(_c >> "side");
		if (_side >= 0 && _side <= 2) then {
			RSTF_FACTIONS = RSTF_FACTIONS + [configName(_c)];
		};
	};
};

call RSTF_fnc_profileLoad;

_template = '
	[%2, {
		%2 = _this;
		["%1", %2] call RSTF_fnc_configUpdateFactions;
	}] spawn RSTF_fnc_showFactions;
';

{
	_ctrl = ["RSTF_RscDialogConfig", "edit", ["controls", _x select 0, "controls"]] call RSTF_fnc_getCtrl;
	_ctrl ctrlAddEventHandler ["ButtonClick", compile(format[_template,_x select 0,_x select 1])];
	call compile format['["%1", %2] call RSTF_fnc_configUpdateFactions',_x select 0,_x select 1];
} foreach [
	["sideFriendly", "FRIENDLY_FACTIONS"],
	["sideNeutral", "NEUTRAL_FACTIONS"],
	["sideEnemy", "ENEMY_FACTIONS"]
];

_ctrl = ["RSTF_RscDialogConfig", "weaponButton"] call RSTF_fnc_getCtrl;
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

_ctrl = ["RSTF_RscDialogConfig", "configButton"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	[] spawn RSTF_fnc_showAdvancedConfig;
}];

_ctrl = ["RSTF_RscDialogConfig", "presetsButton"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	["RSTF_RscDialogConfig" call RSTF_fnc_getDisplay] spawn RSTFUI_fnc_showPresetDialog;
}];

call RSTF_fnc_updateEquipment;

_ctrl = ["RSTF_RscDialogConfig", "start"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	// Validate settings
	_errors = call RSTF_fnc_configValidate;
	if (count(_errors) > 0) exitWith {
		_message = "";
		{
			_message = _message + _x + "<br />";
		} foreach _errors;
		[parseText(_message), "Configuration error"] spawn BIS_fnc_GUImessage;
	};

	// Broadcast settings
	{
		// Skip values that should be player specific
		if (!(_x in RSTF_PRIVATE_PROFILE_VALUES)) then {
			publicVariable _x;
		};
	} foreach RSTF_PROFILE_VALUES;

	// Save config to profile namespace
	call RSTF_fnc_profileSave;

	// Load list of possible battles
	if (RSTF_MAP_VOTE) then {
		RSTF_POINTS = RSTF_MAP_VOTE_COUNT call RSTF_fnc_pickRandomPoints;
	} else {
		RSTF_POINTS = 1 call RSTF_fnc_pickRandomPoints;
	};

	// Fill votes array
	RSTF_POINT_VOTES = [];
	{
		RSTF_POINT_VOTES pushBack 0;
	} foreach RSTF_POINTS;

	// Stop if no battle was found
	if (count(RSTF_POINTS) == 0) exitWith {
		[parseText("No suitable location found on this map."), "Configuration error"] spawn BIS_fnc_GUImessage;
	};

	// Dispatch selected locations
	publicVariable "RSTF_POINTS";
	publicVariable "RSTF_POINT_VOTES";

	// Close config dialog
	closeDialog 0;

	// Start map selection if not dedicated
	if (RSTF_MAP_VOTE) then {
		0 spawn RSTF_fnc_startBattleSelection;
	} else {
		(RSTF_POINTS select 0) call RSTF_fnc_assignPoint;
		0 spawn RSTF_fnc_start;
	};

	// Show voting or start if voting is disabled
	RSTF_CONFIG_DONE = true;
	publicVariable "RSTF_CONFIG_DONE";
}];
