/*
	Author:
	Jan Zipek

	Description:
	Spawn static emplacements and assign tasks
	to find and destroy them.
*/

private _neutrals_side = param [0];

// 0 - AA, 1 - AT, 2 - AI
private _staticWeapons = [ [], [], [] ];
private _staticWeaponsAA = _staticWeapons select 0;
private _staticWeaponsAT = _staticWeapons select 1;
private _staticWeaponsAI = _staticWeapons select 2;
// List of weapon types that have at least one item
private _staticWeaponsTypes = [];
// Names for each weapon type index
private _staticWeaponsNames = [ "AA", "AT", "AI"];

// Contains list of possible emplacement compositions (found in compositions folder)
private _emplacements = [ "emplacement", "emplacement2" ];
// List of classNames and their class (AA/AT/AI) to be overriden
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
			(_staticWeapons select (_item select 0)) pushBack (_item select 1);
		};
	};
} foreach _overrideEmplacements;

// Load list of weapon types with at least one item
{
	if (count(_x) > 0) then {
		_staticWeaponsTypes pushBack _foreachIndex;
	};
} foreach _staticWeapons;

// Don't try to place emplacements when there aren't any static weapons
if (count(_staticWeaponsTypes) == 0 || !RSTF_NEUTRALS_EMPLACEMENTS) then {
	_emplacementsCount = 0;
};

// Start task if enabled
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

	// Completion logic
	[_masterTask] spawn {
		params ["_masterTask"];

		// Wait until all emplacements are placed
		sleep 5;

		// Loop and check if all emplacements were cleared
		private _completed = false;
		while { !_completed } do {
			if (count(RSTF_CLEAR_EMPLACEMENTS_TASKS) > 0) then {
				_completed = true;
				{
					if (!([_x] call BIS_fnc_taskCompleted)) exitWith {
						_completed = false;
					};
				} foreach RSTF_CLEAR_EMPLACEMENTS_TASKS;
			};

			sleep 5;
		};

		[_masterTask, "Succeeded", true] call BIS_fnc_taskSetState;
	};
};

// Spawn emplacements
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

	// Skip if no position was found
	if (count(_position) < 0) exitWith { false; };

	// Make position 3D
	_position set [2, 0];

	/*
	_marker = createMarker ["ASGFJHDASJHD" + str(_position), _position];
	_marker setmarkerShape "ICON";
	_marker setMarkerType "mil_dot";
	_marker setMarkerText "EMPLACEMENT HERE";
	*/

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

			/*
				If the task was completed within 5 seconds of spawning
				the emplacement was definetly spawned at bad place so
				just cancel the task.
			*/
			if (time - _created > 5) then {
				[_task, "ASSIGNED"] spawn BIS_fnc_taskHint;

				// Wait for it to be destroyed
				waitUntil { !alive(_vehicle) || count(crew(_vehicle) select { alive _x }) == 0 };
				[format["Emplacement neutralized", _vehicleType], _task] call RSTF_TASKS_TASK_completed;
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