{
	_name = "RSTF_" + _x;
	_value = missionNamespace getVariable _x;
	missionNamespace setVariable [_x, profilenamespace getVariable [_name, _value]];
} foreach RSTF_PROFILE_VALUES;