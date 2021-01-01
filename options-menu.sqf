RSTF_VALIDATOR_SPAWN_DISTANCE_MIN = {
	params ["_value", "_item"];
	if (_value > RSTF_SPAWN_DISTANCE_MAX) exitWith {
		"Minimal spawn distance has to be less than maximal spawn distance."
	};
	true
};

RSTF_VALIDATOR_SPAWN_DISTANCE_MAX = {
	params ["_value", "_item"];
	if (_value < RSTF_SPAWN_DISTANCE_MIN) exitWith {
		"Maximal spawn distance has to be less than minimal spawn distance."
	};
	true
};

RSTF_VALIDATOR_SKILL_MIN = {
	params ["_value", "_item"];
	if (_value > RSTF_SKILL_MAX) exitWith {
		"Minimal skill has to be less than maximal skill."
	};
	if (_value < 0 || _value > 1) exitWith {
		"Skill has to be in range [0, 1]"
	};
	true
};

RSTF_VALIDATOR_SKILL_MAX = {
	params ["_value", "_item"];
	if (_value < RSTF_SKILL_MIN) exitWith {
		"Maximal skill has to be less than minimal skill."
	};
	if (_value < 0 || _value > 1) exitWith {
		"Skill has to be in range [0, 1]"
	};
	true
};
