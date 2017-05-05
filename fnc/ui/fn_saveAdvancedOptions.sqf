{
	_ctrl = _x select 0;
	_label = _x select 1;
	_type = _x select 2;
	_name = _x select 3;

	// Save value of option
	if (_type == "checkbox") then {
		missionNamespace setVariable [_name, cbChecked _ctrl];
	};

	if (_type == "number" || _type == "float") then {
		missionNamespace setVariable [_name, parseNumber(ctrlText(_ctrl))];
	};

	if (_type == "select") then {
		missionNamespace setVariable [_name, lbCurSel(_ctrl)];
	};

	diag_log text(format["OPTIONS: %1 (%2) set to %3", _name, _type, missionNamespace getVariable _name]);

	// Publish option
	publicVariable _name;
} foreach RSTF_ADVANCED_LASTOPTIONS;