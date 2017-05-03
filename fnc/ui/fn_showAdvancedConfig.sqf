#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

_ok = createDialog "RSTF_RscDialogAdvancedConfig";

if (!_ok) exitWith {
	systemChat "Failed to open advanced config dialog.";
};


RSTF_CHARS_NUMBERS = (toArray "0123456789");
RSTF_advancedConfig_lastOptions = [];
RSTF_advancedConfig = [
	["Game", [
		["RSTF_SCORE_LIMIT", "Score to win", "One side wins after reaching this limit.", "number"],
		["RSTF_SCORE_PER_KILL", "Score per kill", "Score you get for killing soldier.", "number"],
		["RSTF_SCORE_PER_TASK", "Score per task", "Score you get for completing task.", "number"],
		[],
		["RSTF_LIMIT_GROUPS", "Groups per side", "Number of groups spawned for each side.", "number"],
		["RSTF_LIMIT_UNITS", "Units per group", "Number of soldiers in single group.", "number"],
		["RSTF_NEUTRALS_GROUPS", "Neutral groups", "Maximum number of neutral groups spawned.", "number"],
		[],
		["RSTF_LIMIT_SPAWN", "Wave spawn time", "Interval in seconds in which reinforcements are spawned", "number"]
	]],
	["Spawning", [
		["RSTF_SPAWN_TYPE", "Spawn to", "How to select unit to spawn to. Closest - unit closest to your death, Group - unit in your group, Random - random unit", "select", RSTF_SPAWN_TYPES],
		["RSTF_RANDOMIZE_WEAPONS", "Randomize weapons", "Each soldier will be given random weapon.", "checkbox"],
		["RSTF_RANDOMIZE_WEAPONS_RESTRICT", "Restrict weapons to sides", "When weapons are randomized, only use weapons that origins from unit faction. (Useful for mods).", "checkbox"],
		["RSTF_CUSTOM_EQUIPMENT", "Enable custom equipment", "Enable player to customize his equipment, which will be used when switching to soldier.", "checkbox"]
	]],
	["Other", [
		["RSTF_CLEAN", "Clear dead bodies", "Dead bodies will be destroyed after 3 minutes. This helps performance.", "checkbox"],
		["RSTF_WEATHER", "Weather", "Mission weather.", "select", RSTF_WEATHER_TYPES],
		["RSTF_TIME", "Daytime", "Mission daytime.", "select", RSTF_TIME_TYPES]
	]]
];

RSTF_categoryChanged = {
	disableSerialization;
	
	_display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
	_optionsContainer = ["RSTF_RscDialogAdvancedConfig", "optionsContainer"] call RSTF_fnc_getCtrl;

	_options = (RSTF_advancedConfig select _this) select 1;

	// Clear previous options
	{
		_ctrl = _x select 0;
		_label = _x select 1;
		_type = _x select 2;
		_name = _x select 3;

		if (_type == "checkbox") then {
			missionNamespace setVariable [_name, cbChecked _ctrl];
		};

		if (_type == "number") then {
			missionNamespace setVariable [_name, parseNumber(ctrlText(_ctrl))];
		};

		if (_type == "select") then {
			missionNamespace setVariable [_name, lbCurSel(_ctrl)];
		};

		publicVariable _name;

		ctrlDelete _ctrl;
		ctrlDelete _label;
		_ctrl ctrlCommit 0;
		_label ctrlCommit 0;
	} foreach RSTF_advancedConfig_lastOptions;

	RSTF_advancedConfig_lastOptions = [];

	_padding = 0.05;
	_width = RSTF_ADV_OPS_W - _padding * 2;
	_idc = 2000;
	_yy = _padding;
	_xx = _padding;
	{
		if (count(_x) > 0) then {
			_name = _x select 0;
			_value = missionNamespace getVariable [_name, ""];

			_label = _display ctrlCreate ["RscText", _idc, _optionsContainer];
			_label ctrlSetText ((_x select 1) + ":");
			_label ctrlSetTooltip (_x select 2);
			_label ctrlSetPosition [_xx, _yy + 0.025 - 0.037/2, RSTF_ADV_OPS_W * 0.4, 0.037];
			_label ctrlCommit 0.1;

			_idc = _idc + 1;

			_ctrlType = "RscEdit";
			_type = _x select 3;
			switch (_type) do {
				case "checkbox": { _ctrlType = "RscCheckBox"; };
				case "select": { _ctrlType = "RscCombo"; };
			};

			_ctrl = _display ctrlCreate [_ctrlType, _idc, _optionsContainer];
			_ctrl ctrlSetText str(_value);
			_ctrl ctrlSetTooltip (_x select 2);
			
			if (_type == "checkbox") then {
				_ctrl ctrlSetPosition [_xx + _width * 0.5, _yy + 0.005, 0.04, 0.04 * safeZoneW / safeZoneH];

				if (typeName(_value) == typeName(true) && { _value }) then {
					_ctrl cbSetChecked true;
				};
			} else {
				_ctrl ctrlSetPosition [_xx + _width * 0.5, _yy, _width * 0.5, 0.05];
			};

			_ctrl ctrlCommit 0.1;

			if (_type == "select") then {
				_selectOptions = _x select 4;
				{
					_ctrl lbAdd _x;
					if (typeName(_value) == typeName(_foreachIndex) && { _foreachIndex == _value }) then {
						_ctrl lbSetCurSel _foreachIndex;
					};
				} foreach _selectOptions;
			};

			if (_type == "number") then {
				_ctrl ctrlAddEventHandler ["Char", {
					_handled = (RSTF_CHARS_NUMBERS find (_this select 1)) == -1;
					if (_handled) then {
						_this spawn {
							sleep 0.1;
							_updated = toString((toArray (ctrlText (_this select 0))) select { RSTF_CHARS_NUMBERS find _x >= 0 });
							(_this select 0) ctrlSetText _updated;
						};
					};

					_handled;
				}];
			};

			RSTF_advancedConfig_lastOptions pushBack [_ctrl, _label, _type, _name];
			_idc = _idc + 1;
		};
		_yy = _yy + 0.08;
	} foreach _options;
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
	_ctrl ctrlAddEventHandler ["ButtonClick", format["%1 spawn RSTF_categoryChanged", _foreachIndex]];

	_idc = _idc + 1;
	_yy = _yy + 0.105;
} foreach RSTF_advancedConfig;

_saveButton = ["RSTF_RscDialogAdvancedConfig", "saveButton"] call RSTF_fnc_getCtrl;
_saveButton ctrlAddEventHandler ["ButtonClick", {
	0 spawn {
		call RSTF_fnc_profileSave;
		closeDialog 0;
		sleep 0.5;
		call RSTF_fnc_showConfig;
	}
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