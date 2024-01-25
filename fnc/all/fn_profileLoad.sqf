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

// Decrease the default dead bodies clean interval
if (profileNamespace getVariable ["RSTF_NEW_CLEAN_APPLIED", false] == false) then {
	if (RSTF_CLEAN_INTERVAL == 3*60) then {
		RSTF_CLEAN_INTERVAL = 30;
	};

	if (RSTF_CLEAN_INTERVAL_VEHICLES == 3*60) then {
		RSTF_CLEAN_INTERVAL_VEHICLES = 60;
	};

	profileNamespace setVariable ["RSTF_NEW_CLEAN_APPLIED", true];
};
