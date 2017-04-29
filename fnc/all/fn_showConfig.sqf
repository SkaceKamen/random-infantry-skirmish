disableSerialization;

call RSTF_fnc_randomPoint;

if (isMultiplayer) then {
	sleep 1;
};

waitUntil { time > 0 };
showCinemaBorder false;

publicVariable "RSTF_POINT";

RSTF_CAM = "camera" camCreate RSTF_CAM_TARGET;
RSTF_CAM camSetTarget RSTF_CAM_TARGET;
RSTF_CAM cameraEffect ["internal", "back"];
RSTF_CAM camCommit 0;
RSTF_CAM camSetRelPos [3, 3, 2];
RSTF_CAM camCommit 0;

/*
if (true) exitWith {
	call RSTF_fnc_loadWeapons;
	call RSTF_fnc_loadClasses;
	call RSTF_fnc_showEquip;
};
*/

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

/*
_ctrl = _display displayCtrl getNumber(missionConfigFile >> "RSTF_RscDialogConfig" >> "controls" >> "LABEL_LOADING" >> "idc");
_ctrl ctrlShow false;
*/

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


//Game config
_ctrl = ["RSTF_RscDialogConfig", "scoreLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_SCORE_LIMIT);

_ctrl = ["RSTF_RscDialogConfig", "scorePerKill", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_SCORE_PER_KILL);

_ctrl = ["RSTF_RscDialogConfig", "scorePerTask", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_SCORE_PER_TASK);

_ctrl = ["RSTF_RscDialogConfig", "groupsLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_LIMIT_GROUPS);

_ctrl = ["RSTF_RscDialogConfig", "unitsLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_LIMIT_UNITS);

_ctrl = ["RSTF_RscDialogConfig", "neutralsLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_NEUTRALS_GROUPS);

_ctrl = ["RSTF_RscDialogConfig", "spawnTime", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetText str(RSTF_LIMIT_SPAWN);


//Spawn config
_ctrl = ["RSTF_RscDialogConfig", "spawnType", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
lbClear _ctrl;
{
	_ctrl lbAdd _x;
} foreach RSTF_SPAWN_TYPES;
_ctrl lbSetCurSel RSTF_SPAWN_TYPE;

_ctrl = ["RSTF_RscDialogConfig", "randomizeWeapons", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetChecked RSTF_RANDOMIZE_WEAPONS;

_ctrl = ["RSTF_RscDialogConfig", "restrictWeapons", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetChecked RSTF_RANDOMIZE_WEAPONS_RESTRICT;

_ctrl = ["RSTF_RscDialogConfig", "enableCustom", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetChecked RSTF_CUSTOM_EQUIPMENT;

_ctrl = ["RSTF_RscDialogConfig", "changeCustom", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	_ctrl = ["RSTF_RscDialogConfig", "restrictWeapons", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_RANDOMIZE_WEAPONS_RESTRICT = ctrlChecked _ctrl;

	call RSTF_fnc_loadWeapons;
	call RSTF_fnc_loadClasses;
	[] spawn RSTF_fnc_showEquip;
	true;
}];

//Misc config
_ctrl = ["RSTF_RscDialogConfig", "clearDeadBodies", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlSetChecked RSTF_CLEAN;

_ctrl = ["RSTF_RscDialogConfig", "weather", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
lbClear _ctrl;
{
	_ctrl lbAdd _x;
} foreach RSTF_WEATHER_TYPES;
_ctrl lbSetCurSel RSTF_WEATHER;

_ctrl = ["RSTF_RscDialogConfig", "time", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
lbClear _ctrl;
{
	_ctrl lbAdd _x;
} foreach RSTF_TIME_TYPES;
_ctrl lbSetCurSel RSTF_TIME;


/*_ctrl = ["RSTF_RscDialogConfig", "switchIsland", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	//'Altis' spawn RSTF_fnc_switchIsland;
	[] spawn RSTF_fnc_mapsShow;
}];*/

_ctrl = ["RSTF_RscDialogConfig", "reset", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	[] spawn {
		if (["Do you really want to reset all configuration to default values?", "Reset", "Yes", "No"] call BIS_fnc_GUImessage) then {
			call RSTF_fnc_profileReset;
			closeDialog 0;
			sleep 0.5;
			call RSTF_fnc_showConfig;
		};
	};
}];

_ctrl = ["RSTF_RscDialogConfig", "start", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	disableSerialization;

	_errors = call RSTF_fnc_configValidate;
	if (count(_errors) > 0) exitWith {
		_message = "";
		{
			_message = _message + _x + "<br />";
		} foreach _errors;
		[parseText(_message), "Configuration error"] spawn BIS_fnc_GUImessage;
	};

	_display = findDisplay getNumber(missionConfigFile >> "RSTF_RscDialogConfig" >> "idd");

	_ctrl = ["RSTF_RscDialogConfig", "scoreLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_SCORE_LIMIT = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "scorePerKill", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_SCORE_PER_KILL = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "scorePerTask", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_SCORE_PER_TASK = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "groupsLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_LIMIT_GROUPS = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "unitsLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_LIMIT_UNITS = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "neutralsLimit", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_NEUTRALS_GROUPS = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "spawnTime", ["controls", "gameConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_LIMIT_SPAWN = parseNumber(ctrlText _ctrl);

	_ctrl = ["RSTF_RscDialogConfig", "randomizeWeapons", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_RANDOMIZE_WEAPONS = ctrlChecked _ctrl;

	_ctrl = ["RSTF_RscDialogConfig", "restrictWeapons", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_RANDOMIZE_WEAPONS_RESTRICT = ctrlChecked _ctrl;

	_ctrl = ["RSTF_RscDialogConfig", "spawnType", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_SPAWN_TYPE = lbCurSel _ctrl;

	_ctrl = ["RSTF_RscDialogConfig", "enableCustom", ["controls", "spawnConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_CUSTOM_EQUIPMENT = ctrlChecked _ctrl;

	_ctrl = ["RSTF_RscDialogConfig", "clearDeadBodies", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_CLEAN = ctrlChecked _ctrl;

	_ctrl = ["RSTF_RscDialogConfig", "weather", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_WEATHER = lbCurSel _ctrl;

	_ctrl = ["RSTF_RscDialogConfig", "time", ["controls", "otherConfig", "controls"]] call RSTF_fnc_getCtrl;
	RSTF_TIME = lbCurSel _ctrl;

	/*
	_ctrl = _display displayCtrl getNumber(missionConfigFile >> "RSTF_RscDialogConfig" >> "controls" >> "LABEL_LOADING" >> "idc");
	_ctrl ctrlShow true;
	*/

	// Broadcast settings
	{
		publicVariable ("RSTF_" + _x);
	} foreach RSTF_PROFILE_VALUES;

	call RSTF_fnc_profileSave;

	//if (RSTF_SELECTED_WORLD != worldName) then {
	//	RSTF_SELECTED_WORLD spawn RSTF_fnc_switchIsland;
	//} else {
		closeDialog 1;
		[] spawn RSTF_fnc_start;
	//};

	/*
	_currentWorld = configFile >> "cfgWorlds" >> worldName;
	if (_currentWorld != _world) then {
		playScriptedMission [
			configName(_world),
			{
				private["_handle"];

				RSTF_SKIP_CONFIG = true;
				_handle = execVM "init.sqf";
			}
		];
		closeDialog 1;
	} else {
		closeDialog 1;
		call RSTF_fnc_start;
	};
	*/
}];