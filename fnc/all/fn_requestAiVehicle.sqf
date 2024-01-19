/*
	Function:
	RSTF_fnc_requestVehicle

	Description:
	Creates specified vehicle and moves player to it as effectiveCommander.
	Note that this includes camera animation, which requires suspension.

	Parameters:
	_player - player that is requesting the vehicles
	_className - class name of the vehicle to be spawned [STRING]

	Returns:
	Spawned vehicle [OBJECT]
*/

private _player = param [0];
private _vehicleClass = param [1];

// Check money
private _cost = ([_vehicleClass] call RSTF_fnc_getVehicleCost) * RSTF_AI_VEHICLE_SUPPORT_COST_MULTIPLIER;
private _money = [_player] call RSTF_fnc_getPlayerMoney;

// We have to know if it's AIR for some reason
private _parents = [configFile >> "cfgVehicles" >> _vehicleClass, true] call BIS_fnc_returnParents;
private _air = "Air" in _parents;

// Stop when player don't have money for this
if (_cost > _money) exitWith {
	objNull;
};

// Update money
[_player, -_cost] call RSTF_fnc_addPlayerMoney;

// Ask server to spawn AI vehicle
private _vehicle = [side(_player) call RSTF_fnc_sideIndex, _vehicleClass, _air] call RSTF_fnc_spawnAiVehicle;

[_player, objNull, _vehicle, _cost] call RSTF_fnc_attachVehicleRefundCheck;

_vehicle;