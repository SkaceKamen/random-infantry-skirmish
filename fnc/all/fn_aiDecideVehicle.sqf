/*
	Function:
	RSTF_fnc_aiDecideVehicle

	Description:
	Logic for ai vehicle buying.

	Parameters:
	_unit - unit that's going to buy vehicle [Object]
	_side - units side index [Scalar]

	Returns:
	If vehicle was spawned [Boolean]
*/

private _unit = param [0];
private _side = param [1];
private _name = _unit getvariable ["ORIGINAL_NAME", name(_unit)];
private _money = [_name] call RSTF_fnc_getUnitMoney;
private _vehicles = RSTF_BUYABLE_VEHICLES select _side;

// Don't bother if we're broke
if (_money < (_vehicles select 0) select 2) exitWith {
	false;
};

// Select our wish vehicle
private _wish = [RSTF_AI_VEHICLE_WISH, _name, objNull] call AMAP_get;
if (typeName(_wish) == typeName(objNull)) then {
	_wish = selectRandom _vehicles;
	[RSTF_AI_VEHICLE_WISH, _name, _wish] call AMAP_set;
};

// Load info about our wish vehicle
private _class = _wish select 1;
private _cost = _wish select 2;

// Stop if we don't have money
if (_money < _cost) exitWith { false };

private _parents = [configFile >> "cfgVehicles" >> _class, true] call BIS_fnc_returnParents;
private _air = "Air" in _parents;

// Remove money from unit
[_name, -_cost] call RSTF_fnc_addUnitMoney;

// Spawn vehicle
_vehicle = [objNull, _side, _class] call RSTF_fnc_spawnBoughtVehicle;
// Don't get out when vehicle is immobile (gunner can still work)
_vehicle allowCrewInImmobile true;

// Save vehicle to list of vehicles
(RSTF_AI_VEHICLES select _side) pushBack _vehicle;

_group = group(effectiveCommander(_vehicle));

// Remove vehicle from AI vehicles when dead
[_vehicle, _side] spawn {
	private _vehicle = param [0];
	private _side = param [1];

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
		if (!canFire(_vehicle) || { _hasGunner && { count(_gunners select { alive _x }) == 0 } } || { count(crew(_vehicle)) == 0 }) exitWith {
			{
				[_x, _vehicle] spawn {
					sleep 1;
					unassignVehicle (_this select 0);
					(_this select 0) action ["Eject", _this select 1];
				};
			} foreach crew(_vehicle);
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

	while { alive(_vehicle) } do {
		deleteWaypoint [_group, 0];
		_wp = _group addWaypoint [[_side] call RSTF_fnc_getAttackWaypoint, 10];

		if (_side == SIDE_FRIENDLY) then {
			_m = createMarker [format["marker%1%2", time, waypointPosition _wp], waypointPosition _wp];
			_m setMarkerShape "ICON";
			_m setMarkerType "mil_dot";
		};

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

true;