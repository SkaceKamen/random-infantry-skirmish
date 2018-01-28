private _group = _this select 0;
private _index = _this select 1;
private _position = [_index] call RSTF_fnc_randomSpawn;

private _unit = _group createUnit [_index call RSTF_fnc_getRandomSoldier, _position, [], 10, "NONE"];
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

_unit setVariable ["SPAWNED_SIDE", side(_group), true];
_unit addEventHandler ["Killed", RSTF_fnc_unitKilled];

_unit;