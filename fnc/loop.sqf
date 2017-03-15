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
				
			_point = RSTF_POINT;
			if (_index == 0) then {
				_point = [(RSTF_POINT select 0) + cos(180+RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),(RSTF_POINT select 1) + sin(180+RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5)];
			} else {
				_point = [(RSTF_POINT select 0) + cos(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),(RSTF_POINT select 1) + sin(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5)];
			};
					
			_groups = _x;
			if (count(_groups) == 0) then {
				for[{_i = 0},{_i < RSTF_LIMIT_GROUPS},{_i = _i + 1}] do {
					_group = creategroup _side;
					deleteWaypoint [_group, 0];
					_wp = _group addWaypoint [_point,50];
					_wp setWaypointType "SAD";
					_groups set [_i, _group];
				};
			};
			
			{
				_group = _x;
				
				deleteWaypoint [_group, 0];
				_wp = _group addWaypoint [_point,50];
				_wp setWaypointType "SAD";

				//Spawn water units if we're in water
				if (RSTF_WATER) then {
					_vehicle = _group call RSTF_groupVehicle;
					if (isNull(_vehicle)) then {
						_vehicle = [_group, _index, 3] call RSTF_createRandomVehicle;
					};
				} else {
					if (count(units(_x)) < RSTF_LIMIT_UNITS) then {
						for[{_i = count(units(_x))},{_i < RSTF_LIMIT_UNITS},{_i = _i + 1}] do {
							[_x, _index] call RSTF_createRandomUnit;
						};
					};
				};
			} foreach _groups;
			
			_index = _index + 1;
		} foreach RSTF_GROUPS;
	} else {
		_spawn = _spawn - 1;
	};
	
	if (_spawnVehicles == 0) then {
		_spawnVehicles = RSTF_LIMIT_SPAWN_VEHICLES;
		
		_index = 0;
		{
			_side = east;
			if (_index == 1) then {
				_side = west;
			};
		
			_groups = _x;
			if (count(_groups) == 0) then {
				for[{_i = 0},{_i < RSTF_LIMIT_CARS + RSTF_LIMIT_TANKS},{_i = _i + 1}] do {
					_group = creategroup _side;
					_wp = _group addWaypoint [_point,50];
					_wp setWaypointType "SAD";
					_wp setWaypointSpeed "FULL";
					_groups set [_i, _group];
				};
			};
			
			_i = 0;
			{
				_vehicle = _x call RSTF_groupVehicle;
				_group = _x;
				
				if (isNull(_vehicle)) then {
					{
						_x setDamage 1;
					} foreach units(_group);
					_subindex = 0;
					if (_i >= RSTF_LIMIT_CARS) then {
						_subindex = 1;
					};
					[_group, _index, _subindex] call RSTF_createRandomVehicle;
				};
				
				_i = _i + 1;
			} foreach _groups;
			
			_index = _index + 1;
		} foreach RSTF_VEHICLE_GROUPS;
	} else {
		_spawnVehicles = _spawnVehicles - 1;
	};
	
	sleep 1;
};