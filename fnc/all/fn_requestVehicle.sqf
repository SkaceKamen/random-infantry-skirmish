/*
	Function:
	RSTF_fnc_assignVehicle

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
private _cost = [_vehicleClass] call RSTF_fnc_vehicleCost;
private _money = [_player] call RSTF_fnc_getPlayerMoney;

// Stop when player don't have money for this
if (_cost > _money) exitWith {
	objNull;
};

// Update money
[_player, -_cost] call RSTF_fnc_addPlayerMoney;

// Spawn vehicle
private _position = (RSTF_SPAWNS select SIDE_FRIENDLY) findEmptyPosition [0, 100, _vehicleClass];
private _vehicle = createVehicle [_vehicleClass, _position, [], 0, "FLY"];
private _direction = (RSTF_SPAWNS select SIDE_FRIENDLY) getDir RSTF_POINT;

_vehicle setDir _direction;

// Spawn vehicle crew
createVehicleCrew _vehicle;

private _group = group(effectiveCommander(_vehicle));

// Remove effective commander
deleteVehicle effectiveCommander(_vehicle);

// Make sure crew works same as other soldiers
{
	_x setVariable ["SPAWNED_SIDE", side(_group), true];
	_x addEventHandler ["Killed", RSTF_fnc_unitKilled];
} foreach units(_group);

// Creates camera animation
[getPos(_player), _vehicle] remoteExec ["RSTF_fnc_moveCamera", _player];

// Move player into vacant slot and make him leader
[_player] joinSilent _group;
_player moveInAny _vehicle;
_group selectLeader _player;

// If vehicle is destroyed/damaged in first 2 seconds of existence, refund the money
[_player, _vehicle, _cost] spawn {
	private _player = param [0];
	private _vehicle = param [1];
	private _cost = param [2];

	sleep 2;

	if (!canMove(_vehicle) || damage(_vehicle) > 0.2) then {
		[_player, _cost] call RSTF_fnc_addPlayerMoney;
		[format["+%1$ <t color='#dddddd'>Vehicle refund</t>", _cost], 5] remoteExec ["RSTFUI_fnc_addMessage", _player];
	};
};

_vehicle;