{
	_name = "RSTF_" + _x;
	_value = missionNamespace getVariable _x;
	missionNamespace setVariable [_x, profilenamespace getVariable [_name, _value]];
} foreach RSTF_PROFILE_VALUES;

// Old mode replaced with an option
if (RSTF_MODE_SELECTED == "PushDefense") then {
	RSTF_MODE_SELECTED = "Push";
	RSTF_MODE_PUSH_SIDE = 1;
};
