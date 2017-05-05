/**
 * Clear house side mission.
 */

/**
 * Find first house which is still occupied. When no house is found, empty array is returned.
 * House format is [ houseObject, group occupying the house ].
 */
RSTF_TASK_CLEAR_getHouse = {
	private ["_index", "_house"];

	_house = [];

	_index = 0;
	while { _index < count(RSRF_NEUTRAL_HOUSES) } do {
		_current = RSRF_NEUTRAL_HOUSES select _index;
		_alive = { alive _x } count (_current select 1);
		if (_alive > 0) exitWith {
			_house = _current;
		};

		_index = _index + 1;
	};

	_house;
};

/**
 * Returns if this task can be started. Checks if there is any occupied house.
 */
RSTF_TASK_CLEAR_isAvailable = {
	(count(call RSTF_TASK_CLEAR_getHouse) > 0);
};

/**
 * Starts house clearing side mission.
 */
RSTF_TASK_CLEAR_start = {
	private ["_index", "_house"];

	_house = call RSTF_TASK_CLEAR_getHouse;
	if (count(_house) > 0) then {
		[_house, false] call RSTF_TASK_CLEAR_load;
	} else {
		hint "Failed to start side task.";
	};
};

/**
 * Loads side mission params and activates mission.
 */
RSTF_TASK_CLEAR_load = {
	private["_house"];

	_house = _this select 0;
	_spawned = _this select 1;

	RSTF_TASK = [
		side(player), "CLEAR" + str(getPos(_house select 0)),
		["Clear this house, because ... I don't know why", "Clear house at " + str(mapGridPosition(getPos(_house select 0))),""],
		getPos(_house select 0),
		"ASSIGNED",
		0, true,
		"attack"
	] call BIS_fnc_taskCreate;

	RSTF_TASK_TYPE = "clear";
	RSTF_TASK_PARAMS = [_house, _spawned];

	publicVariable "RSTF_TASK";

	if (!_spawned) then {
		RSTF_TASK_PARAMS = [_house, true];

		[_house] spawn {
			_house = _this select 0;
			waitUntil {({ alive _x } count (_house select 1)) == 0};

			call RSTF_TASKS_TASK_completed;
		};
	};
};

/**
 * Add this side mission to list of possible missions.
 */
RSTF_TASKS set [count(RSTF_TASKS), [
	"clear",
	RSTF_TASK_CLEAR_isAvailable,
	RSTF_TASK_CLEAR_start,
	RSTF_TASK_CLEAR_load
]];