RSTF_TASK_EMP_statics = [];
RSTF_TASK_EMP_emplacements = [
	"emplacement"
];
RSTF_TASK_EMP_override = [ ["AA", "RHS_ZU23_MSV"] ];

RSTF_TASK_EMP_getVehicles = {
	if (count(RSTF_TASK_EMP_statics) == 0) then {
		private _statics = (RSTF_VEHICLES select SIDE_ENEMY) select RSTF_VEHICLE_STATIC;

		// Try to load static weapons from config
		RSTF_TASK_EMP_statics = [];
		{
			_threat = getArray(configFile >> "cfgVehicles" >> _x >> "threat");
			if (_threat select 2 >= 0.8) then {
				RSTF_TASK_EMP_statics pushBack ["AA", _x];
			};

			if (_threat select 1 > 0.8) then {
				RSTF_TASK_EMP_statics pushBack ["AT", _x];
			};
		} foreach _statics;

		// Add predefined static weapons if possible
		{
			if ((_x select 1) in _statics) then {
				_exists = false;
				_item = _x;
				{
					if (_x select 1 == _item select 1) exitWith {
						_exists = true;
					}
				} foreach RSTF_TASK_EMP_statics;

				if (!_exists) then {
					RSTF_TASK_EMP_statics pushBack _item;
				};
			};
		} foreach RSTF_TASK_EMP_override;
	};

	if (count(RSTF_TASK_EMP_statics) == 0) then {
		systemChat "No AA found.";
	};

	RSTF_TASK_EMP_statics;
};

RSTF_TASK_EMP_isAvailable = {
	count(call RSTF_TASK_EMP_getVehicles) > 0;
};

RSTF_TASK_EMP_start = {
	[objNull, ""] call RSTF_TASK_EMP_load;
};

RSTF_TASK_EMP_load = {
	private _vehicle = _this select 0;
	private _vehicleType = _this select 1;

	if (isNull(_vehicle)) then {
		// Pick vehicle class
		_vehicle = selectRandom(call RSTF_TASK_EMP_getVehicles);
		_vehicleType = _vehicle select 0;
		_vehicle = _vehicle select 1;
		
		// Create vehicle
		_group = createGroup east;
		
		// Pick position
		_position = [[[RSTF_POINT, 200]]] call BIS_fnc_randomPos;
		_position = [_position, 0, 100, 10, 0, 0.1] call BIS_fnc_findSafePos;

		if (count(_position) < 0) exitWith { false; };

		// Make position 3D
		_position set [2, 0];

		_marker = createMarker ["ASGFJHDASJHD", _position];
		_marker setmarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerText "EMPLACEMENT HERE";

		// Create emplacement
		_empType = selectRandom(RSTF_TASK_EMP_emplacements);
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
		
		[_vehicle, _vehicleType] spawn {
			_vehicle = _this select 0;
			_vehicleType = _this select 1;

			// Wait for player to find the AA emplacement
			waitUntil { PLAYER_SIDE knowsAbout _vehicle > 1 || !alive(_vehicle) || count(crew(_vehicle) select { alive _x }) == 0 };

			// Change task type to destroy
			[RSTF_TASK, _vehicle] call BIS_fnc_taskSetDestination;
			[RSTF_TASK, "destroy"] call BIS_fnc_taskSetType;
			[RSTF_TASK, ["Neutralize " + _vehicleType + " emplacement.", "Neutralize " + _vehicleType + " emplacement", ""]] call BIS_fnc_taskSetDescription;
			[RSTF_TASK, "ASSIGNED"] spawn BIS_fnc_taskHint;

			// Wait for it to be destroyed
			waitUntil { !alive(_vehicle) || count(crew(_vehicle) select { alive _x }) == 0 };
			"AA neutralized" call RSTF_TASKS_TASK_completed;
		};
	};

	RSTF_TASK = [
		side(player), "DESTROYEMP" + str(_vehicle),
		["Find and neutralize " + _vehicleType + " emplacement.", "Find and neutralize " + _vehicleType + " emplacement",""],
		[],
		"ASSIGNED",
		0, true,
		"search"
	] call BIS_fnc_taskCreate;

	RSTF_TASK_TYPE = "clear_emplacement";
	RSTF_TASK_PARAMS = [_vehicle, _vehicleType];

	publicVariable "RSTF_TASK";
};

/**
 * Add this side mission to list of possible missions.
 */
RSTF_TASKS set [count(RSTF_TASKS), [
	"clear_emplacement",
	RSTF_TASK_EMP_isAvailable,
	RSTF_TASK_EMP_start,
	RSTF_TASK_EMP_load
]];