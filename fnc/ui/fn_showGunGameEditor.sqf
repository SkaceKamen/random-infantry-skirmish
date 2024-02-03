private _parent = (RSTF_ADVANCED_CONFIG_DISPLAY#0) createDisplay "RscDisplayEmpty";

RSTF_GUN_GAME_EDITOR_layout = [missionConfigFile >> "GunGameEditorDialog", _parent] call ZUI_fnc_createDisplay;
RSTF_GUN_GAME_EDITOR_WEAPONS = RSTF_MODE_GUN_GAME_CUSTOM_WEAPONS;

private _display = [RSTF_GUN_GAME_EDITOR_layout] call ZUI_fnc_display;
private _ctrl = [RSTF_GUN_GAME_EDITOR_layout, "add"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	0 spawn RSTF_fnc_showGunGameEditorWeaponPick;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "remove"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	private _ctrl = [RSTF_GUN_GAME_EDITOR_layout, "weapons"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index == -1) exitWith {};

	RSTF_GUN_GAME_EDITOR_WEAPONS deleteAt _index;
	call RSTF_fnc_updateGunGameEditor;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "up"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	private _ctrl = [RSTF_GUN_GAME_EDITOR_layout, "weapons"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index == -1) exitWith {};

	if (_index > 0) then {
		private _weapon = RSTF_GUN_GAME_EDITOR_WEAPONS select _index;
		RSTF_GUN_GAME_EDITOR_WEAPONS set [_index, RSTF_GUN_GAME_EDITOR_WEAPONS select (_index - 1)];
		RSTF_GUN_GAME_EDITOR_WEAPONS set [_index - 1, _weapon];
		call RSTF_fnc_updateGunGameEditor;
		_ctrl lnbSetCurSelRow (_index - 1);
	};
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "down"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	private _ctrl = [RSTF_GUN_GAME_EDITOR_layout, "weapons"] call ZUI_fnc_getControlById;
	private _index = lnbCurSelRow _ctrl;
	if (_index == -1) exitWith {};

	if (_index < count RSTF_GUN_GAME_EDITOR_WEAPONS - 1) then {
		private _weapon = RSTF_GUN_GAME_EDITOR_WEAPONS select _index;
		RSTF_GUN_GAME_EDITOR_WEAPONS set [_index, RSTF_GUN_GAME_EDITOR_WEAPONS select (_index + 1)];
		RSTF_GUN_GAME_EDITOR_WEAPONS set [_index + 1, _weapon];
		call RSTF_fnc_updateGunGameEditor;
		_ctrl lnbSetCurSelRow (_index + 1);
	};
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "cancel"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	RSTF_GUN_GAME_EDITOR_WEAPONS = [];
	[RSTF_GUN_GAME_EDITOR_layout] call ZUI_fnc_closeDisplay;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "save"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	RSTF_MODE_GUN_GAME_CUSTOM_WEAPONS = RSTF_GUN_GAME_EDITOR_WEAPONS;
	RSTF_GUN_GAME_EDITOR_WEAPONS = [];
	[RSTF_GUN_GAME_EDITOR_layout] call ZUI_fnc_closeDisplay;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "random"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	private _weapons = "getNumber(_x >> 'scope') == 2 && (getNumber(_x >> 'type') == 1 || getNumber(_x >> 'type') == 2)" configClasses (configFile >> "CfgWeapons");
	_weapons = _weapons call BIS_fnc_arrayShuffle;

	for[{_i = 0},{_i < 5 && count(_weapons) > 0},{_i = _i + 1}] do {
		private _item = configName(_weapons call BIS_fnc_arrayPop);
		if (RSTF_GUN_GAME_EDITOR_WEAPONS find _item == -1) then {
			RSTF_GUN_GAME_EDITOR_WEAPONS pushBack _item;
		} else {
			_i = _i - 1;
		};
	};

	call RSTF_fnc_updateGunGameEditor;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "clear"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	RSTF_GUN_GAME_EDITOR_WEAPONS = [];
	call RSTF_fnc_updateGunGameEditor;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "savePreset"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	["show", "save"] call RSTF_fnc_gunGamePresetDialog;
}];

_ctrl = [RSTF_GUN_GAME_EDITOR_layout, "loadPreset"] call ZUI_fnc_getControlById;
_ctrl ctrlAddEventHandler ["ButtonClick", {
	["show", "load"] call RSTF_fnc_gunGamePresetDialog;
}];

call RSTF_fnc_updateGunGameEditor;