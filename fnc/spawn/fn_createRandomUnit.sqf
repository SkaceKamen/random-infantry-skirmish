private _group = _this select 0;
private _side = _this select 1;
private _position = [_side] call RSTF_fnc_randomSpawn;

private _unitClass = _side call RSTF_fnc_getRandomSoldier;
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
	_unit setName _name;
} else {
	if (RSTF_DEBUG) then {
		systemChat "[RSTF] Creating new ID";
	};

	RSTF_ID_COUNTER = RSTF_ID_COUNTER + 1;
	_unit setVariable ["ORIGINAL_NAME", str(RSTF_ID_COUNTER)];
	_unit setName str(RSTF_ID_COUNTER);
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
				_unit spawn RSTF_fnc_assignPlayer;
			};
		};
	} foreach (call BIS_fnc_listPlayers);
};

_unit setVariable ["SPAWNED_SIDE", side(_group), true];
_unit setVariable ["SPAWNED_SIDE_INDEX", _side, true];
_unit addEventHandler ["Killed", RSTF_fnc_unitKilled];

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

_unit;