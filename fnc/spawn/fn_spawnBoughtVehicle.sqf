/*
	Function:
	RSTF_fnc_spawnBoughtVehicle

	Description:
	Spawns vehicle bought through vehicle menu or bought by AI.

	Parameter(s):
	_unit - unit that bought the vehicle [Object]
	_side - side index that the unit is on [Number]
	_vehicleClass - classname of vehicle to be spawned [String]

	Returns:
	Spawned vehicle [Object]
*/

private _unit = param [0];
private _side = param [1];
private _vehicleClass = param [2];

private _parents = [configFile >> "cfgVehicles" >> _vehicleClass, true] call BIS_fnc_returnParents;
private _plane = "Plane" in _parents;
private _air = "Air" in _parents;

private _distance = RSTF_DISTANCE * 2;
private _height = 0;

if (_air) then {
	_distance = 1000;
	_height = 500;
};

if (_plane) then {
	_distance = 3000;
	_height = 1000;
};

// Spawn vehicle
private _direction = (RSTF_SPAWNS select _side) getDir RSTF_POINT;
private _position = (RSTF_SPAWNS select _side) vectorAdd [
	sin(_direction + 180) * _distance,
	cos(_direction + 180) * _distance,
	_height
];
private _radius = 100;

// _position = _position findEmptyPosition [0, 100, _vehicleClass];
// if (count(_position) == 0) then { _radius = 100; _position = (RSTF_SPAWNS select _side); };

private _vehicle = createVehicle [_vehicleClass, _position, [], _radius, "FLY"];

// Add to GC with 30 seconds to despawn
if (RSTF_CLEAN) then {
	[_vehicle, RSTF_CLEAN_INTERVAL_VEHICLES, true] call RSTFGC_fnc_attach;
};

if (_plane) then {
	_vehicle setPos _position;
};

_vehicle setDir _direction;

// Spawn vehicle crew
createVehicleCrew _vehicle;

// Create group on correct side and assign crew to it
private _group = createGroup (RSTF_SIDES_SIDES select _side);
units(group(effectiveCommander(_vehicle))) joinSilent _group;

if (!isNull(_unit)) then {
	// Remove effective commander
	deleteVehicle effectiveCommander(_vehicle);
};

// Make sure crew works same as other soldiers
{
	_x setVariable ["SPAWNED_SIDE", side(_group), true];
	_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
	[_x, RSTF_CLEAN_INTERVAL] call RSTFGC_fnc_attach;
} foreach units(_group);

if (!isNull(_unit)) then {
	// Move player into vacant slot and make him leader
	[_unit] joinSilent _group;
	_unit moveInAny _vehicle;
	_group selectLeader _unit;
} else {
	// Stop player from entering friendly AI vehicles
	_vehicle setVehicleLock "LOCKEDPLAYER";
};

_vehicle;