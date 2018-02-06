/*
	Function:
	RSTFGC_fnc_enqueue

	Description:
	Enqueues object to be deleted by garbage collector.

	Parameter(s):
	_object - object to be deleted [Object]
	_delay - removal delay in seconds [Scalar]
	_force - don't check if object is already in queue [Boolean, default false]

	Returns:
	If the object was enqueued [Boolean]

	Author:
	Jan Zípek
*/

private _object = param [0];
private _delay = param [1];
private _force = param [2, false];

if (_force || !(_object getVariable "GC_queued")) exitWith {
	_object setVariable ["GC_queued", true];
	RSTFGC_QUEUE pushBack [_object, time + _delay];
	true;
};

false;
