/*
	Function:
	RSTF_fnc_spawnBoughtVehicle

	Description:
	Spawns vehicle bought through vehicle menu or bought by AI.

	Parameter(s):
	_unit - unit that bought the vehicle [Object]
	_side - side index that the unit is on [Number]
	_vehicleClass - classname of vehicle to be spawned [String]
	_crewParam - where to place player [Array]
	_camouflage - camouflage to be applied to the vehicle [STRING]
	_components - components to be applied to the vehicle [ARRAY]

	Returns:
	Spawned vehicle [Object]
*/

private _unit = param [0];
private _side = param [1];
private _vehicleClass = param [2];
private _crewParam = param [3, ["", "effectiveCommander"]];
private _camouflage = param [4, false];
private _components = param [5, false];

private _parents = [configFile >> "cfgVehicles" >> _vehicleClass, true] call BIS_fnc_returnParents;
private _plane = "Plane" in _parents;
private _air = "Air" in _parents;

private _distance = (RSTF_SPAWN_DISTANCE_MIN + random(RSTF_SPAWN_DISTANCE_MAX - RSTF_SPAWN_DISTANCE_MIN)) + RSTF_VEHICLES_SPAWN_DISTANCE;
private _height = 0;

if (_air) then {
	_distance = RSTF_AIR_VEHICLES_SPAWN_DISTANCE;
	_height = 500;
};

if (_plane) then {
	_distance = RSTF_PLANES_SPAWN_DISANCE;
	_height = 500;
};

// Spawn vehicle
private _radius = 0;
private _position = [];
private _direction = RSTF_DIRECTION;

if (_side == SIDE_ENEMY) then {
	_direction = _direction + 180;
};

while { true } do {
	private _center = (RSTF_SPAWNS select _side) vectorAdd [
		sin(_direction + 180) * _distance,
		cos(_direction + 180) * _distance,
		_height
	];
	_position = [_side, _center, _direction, 300, 60, _air] call RSTF_fnc_randomSpawn;

	if (!_air) then {
		private _roads = _position nearRoads 100;
		if (count(_roads) == 0) then {
			_roads = _position nearRoads 200;
		};
		if (count(_roads) == 0) then {
			_roads = _position nearRoads 300;
		};

		if (count(_roads) > 0) then {
			_position = getPos(selectRandom(_roads));
		} else {
			_position = _position findEmptyPosition [0, 100, _vehicleClass];
		};
	} else {
		_position set [2, _height];
	};

	if (count(_position) > 0 && { _air || !(surfaceIsWater _position) }) exitWith {};

	_distance = _distance - 100;
};

/*
private _direction = (RSTF_SPAWNS select _side) getDir RSTF_POINT;
private _position = (RSTF_SPAWNS select _side) vectorAdd [
	sin(_direction + 180) * _distance,
	cos(_direction + 180) * _distance,
	_height
];
private _radius = 100;
*/

// _position = _position findEmptyPosition [0, 100, _vehicleClass];
// if (count(_position) == 0) then { _radius = 100; _position = (RSTF_SPAWNS select _side); };

private _vehicle = createVehicle [_vehicleClass, _position, [], _radius, "FLY"];

if (typeName(_camouflage) != typeName(false) || typeName(_components) != typeName(false)) then {
	private _componentsArg = _components;
	private _camouflageArg = _camouflage;
	
	if (typeName(_components) != typeName(false)) then {
		_componentsArg = [];
		{
			_componentsArg pushBack _x;
			_componentsArg pushBack 1;
		} forEach _components;
	};

	if (typeName(_camouflage) != typeName(false)) then {
		_camouflageArg = [_camouflage, 1];
	};

	[_vehicle, _camouflageArg, _componentsArg] call BIS_fnc_initVehicle;
};

// Add to GC with 30 seconds to despawn
if (RSTF_CLEAN) then {
	[_vehicle, RSTF_CLEAN_INTERVAL_VEHICLES, true] call RSTFGC_fnc_attach;
};

// Spawn vehicle crew
createVehicleCrew _vehicle;

_vehicle setDir _direction;

if (_plane) then {
	_vehicle setPos _position;
	_vehicle setVelocity [100 * (sin _direction), 100 * (cos _direction), 0];
};


// DEBUG - Track unit position
if (RSTF_DEBUG) then {
	private _marker = createMarkerLocal [str(_vehicle), getPos(_vehicle)];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "c_car";
	_marker setMarkerColor (RSTF_SIDES_COLORS select _side);
};

// Pick who will be the player
private _unitToReplace = effectiveCommander(_vehicle);

switch (_crewParam#1) do {
	case "driver": {
		_unitToReplace = driver _vehicle;
	};
	case "turret": {
		_unitToReplace = _vehicle turretUnit (_crewParam#2);
	};
};

// Create group on correct side and assign crew to it
private _group = createGroup (RSTF_SIDES_SIDES select _side);
units(group(_unitToReplace)) joinSilent _group;

if (!isNull(_unit)) then {
	// Remove effective commander
	deleteVehicle _unitToReplace;
};

// Make sure crew works same as other soldiers
{
	// TODO: What about name? It's important for money tracking
	_x setVariable ["SPAWNED_SIDE", side(_group), true];
	_x setVariable ["SPAWNED_SIDE_INDEX", _side, true];
	_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
	[_x, RSTF_CLEAN_INTERVAL] call RSTFGC_fnc_attach;
} foreach units(_group);

if (!isNull(_unit)) then {
	// Move player into vacant slot and make him leader
	[_unit] joinSilent _group;
	_unit moveInAny _vehicle;
	_group selectLeader _unit;
	_vehicle setEffectiveCommander _unit;
} else {
	if (!RSTF_SPAWN_VEHICLES_UNLOCKED) then {
		// Stop player from entering friendly AI vehicles
		_vehicle setVehicleLock "LOCKEDPLAYER";
	};
};

_vehicle setVariable ["SPAWNED_SIDE", side(_group), true];
_vehicle addEventHandler ["Killed", RSTF_fnc_vehicleKilled];

_vehicle;