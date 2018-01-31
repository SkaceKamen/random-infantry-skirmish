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
private _index = [_player] call RSTF_MODE_KOTH_getMoneyIndex;
private _money = RSTF_MODE_KOTH_MONEY select _index;

// Stop when player don't have money for this
if (_cost > _money) exitWith {
	objNull;
};

// Update money
RSTF_MODE_KOTH_MONEY set [_index, _money - _cost];

// Spawn vehicle
private _vehicle = createVehicle [_vehicleClass, RSTF_SPAWNS select SIDE_FRIENDLY, [], 50, "FLY"];
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

/*
// Camera animation
if (isNull(RSTF_CAM)) then {
	call RSTF_fnc_createCam;
};

waitUntil { camCommitted RSTF_CAM; };

// Move camera to player

RSTF_CAM camSetTarget player;
RSTF_CAM camSetRelPos [0, -1, 0.5];
RSTF_CAM camCommit 0;

waitUntil { camCommitted RSTF_CAM; };

// Move camera to target vehicle

RSTF_CAM camSetTarget _vehicle;
RSTF_CAM camSetRelPos [0, -1, 0.5];
RSTF_CAM camCommit 1;

waitUntil { camCommitted RSTF_CAM; };

// Destroy camera

RSTF_CAM cameraEffect ["terminate","back"];
camDestroy RSTF_CAM;
RSTF_CAM = objNull;
*/

// Move player into vacant slot and make him leader
[_player] joinSilent _group;
_player moveInAny _vehicle;
_group selectLeader _player;

_vehicle;