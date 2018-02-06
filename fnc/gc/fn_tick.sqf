/*
	Function:
	RSTFGC_fnc_tick

	Description:
	One tick of GC. Can be called in any interval,
	time is used to measure when to delete objects.

	Parameter(s):
	_force - delete everything, ignore delay [Boolean, default false]

	Author:
	Jan Zípek
*/


private _force = param [0, false];

// Check vehicles, empty vehicles are enqueued
private _tracked = [];
{
	if (count([_x] call RSTF_fnc_aliveCrew) == 0 || !canFire(_x)) then {
		[_x, _x getVariable ["GC_delay", 30]] call RSTFGC_fnc_enqueue;
	} else {
		_tracked pushBack _x;
	};
} foreach RSTFGC_TRACKED;

RSTFGC_TRACKED = _tracked;

// Process removal queue
private _queue = [];
{
	private _object = _x select 0;
	private _timeout = _x select 1;
	if (_timeout < time || _force) then {
		// Safety check, don't delete vehicle with crew in it
		if (!(_object isKindOf "Man") && { count([_object] call RSTF_fnc_aliveCrew) > 0 }) then {
			diag_log text(format["[RSTF] Queue vehicle again %1", _object]);
			[_object, 30, true] call RSTFGC_fnc_attach;
		} else {
			diag_log text(format["[RSTF] Delete vehicle %1", _object]);
			deleteVehicle _object;
		};
	} else {
		diag_log text(format["[RSTF] Still in queue %1", _object]);
		_queue pushBack _x;
	};
} foreach RSTFGC_QUEUE;

RSTFGC_QUEUE = _queue;