/*
	Function:
	RSTF_fnc_assignVehicle

	Description:
	Creates specified vehicle and moves player to it as effectiveCommander.
	Note that this includes camera animation, which requires suspension.

	Parameters:
	_className - class name of the vehicle to be spawned [STRING]

	Returns:
	Spawned vehicle [OBJECT]
*/

private _vehicleClass = param [0];

// Spawn vehicle
private _vehicle = createVehicle [_vehicleClass, RSTF_SPAWNS select SIDE_FRIENDLY, [], 50, "FLY"];

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

// Move player into vacant slot and make him leader
player moveInAny _vehicle;
_group selectLeader player;

_vehicle;