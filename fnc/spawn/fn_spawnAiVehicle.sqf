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

private _group = group(effectiveCommander(_vehicle));
private _gunners = [];
{
	private _role = assignedVehicleRole _x;
	if (_role select 0 == "Turret") then {
		_gunners pushBack _x;
	};
} foreach crew(_vehicle);

// Save vehicle to list of vehicles
(RSTF_AI_VEHICLES select _side) pushBack [_group, _vehicle, _air, _gunners];

if (RSTF_DEBUG) then {
	_m = createMarkerLocal [str(_vehicle), getPos(_vehicle)];
	_m setMarkerShape "ICON";
	_m setMarkerType "mil_box";
	_m setMarkerColor (RSTF_SIDES_COLORS select _side);
};

[_group] call RSTF_fnc_refreshVehicleWaypoints;

_vehicle;