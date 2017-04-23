{
	_name = "RSTF_" + _x;
	profilenamespace setVariable [_name, nil];
} foreach RSTF_PROFILE_VALUES;

call compile(preprocessFileLineNumbers('options.sqf'));