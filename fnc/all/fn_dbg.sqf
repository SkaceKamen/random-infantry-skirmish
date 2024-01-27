private _logLine = if (typeName _this == typeName("")) then {_this} else {str(_this)};

diag_log text("[RSTF] " + _logLine);

if RSTF_DEBUG then {
	systemChat _logLine;
};