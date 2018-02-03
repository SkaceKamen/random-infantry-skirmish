private _unit = param [0];
private _side = param [1];
private _name = _unit getvariable ["ORIGINAL_NAME", name(_unit)];
private _money = [_name] call RSTF_fnc_getUnitMoney;
private _vehicles = RSTF_BUYABLE_VEHICLES select _side;

// Don't bother if we're broke
if (_money < (_vehicles select 0) select 2) exitWith {
	false;
};

_shuffled = _vehicles call BIS_fnc_arrayShuffle;
private _spawned = false;
private _iteration = 0;
private _limit = 5;

{
	private _class = _x select 1;
	private _cost = _x select 2;

	if (_money >= _cost) exitWith {
		[_name, -_cost] call RSTF_fnc_addUnitMoney;
		_vehicle = [_unit, _side, _class] call RSTF_fnc_spawnBoughtVehicle;
		(RSTF_AI_VEHICLES select _side) pushBack _vehicle;

		_group = group(_unit);

		// Remove vehicle from AI vehicles when dead
		[_vehicle, _side] spawn {
			_vehicle = param [0];
			_side = param [1];

			waitUntil { !canMove(_vehicle) || count(crew(_vehicle)) == 0 || !canFire(_vehicle) };

			_vehicles = (RSTF_AI_VEHICLES select _side);
			_index = _vehicles find _vehicle;
			_vehicles = [_vehicles, _index] call BIS_fnc_removeIndex;
			RSTF_AI_VEHICLES set [_side, _vehicles];

			sleep 5;

			_vehicle setDamage 1;
		};

		// Keep pressuring vehicle to attack, because the AI is pussy mostly
		[_vehicle, _group, _side] spawn {
			_vehicle = param [0];
			_group = param [1];
			_side = param [2];

			while { alive(_vehicle) } do {
				deleteWaypoint [_group, 0];
				_wp = _group addWaypoint [[_side] call RSTF_fnc_getAttackWaypoint, 10];
				_wp setWaypointType "MOVE";
				_wp setWaypointSpeed "LIMITED";
				_wp setwaypointbehaviour "COMBAT";

				sleep 20;
			};
		};

		_spawned = true;
	};

	_iteration = _iteration + 1;
	if (_iteration >= _limit) exitWith {};
} foreach _shuffled;

_spawned;