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
