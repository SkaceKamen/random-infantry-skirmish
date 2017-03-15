{
	_name = "RSTF_" + _x;
	_value = missionNamespace getVariable _x;
	profilenamespace setVariable [_name, _value];
} foreach RSTF_PROFILE_VALUES;