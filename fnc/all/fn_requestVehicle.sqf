/*
	Function:
	RSTF_fnc_requestVehicle

	Description:
	Creates specified vehicle and moves player to it as effectiveCommander.
	Note that this includes camera animation, which requires suspension.

	Parameters:
	_player - player that is requesting the vehicles
	_className - class name of the vehicle to be spawned [STRING]
	_crewParam - where to place player [ARRAY]

	Returns:
	Spawned vehicle [OBJECT]
*/

private _player = param [0];
private _vehicleClass = param [1];
private _crewParam = param [2];

// Check money
private _cost = [_vehicleClass] call RSTF_fnc_getVehicleCost;
private _money = [_player] call RSTF_fnc_getPlayerMoney;

// Stop when player don't have money for this
if (_cost > _money) exitWith {
	objNull;
};

// Update money
[_player, -_cost] call RSTF_fnc_addPlayerMoney;

private _previousPosition = getPos(_player);

// Spawn vehicle
private _vehicle = [_player, SIDE_FRIENDLY, _vehicleClass, _crewParam] call RSTF_fnc_spawnBoughtVehicle;

// Camera animation
[_previousPosition, _vehicle] remoteExec ["RSTF_fnc_moveCamera", _player];

[_player, objNull, _vehicle, _cost] call RSTF_fnc_attachVehicleRefundCheck;

_vehicle;