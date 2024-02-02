private _action = param [0];

switch (_action) do {
	case "show": {
		private _action = param [1, "load"];
		private _parent = ([RSTF_GUN_GAME_EDITOR_layout] call ZUI_fnc_display) createDisplay "RscDisplayEmpty";

		RSTF_GUN_GAME_EDITOR_PRESET_layout = [missionConfigFile >> "GunGameEditorPresetDialog", _parent] call ZUI_fnc_createDisplay;
		RSTF_GUN_GAME_EDITOR_PRESETS = [profileNamespace getVariable ["RSTF_GUN_GAME_EDITOR_PRESETS", []], [], { _x#0 }] call BIS_fnc_sortBy;

		[RSTF_GUN_GAME_EDITOR_PRESET_layout, "presets", "LBSelChanged", {
			private _index = param [1];
			private _item = RSTF_GUN_GAME_EDITOR_PRESETS select _index;

			private _ctrl = [RSTF_GUN_GAME_EDITOR_PRESET_layout, "name"] call ZUI_fnc_getControlById;
			_ctrl ctrlSetText (_item#0);

			_ctrl = [RSTF_GUN_GAME_EDITOR_PRESET_layout, "detail"] call ZUI_fnc_getControlById;
			_ctrl ctrlSetStructuredText parseText((_item#1 apply {
				private _config = configFile >> "CfgWeapons" >> _x;
				private _name = if (isClass(_config)) then { getText(_config >> "displayName") } else { "MISSING: " + _x };
				private _image = if (isClass(_config)) then { getText(_config >> "picture") } else { "" };

				format ["<img image='%2' /> %1", _name, _image];
			}) joinString '<br/>');
		}] call ZUI_fnc_on;

		[RSTF_GUN_GAME_EDITOR_PRESET_layout, "remove", "ButtonClick", {
			["removeSelected"] call RSTF_fnc_gunGamePresetDialog;
		}] call ZUI_fnc_on;

		[RSTF_GUN_GAME_EDITOR_PRESET_layout, "cancel", "ButtonClick", {
			["cancel"] call RSTF_fnc_gunGamePresetDialog;
		}] call ZUI_fnc_on;

		[RSTF_GUN_GAME_EDITOR_PRESET_layout, "save", "ButtonClick", {
			["save"] call RSTF_fnc_gunGamePresetDialog;
		}] call ZUI_fnc_on;

		[RSTF_GUN_GAME_EDITOR_PRESET_layout, "load", "ButtonClick", {
			["load"] call RSTF_fnc_gunGamePresetDialog;
		}] call ZUI_fnc_on;

		if (_action == 'load') then {
			[RSTF_GUN_GAME_EDITOR_PRESET_layout, "save"] call ZUI_fnc_destroyChild;
			[RSTF_GUN_GAME_EDITOR_PRESET_layout, "input"] call ZUI_fnc_destroyChild;
		} else {
			[RSTF_GUN_GAME_EDITOR_PRESET_layout, "load"] call ZUI_fnc_destroyChild;
		};

		"Refresh after visibility change" call RSTF_fnc_dbg;

		[RSTF_GUN_GAME_EDITOR_PRESET_layout, safeZoneW, safeZoneH, safeZoneX, safeZoneY] call ZUI_fnc_refresh;

		["update"] call RSTF_fnc_gunGamePresetDialog;
	};

	case "update": {
		private _ctrl = [RSTF_GUN_GAME_EDITOR_PRESET_layout, "presets"] call ZUI_fnc_getControlById;

		lnbClear _ctrl;

		{
			private _name = _x#0;
			private _missing = _x#1 select { !isClass(configFile >> "CfgWeapons" >> _x) };
			private _weapons = str(count(_x#1)) + " weapons";
			if (count(_missing) > 0) then {
				_weapons = _weapons + " (" + str(count(_missing)) + " missing)"
			};

			private _row = _ctrl lnbAddRow [_name, _weapons];

			if (count(_missing) > 0) then {
				_row lnbSetColor [[_row, 1], [1, 0, 0, 1]];
			};
		} forEach RSTF_GUN_GAME_EDITOR_PRESETS;
	};

	case "cancel": {
		["close"] call RSTF_fnc_gunGamePresetDialog;
	};

	case "save": {
		private _name = ctrlText ([RSTF_GUN_GAME_EDITOR_PRESET_layout, "name"] call ZUI_fnc_getControlById);
		private _existingIndex = RSTF_GUN_GAME_EDITOR_PRESETS findIf { _x#0 == _name };
		private _item = [_name, RSTF_GUN_GAME_EDITOR_WEAPONS];

		if (_existingIndex >= 0) then {
			RSTF_GUN_GAME_EDITOR_PRESETS set [_existingIndex, _item];
		} else {
			RSTF_GUN_GAME_EDITOR_PRESETS pushBack _item;
		};

		profileNamespace setVariable ["RSTF_GUN_GAME_EDITOR_PRESETS", RSTF_GUN_GAME_EDITOR_PRESETS];

		["close"] call RSTF_fnc_gunGamePresetDialog;
	};

	case "load": {
		private _ctrl = [RSTF_GUN_GAME_EDITOR_LOAD_PRESET_layout, "presets"] call ZUI_fnc_getControlById;
		private _row = lnbCurSelRow _ctrl;

		if (_row >= 0) then {
			RSTF_GUN_GAME_EDITOR_WEAPONS = (RSTF_GUN_GAME_EDITOR_PRESETS select _row) select 1;
			["close"] call RSTF_fnc_gunGamePresetDialog;
			call RSTF_fnc_updateGunGameEditor;
		};
	};

	case "removeSelected": {
		private _ctrl = [RSTF_GUN_GAME_EDITOR_PRESET_layout, "presets"] call ZUI_fnc_getControlById;
		private _row = lnbCurSelRow _ctrl;

		if (_row >= 0) then {
			RSTF_GUN_GAME_EDITOR_PRESETS deleteAt _row;
			profileNamespace setVariable ["RSTF_GUN_GAME_EDITOR_PRESETS", RSTF_GUN_GAME_EDITOR_PRESETS];
			["update"] call RSTF_fnc_gunGamePresetDialog;
		};
	};

	case "close": {
		[RSTF_GUN_GAME_EDITOR_PRESET_layout] call ZUI_fnc_closeDisplay;
		RSTF_GUN_GAME_EDITOR_PRESET_layout = [];
	};

	default {
		systemChat format ["Unknown action: %1", _action];
	};
};
