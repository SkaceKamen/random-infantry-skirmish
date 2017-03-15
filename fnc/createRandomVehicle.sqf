private ["_side", "_group", "_index", "_subindex", "_class", "_vehicle"];

_group = _this select 0;
_index = _this select 1;
_subindex = _this select 2;

_class = [_index, _subindex] call RSTF_getRandomVehicle;
_vehicle = createVehicle [_class, RSTF_SPAWNS select _index, [], 100, "NONE"];

_boat = _class isKindOf "Ship";

createVehicleCrew _vehicle;
(crew _vehicle) joinSilent _group;

{
	_x setVariable ["SPAWNED_SIDE", side(_group)];
	_x setVariable ["RSTF_vehicle", _vehicle];
	_x addEventHandler ["Killed", RSTF_unitKilled];
	if (_boat) then {
		_x addEventHandler ["Killed", RSTF_sailorKilled];
	};
} foreach crew _vehicle;

if (side(_group) == side(player)) then {
	_unit = gunner(_vehicle);
	if (isNull(_unit)) then {
		_unit = leader(_group);
	};
	
	setPlayable _unit;
	if (!PLAYER_SPAWNED) then {
		PLAYER_SPAWNED = true;
		PLAYER_SIDE = side(player);
		_unit call RSTF_assignPlayer;
	};
};

_vehicle;