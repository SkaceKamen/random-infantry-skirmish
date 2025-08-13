/*
	Function:
	RSTF_fnc_createRandomUnit

	Description:
	Spawns a random unit

	Parameters:
	_group - group [Group]
	_side - side index [Number]
	_checkMovement - check if unit moves, kill if not, default false [Boolean]

	Returns:
	Spawned unit [Object]
*/

private _group = param [0];
private _side = param [1];
private _checkMovement = param [2, false];
private _position = [];

if (!RSTF_DISABLE_GROUP_SPAWNS && RSTF_SPAWN_AT_OWN_GROUP) then {
	_position = [_group, _side] call RSTF_fnc_getGroupSpawnPosition;
} else {
	_position = [_side] call RSTF_fnc_randomSpawn;
};

private _possibilities = RSTF_MEN#_side;
private _possibilitiesWeighted = [];

if (RSTF_GROUP_UNIT_RESTRICTION > 0) then {
	private _targetFaction = _group getVariable ["RSTF_TARGET_FACTION", ""];
	private _targetVehicleClass = _group getVariable ["RSTF_TARGET_VEHICLE_CLASS", ""];

	if (_targetFaction == "" || _targetVehicleClass == "" || units(_group) findIf { alive(_x) } == -1) then {
		private _usableFactions = (([_side] call RSTF_fnc_getFactionsForSide) apply { toLower(_x) }) select { _x in RSTF_MEN_PER_FACTION_CLASS };
		_targetFaction = selectRandom _usableFactions;
		_targetVehicleClass = selectRandom (keys (RSTF_MEN_PER_FACTION_CLASS get _targetFaction));
		
		_group setVariable ["RSTF_TARGET_FACTION", _targetFaction, true];
		_group setVariable ["RSTF_TARGET_VEHICLE_CLASS", _targetVehicleClass, true];
	};

	if (RSTF_GROUP_UNIT_RESTRICTION == 2) then {
	 	_possibilities = (RSTF_MEN_PER_FACTION_CLASS get _targetFaction) get _targetVehicleClass;
	} else {
		_possibilities = RSTF_MEN_PER_FACTION get _targetFaction;
	};
};

if (RSTF_SPAWN_CLASSIFICATION_RATIOS) then {
	{
		private _weight = RSTF_SPAWN_CLASSIFICATION_AI_RATIO;
		private _classification = [configFile >> "cfgVehicles" >> _x] call RSTF_fnc_classifyVehicle;

		if (_classification == RSTF_CLASSIFICATION_AA_VEHICLE) then {
			_weight = RSTF_SPAWN_CLASSIFICATION_AA_RATIO;
		};

		if (_classification == RSTF_CLASSIFICATION_AT_VEHICLE) then {
				_weight = RSTF_SPAWN_CLASSIFICATION_AT_RATIO;
		};

		_possibilitiesWeighted pushBack _x;
		_possibilitiesWeighted pushBack _weight;
	} foreach _possibilities;
};

// Try to spawn next to our group, but only if they're inside spawn
if (!RSTF_MODE_DEFEND_ENABLED && !RSTF_DISABLE_WAVE_GROUP_SPAWNS) then {
	private _width = RSTF_RANDOM_SPAWN_WIDTH;
	private _height = RSTF_RANDOM_SPAWN_HEIGHT;
	private _direction = RSTF_DIRECTION;
	private _spawn = RSTF_SPAWNS select _side;
	
	{
		if (getPos(_x) inArea [_spawn, _width, _height, _direction, true]) exitWith {
			_position = getPos(_x);
		};
	} forEach units(_group);
};

private _unitClass = selectRandom _possibilities;

if (RSTF_SPAWN_CLASSIFICATION_RATIOS) then {
	// TODO: This should be cached
	private _possibilitiesByClassification = [[], [], []];
	{
		private _classification = [configFile >> "cfgVehicles" >> _x] call RSTF_fnc_classifyVehicle;
		_possibilitiesByClassification#_classification pushBack _x;
	} forEach _possibilities;

	private _classifications = [];
	if (count(_possibilitiesByClassification#RSTF_CLASSIFICATION_AA_VEHICLE) > 0) then {
		_classifications pushBack RSTF_CLASSIFICATION_AA_VEHICLE;

		if (RSTF_SPAWN_CLASSIFICATION_ENEMY_RATIOS && _side != SIDE_FRIENDLY) then {
			_classifications pushBack RSTF_SPAWN_CLASSIFICATION_ENEMY_AA_RATIO;
		} else {
			_classifications pushBack RSTF_SPAWN_CLASSIFICATION_AA_RATIO;
		};
	};

	if (count(_possibilitiesByClassification#RSTF_CLASSIFICATION_AT_VEHICLE) > 0) then {
		_classifications pushBack RSTF_CLASSIFICATION_AT_VEHICLE;
		
		if (RSTF_SPAWN_CLASSIFICATION_ENEMY_RATIOS && _side != SIDE_FRIENDLY) then {
			_classifications pushBack RSTF_SPAWN_CLASSIFICATION_ENEMY_AT_RATIO;
		} else {
			_classifications pushBack RSTF_SPAWN_CLASSIFICATION_AT_RATIO;
		};
	};

	if (count(_possibilitiesByClassification#RSTF_CLASSIFICATION_GENERAL_VEHICLE) > 0) then {
		_classifications pushBack RSTF_CLASSIFICATION_GENERAL_VEHICLE;
		
		if (RSTF_SPAWN_CLASSIFICATION_ENEMY_RATIOS && _side != SIDE_FRIENDLY) then {
			_classifications pushBack RSTF_SPAWN_CLASSIFICATION_ENEMY_AI_RATIO;
		} else {
			_classifications pushBack RSTF_SPAWN_CLASSIFICATION_AI_RATIO;
		};
	};

	if (count(_classifications) > 0) then {
		private _pickedClassification = selectRandomWeighted _classifications;
		_unitClass = selectRandom (_possibilitiesByClassification#_pickedClassification);
	};
};

private _unit = _group createUnit [_unitClass, _position, [], 10, "NONE"];

if (isNull(_unit)) exitWith {
	diag_log text(format["ERROR: Failed to spawn %1 (group %3) at %2", _unitClass, _position, _group]);
	systemChat format["FAILED TO SPAWN AI! Groups: %1, Units: %2", count(allGroups), count(allUnits)];
};

// Add to GC
if (RSTF_CLEAN) then {
	[_unit, RSTF_CLEAN_INTERVAL] call RSTFGC_fnc_attach;
};

if (count(RSTF_SPAWN_VEHICLES select _side) > 0) then {
	_vehicles = RSTF_SPAWN_VEHICLES select _side;
	_candidates = [];
	{
		if (alive(_x) && (_x emptyPositions "CARGO") > 0) then {
			_candidates pushBack _x;
		};
	} foreach _vehicles;

	if (count(_candidates) > 0) then {
		_vehicle = selectRandom _candidates;
		_unit moveInCargo _vehicle;
		[_unit, _vehicle] spawn { sleep 1; unassignVehicle (_this select 0); (_this select 0) action ["Eject", _this select 1]; };
	};
};

// DEBUG - Mark spawn location
if (RSTF_DEBUG) then {
	if (vehicle(_unit) == _unit) then {
		private _marker = createMarkerLocal [str(getPos(_unit)), getPos(_unit)];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_triangle";
		_marker setMarkerColor (RSTF_SIDES_COLORS select _side);
	};
};

// Ensure the skill level is within bounds
if (RSTF_SKILL_MIN > RSTF_SKILL_MAX) then {
	RSTF_SKILL_MAX = RSTF_SKILL_MIN;
};

_unit setSkill (RSTF_SKILL_MIN + random(RSTF_SKILL_MAX - RSTF_SKILL_MIN));

[_unit] joinSilent _group;
[_unit, _side] call RSTF_fnc_equipSoldier;

// TODO: The names are not assigned properly

private _names = RSTF_QUEUE_NAMES select _side;
if (count(_names) > 0) then {
	_name = [_names] call BIS_fnc_arrayShift;
	_unit setVariable ["ORIGINAL_NAME", _name];
} else {
	RSTF_ID_COUNTER = RSTF_ID_COUNTER + 1;
	_unit setVariable ["ORIGINAL_NAME", str(RSTF_ID_COUNTER)];
};

/*
	Possibly spawn in vehicle. Check if we're not neutral, if vehicles are enabled,
	if there is vehicle space and lastly if there's more than 1 unit in my group (to prevent group being autodeleted)
*/
private _vehicular = false;
if ([_group, _side] call RSTF_fnc_shouldSpawnVehicle) then {
	_vehicular = [_unit, _side] call RSTF_fnc_aiDecideVehicle;
};

if (!_vehicular) then {
	// This is initial spawn
	{
		_player = _x;
		if (!(_player getVariable ["ASSIGNED", true]) and side(_player) == side(_unit)) exitWith {
			_player setVariable ["ASSIGNED", true, true];

			RSTF_ASSIGNED_UNITS set [0, _player];
			RSTF_ASSIGNED_UNITS set [1, _unit];

			publicVariable "RSTF_ASSIGNED_UNITS";

			if (!isDedicated && _player == player) then {
				[_unit] spawn RSTF_fnc_assignPlayer;
			};
		};
	} foreach [player];
};

_unit setVariable ["SPAWNED_SIDE", side(_group), true];
_unit setVariable ["SPAWNED_SIDE_INDEX", _side, true];
_unit addEventHandler ["Killed", RSTF_fnc_unitKilled];

if (_checkMovement) then {
	RSTF_MOVEMENT_CHECK_UNITS pushBack _unit;
};

// DEBUG - Track unit position
if (RSTF_DEBUG) then {
	private _marker = createMarkerLocal [str(_unit), getPos(_unit)];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_dot";
	_marker setMarkerColor (RSTF_SIDES_COLORS select _side);

	[_unit, _marker] spawn {
		private _unit = param [0];
		private _marker = param [1];

		while { alive(_unit) } do {
			_marker setMarkerPos getPos(_unit);
			sleep 1;
		};

		deleteMarker _marker;
	};
};

if (!_vehicular) then {
	[_unit] call RSTF_MODE_unitSpawned;
};

_unit;