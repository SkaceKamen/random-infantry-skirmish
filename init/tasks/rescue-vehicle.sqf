RSTF_TASK_RESCUE_createVIP = {
	_grp = creategroup side(player);
	_vip = _grp createUnit [(SIDE_FRIENDLY call RSTF_fnc_getRandomSoldier), _this select 0, [], 0, "NONE"];
	removeAllWeapons _vip;
	_vip setCaptive true;
	_vip switchMove "Acts_AidlPsitMstpSsurWnonDnon01";

	_vip addEventHandler ["Killed", RSTF_TASK_RESCUE_vipKilled];
	_vip addAction ["Rescue", {
		_vip = _this select 3;

		_vip removeAction (_this select 2);
		_vip playMoveNow "Acts_AidlPsitMstpSsurWnonDnon_out";

		_wp = group(_vip) addWaypoint [RSTF_SPAWNS select SIDE_FRIENDLY, 100];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "CARELESS";

		call RSTF_TASKS_TASK_completed;
	}, _vip];

	_vip;
};

RSTF_TASK_RESCUE_vipKilled = {
	call RSTF_TASKS_TASK_failed;
};

RSTF_TASK_RESCUE_VEHICLE_isAvailable = {
	// @TODO: Add check
	true;
};

RSTF_TASK_RESCUE_VEHICLE_start = {
	/*
		OPTIONS:
			1. Spawn guy inside car
				+ spawn guys around car
				+ destroy tire or something
				! need to correctly choose location (close to enemies, not too far / close from player, on road)
	*/

	_roads = RSTF_POINT nearRoads RSTF_NEUTRALS_RADIUS;
	_roads = _roads call RSTF_fnc_arrayShuffle;
	_road = objNull;

	{
		_pos = getPos(_x);
		_near = _pos nearObjects ["Man", 100];
		_safe = true;

		{
			if (side(_x) != east) exitWith {
				_safe = false;
			};
		} foreach _near;

		if (_safe) exitWith {
			_road = _x;
		};
	} foreach _roads;

	[false, _road, objNull] call RSTF_TASK_RESCUE_VEHICLE_load;

};

RSTF_TASK_RESCUE_VEHICLE_load = {
	_spawned = _this select 0;
	_road = _this select 1;
	_vip = _this select 2;

	if (!_spawned) then {
		_vip = [getPos(_road)] call RSTF_TASK_RESCUE_createVIP;

		_enemies = creategroup east;
		for [{_i = 0}, {_i < 10}, {_i = _i + 1}] do {
			_soldier = [_enemies, SIDE_ENEMY] call RSTF_fnc_createRandomUnit;
			_soldier setPos(getPos(_road));
		};

		_wp = _enemies addWaypoint [getPos(_vip), 0];
		_wp setWaypointType "SUPPORT";

		RSTF_TASK_PARAMS = [true, _road, _vip];

	};

	RSTF_TASK_TYPE = "rescue-vehicle";

	RSTF_TASK = [
		side(player), ["sideTask"],
		["Save this guy, please","Rescue VIP",""],
		_vip,
		"ASSIGNED"
	] call BIS_fnc_taskCreate;
};

/**
 * Add this side mission to list of possible missions.
 */
RSTF_TASKS set [count(RSTF_TASKS), [
	"rescue-vehicle",
	RSTF_TASK_RESCUE_VEHICLE_isAvailable,
	RSTF_TASK_RESCUE_VEHICLE_start,
	RSTF_TASK_RESCUE_VEHICLE_load
]];