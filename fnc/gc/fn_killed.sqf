/*
	Function:
	RSTFGC_fnc_killed

	Description:
	Killed event handler for object with attached GC.

	Parameter(s):
	_object - object that was killed

	Author:
	Jan Zípek
*/


private _object = param [0];

[_object, _object getVariable ["GC_delay", 30]] call RSTFGC_fnc_enqueue;