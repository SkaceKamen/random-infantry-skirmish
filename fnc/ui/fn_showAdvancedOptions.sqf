#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

_display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
_optionsContainer = ["RSTF_RscDialogAdvancedConfig", "optionsContainer"] call RSTF_fnc_getCtrl;

_options = (RSTF_CONFIG_VALUES select _this) select 1;

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
} foreach RSTF_ADVANCED_LASTOPTIONS;

RSTF_ADVANCED_LASTOPTIONS = [];

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

		RSTF_ADVANCED_LASTOPTIONS pushBack [_ctrl, _label, _type, _name];
		_idc = _idc + 1;
	};
	_yy = _yy + 0.08;
} foreach _options;