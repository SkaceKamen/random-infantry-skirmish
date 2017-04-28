private ["_group", "_index", "_unit"];
	
_group = _this select 0;
_index = _this select 1;

_unit = _group createUnit [_index call RSTF_fnc_getRandomSoldier, RSTF_SPAWNS select _index, [], 100, "NONE"];
if (isNull(_unit)) then {
	systemChat "FAILED TO SPAWN AI!";
};

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

// This is initial spawn
{
	_player = _x select 0;
	_assigned = _x select 1;
	if (isNull(_assigned) && side(_player) == side(_unit)) exitWith {
		RSTF_ASSIGNED_UNITS set [_foreachIndex, [_player, _unit]];
		publicVariable "RSTF_ASSIGNED_UNITS";

		if (not isDedicated && _player == player) then {
			_unit call RSTF_fnc_assignPlayer;
		};
	};
} foreach RSTF_ASSIGNED_UNITS;

_unit setVariable ["SPAWNED_SIDE", side(_group), true];
_unit addEventHandler ["Killed", RSTF_fnc_unitKilled];

_unit;