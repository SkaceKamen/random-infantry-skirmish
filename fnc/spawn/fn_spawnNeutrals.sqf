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
				sin(_d) * 2, cos(_d) * 2, 0
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
		_group = creategroup _neutrals_side;
		
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

/*
	Spawn static emplacements and assign tasks
	to find and destroy them.
*/

// 0 - AA, 1 - AT, 2 - AI
private _staticWeapons = [ [], [], [] ];
private _staticWeaponsAA = _staticWeapons select 0;
private _staticWeaponsAT = _staticWeapons select 1;
private _staticWeaponsAI = _staticWeapons select 2;
private _staticWeaponsTypes = [];
private _staticWeaponsNames = [ "AA", "AT", "AI"];

private _emplacements = [ "emplacement" ];
private _overrideEmplacements = [ [0, "RHS_ZU23_MSV"], [0, "RHS_ZU23_VDV"] ];
private _statics = (RSTF_VEHICLES select SIDE_NEUTRAL) select RSTF_VEHICLE_STATIC;
private _emplacementsCount = 5;
private _masterTask = "";

// Try to load static weapons from config
{
	_threat = getArray(configFile >> "cfgVehicles" >> _x >> "threat");
	if (_threat select 2 >= 0.8) then {
		_staticWeaponsAA pushBack _x;
	};
	if (_threat select 1 > 0.8) then {
		_staticWeaponsAT pushBack _x;
	};
	if (_threat select 0 > 0.8) then {
		_staticWeaponsAI pushBack _x;
	};
} foreach _statics;

// Add predefined static weapons if possible
{
	if ((_x select 1) in _statics) then {
		_exists = false;
		_item = _x;
		{
			if (_foreachIndex == _item select 0 && { (_item select 1) in _x }) exitWith {
				_exists = true;
			};
		} foreach _staticWeapons;

		if (!_exists) then {
			_staticWeapons pushBack (_item select 1);
		};
	};
} foreach _overrideEmplacements;

{
	if (count(_x) > 0) then {
		_staticWeaponsTypes pushBack _foreachIndex;
	};
} foreach _staticWeapons;

if (count(_staticWeaponsTypes) == 0 || !RSTF_NEUTRALS_EMPLACEMENTS) then {
	_emplacementsCount = 0;
};

if (RSTF_TASKS_EMP_ENABLED && _emplacementsCount > 0) then {
	_masterTask = [
		side(player), "CLEAREMPLACEMENTS",
		["Clear all defences in the city.", "Clear all defences", ""],
		[],
		"CREATED",
		0, false,
		"destroy"
	] call BIS_fnc_taskCreate;

	RSTF_CURRENT_TASKS pushBack _masterTask;

	RSTF_CLEAR_EMPLACEMENTS_TASKS = [];

	[_masterTask] spawn {
		params ["_masterTask"];

		private _completed = false;
		while { !_completed } do {
			if (count(RSTF_CLEAR_EMPLACEMENTS_TASKS) > 0) then {
				_completed = true;
				{

					if ([_x] call BIS_fnc_taskCompleted) exitWith {
						_completed = false;
					};
				} foreach RSTF_CLEAR_EMPLACEMENTS_TASKS;
			};

			sleep 5;
		};

		[_masterTask, "Succeeded", true] call BIS_fnc_taskSetState;
	};
};

for [{_i = 0}, {_i < _emplacementsCount}, {_i = _i + 1}] do {
	// Pick vehicle class
	private _typeIndex = selectRandom(_staticWeaponsTypes);
	private _vehicle = selectRandom(_staticWeapons select _typeIndex);
	private _vehicleType = _staticWeaponsNames select _typeIndex;

	// Create vehicle
	_group = createGroup _neutrals_side;

	// Pick position
	_position = [[[RSTF_POINT, 150]]] call BIS_fnc_randomPos;
	_position = [_position, 0, 100, 10, 0, 0.1] call BIS_fnc_findSafePos;

	if (count(_position) < 0) exitWith { false; };

	// Make position 3D
	_position set [2, 0];

	/*_marker = createMarker ["ASGFJHDASJHD" + str(_position), _position];
	_marker setmarkerShape "ICON";
	_marker setMarkerType "mil_dot";
	_marker setMarkerText "EMPLACEMENT HERE";*/

	// Create emplacement
	_empType = selectRandom(_emplacements);
	_spawned = [_position, random 360, _empType] call RSTF_fnc_spawnComposition;

	// Replace weapon placeholder with actual weapon
	{
		if (typeOf(_x) == "TargetBootcampHuman_F") then {
			_pos = getPos(_x);
			_dir = getDir(_x);
			deleteVehicle(_x);

			if (typeName(_vehicle) == typeName("")) then {
				_vehicle = createVehicle [_vehicle, _pos, [], 0, "CAN_COLLIDE"];
				_vehicle setPos _pos;
				_vehicle setDir _dir;

				createvehiclecrew(_vehicle);
				crew(_vehicle) joinSilent _group;

				{
					_x setVariable ["SPAWNED_SIDE", side(_group), true];
					_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
				} foreach units(_group);
			};
		};
	} foreach _spawned;

	if (RSTF_TASKS_EMP_ENABLED) then {
		// Create task
		private _task = [
			side(player), ["DESTROYEMP" + str(_vehicle), _masterTask],
			[format["There is %1 emplacement somewhere in the AO, find and neutralize it!", _vehicleType], format["Find emplacement", _vehicleType],""],
			[],
			"CREATED",
			0, false,
			"search"
		] call BIS_fnc_taskCreate;

		// Task logic
		[_vehicle, _vehicleType, _task] spawn {
			params ["_vehicle", "_vehicleType", "_task"];

			private _created = time;

			// Wait for player to find the AA emplacement
			waitUntil { PLAYER_SIDE knowsAbout _vehicle > 1 || !alive(_vehicle) || count(crew(_vehicle) select { alive _x }) == 0 };

			// Change task type to destroy
			[_task, _vehicle] call BIS_fnc_taskSetDestination;
			[_task, "destroy"] call BIS_fnc_taskSetType;
			[_task, [format["There is %1 emplacement somewhere in the AO, find and neutralize it!", _vehicleType], format["Neutralize emplacement", _vehicleType], ""]] call BIS_fnc_taskSetDescription;
			
			if (time - _created > 5) then {
				[_task, "ASSIGNED"] spawn BIS_fnc_taskHint;

				// Wait for it to be destroyed
				waitUntil { !alive(_vehicle) || count(crew(_vehicle) select { alive _x }) == 0 };
				[format["%1 neutralized", _vehicleType], _task] call RSTF_TASKS_TASK_completed;
			} else {
				[_task, "CANCELED", false] call BIS_fnc_taskSetState;
				[_task] call RSTF_TASKS_TASK_remove;
			};
		};

		// Save task and send it to clients
		RSTF_CURRENT_TASKS pushBack _task;
		RSTF_CLEAR_EMPLACEMENTS_TASKS pushBack _task;
	};
};

publicVariable "RSTF_CURRENT_TASKS";