disableSerialization;

RSTF_CAM = "camera" camCreate RSTF_CAM_TARGET;
RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM camCommit 0;

_ok = createDialog "RSTF_RscDialogConfig";
if (!_ok) exitWith {
	systemChat "Fatal error. Couldn't create config dialog.";
	call RSTF_fnc_start;
};

_display = findDisplay getNumber(missionConfigFile >> "RSTF_RscDialogConfig" >> "idd");

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
	closeDialog 0;
	[false] spawn RSTF_fnc_showEquip;
	true;
}];

_ctrl = ["RSTF_RscDialogConfig", "configButton"] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	[] spawn RSTF_fnc_showAdvancedConfig;
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
		publicVariable ("RSTF_" + _x);
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

	// Close config dialog
	closeDialog 1;

	// Show voting or start if voting is disabled
	if (RSTF_MAP_VOTE) then {
		0 spawn RSTF_fnc_startBattleSelection;
	} else {
		(RSTF_POINTS select 0) call RSTF_fnc_assignPoint;
		0 spawn RSTF_fnc_start;
	}
}];