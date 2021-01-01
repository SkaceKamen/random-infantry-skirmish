// Load gamemode
private _mode = RSTF_MODES select RSTF_MODE_INDEX;

// Checks if handler was properly defined
private _loadCallback = {
	private _mode = param [0];
	private _name = param [1];
	private _required = param [2, true];

	if (!isText(_mode >> _name)) exitWith {
		if (_required) then {
			systemChat format["%1 mode handler is not defined!", _name];
			diag_log text(format["%1 mode handler is not defined!", _name]);
		};

		{};
	};

	private _variable = getText(_mode >> _name);

	if (isNil(_variable)) exitWith {
		if (_required) then {
			systemChat format["%1 mode handler '%2' is not defined function!", _name, _variable];
			diag_log text(format["%1 mode handler '%2' is not defined function!", _name, _variable]);
		};

		{};
	};

	missionNamespace getVariable _variable;
};

// Assign to global variables so we don't have to do this every time we need something mode-related
RSTF_MODE_info = _mode;
RSTF_MODE_init = [_mode, "init"] call _loadCallback;
RSTF_MODE_unitKilled = [_mode, "unitKilled"] call _loadCallback;
RSTF_MODE_taskCompleted = [_mode, "taskCompleted"] call _loadCallback;
RSTF_MODE_vehicleKilled = [_mode, "vehicleKilled"] call _loadCallback;

// Initialize gamemode
0 spawn RSTF_MODE_init;
