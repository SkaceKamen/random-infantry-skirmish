private _group = _this select 0;
private _index = _this select 1;
private _position = [_index] call RSTF_fnc_randomSpawn;

private _unitClass = _index call RSTF_fnc_getRandomSoldier;
private _unit = _group createUnit [_unitClass, _position, [], 10, "NONE"];

if (isNull(_unit)) exitWith {
	diag_log text(format["ERROR: Failed to spawn %1 (group %3) at %2", _unitClass, _position, _group]);
	systemChat format["FAILED TO SPAWN AI! Groups: %1, Units: %2", count(allGroups), count(allUnits)];
};

// Add to GC
[_unit] call RSTFGC_fnc_attach;

if (count(RSTF_SPAWN_VEHICLES select _index) > 0) then {
	_vehicles = RSTF_SPAWN_VEHICLES select _index;
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

_unit setSkill random(1);

[_unit] joinSilent _group;
[_unit, _index] call RSTF_fnc_equipSoldier;

private _names = RSTF_QUEUE_NAMES select _index;
if (count(_names) > 0) then {
	_name = [_names] call BIS_fnc_arrayShift;
	_unit setVariable ["ORIGINAL_NAME", _name];
	_unit setName _name;
} else {
	_unit setVariable ["ORIGINAL_NAME", name(_unit)];
};

/*
	Possibly spawn in vehicle. Check if we're not neutral, if vehicles are enabled,
	if there is vehicle space and lastly if there's more than 1 unit in my group (to prevent group being autodeleted)
*/
private _vehicular = false;
if (count(units(_group)) > 1 && _index != SIDE_NEUTRAL && RSTF_MONEY_ENABLED && RSTF_MONEY_VEHICLES_ENABLED && count(RSTF_AI_VEHICLES select _index) < RSTF_MONEY_VEHICLES_AI_LIMIT) then {
	_vehicular = [_unit, _index] call RSTF_fnc_aiDecideVehicle;
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
_unit addEventHandler ["Killed", RSTF_fnc_unitKilled];

_unit;