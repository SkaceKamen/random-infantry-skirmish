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

// Spawn vehicle
private _direction = (RSTF_SPAWNS select _side) getDir RSTF_POINT;
private _position = (RSTF_SPAWNS select _side) vectorAdd [
	sin(_direction + 180) * 150,
	cos(_direction + 180) * 150,
	0
];
private _radius = 100;

// _position = _position findEmptyPosition [0, 100, _vehicleClass];
// if (count(_position) == 0) then { _radius = 100; _position = (RSTF_SPAWNS select _side); };

private _vehicle = createVehicle [_vehicleClass, _position, [], _radius, "FLY"];

_vehicle setDir _direction;

// Spawn vehicle crew
createVehicleCrew _vehicle;

// Create group on correct side and assign crew to it
private _group = createGroup (RSTF_SIDES_SIDES select _side);
units(group(effectiveCommander(_vehicle))) joinSilent _group;

// Remove effective commander
deleteVehicle effectiveCommander(_vehicle);

// Make sure crew works same as other soldiers
{
	_x setVariable ["SPAWNED_SIDE", side(_group), true];
	_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
} foreach units(_group);

// Move player into vacant slot and make him leader
[_unit] joinSilent _group;
_unit moveInAny _vehicle;
_group selectLeader _unit;

_vehicle;