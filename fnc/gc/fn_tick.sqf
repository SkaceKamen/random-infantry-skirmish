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

private _queue = [];
{
	if (_x select 1 < time || _force) then {
		deleteVehicle (_x select 0);
	} else {
		_queue pushBack _x;
	};
} foreach RSTFGC_QUEUE;

RSTFGC_QUEUE = _queue;