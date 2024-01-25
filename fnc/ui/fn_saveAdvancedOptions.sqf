private _errors = [];

{
	private _ctrl = _x select 0;
	private _label = _x select 1;
	private _type = _x select 2;
	private _name = _x select 3;
	private _callback = _x param [4, -1, [-1, {}]];
	private _config = _x select 5;

	private _value = -1;

	if (_type == 'spacer') then {
		continue;
	};

	// Save value of option
	if (_type == "checkbox") then {
		_value = cbChecked(_ctrl);
	};

	if (_type == "number" || _type == "float") then {
		_value = parseNumber(ctrlText(_ctrl));
	};

	if (_type == "select") then {
		private _index = lbCurSel(_ctrl);
		_value = _ctrl lbData _index;

		if (!isText(_config >> "optionType") || { getText(_config >> "optionType") != "string" }) then {
			_value = parseNumber(_value);
		};
	};

	// Validate the value
	private _valid = true;
	if (!(_callback isEqualTo -1)) then {
		private _error = [_value, _x] call _callback;
		if (typeName(_error) == "STRING") then {
			_valid = false;
			_errors pushBack _error;
		};
	};

	// Only save valid values
	if (_valid) then {
		missionNamespace setVariable [_name, _value];
	};

	// diag_log text(format["OPTIONS: %1 (%2) set to %3", _name, _type, missionNamespace getVariable _name]);

	// Publish option
	publicVariable _name;
} foreach RSTF_ADVANCED_LASTOPTIONS;

if (count(_errors) > 0) then {
	private _message = "";
	{
		_message = _message + _x + "<br />";
	} foreach _errors;
	[parseText(_message), "Configuration error", true, false, RSTF_ADVANCED_CONFIG_DISPLAY#0] spawn BIS_fnc_GUImessage;
};