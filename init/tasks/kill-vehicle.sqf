/**
 * Clear house side mission.
 */

RSTF_TASK_KVEH_getVehicles = {
	(RSTF_VEHICLES select SIDE_ENEMY) select RSTF_VEHICLE_APC
};

/**
 * Returns if this task can be started. Checks if there is any occupied house.
 */
RSTF_TASK_KVEH_isAvailable = {
	count(call RSTF_TASK_KVEH_getVehicles) > 0;
};

/**
 * Starts house clearing side mission.
 */
RSTF_TASK_KVEH_start = {
	private ["_index", "_house"];

	[objNull] call RSTF_TASK_KVEH_load;
};

/**
 * Loads side mission params and activates mission.
 */
RSTF_TASK_KVEH_load = {
	private["_vehicle"];

	_vehicle = _this select 0;

	if (isNull(_vehicle)) then {
		// Pick vehicle class
		_vehicle = selectRandom(call RSTF_TASK_KVEH_getVehicles);
		
		// Create vehicle
		_group = createGroup east;
		_vehicle = createVehicle [_vehicle, RSTF_SPAWNS select SIDE_ENEMY, [], 50, "NONE"];
		createvehiclecrew(_vehicle);
		crew(_vehicle) joinSilent _group;

		{
			_x setVariable ["SPAWNED_SIDE", side(_group), true];
			_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
		} foreach units(_group);

		_wp = _group addWaypoint [RSTF_POINT, 50];
		_wp setWaypointType "MOVE";

		_vehicle limitSpeed 10;

		[_vehicle] spawn {
			_vehicle = _this select 0;
			waitUntil { !alive(_vehicle) || count(crew(_vehicle) select { alive _x }) == 0 };
			"Vehicle destroyed" call RSTF_TASKS_TASK_completed;
		};
	};

	RSTF_TASK = [
		side(player), "KILL" + str(_vehicle),
		["Enemy IFV is supporting their advance, destroy it.", "Destroy enemy IFV",""],
		_vehicle,
		"ASSIGNED",
		0, true,
		"destroy"
	] call BIS_fnc_taskCreate;

	RSTF_TASK_TYPE = "kill_vehicle";
	RSTF_TASK_PARAMS = [_vehicle];

	publicVariable "RSTF_TASK";
};

/**
 * Add this side mission to list of possible missions.
 */
RSTF_TASKS set [count(RSTF_TASKS), [
	"kill_vehicle",
	RSTF_TASK_KVEH_isAvailable,
	RSTF_TASK_KVEH_start,
	RSTF_TASK_KVEH_load
]];