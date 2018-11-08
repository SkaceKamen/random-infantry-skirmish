#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

_display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
_optionsContainer = ["RSTF_RscDialogAdvancedConfig", "optionsContainer"] call RSTF_fnc_getCtrl;

_options = (RSTF_CONFIG_VALUES select _this) select 1;

// Save previously displayed options
call RSTF_fnc_saveAdvancedOptions;
call RSTF_fnc_profileSave;
call RSTF_fnc_updateEquipment;

// Remove previous options
{
	ctrlDelete (_x select 0);
	ctrlDelete (_x select 1);
	(_x select 0) ctrlCommit 0;
	(_x select 1) ctrlCommit 0;
} foreach RSTF_ADVANCED_LASTOPTIONS;

RSTF_ADVANCED_LASTOPTIONS = [];

_padding = 0.05;
_width = RSTF_ADV_OPS_W - _padding * 2;
_idc = 2000;
_yy = _padding;
_xx = _padding;
{
	// Empty array is separator
	if (count(_x) > 0) then {
		// Load variable name and value
		_name = _x select 0;
		_callback = _x param [5, -1, [-1, {}]];
		_value = missionNamespace getVariable [_name, ""];

		// Add label
		_label = _display ctrlCreate ["RscText", _idc, _optionsContainer];
		_label ctrlSetText ((_x select 1) + ":");
		_label ctrlSetTooltip (_x select 2);
		_label ctrlSetPosition [_xx, _yy + 0.025 - 0.037/2, RSTF_ADV_OPS_W * 0.4, 0.037];
		_label ctrlCommit 0;

		_idc = _idc + 1;

		// Decide control used for input
		_ctrlType = "RscEdit";
		_type = _x select 3;
		switch (_type) do {
			case "checkbox": { _ctrlType = "RscCheckBox"; };
			case "select": { _ctrlType = "RscCombo"; };
		};

		diag_log text(format["OPTIONS: %1 (%2) is %3", _name, _type, _value]);

		// Build input control
		_ctrl = _display ctrlCreate [_ctrlType, _idc, _optionsContainer];
		_ctrl ctrlSetText str(_value);
		_ctrl ctrlSetTooltip (_x select 2);

		// Checkbox have fixed size and diferent input
		if (_type == "checkbox") then {
			_ctrl ctrlSetPosition [_xx + _width * 0.5, _yy + 0.005, 0.04, 0.04 * safeZoneW / safeZoneH];

			if (typeName(_value) == typeName(true) && { _value }) then {
				_ctrl cbSetChecked true;
			};
		} else {
			_ctrl ctrlSetPosition [_xx + _width * 0.5, _yy, _width * 0.5, 0.05];
		};

		_ctrl ctrlCommit 0;

		// Add values to combo box
		if (_type == "select") then {
			_selectOptions = _x select 4;
			{
				_ctrl lbAdd _x;
				if (typeName(_value) == typeName(_foreachIndex) && { _foreachIndex == _value }) then {
					_ctrl lbSetCurSel _foreachIndex;
				};
			} foreach _selectOptions;
		};

		// Add input filtering for numbers
		if (_type == "number") then {
			_ctrl ctrlAddEventHandler ["Char", {
				[_this select 0, _this select 1, "NUMBERS"] call RSTF_fnc_filterInput;
			}];
		};

		// Add input filtering for floats
		if (_type == "float") then {
			_ctrl ctrlAddEventHandler ["Char", {
				[_this select 0, _this select 1, "FLOAT"] call RSTF_fnc_filterInput;
			}];
		};

		// Save created option for later manipulation
		RSTF_ADVANCED_LASTOPTIONS pushBack [_ctrl, _label, _type, _name, _callback];
		_idc = _idc + 1;
	};

	_yy = _yy + 0.08;
} foreach _options;