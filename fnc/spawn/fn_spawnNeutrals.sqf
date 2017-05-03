_neutrals_side = resistance;
if (RSTF_NEUTRALS_EAST) then {
	_neutrals_side = east;
};

// Try to categorize static weapons
_vehicles = RSTF_VEHICLES select SIDE_NEUTRAL;
_statics = _vehicles select RSTF_VEHICLE_STATIC;
_high = [];
{
	_veh = _x createVehicle [0, 0, 100];
	_pos = ASLToATL(eyePos(_veh));
	if (_pos select 2 > 1.2) then {
		_high pushBack _x;
	};
	deleteVehicle _veh;
} foreach _statics;

diag_log text(format["NEUTRALS: Found %1 (of %2) high static weapons", count(_high), count(_statics)]);

// Load usable houses in area, only use bigger houses
_houses = nearestObjects [RSTF_POINT, ["House"], RSTF_NEUTRALS_RADIUS];
_usable = [];
{
	_positions = []; _i = 0;
	while{ (_x buildingPos _i) distance [0,0,0] > 0 } do
	{
		_positions set [count(_positions), [_i,_x buildingPos _i]];
		_i = _i + 1;
	};
	if (count(_positions) >= 4 && !(typeOf(_x) in RSTF_BANNED_BUILDINGS)) then
	{
		_usable set [count(_usable), [_x, _positions]];
	};
} foreach _houses;

// Can't have more groups then houses
if (count(_usable) < RSTF_NEUTRALS_GROUPS) then {
	RSTF_NEUTRALS_GROUPS = count(_usable);
};

// Shuffle buildings, so accessing it by incerasing index will access them randomly
// This will ensure every building will be used once
_usable = _usable call BIS_fnc_arrayShuffle;

// Now create neutral groups
for[{_i = 0},{_i < RSTF_NEUTRALS_GROUPS},{_i = _i + 1}] do {
	// Decide count of units inside building
	_units = RSTF_NEUTRALS_UNITS_MIN + round(random(RSTF_NEUTRALS_UNITS_MAX - RSTF_NEUTRALS_UNITS_MIN));
	
	_house = (_usable select _i) select 0;
	_positions = (_usable select _i) select 1;
	
	// Create helper
	/*_marker = createMarker ["HOUSE " + str(_i), getPos(_house)];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "MIL_DOT";
	_marker setMarkerText ("House " + str(_i));*/
	
	// Shuffle positions, then access them by linear index, ensuring no position is used twice
	_positions = _positions call BIS_fnc_arrayShuffle;
	_units = _units max count(_positions);

	// Number of static weapons in the house
	_statics = 0;
	if (count(_high) > 0) then {
		_statics = round(random(2));
	};
	
	_spawned = [];
	for[{_u = 0},{_u < _units && _u < count(_positions)},{_u = _u + 1}] do {
		_position = (_positions select _u) select 1;
	
		_canHaveStatic = false;
		_pos1 = ATLtoASL(_position vectorAdd [0, 0, 1.5]);
		for [{_d = 0},{_d < 360},{_d = _d + 1}] do {
			_pos2 = _pos1 vectorAdd [
				cos(_d) * 2, sin(_d) * 2, 0
			];
			if (!(lineIntersects [_pos1, _pos2])) then {
				_pos3 = _pos2 vectorAdd [0, 0, 5];
				if (!(lineIntersects [_pos2, _pos3])) then {
					_canHaveStatic = true;
				};
			};
			if (_canHaveStatic) exitWith {};
		};

		// Every unit has its own group, this way they wont run off their position
		// @TODO: Is there better way?
		_group = creategroup resistance;
		
		// Create equipped unit
		_unit = [_group, SIDE_NEUTRAL] call RSTF_fnc_createRandomUnit;
		_dir = [getPos(_house), _position] call BIS_fnc_dirTo;
		_group setFormDir _dir;
		_unit setDir _dir;
		
		// Set his task
		_wp = _group addWaypoint [_position, 0];
		_wp waypointAttachObject _house;
		_wp setWaypointHousePosition ((_positions select _u) select 0);
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "LIMITED";
		
		// Ensure unit is on right side
		[_unit] joinSilent _group;
		
		// Make sure he's right in specified position
		_unit setPos _position; 
		
		// Units tend to prone and do nothing
		_unit setUnitPos "UP";

		if (_statics > 0 && _canHaveStatic) then {
			_veh = selectRandom(_high) createVehicle _position;
			_veh setDir _dir;
			_veh setPos _position;
			if (damage _veh > 0) then {
				deleteVehicle _veh;
			} else {
				_unit moveInGunner _veh;
				_statics = _statics - 1;
			};
		};
		
		_spawned set [count(_spawned), _unit];
		// Units tend to move outside
		//_unit disableAI "MOVE";
		// Look suprised!
		//_unit setBehaviour "SAFE";
	};
	
	RSRF_NEUTRAL_HOUSES set [count(RSRF_NEUTRAL_HOUSES), [_house, _spawned]];
};

RSRF_NEUTRAL_HOUSES = [RSRF_NEUTRAL_HOUSES, [], { (_x select 0) distance (RSTF_SPAWNS select SIDE_FRIENDLY) }, "ASCEND"] call BIS_fnc_sortBy;