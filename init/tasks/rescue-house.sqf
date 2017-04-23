RSTF_TASK_RECUE_HOUSE_getHouses = {
	_houses = nearestObjects [RSTF_POINT, ["House"], RSTF_NEUTRALS_RADIUS];
	_usable = [];
	{
		_positions = []; _i = 0;
		_house = _x;
		while { (_house buildingPos _i) distance [0,0,0] > 0 } do
		{
			_positions set [count(_positions), [_i,_house buildingPos _i]];
			_i = _i + 1;
		};

		if (count(_positions) >= 4 && !(typeOf(_house) in RSTF_BANNED_BUILDINGS)) then
		{
			_found = false;
			{
				if (_x select 0 == _house) exitWith {
					_found = true;
				};
			} foreach RSRF_NEUTRAL_HOUSES;
		
			if (!_found) then {
				_usable set [count(_usable), [_house, _positions]];
			};
		};
	} foreach _houses;

	_usable;
};

RSTF_TASK_RESCUE_HOUSE_isAvailable = {
	count(call RSTF_TASK_RECUE_HOUSE_getHouses) > 0;
};

RSTF_TASK_RESCUE_HOUSE_start = {
	_position = [];
	_unit = objNull;

	/*
		Spawn guy inside house
			! need to correctly choose house (not too far / close from player, musn't be occupied by neutrals)
	*/
	
	// Find usable houses
	_usable = call RSTF_TASK_RECUE_HOUSE_getHouses;
	_house = _usable call BIS_fnc_selectRandom;

	[false, _house, objNull] call RSTF_TASK_RESCUE_HOUSE_load;
};

RSTF_TASK_RESCUE_HOUSE_load = {
	_spawned = _this select 0;
	_house = _this select 1;
	_vip = _this select 2;
	_houseObj = _house select 0;
	_positions = _house select 1;

	if (!_spawned) then {
		_vip = [getPos(_houseObj)] call RSTF_TASK_RESCUE_createVIP;

		_enemies = creategroup east;
		for [{_i = 0}, {_i < 10}, {_i = _i + 1}] do {
			_soldier = [_enemies, SIDE_ENEMY] call RSTF_fnc_createRandomUnit;
			_soldier setPos(getPos(_houseObj));
		};

		_wp = _enemies addWaypoint [getPos(_vip), 0];
		_wp setWaypointType "SUPPORT";

		RSTF_TASK_PARAMS = [true, _house, _vip];
	};

	RSTF_TASK_TYPE = "rescue-house";

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
	"rescue-house",
	RSTF_TASK_RESCUE_HOUSE_isAvailable,
	RSTF_TASK_RESCUE_HOUSE_start,
	RSTF_TASK_RESCUE_HOUSE_load
]];