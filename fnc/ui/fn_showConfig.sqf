disableSerialization;

call RSTF_fnc_randomPoint;

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