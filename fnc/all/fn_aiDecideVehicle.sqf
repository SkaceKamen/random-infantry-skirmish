private _unit = param [0];
private _side = param [1];
private _name = _unit getvariable ["ORIGINAL_NAME", name(_unit)];
private _money = [_name] call RSTF_fnc_getUnitMoney;
private _vehicles = RSTF_BUYABLE_VEHICLES select _side;

// Don't bother if we're broke
if (_money < (_vehicles select 0) select 2) exitWith {
	false;
};

_shuffled = _vehicles call RSTF_fnc_arrayShuffle;
private _spawned = false;
private _iteration = 0;
private _limit = 5;

{
	private _class = _x select 1;
	private _cost = _x select 2;
	private _hasDriver = getNumber(configFile >> "cfgVehicles" >> _class >> "hasDriver") == 1;

	if (_hasDriver && _money >= _cost) exitWith {
		private _parents = [configFile >> "cfgVehicles" >> _class, true] call BIS_fnc_returnParents;
		private _air = "Air" in _parents;

		[_name, -_cost] call RSTF_fnc_addUnitMoney;
		_vehicle = [objNull, _side, _class] call RSTF_fnc_spawnBoughtVehicle;
		(RSTF_AI_VEHICLES select _side) pushBack _vehicle;

		_group = group(effectiveCommander(_vehicle));

		// Remove vehicle from AI vehicles when dead
		[_vehicle, _side] spawn {
			_vehicle = param [0];
			_side = param [1];

			while { true } do {
				// Get out of useless vehicle
				if (!canFire(_vehicle)) then {
					{
						[_x, _vehicle] spawn { sleep 1; unassignVehicle (_this select 0); (_this select 0) action ["Eject", _this select 1]; };
					} foreach crew(_vehicle);
				};

				if (!canMove(_vehicle) || count(crew(_vehicle)) == 0 || !canFire(_vehicle)) exitWith {
					_vehicles = (RSTF_AI_VEHICLES select _side);
					_index = _vehicles find _vehicle;
					_vehicles = [_vehicles, _index] call BIS_fnc_removeIndex;
					RSTF_AI_VEHICLES set [_side, _vehicles];
				};

				sleep 60;
			};
		};

		// Keep pressuring vehicle to attack, because the AI is pussy mostly
		[_vehicle, _group, _side, _air] spawn {
			_vehicle = param [0];
			_group = param [1];
			_side = param [2];
			_air = param [3];

			while { alive(_vehicle) } do {
				deleteWaypoint [_group, 0];
				_wp = _group addWaypoint [[_side] call RSTF_fnc_getAttackWaypoint, 10];
				if (!_air) then {
					_wp setWaypointType "SAD";
					_wp setWaypointSpeed "LIMITED";
					_wp setwaypointbehaviour "COMBAT";
				} else {
					_wp setWaypointType "SAD";
				};

				sleep 20;
			};
		};

		_spawned = true;
	};

	_iteration = _iteration + 1;
	if (_iteration >= _limit) exitWith {};
} foreach _shuffled;

_spawned;