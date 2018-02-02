private _unit = param [0];
private _side = param [1];
private _name = _unit getvariable ["ORIGINAL_NAME", name(_unit)];
private _money = [_name] call RSTF_fnc_getUnitMoney;
private _vehicles = RSTF_BUYABLE_VEHICLES select _side;
_shuffled = _vehicles call BIS_fnc_arrayShuffle;
private _spawned = false;

{
	private _class = _x select 1;
	private _cost = [_class] call RSTF_fnc_vehicleCost;

	if (_money >= _cost) exitWith {
		[_name, -_cost] call RSTF_fnc_addUnitMoney;
		_vehicle = [_unit, _side, _class] call RSTF_fnc_spawnBoughtVehicle;

		(RSTF_AI_VEHICLES select _side) pushBack _vehicle;

		_group = group(_unit);

		_point = RSTF_POINT;
		if (_side == SIDE_ENEMY) then {
			_point = RSTF_POINT vectorAdd [
				sin(180 + RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
				cos(180 + RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
				0
			];
		} else {
			_point = RSTF_POINT vectorAdd [
				sin(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
				cos(RSTF_DIRECTION) * (RSTF_DISTANCE * 0.5),
				0
			];
		};

		_dis = selectRandom([-1,1]) * random(RSTF_DISTANCE * 0.4);
		_wppoint = _point vectorAdd [
			sin(RSTF_DIRECTION + 90) * _dis,
			cos(RSTF_DIRECTION + 90) * _dis,
			0
		];

		_wp = _group addWaypoint [_wppoint, 50];
		_wp setWaypointType "SAD";

		_spawned = true;
	};
} foreach _shuffled;

_spawned;