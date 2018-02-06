/*
	Function:
	RSTFGC_fnc_dammaged

	Description:
	Dammaged event handler for object with attached GC.

	Parameter(s):
	_object - object that was damaged

	Author:
	Jan Zípek
*/


private _object = param [0];
private _vehicle = _object getVariable ["GC_vehicle", false];

if (_vehicle && { !canFire(_object) || count(crew(_object)) == 0 }) then {
	[_object, _object getVariable ["GC_delay", 30]] call RSTFGC_fnc_enqueue;
};