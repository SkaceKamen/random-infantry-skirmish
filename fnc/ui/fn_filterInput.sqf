/*
	Author: Jan Zípek

	Description:
	Filters char input for control.

	Parameter(s):
	0: CONTROL - text input control
	1: NUMBER - code of inserted char
	2: STRING - class of allowed characters

	Returns: BOOL - if char should be accepted
*/

disableSerialization;
params ["_ctrl", "_char", "_allowed"];

private _chars = missionNamespace getVariable ["RSTF_CHARS_" + _allowed, []];
private _handled = (_chars find (_this select 1)) == -1;

if (_handled) then {
	_this spawn {
		sleep 0.1;
		_updated = toString((toArray (ctrlText (_this select 0))) select format["RSTF_CHARS_%1 find _x >= 0", _this select 2]);
		(_this select 0) ctrlSetText _updated;
	};
};

_handled;