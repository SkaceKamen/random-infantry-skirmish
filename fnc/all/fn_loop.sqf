_spawn = 0;
_spawnVehicles = 0;

_cars = 0;
_tanks = 0;

while{true} do {
	if (_spawn == 0) then {
		_spawn = RSTF_LIMIT_SPAWN;
		
		_index = 0;
		{
			_side = east;
			if (_index == 1) then {
				_side = west;
			};
			
			// Rather than attacking center of battle, try to attack enemy spawn
			_point = RSTF_POINT;
			if (_index == 0) then {
				_point = RSTF_POINT vectorAdd [
					sin(180 + RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
					cos(180 + RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
					0
				];
			} else {
				_point = RSTF_POINT vectorAdd [
					sin(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
					cos(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
					0
				];
			};
			
			// Create groups if needed
			_groups = _x;
			if (count(_groups) == 0) then {
				// Enemy can have groups advantage
				_groups_advantage = 0;
				if (_side == east) then {
					_groups_advantage = RSTF_ENEMY_ADVANTAGE_GROUPS;
				};

				for [{_i = 0},{_i < RSTF_LIMIT_GROUPS + _groups_advantage},{_i = _i + 1}] do {
					_groups set [_i, creategroup _side];
				};

				publicVariable "RSTF_GROUPS";
			};
			
			// Enemy can have units advantage
			_units_advantage = 0;
			if (_side == east) then {
				_units_advantage = RSTF_ENEMY_ADVANTAGE_UNITS;
			};

			{
				_group = _x;
				
				_dis = selectRandom([-1,1]) * random(RSTF_DISTANCE * 0.4);
				_wppoint = _point vectorAdd [
					sin(RSTF_DIRECTION + 90) * _dis,
					cos(RSTF_DIRECTION + 90) * _dis,
					0
				];

				// Delete and recreate waypoint
				// This sometimes helps with stuck units
				deleteWaypoint [_group, 0];
				_wp = _group addWaypoint [_wppoint, 50];
				_wp setWaypointType "SAD";

				if (count(units(_x)) < RSTF_LIMIT_UNITS + _units_advantage) then {
					for[{_i = count(units(_x)); _k = 0},{_i < RSTF_LIMIT_UNITS && _k < 5},{_i = _i + 1; _k = _k + 1}] do {
						[_x, _index] call RSTF_fnc_createRandomUnit;
					};
				};
			} foreach _groups;
			
			_index = _index + 1;
		} foreach RSTF_GROUPS;
	} else {
		_spawn = _spawn - 1;
	};
	
	if (isServer && RSTF_TASK == "") then {
		0 spawn RSTF_TASKS_start;
	};
	
	sleep 1;
};