/*
	Function:
	RSTF_fnc_spawnAiVehicle

	Description:
	Spawns AI controlled vehicle

	Parameters:
	_side - side index [Scalar]
	_class - vehicle class name
	_air - if the vehicle is air based

	Returns:
	Spawned vehicle [Object]
*/

private _side = param [0];
private _class = param [1];
private _air = param [2];

// Spawn vehicle
private _vehicle = [objNull, _side, _class] call RSTF_fnc_spawnBoughtVehicle;
// Don't get out when vehicle is immobile (gunner can still work)
_vehicle allowCrewInImmobile true;

// Save vehicle to list of vehicles
(RSTF_AI_VEHICLES select _side) pushBack _vehicle;

private _group = group(effectiveCommander(_vehicle));

// Remove vehicle from AI vehicles when dead
[_vehicle, _side, _air] spawn {
	private _vehicle = param [0];
	private _side = param [1];
	private _air = param [2];

	// Try to load all gunners
	private _gunners = [];
	{
		private _role = assignedVehicleRole _x;
		if (_role select 0 == "Turret") then {
			_gunners pushBack _x;
		};
	} foreach crew(_vehicle);
	private _hasGunner = count(_gunners) > 0;

	// Wait until vehicle is useless
	while { true } do {
		// Get out of useless vehicle
		if (!canFire(_vehicle)
			|| { _hasGunner && { count(_gunners select { alive _x }) == 0 } }
			|| { count(crew(_vehicle)) == 0 }
			|| { !canMove(_vehicle) && _vehicle distance RSTF_POINT > 300 }
		) exitWith {
			{
				[_x, _vehicle] spawn {
					sleep 1;
					unassignVehicle (_this select 0);
					(_this select 0) action ["Eject", _this select 1];
				};
			} foreach crew(_vehicle);
		};

		// Air vehicles have limited ammo, this makes them more fun
		if (_air) then {
			_vehicle setVehicleAmmo 1;
		};

		sleep 60;
	};

	// Remove from vehicles array
	private _vehicles = (RSTF_AI_VEHICLES select _side);
	private _index = _vehicles find _vehicle;
	private _vehicles = [_vehicles, _index] call BIS_fnc_removeIndex;
	RSTF_AI_VEHICLES set [_side, _vehicles];
};

// Keep pressuring vehicle to attack, because the AI is pussy mostly
[_vehicle, _group, _side, _air] spawn {
	_vehicle = param [0];
	_group = param [1];
	_side = param [2];
	_air = param [3];
	_m = "";
	_startPosition = getPos(_vehicle);
	_moved = false;
	_notMovedTimes = 0;

	if (RSTF_DEBUG) then {
		_m = createMarkerLocal [str(_vehicle), getPos(_vehicle)];
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_box";
		_m setMarkerColor (RSTF_SIDES_COLORS select _side);
	};

	while { alive(_vehicle) } do {
		deleteWaypoint [_group, 0];
		_wp = _group addWaypoint [[_side, true] call RSTF_fnc_getAttackWaypoint, 10];

		if (RSTF_DEBUG) then {
			_m setmarkerPos (waypointPosition _wp);
		};

		if (!_air) then {
			_wp setWaypointType "SAD";
			_wp setWaypointSpeed "LIMITED";
			_wp setwaypointbehaviour "COMBAT";
		} else {
			_wp setWaypointType "SAD";
		};

		// Checks if the spawned vehicle has moved trying to identify stuck vehicles
		if (!_moved) then {
			if (_startPosition distance getPos(_vehicle) < 5) then {
				_notMovedTimes = _notMovedTimes + 1;
			} else {
				_moved = true;
			};

			if (_notMovedTimes > 3) then {
				// Remove from vehicles array and destroy the vehicle
				private _vehicles = (RSTF_AI_VEHICLES select _side);
				private _index = _vehicles find _vehicle;
				private _vehicles = [_vehicles, _index] call BIS_fnc_removeIndex;
				RSTF_AI_VEHICLES set [_side, _vehicles];
				deleteVehicle _vehicle;
			};
		};

		sleep 20;
	};
};

_vehicle;