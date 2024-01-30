#include "..\..\dialogs\advancedConfigDialog.inc"

disableSerialization;

private _display = "RSTF_RscDialogAdvancedConfig" call RSTF_fnc_getDisplay;
private _optionsContainer = ["RSTF_RscDialogAdvancedConfig", "optionsContainer"] call RSTF_fnc_getCtrl;

private _category = param [0];
private _firstLoad = param [1, false];

private _options = missionConfigFile >> "RSTF_Options" >> _category;

// Save previously displayed options
if (not _firstLoad) then {
	call RSTF_fnc_saveAdvancedOptions;
	call RSTF_fnc_profileSave;
};

call RSTF_fnc_updateEquipment;
call RSTF_fnc_updateAdvancedConfig;

// Remove previous options
{
	ctrlDelete (_x select 0);
	ctrlDelete (_x select 1);
	ctrlDelete (_x select 2);
	(_x select 0) ctrlCommit 0;
	(_x select 1) ctrlCommit 0;
	(_x select 2) ctrlCommit 0;
} foreach RSTF_ADVANCED_LASTOPTIONS;

RSTF_ADVANCED_LASTOPTIONS = [];

private _items = "true" configClasses (_options >> "Items");

private _idc = 2000;

private _padding = 0.05;
private _width = RSTF_ADV_OPS_W - _padding * 2;
{
	private _configItem = _x;
	private _type = getText(_x >> "type");

	if (_type == 'spacer') then {
		RSTF_ADVANCED_LASTOPTIONS pushBack [controlNull, controlNull, controlNull, _type, "", -1, _x];
		continue;
	};

	// Load variable name and value
	private _name = configName(_x);
	private _title = getText(_x >> "title");
	private _description = getText(_x >> "description");
	private _validator = -1;
	private _value = missionNamespace getVariable [_name, ""];
	
	if (isText(_x >> "validator")) then {
		_validator = compile(getText(_x >> "validator"));
	};

	// Add label
	private _label = _display ctrlCreate ["RSTF_ADV_LABEL", _idc, _optionsContainer];
	_label ctrlSetText (_title + ":");
	_label ctrlSetTooltip _description;
	_label ctrlShow false;
	_label ctrlCommit 0;

	_idc = _idc + 1;

	// Decide control used for input
	private _ctrlType = "RscEdit";
	switch (_type) do {
		case "checkbox": { _ctrlType = "RscCheckBox"; };
		case "select": { _ctrlType = "RscCombo"; };
	};

	// Build input control
	private _ctrl = _display ctrlCreate [_ctrlType, _idc, _optionsContainer];
	_ctrl ctrlSetText str(_value);
	_ctrl ctrlSetTooltip _description;
	_ctrl ctrlShow false;
	_ctrl ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2)/ 1.2)/ 25) * 0.8);

	private _postfixCtrl = controlNull;

	if (isText(_x >> "postfix")) then {
		_postfixCtrl = _display ctrlCreate ["RSTF_ADV_POSTFIX", _idc, _optionsContainer];
		_postfixCtrl ctrlSetText getText(_x >> "postfix");
		_postfixCtrl ctrlShow false;
		_postfixCtrl ctrlCommit 0;

		_idc = _idc + 1;
	};

	// Checkbox have fixed size and diferent input
	if (_type == "checkbox") then {
		if (typeName(_value) == typeName(true) && { _value }) then {
			_ctrl cbSetChecked true;
		};

		_ctrl ctrlAddEventHandler ["CheckedChanged", {
			0 spawn {
				call RSTF_fnc_saveAdvancedOptions;
				call RSTF_fnc_updateAdvancedConfig;
			}
		}];
	};

	_ctrl ctrlCommit 0;

	// Add values to combo box
	if (_type == "select") then {
		private _selectOptions = if (isArray(_x >> "options")) then { getArray(_x >> "options") } else { [] };
		if (isText(_x >> "optionsVariable")) then {
			_selectOptions = missionNamespace getVariable getText(_x >> "optionsVariable");
		};

		{
			private _itemValue = _foreachIndex;
			private _itemLabel = _x;

			if (typeName(_x) == typeName([])) then {
				_itemValue = _x#0;
				_itemLabel = _x#1;
			};

			_ctrl lbAdd _itemLabel;
			_ctrl lbSetData [_foreachIndex, if (typeName(_itemValue) != typeName("")) then { str(_itemValue) } else { _itemValue }];

			if (typeName(_value) == typeName(_itemValue) && { _itemValue == _value }) then {
				_ctrl lbSetCurSel _foreachIndex;
			};
		} foreach _selectOptions;

		_ctrl ctrlAddEventHandler ["LBSelChanged", {
			0 spawn {
				call RSTF_fnc_saveAdvancedOptions;
				call RSTF_fnc_updateAdvancedConfig;
			}
		}];
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

	if (_type == "number" || _type == "float") then {
		_ctrl ctrlAddEventHandler ["EditChanged", {
			call RSTF_fnc_saveAdvancedOptions;
			call RSTF_fnc_updateAdvancedConfig;
		}];
	};

	if (RSTF_ADVANCED_CONFIG_INGAME) then {
		private _allowIngame = isNumber(_x >> "ingame") && { getNumber(_x >> "ingame") == 1 };
		_ctrl ctrlEnable _allowIngame;
		if (!_allowIngame) then {
			_ctrl ctrlSetTooltip "This option can only be changed in the lobby";
		};

		private _onlyClient = isMultiplayer && !isServer && (admin clientOwner) == 0;
		if (_onlyClient) then {
			private _allowClient = isNumber(_x >> "client") && { getNumber(_x >> "client") == 1 };
			_ctrl ctrlEnable _allowClient;
			if (!_allowClient) then {
				_ctrl ctrlSetTooltip "This can only be changed by admin";
			};
		};
	};

	// Save created option for later manipulation
	RSTF_ADVANCED_LASTOPTIONS pushBack [_ctrl, _label, _postfixCtrl, _type, _name, _validator, _x];
	_idc = _idc + 1;
} foreach _items;

call RSTF_fnc_updateAdvancedOptions;